// Exercises the original JNI translation unit with a strict simulated JNIEnv.
// Every non-cleanup JNI operation asserts that no exception is pending.
#include <cassert>
#include <atomic>
#include <chrono>
#include <condition_variable>
#include <future>
#include <iostream>
#include <stdexcept>
#include <unordered_set>
#ifdef _MSC_VER
// Android's single copied jni.h uses a visibility attribute unavailable to
// MSVC. Ignore that export decoration in this offline executable only.
#define __attribute__(ignored)
#endif
#include "../../main/cpp/openvpn_jni.cpp"

using namespace fuzevpn::openvpn;
using namespace std::chrono_literals;
namespace {
struct String final : _jstring { explicit String(std::string text) : text(std::move(text)) {} std::string text; };
struct Array final : _jlongArray {};
struct Environment {
  bool pending = false;
  int globals = 0, methods = 0, strings = 0, lengths = 0, reads = 0, releases = 0, arrays = 0, stores = 0;
  int fail_global = 0, fail_class = 0, fail_method = 0, fail_string = 0, fail_length = 0, fail_read = 0, fail_array = 0, fail_store = 0;
  int java_calls = 0;
  std::unordered_set<jobject> string_refs;
  std::unordered_set<jobject> array_refs;
  void ResetFailures() {
    pending = false;
    methods = strings = lengths = reads = releases = arrays = stores = java_calls = 0;
    fail_global = fail_class = fail_method = fail_string = fail_length = fail_read = fail_array = fail_store = 0;
  }
  void NormalCall() const { assert(!pending && "JNI operation while an exception is pending"); }
} mock;
JNINativeInterface functions{};
JNIInvokeInterface invocation{};
JNIEnv environment{&functions};
JavaVM machine{&invocation};
_jobject callback;
_jclass callback_class;

struct Control {
  std::mutex mutex;
  std::condition_variable changed;
  std::atomic<int> starts{0}, stops{0};
  bool throw_start = false, throw_stop = false, throw_stats = false, throw_connected = false;
  bool block_stop = false, stop_entered = false, release_stop = false;
} control;

class TestCore final : public CoreSession {
 public:
  bool Start(ValidatedProfile profile, std::string_view, PlatformCallbacks*) override {
    ScopedStringErase erase(profile.content);
    ++control.starts;
    if (control.throw_start) throw std::bad_alloc();
    connected_ = true;
    return true;
  }
  void Stop() override {
    ++control.stops;
    if (control.throw_stop) throw std::runtime_error("injected stop failure");
    std::unique_lock<std::mutex> lock(control.mutex);
    control.stop_entered = true;
    control.changed.notify_all();
    if (control.block_stop) control.changed.wait(lock, [] { return control.release_stop; });
    connected_ = false;
  }
  bool IsConnected() const override {
    if (control.throw_connected) throw std::runtime_error("injected proof failure");
    return connected_;
  }
  CoreStatistics Statistics() const override {
    if (control.throw_stats) throw std::bad_alloc();
    return {7, 9};
  }
 private:
  bool connected_ = false;
};

void InitializeJni() {
  functions.ExceptionCheck = [](JNIEnv*) -> jboolean { return mock.pending ? JNI_TRUE : JNI_FALSE; };
  functions.ExceptionClear = [](JNIEnv*) { mock.pending = false; };
  functions.GetJavaVM = [](JNIEnv*, JavaVM** vm) -> jint { mock.NormalCall(); *vm = &machine; return JNI_OK; };
  functions.NewGlobalRef = [](JNIEnv*, jobject value) -> jobject {
    mock.NormalCall();
    if (mock.fail_global) { mock.pending = true; return nullptr; }
    ++mock.globals; return value;
  };
  functions.DeleteGlobalRef = [](JNIEnv*, jobject) { assert(mock.globals > 0); --mock.globals; };
  functions.GetObjectClass = [](JNIEnv*, jobject) -> jclass {
    mock.NormalCall();
    if (mock.fail_class) { mock.pending = true; return nullptr; }
    return &callback_class;
  };
  functions.GetMethodID = [](JNIEnv*, jclass, const char*, const char*) -> jmethodID {
    mock.NormalCall();
    if (++mock.methods == mock.fail_method) { mock.pending = true; return nullptr; }
    return reinterpret_cast<jmethodID>(static_cast<uintptr_t>(mock.methods));
  };
  functions.NewStringUTF = [](JNIEnv*, const char* value) -> jstring {
    mock.NormalCall();
    if (++mock.strings == mock.fail_string) { mock.pending = true; return nullptr; }
    auto* text = new String(value);
    mock.string_refs.insert(text);
    return text;
  };
  functions.DeleteLocalRef = [](JNIEnv*, jobject value) {
    if (mock.string_refs.erase(value)) delete static_cast<String*>(value);
    if (mock.array_refs.erase(value)) delete static_cast<Array*>(value);
  };
  functions.GetStringUTFLength = [](JNIEnv*, jstring value) -> jsize {
    mock.NormalCall();
    if (++mock.lengths == mock.fail_length) { mock.pending = true; return -1; }
    return static_cast<jsize>(static_cast<String*>(value)->text.size());
  };
  functions.GetStringUTFChars = [](JNIEnv*, jstring value, jboolean*) -> const char* {
    mock.NormalCall();
    if (++mock.reads == mock.fail_read) { mock.pending = true; return nullptr; }
    return static_cast<String*>(value)->text.c_str();
  };
  functions.ReleaseStringUTFChars = [](JNIEnv*, jstring, const char*) { ++mock.releases; };
  functions.CallVoidMethodV = [](JNIEnv*, jobject, jmethodID, va_list) { mock.NormalCall(); ++mock.java_calls; };
  functions.CallObjectMethodV = [](JNIEnv*, jobject, jmethodID, va_list) -> jobject { mock.NormalCall(); ++mock.java_calls; return nullptr; };
  functions.CallIntMethodV = [](JNIEnv*, jobject, jmethodID, va_list) -> jint { mock.NormalCall(); ++mock.java_calls; return -1; };
  functions.CallBooleanMethodV = [](JNIEnv*, jobject, jmethodID, va_list) -> jboolean { mock.NormalCall(); ++mock.java_calls; return JNI_TRUE; };
  functions.NewLongArray = [](JNIEnv*, jsize) -> jlongArray {
    mock.NormalCall();
    if (++mock.arrays == mock.fail_array) { mock.pending = true; return nullptr; }
    auto* array = new Array(); mock.array_refs.insert(array); return array;
  };
  functions.SetLongArrayRegion = [](JNIEnv*, jlongArray, jsize, jsize, const jlong*) {
    mock.NormalCall(); if (++mock.stores == mock.fail_store) mock.pending = true;
  };
  functions.FindClass = [](JNIEnv*, const char*) -> jclass { mock.NormalCall(); return &callback_class; };
  functions.ThrowNew = [](JNIEnv*, jclass, const char* text) -> jint {
    mock.NormalCall(); assert(std::string_view(text) == "openvpn_native_state_unavailable"); mock.pending = true; return JNI_OK;
  };
  functions.RegisterNatives = [](JNIEnv*, jclass, const JNINativeMethod*, jint) -> jint { mock.NormalCall(); return JNI_OK; };
  invocation.GetEnv = [](JavaVM*, void** env, jint) -> jint { *env = &environment; return JNI_OK; };
  invocation.AttachCurrentThread = [](JavaVM*, JNIEnv** env, void*) -> jint { *env = &environment; return JNI_OK; };
  invocation.DetachCurrentThread = [](JavaVM*) -> jint { return JNI_OK; };
}

// Inline blocks hold PEM only (A12-openvpn-native-01); the key body is the
// base64 of "offline-synthetic-placeholder".
const std::string synthetic_key("-----BEGIN OpenVPN tls-crypt-v2 client key-----\nb2ZmbGluZS1zeW50aGV0aWMtcGxhY2Vob2xkZXI=\n-----END OpenVPN tls-crypt-v2 client key-----");
String profile("client\ndev tun\nproto udp4\nremote 192.0.2.1 1194\nnobind\nremote-cert-tls server\nverify-x509-name server.example name\nEXTERNAL_PKI true\nAUTOLOGIN true\nauth-nocache\nallow-compression no\nblock-ipv6\ndata-ciphers AES-256-GCM\ndhcp-option DNS 192.0.2.53\n<ca>\n-----BEGIN CERTIFICATE-----\nAAAAAAAA\n-----END CERTIFICATE-----\n</ca>\n<tls-crypt-v2>\n" + synthetic_key + "\n</tls-crypt-v2>\n");
String alias("offline.alias"), empty("");
bool Start(jlong handle) { return NativeStart(&environment, nullptr, handle, &profile, &alias, &empty, &empty) == JNI_TRUE; }
jlong Create() {
  const jlong handle = NativeCreate(&environment, nullptr, &callback);
  assert(handle != 0); return handle;
}
void Destroy(jlong handle) {
  assert(NativeDestroy(&environment, nullptr, handle) == JNI_TRUE);
  assert(!FindSession(handle));
  assert(!mock.pending && mock.globals == 0 && mock.string_refs.empty() && mock.array_refs.empty());
}
}

namespace fuzevpn::openvpn {
bool IsCoreAvailable() { return true; }
std::unique_ptr<CoreSession> CreateCoreSession() { return std::make_unique<TestCore>(); }
}

int main() {
  InitializeJni();
  int cases = 0;
  assert(JNI_OnLoad(&machine, nullptr) == JNI_VERSION_1_6);
  mock.fail_global = 1;
  assert(NativeCreate(&environment, nullptr, &callback) == 0);
  assert(!mock.pending && mock.globals == 0); ++cases;
  mock.ResetFailures(); mock.fail_class = 1;
  assert(NativeCreate(&environment, nullptr, &callback) == 0);
  assert(!mock.pending && mock.globals == 0); ++cases;
  for (int failure = 1; failure <= 5; ++failure) {
    mock.ResetFailures(); mock.fail_method = failure;
    assert(NativeCreate(&environment, nullptr, &callback) == 0);
    assert(mock.methods == failure && !mock.pending && mock.globals == 0); ++cases;
  }
  for (int failure = 1; failure <= 2; ++failure) {
    mock.ResetFailures();
    { JniPlatformCallbacks callbacks(&environment, &callback);
      mock.fail_string = failure;
      callbacks.OnCoreState("error", "offline_failure");
      assert(mock.strings == failure && !mock.pending && mock.string_refs.empty());
      assert(mock.java_calls == 0);
    }
    assert(mock.globals == 0); ++cases;
  }
  for (int failure = 1; failure <= 5; ++failure) {
    mock.ResetFailures();
    { JniPlatformCallbacks callbacks(&environment, &callback);
      mock.fail_string = failure;
      assert(!callbacks.PkiSign("offline.alias", "AAAA", "ECDSA", "SHA256", ""));
      assert(mock.strings == failure && !mock.pending && mock.string_refs.empty() && mock.java_calls == 0);
    }
    assert(mock.globals == 0); ++cases;
  }
  for (bool length_failure : {false, true}) {
    for (int failure = 1; failure <= 4; ++failure) {
      mock.ResetFailures(); const auto handle = Create(); const int starts = control.starts;
      if (length_failure) mock.fail_length = failure; else mock.fail_read = failure;
      assert(!Start(handle));
      assert(!mock.pending && control.starts == starts);
      assert(mock.lengths == failure);
      assert(mock.reads == (length_failure ? failure - 1 : failure));
      assert(mock.releases == failure - 1);
      mock.ResetFailures(); Destroy(handle); ++cases;
    }
  }
  for (bool store_failure : {false, true}) {
    mock.ResetFailures(); const auto handle = Create(); assert(Start(handle));
    if (store_failure) mock.fail_store = 1; else mock.fail_array = 1;
    assert(NativeStatistics(&environment, nullptr, handle) == nullptr);
    assert(!mock.pending && mock.array_refs.empty());
    assert(mock.stores == (store_failure ? 1 : 0));
    mock.ResetFailures(); Destroy(handle); ++cases;
  }
  {
    mock.ResetFailures(); const auto handle = Create();
    control.throw_start = true; assert(!Start(handle)); control.throw_start = false;
    assert(!mock.pending && mock.reads == mock.releases);
    Destroy(handle); ++cases;
  }
  {
    mock.ResetFailures(); const auto handle = Create(); assert(Start(handle));
    control.throw_stats = true;
    assert(NativeStatistics(&environment, nullptr, handle) == nullptr);
    control.throw_stats = false;
    control.throw_connected = true;
    assert(NativeIsConnected(&environment, nullptr, handle) == JNI_FALSE);
    assert(mock.pending); // managed exception preserves unknown proof semantics
    control.throw_connected = false; mock.pending = false;
    Destroy(handle); ++cases;
  }
  {
    mock.ResetFailures(); const auto handle = Create(); assert(Start(handle));
    control.throw_stop = true;
    assert(NativeDestroy(&environment, nullptr, handle) == JNI_FALSE);
    assert(FindSession(handle));
    const int starts = control.starts;
    assert(!Start(handle)); assert(control.starts == starts);
    control.throw_stop = false;
    Destroy(handle); ++cases;
  }
  {
    mock.ResetFailures(); const auto handle = Create(); assert(Start(handle));
    auto retained = FindSession(handle);
    { std::lock_guard<std::mutex> lock(control.mutex);
      control.block_stop = true; control.stop_entered = control.release_stop = false;
    }
    auto destroyed = std::async(std::launch::async, [&] { return NativeDestroy(&environment, nullptr, handle); });
    { std::unique_lock<std::mutex> lock(control.mutex);
      assert(control.changed.wait_for(lock, 2s, [] { return control.stop_entered; }));
    }
    assert(destroyed.wait_for(0ms) == std::future_status::timeout);
    assert(FindSession(handle)); // no early removal/proof while Stop is pending
    { std::lock_guard<std::mutex> lock(control.mutex); control.release_stop = true; control.changed.notify_all(); }
    assert(destroyed.wait_for(2s) == std::future_status::ready);
    assert(destroyed.get() == JNI_TRUE && !FindSession(handle));
    const int starts = control.starts;
    assert(!retained->Start(profile.text, alias.text, {})); assert(control.starts == starts);
    retained.reset(); control.block_stop = false;
    assert(mock.globals == 0);
    assert(NativeDestroy(&environment, nullptr, handle) == JNI_FALSE); // absent is no proof
    ++cases;
  }
  {
    std::string secret("offline temporary");
    try { ScopedStringErase erase(secret); throw std::runtime_error("injected exit"); }
    catch (const std::runtime_error&) {}
    assert(secret.empty()); ++cases;
  }
  // Validation still accepts a nonempty synthetic TLS container and rejects a
  // whitespace-only one; validation no longer needs to copy that container.
  {
    ProfileFailure failure{};
    assert(ProfileValidator::Validate(profile.text, alias.text, &failure));
    auto whitespace = profile.text;
    const auto at = whitespace.find(synthetic_key);
    whitespace.replace(at, synthetic_key.size(), " \t ");
    assert(!ProfileValidator::Validate(whitespace, alias.text, &failure));
    assert(failure == ProfileFailure::kInvalidTlsCryptV2); ++cases;
    // The 8 KiB bound counts every container line plus its newline: 48-byte
    // BEGIN, 124 base64 lines of 65 bytes, a last line, then the 46-byte END.
    // PEM lines stay below Core's 512-byte line limit.
    const auto sized = [](size_t last) {
      std::string key = "-----BEGIN OpenVPN tls-crypt-v2 client key-----\n";
      for (int line = 0; line < 124; ++line) key += std::string(64, 'x') + "\n";
      return key + std::string(last, 'x') + "\n-----END OpenVPN tls-crypt-v2 client key-----";
    };
    auto maximum = profile.text;
    maximum.replace(at, synthetic_key.size(), sized(37));  // 8192 bytes
    assert(ProfileValidator::Validate(maximum, alias.text, &failure)); ++cases;
    auto oversized = profile.text;
    oversized.replace(at, synthetic_key.size(), sized(38));  // 8193 bytes
    assert(!ProfileValidator::Validate(oversized, alias.text, &failure));
    assert(failure == ProfileFailure::kInvalidTlsCryptV2); ++cases;
  }
  {
    // No TUN on this host: no name, and no Java string is ever made.
    mock.ResetFailures();
    assert(NativeTunInterfaceName(&environment, nullptr, -1) == nullptr);
    assert(NativeTunInterfaceName(&environment, nullptr, 0) == nullptr);
    assert(NativeTunInterfaceName(nullptr, nullptr, 0) == nullptr);
    assert(!mock.pending && mock.strings == 0); ++cases;
  }
  assert(sessions.empty() && !mock.pending && mock.globals == 0 && mock.string_refs.empty() && mock.array_refs.empty());
  std::cout << cases << " original-JNI injected failure/lifecycle cases passed\n";
}
