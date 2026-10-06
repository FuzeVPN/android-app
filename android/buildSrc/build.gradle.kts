plugins {
    java
}

java {
    toolchain.languageVersion.set(JavaLanguageVersion.of(17))
}

// No network dependencies: these checks use only the JDK and the reviewed AAR.
val testWireGuardPolicy by tasks.registering(JavaExec::class) {
    dependsOn(tasks.testClasses)
    classpath = sourceSets.test.get().runtimeClasspath
    mainClass.set("com.fuzevpn.build.WireGuardAarPolicyTest")
    args(file("../third_party/wireguard-android/dist/tunnel-1.0.20260102-fuzevpn-fgs.aar"))
}
// The regression suite is an executable main, not a JUnit test class.
tasks.test { enabled = false }
val testNativeBundlePolicy by tasks.registering(JavaExec::class) {
    dependsOn(tasks.testClasses)
    classpath = sourceSets.test.get().runtimeClasspath
    mainClass.set("com.fuzevpn.build.NativeBundlePolicyTest")
    args(file("../app/src/main/cpp/third_party"), file("../native-provenance/bundle.sha256"))
}
val testAndroidManifestPolicy by tasks.registering(JavaExec::class) {
    dependsOn(tasks.testClasses)
    classpath = sourceSets.test.get().runtimeClasspath
    mainClass.set("com.fuzevpn.build.AndroidManifestPolicyTest")
}
tasks.check { dependsOn(testWireGuardPolicy, testNativeBundlePolicy, testAndroidManifestPolicy) }
