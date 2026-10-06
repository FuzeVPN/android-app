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

std::optional<std::string> ReadUtf8(JNIEnv* env, jstring value, size_t maximum) {
  if (env == nullptr || value == nullptr) return std::nullopt;
  const jsize bytes = env->GetStringUTFLength(value);
  if (bytes < 0 || static_cast<size_t>(bytes) > maximum) return std::nullopt;
  const char* chars = env->GetStringUTFChars(value, nullptr);
  if (chars == nullptr || ClearException(env)) return std::nullopt;
  std::string result(chars, static_cast<size_t>(bytes));
  env->ReleaseStringUTFChars(value, chars);
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
    if (callback_ == nullptr || ClearException(env)) {
      callback_ = nullptr;
      return;
    }
    jclass callback_class = env->GetObjectClass(callback);
    if (callback_class == nullptr || ClearException(env)) {
      Release(env);
      return;
    }
    on_state_ = env->GetMethodID(callback_class, "onNativeState",
                                 "(Ljava/lang/String;Ljava/lang/String;)V");
    on_tun_ = env->GetMethodID(callback_class, "onTunConfiguration",
                               "(Ljava/lang/String;)I");
    on_protect_ = env->GetMethodID(callback_class, "onProtectSocket", "(I)Z");
    on_certificate_ = env->GetMethodID(callback_class, "onPkiCertificate",
                                       "(Ljava/lang/String;)Ljava/lang/String;");
    on_sign_ = env->GetMethodID(
        callback_class, "onPkiSign",
        "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;");
    env->DeleteLocalRef(callback_class);
    if (ClearException(env) || on_state_ == nullptr || on_tun_ == nullptr ||
        on_protect_ == nullptr || on_certificate_ == nullptr || on_sign_ == nullptr) {
      Release(env);
    }
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
    jstring state_value = env->NewStringUTF(std::string(state).c_str());
    jstring reason_value = env->NewStringUTF(std::string(reason).c_str());
    if (state_value != nullptr && reason_value != nullptr && !ClearException(env)) {
      env->CallVoidMethod(callback_, on_state_, state_value, reason_value);
      ClearException(env);
    }
    if (state_value != nullptr) env->DeleteLocalRef(state_value);
    if (reason_value != nullptr) env->DeleteLocalRef(reason_value);
  }

  int EstablishTun(const TunPlan& plan) override {
    std::string json = PlanJson(plan);
    std::lock_guard<std::mutex> lock(callback_mutex_);
    ScopedEnv scoped(vm_);
    JNIEnv* env = scoped.get();
    if (env == nullptr || callback_ == nullptr) return -1;
    jstring value = env->NewStringUTF(json.c_str());
    SecureErase(&json);
    if (value == nullptr || ClearException(env)) return -1;
    const jint descriptor = env->CallIntMethod(callback_, on_tun_, value);
    const bool failed = ClearException(env);
    env->DeleteLocalRef(value);
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
    jstring alias_value = env->NewStringUTF(std::string(alias).c_str());
    if (alias_value == nullptr || ClearException(env)) return std::nullopt;

    jobject returned = nullptr;
    jstring data_value = nullptr;
    jstring algorithm_value = nullptr;
    jstring hash_value = nullptr;
    jstring salt_value = nullptr;
    if (signature) {
      data_value = env->NewStringUTF(std::string(data).c_str());
      algorithm_value = env->NewStringUTF(std::string(algorithm).c_str());
      hash_value = env->NewStringUTF(std::string(hash_algorithm).c_str());
      salt_value = env->NewStringUTF(std::string(salt_length).c_str());
      if (data_value == nullptr || algorithm_value == nullptr || hash_value == nullptr ||
          salt_value == nullptr || ClearException(env)) {
        if (data_value != nullptr) env->DeleteLocalRef(data_value);
        if (algorithm_value != nullptr) env->DeleteLocalRef(algorithm_value);
        if (hash_value != nullptr) env->DeleteLocalRef(hash_value);
        if (salt_value != nullptr) env->DeleteLocalRef(salt_value);
        env->DeleteLocalRef(alias_value);
        return std::nullopt;
      }
      returned = env->CallObjectMethod(callback_, method, alias_value, data_value,
                                       algorithm_value, hash_value, salt_value);
    } else {
      returned = env->CallObjectMethod(callback_, method, alias_value);
    }
    const bool failed = ClearException(env);
    std::optional<std::string> result;
    if (!failed && returned != nullptr) {
      result = ReadUtf8(env, static_cast<jstring>(returned), maximum);
      if (result && signature && !IsBase64(*result)) {
        SecureErase(&*result);
        result.reset();
      }
    }
    if (returned != nullptr) env->DeleteLocalRef(returned);
    if (data_value != nullptr) env->DeleteLocalRef(data_value);
    if (algorithm_value != nullptr) env->DeleteLocalRef(algorithm_value);
    if (hash_value != nullptr) env->DeleteLocalRef(hash_value);
    if (salt_value != nullptr) env->DeleteLocalRef(salt_value);
    env->DeleteLocalRef(alias_value);
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
    std::lock_guard<std::mutex> lock(mutex_);
    if (!valid()) return false;
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
    if (!started_) return;
    callbacks_->OnCoreState("disconnecting", "disconnecting");
    core_->Stop();
    started_ = false;
    callbacks_->OnCoreState("idle", "disconnected");
  }

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
};

std::mutex sessions_mutex;
std::unordered_map<jlong, std::shared_ptr<NativeSession>> sessions;

std::shared_ptr<NativeSession> FindSession(jlong handle) {
  if (handle == 0) return {};
  std::lock_guard<std::mutex> lock(sessions_mutex);
  const auto found = sessions.find(handle);
  return found == sessions.end() ? std::shared_ptr<NativeSession>{} : found->second;
}

jboolean NativeIsCoreAvailable(JNIEnv*, jobject) {
  return IsCoreAvailable() ? JNI_TRUE : JNI_FALSE;
}

jlong NativeCreate(JNIEnv* env, jobject, jobject callback) {
  try {
    auto callbacks = std::make_unique<JniPlatformCallbacks>(env, callback);
    auto session = std::make_shared<NativeSession>(std::move(callbacks));
    if (!session->valid()) return 0;
    const jlong handle = reinterpret_cast<jlong>(session.get());
    std::lock_guard<std::mutex> lock(sessions_mutex);
    sessions.emplace(handle, std::move(session));
    return handle;
  } catch (...) {
    // Do not expose native exception text across the security boundary.
    return 0;
  }
}

jboolean NativeDestroy(JNIEnv*, jobject, jlong handle) {
  std::shared_ptr<NativeSession> session;
  {
    std::lock_guard<std::mutex> lock(sessions_mutex);
    const auto found = sessions.find(handle);
    if (found == sessions.end()) return JNI_FALSE;
    session = std::move(found->second);
    sessions.erase(found);
  }
  session->Stop();
  // Return success only after Stop joined Core's worker and the privileged
  // native session is no longer reachable from the process registry.
  return FindSession(handle) == nullptr ? JNI_TRUE : JNI_FALSE;
}

jboolean NativeStart(JNIEnv* env, jobject, jlong handle, jstring profile,
                     jstring alias, jstring expected_ipv4, jstring expected_ipv6) {
  auto session = FindSession(handle);
  if (!session) return JNI_FALSE;
  auto profile_value = ReadUtf8(env, profile, kMaxProfileUtf8Bytes);
  auto alias_value = ReadUtf8(env, alias, kMaxAliasUtf8Bytes);
  auto ipv4_value = ReadUtf8(env, expected_ipv4, 15);
  auto ipv6_value = ReadUtf8(env, expected_ipv6, 45);
  if (!profile_value || !alias_value || !ipv4_value || !ipv6_value) {
    if (profile_value) SecureErase(&*profile_value);
    if (alias_value) SecureErase(&*alias_value);
    return JNI_FALSE;
  }
  const bool started = session->Start(std::move(*profile_value), std::move(*alias_value),
      NetworkPolicy{std::move(*ipv4_value), std::move(*ipv6_value)});
  return started ? JNI_TRUE : JNI_FALSE;
}

jboolean NativeStop(JNIEnv*, jobject, jlong handle) {
  if (auto session = FindSession(handle)) {
    session->Stop();
    return session->IsConnected() ? JNI_FALSE : JNI_TRUE;
  }
  return JNI_FALSE;
}

jboolean NativeIsConnected(JNIEnv*, jobject, jlong handle) {
  if (auto session = FindSession(handle)) {
    return session->IsConnected() ? JNI_TRUE : JNI_FALSE;
  }
  return JNI_FALSE;
}

jlongArray NativeStatistics(JNIEnv* env, jobject, jlong handle) {
  if (env == nullptr) return nullptr;
  const auto session = FindSession(handle);
  if (!session) return nullptr;
  const CoreStatistics stats = session->Statistics();
  const jlong values[] = {
      static_cast<jlong>(std::max<long long>(0, stats.received_bytes)),
      static_cast<jlong>(std::max<long long>(0, stats.sent_bytes)),
  };
  jlongArray result = env->NewLongArray(2);
  if (result == nullptr || ClearException(env)) return nullptr;
  env->SetLongArrayRegion(result, 0, 2, values);
  if (ClearException(env)) {
    env->DeleteLocalRef(result);
    return nullptr;
  }
  return result;
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
