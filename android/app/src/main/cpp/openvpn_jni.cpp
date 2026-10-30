// SPDX-License-Identifier: MPL-2.0
//
// JNI boundary for the Android OpenVPN service.  This boundary contains no
// logging of profile, certificate, key, endpoint or raw OpenVPN diagnostic
// data.  All errors crossing it are stable, non-sensitive categories.

#include <jni.h>

#include "openvpn_contract.h"
#include "openvpn_core.h"
#include "openvpn_profile.h"

#include <algorithm>
#include <cctype>
#include <memory>
#include <mutex>
#include <optional>
#include <string>
#include <string_view>
#include <unordered_map>
#include <utility>

namespace fuzevpn::openvpn {
namespace {

constexpr size_t kMaxProfileUtf8Bytes = 64 * 1024;
constexpr size_t kMaxAliasUtf8Bytes = 256;
constexpr size_t kMaxCertificateUtf8Bytes = 64 * 1024;
constexpr size_t kMaxPkiRequestUtf8Bytes = 16 * 1024;
constexpr size_t kMaxPkiSignatureUtf8Bytes = 16 * 1024;
constexpr size_t kMaxCategoryBytes = 96;

class ScopedEnv final {
 public:
  explicit ScopedEnv(JavaVM* vm) : vm_(vm) {
    if (vm_ == nullptr) return;
    const jint status = vm_->GetEnv(reinterpret_cast<void**>(&env_), JNI_VERSION_1_6);
    if (status == JNI_EDETACHED) {
      if (vm_->AttachCurrentThread(&env_, nullptr) == JNI_OK) {
        attached_ = true;
      }
      else env_ = nullptr;
    } else if (status != JNI_OK) {
      env_ = nullptr;
    }
  }

  ~ScopedEnv() {
    if (attached_ && vm_ != nullptr) vm_->DetachCurrentThread();
  }

  JNIEnv* get() const { return env_; }

 private:
  JavaVM* vm_ = nullptr;
  JNIEnv* env_ = nullptr;
  bool attached_ = false;
};

bool ClearException(JNIEnv* env) {
  if (env == nullptr || !env->ExceptionCheck()) return false;
  env->ExceptionClear();
  return true;
}

template <typename T>
class LocalRef final {
 public:
  LocalRef(JNIEnv* env, T value) noexcept : env_(env), value_(value) {}
  ~LocalRef() { if (value_ != nullptr) env_->DeleteLocalRef(value_); }
  T get() const noexcept { return value_; }
  T release() noexcept { return std::exchange(value_, nullptr); }
  LocalRef(const LocalRef&) = delete;
  LocalRef& operator=(const LocalRef&) = delete;

 private:
  JNIEnv* env_;
  T value_;
};

jstring NewUtfString(JNIEnv* env, const char* value) {
  LocalRef<jstring> result(env, env->NewStringUTF(value));
  if (ClearException(env)) return nullptr;
  return result.release();
}

template <typename T, typename Function>
T JniGuard(JNIEnv* env, T failure, Function&& operation, bool unreadable_state = false) noexcept {
  try {
    return operation();
  } catch (...) {
    // C++ exceptions cannot cross a JNI transition. Never expose their text.
    ClearException(env);
    if (unreadable_state && env != nullptr) {
      // A failed proof query must reach Kotlin as unknown, never as a false
      // assertion that the engine stopped. Throw only a stable category.
      LocalRef<jclass> type(env, env->FindClass("java/lang/IllegalStateException"));
      if (type.get() != nullptr && !env->ExceptionCheck()) {
        env->ThrowNew(type.get(), "openvpn_native_state_unavailable");
      }
    }
    return failure;
  }
}

std::optional<std::string> ReadUtf8(JNIEnv* env, jstring value, size_t maximum) {
  if (env == nullptr || value == nullptr) return std::nullopt;
  const jsize bytes = env->GetStringUTFLength(value);
  if (ClearException(env)) return std::nullopt;
  if (bytes < 0 || static_cast<size_t>(bytes) > maximum) return std::nullopt;
  const char* chars = env->GetStringUTFChars(value, nullptr);
  // Always clear/check before testing a null result: || in the other order
  // skips this operation exactly when JNI leaves OutOfMemoryError pending.
  const bool failed = ClearException(env);
  struct Lease {
    JNIEnv* env;
    jstring value;
    const char* chars;
    ~Lease() { if (chars != nullptr) env->ReleaseStringUTFChars(value, chars); }
  } lease{env, value, chars};
  if (failed || chars == nullptr) return std::nullopt;
  std::string result(chars, static_cast<size_t>(bytes));
  return result;
}

bool IsSafeCategory(std::string_view value) {
  if (value.empty() || value.size() > kMaxCategoryBytes) return false;
  return std::all_of(value.begin(), value.end(), [](unsigned char character) {
    return std::islower(character) || std::isdigit(character) || character == '_';
  });
}

// Algorithm names sent by OpenVPN External PKI (for example ECDSA and
// SHA256) are protocol tokens, not user-facing state categories.  Accept a
// deliberately small ASCII grammar so a valid P-256 signing request is not
// rejected merely because it is uppercase, while still preventing callback
// injection or arbitrary diagnostic text from crossing JNI.
bool IsSafePkiToken(std::string_view value, bool allow_empty = false) {
  if (value.empty()) return allow_empty;
  if (value.size() > 32) return false;
  return std::all_of(value.begin(), value.end(), [](unsigned char character) {
    return std::isalnum(character) || character == '_' || character == '-';
  });
}

bool IsBase64(std::string_view value) {
  if (value.empty() || value.size() > kMaxPkiSignatureUtf8Bytes) return false;
  return std::all_of(value.begin(), value.end(), [](unsigned char character) {
    return std::isalnum(character) || character == '+' || character == '/' ||
           character == '=';
  });
}

void AppendJsonEscaped(std::string* output, std::string_view value) {
  output->push_back('"');
  for (const unsigned char character : value) {
    switch (character) {
      case '"': output->append("\\\""); break;
      case '\\': output->append("\\\\"); break;
      case '\b': output->append("\\b"); break;
      case '\f': output->append("\\f"); break;
      case '\n': output->append("\\n"); break;
      case '\r': output->append("\\r"); break;
      case '\t': output->append("\\t"); break;
      default:
        // TunBuilder values originate from Core, which pre-validates network
        // values.  Still escape control bytes rather than passing invalid JSON.
        if (character < 0x20) {
          static constexpr char kHex[] = "0123456789abcdef";
          output->append("\\u00");
          output->push_back(kHex[(character >> 4) & 0x0f]);
          output->push_back(kHex[character & 0x0f]);
        } else {
          output->push_back(static_cast<char>(character));
        }
    }
  }
  output->push_back('"');
}

std::string PlanJson(const TunPlan& plan) {
  std::string result;
  result.reserve(512 + plan.addresses.size() * 32 + plan.routes.size() * 32);
  result.append("{\"session\":");
  AppendJsonEscaped(&result, plan.session_name.empty() ? "FuzeVPN OpenVPN" : plan.session_name);
  result.append(",\"mtu\":");
  result.append(std::to_string(plan.mtu == 0 ? 1500 : plan.mtu));
  result.append(",\"addresses\":[");
  for (size_t index = 0; index < plan.addresses.size(); ++index) {
    if (index != 0) result.push_back(',');
    AppendJsonEscaped(&result, plan.addresses[index].address + "/" +
                                   std::to_string(plan.addresses[index].prefix_length));
  }
  result.append("],\"routes\":[");
  if (plan.route_ipv4_default) AppendJsonEscaped(&result, "0.0.0.0/0");
  if (plan.route_ipv6_default) {
    if (plan.route_ipv4_default) result.push_back(',');
    AppendJsonEscaped(&result, "::/0");
  }
  for (size_t index = 0; index < plan.routes.size(); ++index) {
    if (plan.route_ipv4_default || plan.route_ipv6_default || index != 0) result.push_back(',');
    AppendJsonEscaped(&result, plan.routes[index].address + "/" +
                                   std::to_string(plan.routes[index].prefix_length));
  }
  result.append("],\"dns\":[");
  for (size_t index = 0; index < plan.dns_servers.size(); ++index) {
    if (index != 0) result.push_back(',');
    AppendJsonEscaped(&result, plan.dns_servers[index]);
  }
  result.append("]}");
  return result;
}

class JniPlatformCallbacks final : public PlatformCallbacks {
 public:
  JniPlatformCallbacks(JNIEnv* env, jobject callback) {
    if (env == nullptr || callback == nullptr ||
        env->GetJavaVM(&vm_) != JNI_OK) {
      return;
    }
    callback_ = env->NewGlobalRef(callback);
    if (ClearException(env) || callback_ == nullptr) {
      if (callback_ != nullptr) env->DeleteGlobalRef(callback_);
      callback_ = nullptr;
      return;
    }
    LocalRef<jclass> callback_class(env, env->GetObjectClass(callback));
    if (ClearException(env) || callback_class.get() == nullptr) {
      Release(env);
      return;
    }
    const auto method = [&](const char* name, const char* signature) {
      const auto result = env->GetMethodID(callback_class.get(), name, signature);
      return ClearException(env) ? nullptr : result;
    };
    if ((on_state_ = method("onNativeState", "(Ljava/lang/String;Ljava/lang/String;)V")) == nullptr ||
        (on_tun_ = method("onTunConfiguration", "(Ljava/lang/String;)I")) == nullptr ||
        (on_protect_ = method("onProtectSocket", "(I)Z")) == nullptr ||
        (on_certificate_ = method("onPkiCertificate", "(Ljava/lang/String;)Ljava/lang/String;")) == nullptr ||
        (on_sign_ = method("onPkiSign", "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;")) == nullptr) Release(env);
  }

  ~JniPlatformCallbacks() override {
    ScopedEnv scoped(vm_);
    if (scoped.get() != nullptr) Release(scoped.get());
  }

  bool valid() const { return callback_ != nullptr; }

  void OnCoreState(std::string_view state, std::string_view reason) override {
    if (!IsSafeCategory(state) || !IsSafeCategory(reason)) return;
    std::lock_guard<std::mutex> lock(callback_mutex_);
    ScopedEnv scoped(vm_);
    JNIEnv* env = scoped.get();
    if (env == nullptr || callback_ == nullptr) return;
    LocalRef<jstring> state_value(env, NewUtfString(env, std::string(state).c_str()));
    if (state_value.get() == nullptr) return;
    LocalRef<jstring> reason_value(env, NewUtfString(env, std::string(reason).c_str()));
    if (reason_value.get() == nullptr) return;
    env->CallVoidMethod(callback_, on_state_, state_value.get(), reason_value.get());
    ClearException(env);
  }

  int EstablishTun(const TunPlan& plan) override {
    std::string json = PlanJson(plan);
    std::lock_guard<std::mutex> lock(callback_mutex_);
    ScopedEnv scoped(vm_);
    JNIEnv* env = scoped.get();
    if (env == nullptr || callback_ == nullptr) return -1;
    LocalRef<jstring> value(env, NewUtfString(env, json.c_str()));
    SecureErase(&json);
    if (value.get() == nullptr) return -1;
    const jint descriptor = env->CallIntMethod(callback_, on_tun_, value.get());
    const bool failed = ClearException(env);
    return failed ? -1 : descriptor;
  }

  bool ProtectSocket(int fd) override {
    if (fd < 0) return false;
    std::lock_guard<std::mutex> lock(callback_mutex_);
    ScopedEnv scoped(vm_);
    JNIEnv* env = scoped.get();
    if (env == nullptr || callback_ == nullptr) return false;
    const jboolean protected_socket = env->CallBooleanMethod(callback_, on_protect_, fd);
    return !ClearException(env) && protected_socket == JNI_TRUE;
  }

  std::optional<std::string> PkiCertificate(std::string_view alias) override {
    return CallPkiString(on_certificate_, alias, {}, {}, {}, {},
                         kMaxCertificateUtf8Bytes, false);
  }

  std::optional<std::string> PkiSign(std::string_view alias,
                                      std::string_view data_base64,
                                      std::string_view algorithm,
                                      std::string_view hash_algorithm,
                                      std::string_view salt_length) override {
    if (data_base64.empty() || data_base64.size() > kMaxPkiRequestUtf8Bytes ||
        !IsSafePkiToken(algorithm) || !IsSafePkiToken(hash_algorithm, true) ||
        !IsSafePkiToken(salt_length, true)) {
      return std::nullopt;
    }
    return CallPkiString(on_sign_, alias, data_base64, algorithm,
                         hash_algorithm, salt_length, kMaxPkiSignatureUtf8Bytes,
                         true);
  }

 private:
  std::optional<std::string> CallPkiString(jmethodID method,
                                            std::string_view alias,
                                            std::string_view data,
                                            std::string_view algorithm,
                                            std::string_view hash_algorithm,
                                            std::string_view salt_length,
                                            size_t maximum, bool signature) {
    if (!ProfileValidator::IsSafeIdentityAlias(alias)) return std::nullopt;
    std::lock_guard<std::mutex> lock(callback_mutex_);
    ScopedEnv scoped(vm_);
    JNIEnv* env = scoped.get();
    if (env == nullptr || callback_ == nullptr || method == nullptr) return std::nullopt;
    LocalRef<jstring> alias_value(env, NewUtfString(env, std::string(alias).c_str()));
    if (alias_value.get() == nullptr) return std::nullopt;

    jobject returned = nullptr;
    if (signature) {
      LocalRef<jstring> data_value(env, NewUtfString(env, std::string(data).c_str()));
      if (data_value.get() == nullptr) return std::nullopt;
      LocalRef<jstring> algorithm_value(env, NewUtfString(env, std::string(algorithm).c_str()));
      if (algorithm_value.get() == nullptr) return std::nullopt;
      LocalRef<jstring> hash_value(env, NewUtfString(env, std::string(hash_algorithm).c_str()));
      if (hash_value.get() == nullptr) return std::nullopt;
      LocalRef<jstring> salt_value(env, NewUtfString(env, std::string(salt_length).c_str()));
      if (salt_value.get() == nullptr) return std::nullopt;
      returned = env->CallObjectMethod(callback_, method, alias_value.get(), data_value.get(),
                                       algorithm_value.get(), hash_value.get(), salt_value.get());
    } else {
      returned = env->CallObjectMethod(callback_, method, alias_value.get());
    }
    LocalRef<jobject> returned_ref(env, returned);
    const bool failed = ClearException(env);
    std::optional<std::string> result;
    if (!failed && returned != nullptr) {
      result = ReadUtf8(env, static_cast<jstring>(returned), maximum);
      if (result && signature && !IsBase64(*result)) {
        SecureErase(&*result);
        result.reset();
      }
    }
    return result;
  }

  void Release(JNIEnv* env) {
    if (env != nullptr && callback_ != nullptr) env->DeleteGlobalRef(callback_);
    callback_ = nullptr;
    on_state_ = nullptr;
    on_tun_ = nullptr;
    on_protect_ = nullptr;
    on_certificate_ = nullptr;
    on_sign_ = nullptr;
  }

  JavaVM* vm_ = nullptr;
  jobject callback_ = nullptr;
  jmethodID on_state_ = nullptr;
  jmethodID on_tun_ = nullptr;
  jmethodID on_protect_ = nullptr;
  jmethodID on_certificate_ = nullptr;
  jmethodID on_sign_ = nullptr;
  std::mutex callback_mutex_;
};

class NativeSession final {
 public:
  explicit NativeSession(std::unique_ptr<JniPlatformCallbacks> callbacks)
      : callbacks_(std::move(callbacks)), core_(CreateCoreSession()) {}

  bool valid() const { return callbacks_ != nullptr && callbacks_->valid() && core_ != nullptr; }

  bool Start(std::string profile, std::string alias, NetworkPolicy network) {
    ScopedStringErase erase_profile(profile);
    ScopedStringErase erase_alias(alias);
    std::lock_guard<std::mutex> lock(mutex_);
    if (!valid() || destroying_) return false;
    if (started_) {
      callbacks_->OnCoreState("error", "session_busy");
      SecureErase(&profile);
      SecureErase(&alias);
      return false;
    }
    ProfileFailure failure = ProfileFailure::kNone;
    if (!network.valid()) {
      SecureErase(&profile);
      SecureErase(&alias);
      callbacks_->OnCoreState("error", "tun_network_mismatch");
      return false;
    }
    auto validated = ProfileValidator::Validate(profile, alias, &failure, network.dual_stack());
    SecureErase(&profile);
    if (!validated) {
      callbacks_->OnCoreState("error", ProfileValidator::FailureCode(failure));
      SecureErase(&alias);
      return false;
    }
    validated->network = std::move(network);
    started_ = core_->Start(std::move(*validated), alias, callbacks_.get());
    SecureErase(&alias);
    return started_;
  }

  void Stop() {
    std::lock_guard<std::mutex> lock(mutex_);
    StopLocked();
  }

  bool Destroy() {
    std::lock_guard<std::mutex> lock(mutex_);
    if (destroyed_) return true;
    // An already admitted Start must finish before this lock is acquired;
    // a later Start cannot revive the object after it leaves the registry.
    destroying_ = true;
    StopLocked();
    destroyed_ = true;
    return true;
  }

 private:
  void Emit(std::string_view state, std::string_view reason) noexcept {
    try { callbacks_->OnCoreState(state, reason); } catch (...) {}
  }

  void StopLocked() {
    if (started_) Emit("disconnecting", "disconnecting");
    // Also clean a partially initialized client after a failed Start.
    core_->Stop();
    const bool was_started = started_;
    started_ = false;
    if (was_started) Emit("idle", "disconnected");
  }

 public:
  bool IsConnected() const {
    std::lock_guard<std::mutex> lock(mutex_);
    return started_ && core_->IsConnected();
  }

  CoreStatistics Statistics() const {
    std::lock_guard<std::mutex> lock(mutex_);
    return started_ ? core_->Statistics() : CoreStatistics{};
  }

 private:
  mutable std::mutex mutex_;
  std::unique_ptr<JniPlatformCallbacks> callbacks_;
  std::unique_ptr<CoreSession> core_;
  bool started_ = false;
  bool destroying_ = false;
  bool destroyed_ = false;
};

std::mutex sessions_mutex;
std::unordered_map<jlong, std::shared_ptr<NativeSession>> sessions;

std::shared_ptr<NativeSession> FindSession(jlong handle) {
  if (handle == 0) return {};
  std::lock_guard<std::mutex> lock(sessions_mutex);
  const auto found = sessions.find(handle);
  return found == sessions.end() ? std::shared_ptr<NativeSession>{} : found->second;
}

jboolean NativeIsCoreAvailable(JNIEnv* env, jobject) noexcept {
  return JniGuard(env, static_cast<jboolean>(JNI_FALSE), [] {
    return static_cast<jboolean>(IsCoreAvailable() ? JNI_TRUE : JNI_FALSE);
  });
}

jlong NativeCreate(JNIEnv* env, jobject, jobject callback) noexcept {
  return JniGuard(env, static_cast<jlong>(0), [&] {
    auto callbacks = std::make_unique<JniPlatformCallbacks>(env, callback);
    auto session = std::make_shared<NativeSession>(std::move(callbacks));
    if (!session->valid()) return static_cast<jlong>(0);
    const jlong handle = reinterpret_cast<jlong>(session.get());
    std::lock_guard<std::mutex> lock(sessions_mutex);
    sessions.emplace(handle, std::move(session));
    return handle;
  });
}

jboolean NativeDestroy(JNIEnv* env, jobject, jlong handle) noexcept {
  return JniGuard(env, static_cast<jboolean>(JNI_FALSE), [&] {
    const auto session = FindSession(handle);
    if (!session || !session->Destroy()) return static_cast<jboolean>(JNI_FALSE);
    // Retain the registry's ownership until Stop has joined the worker. If
    // Stop throws, a subsequent call can still find and finish this session.
    std::lock_guard<std::mutex> lock(sessions_mutex);
    const auto found = sessions.find(handle);
    if (found != sessions.end() && found->second == session) sessions.erase(found);
    return static_cast<jboolean>(JNI_TRUE);
  });
}

jboolean NativeStart(JNIEnv* env, jobject, jlong handle, jstring profile,
                     jstring alias, jstring expected_ipv4, jstring expected_ipv6) noexcept {
  return JniGuard(env, static_cast<jboolean>(JNI_FALSE), [&] {
    auto session = FindSession(handle);
    if (!session) return static_cast<jboolean>(JNI_FALSE);
    auto profile_value = ReadUtf8(env, profile, kMaxProfileUtf8Bytes);
    if (!profile_value) return static_cast<jboolean>(JNI_FALSE);
    ScopedStringErase erase_profile(*profile_value);
    auto alias_value = ReadUtf8(env, alias, kMaxAliasUtf8Bytes);
    if (!alias_value) return static_cast<jboolean>(JNI_FALSE);
    ScopedStringErase erase_alias(*alias_value);
    auto ipv4_value = ReadUtf8(env, expected_ipv4, 15);
    if (!ipv4_value) return static_cast<jboolean>(JNI_FALSE);
    auto ipv6_value = ReadUtf8(env, expected_ipv6, 45);
    if (!ipv6_value) return static_cast<jboolean>(JNI_FALSE);
    const bool started = session->Start(std::move(*profile_value), std::move(*alias_value),
        NetworkPolicy{std::move(*ipv4_value), std::move(*ipv6_value)});
    return static_cast<jboolean>(started ? JNI_TRUE : JNI_FALSE);
  });
}

jboolean NativeStop(JNIEnv* env, jobject, jlong handle) noexcept {
  return JniGuard(env, static_cast<jboolean>(JNI_FALSE), [&] {
    if (auto session = FindSession(handle)) {
      session->Stop();
      return static_cast<jboolean>(session->IsConnected() ? JNI_FALSE : JNI_TRUE);
    }
    return static_cast<jboolean>(JNI_FALSE);
  });
}

jboolean NativeIsConnected(JNIEnv* env, jobject, jlong handle) noexcept {
  return JniGuard(env, static_cast<jboolean>(JNI_FALSE), [&] {
    if (auto session = FindSession(handle)) {
      return static_cast<jboolean>(session->IsConnected() ? JNI_TRUE : JNI_FALSE);
    }
    return static_cast<jboolean>(JNI_FALSE);
  }, true);
}

jlongArray NativeStatistics(JNIEnv* env, jobject, jlong handle) noexcept {
  return JniGuard(env, static_cast<jlongArray>(nullptr), [&]() -> jlongArray {
    if (env == nullptr) return nullptr;
    const auto session = FindSession(handle);
    if (!session) return nullptr;
    const CoreStatistics stats = session->Statistics();
    const jlong values[] = {
        static_cast<jlong>(std::max<long long>(0, stats.received_bytes)),
        static_cast<jlong>(std::max<long long>(0, stats.sent_bytes)),
    };
    LocalRef<jlongArray> result(env, env->NewLongArray(2));
    if (ClearException(env) || result.get() == nullptr) return nullptr;
    env->SetLongArrayRegion(result.get(), 0, 2, values);
    if (ClearException(env)) return nullptr;
    return result.release();
  });
}

const JNINativeMethod kMethods[] = {
    {const_cast<char*>("nativeIsCoreAvailable"), const_cast<char*>("()Z"),
     reinterpret_cast<void*>(NativeIsCoreAvailable)},
    {const_cast<char*>("nativeCreate"),
     const_cast<char*>("(Lcom/fuzevpn/android/openvpn/OpenVpnNative$Callback;)J"),
     reinterpret_cast<void*>(NativeCreate)},
    {const_cast<char*>("nativeDestroy"), const_cast<char*>("(J)Z"),
     reinterpret_cast<void*>(NativeDestroy)},
    {const_cast<char*>("nativeStart"),
     const_cast<char*>("(JLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z"),
     reinterpret_cast<void*>(NativeStart)},
    {const_cast<char*>("nativeStop"), const_cast<char*>("(J)Z"),
     reinterpret_cast<void*>(NativeStop)},
    {const_cast<char*>("nativeIsConnected"), const_cast<char*>("(J)Z"),
     reinterpret_cast<void*>(NativeIsConnected)},
    {const_cast<char*>("nativeStatistics"), const_cast<char*>("(J)[J"),
     reinterpret_cast<void*>(NativeStatistics)},
};

}  // namespace
}  // namespace fuzevpn::openvpn

extern "C" JNIEXPORT jint JNICALL JNI_OnLoad(JavaVM* vm, void*) {
  JNIEnv* env = nullptr;
  if (vm == nullptr || vm->GetEnv(reinterpret_cast<void**>(&env), JNI_VERSION_1_6) != JNI_OK ||
      env == nullptr) {
    return JNI_ERR;
  }
  jclass clazz = env->FindClass("com/fuzevpn/android/openvpn/OpenVpnNative");
  if (clazz == nullptr || env->ExceptionCheck()) {
    if (env->ExceptionCheck()) env->ExceptionClear();
    return JNI_ERR;
  }
  const jint status = env->RegisterNatives(
      clazz, fuzevpn::openvpn::kMethods,
      static_cast<jint>(sizeof(fuzevpn::openvpn::kMethods) /
                        sizeof(fuzevpn::openvpn::kMethods[0])));
  env->DeleteLocalRef(clazz);
  if (status != JNI_OK || env->ExceptionCheck()) {
    if (env->ExceptionCheck()) env->ExceptionClear();
    return JNI_ERR;
  }
  return JNI_VERSION_1_6;
}
