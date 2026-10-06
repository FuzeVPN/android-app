@file:Suppress("UnstableApiUsage")

import com.android.build.api.artifact.SingleArtifact

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

// Maven is a debug-only development fallback. Every other build type requires
// explicit selection of the approved local AAR and verification before use.
val usePatchedWireGuardAar = providers.gradleProperty("fuzevpn.usePatchedWireGuardAar")
    .map { value -> value.equals("true", ignoreCase = true) }
    .orElse(false)
val patchedWireGuardAar = rootProject.file(
    "third_party/wireguard-android/dist/tunnel-1.0.20260102-fuzevpn-fgs.aar",
)
val nativeBundleRoot = file("src/main/cpp/third_party")
val nativeBundleManifest = rootProject.file("native-provenance/bundle.sha256")
val verifyNativeBundle = tasks.register("verifyNativeBundle") {
    group = "verification"
    description = "Verify every reviewed OpenVPN/native file before building"
    // No outputs and no up-to-date exemption: changed native archives must be
    // rejected even when CMake configuration or compilation would be up-to-date.
    doLast {
        com.fuzevpn.build.NativeBundlePolicy.verify(nativeBundleRoot.toPath(), nativeBundleManifest.toPath())
    }
}
tasks.configureEach {
    if (name.matches(Regex("pre.*Build|generate.*BuildConfig")) ||
        name.startsWith("configureCMake") || name.startsWith("buildCMake") ||
        name.startsWith("externalNativeBuild")) {
        dependsOn(verifyNativeBundle)
    }
}

android {
    namespace = "com.fuzevpn.android"
    compileSdk = 36
    ndkVersion = "28.2.13676358"

    defaultConfig {
        applicationId = "com.fuzevpn"
        testApplicationId = "com.fuzevpn.test"
        manifestPlaceholders["fuzevpnSupportsAlwaysOn"] = usePatchedWireGuardAar.get().toString()
        minSdk = 26
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        // Match all native dependencies to Flutter's selected targets for
        // bundles and universal APKs. Flutter's default filter includes x86_64
        // even when --target-platform requests only ARM. ABI splits perform
        // their own filtering and cannot be combined with NDK abiFilters.
        val splitPerAbi = providers.gradleProperty("split-per-abi")
            .map { it.toBoolean() }.orElse(false).get()
        val targetPlatforms = providers.gradleProperty("target-platform").orNull
        if (!splitPerAbi && targetPlatforms != null) {
            val targetAbis = targetPlatforms.split(",").map { platform ->
                when (platform) {
                    "android-arm" -> "armeabi-v7a"
                    "android-arm64" -> "arm64-v8a"
                    "android-x64" -> "x86_64"
                    else -> throw GradleException("Unsupported Android target: $platform")
                }
            }
            ndk.abiFilters.clear()
            ndk.abiFilters.addAll(targetAbis)
        }

        externalNativeBuild {
            cmake {
                arguments += listOf(
                    "-DANDROID_STL=c++_shared",
                    "-DANDROID_SUPPORT_FLEXIBLE_PAGE_SIZES=ON",
                    // Core and OpenSSL are imported in src/main/cpp/third_party.
                    // OpenVPN's upstream XKey provider delegates P-256 ECDSA
                    // signatures to the non-exportable Android Keystore key.
                    "-DFUZEVPN_ENABLE_OPENVPN3_CORE=ON",
                )
                cppFlags += "-std=c++20"
            }
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro",
            )
        }
    }

    externalNativeBuild {
        cmake {
            path = file("src/main/cpp/CMakeLists.txt")
            version = "3.22.1"
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    buildFeatures {
        buildConfig = true
    }

    // Notifications and the quick-settings tile follow the in-app locale.
    // Keep every translated Android resource in the base install so this
    // continues to work for APKs and future app bundles without Play Core.
    bundle {
        language {
            enableSplit = false
        }
    }

    lint {
        // AGP 9.3's CommentDetector crashes while inspecting the current
        // url_launcher Android source on JDK 17 (List.removeLast linkage).
        // These non-security comment-only checks are the two detectors named
        // by lint itself; all relevant Android/VPN lint checks remain active.
        disable += setOf("EasterEgg", "StopShip")
        // This project deliberately pins the SDK/toolchain matrix requested
        // for the product. Version-availability checks are not code defects
        // and would make offline/reproducible validation contact repositories.
        disable += setOf(
            "OldTargetApi",
            "AndroidGradlePluginVersion",
            "GradleDependency",
            "NewerVersionAvailable",
            // Flutter regenerates the ignored local.properties file using a
            // Windows path form that AGP's PropertyEscape detector rejects.
            // It is never packaged and cannot affect the shipped APK.
            "PropertyEscape",
        )
    }

    packaging {
        jniLibs {
            pickFirsts += "lib/**/libc++_shared.so"
        }
        resources {
            excludes += setOf("META-INF/DEPENDENCIES", "META-INF/LICENSE*", "META-INF/NOTICE*")
        }
    }
}

// Flutter creates profile from debug. Set both the runtime and BuildConfig per
// build type so profile cannot inherit the unpatched development configuration.
val wireGuardChecks = mutableMapOf<String, TaskProvider<Task>>()
android.buildTypes.configureEach {
    val type = name
    val selected = usePatchedWireGuardAar.get()
    val needsPatchedRuntime = type != "debug" || selected
    buildConfigField("boolean", "USE_PATCHED_WIREGUARD_AAR", needsPatchedRuntime.toString())
    val verification = tasks.register("verify${type.replaceFirstChar { it.uppercaseChar() }}WireGuardAar") {
        group = "verification"
        description = "Verify the approved WireGuard runtime for $type"
        // No outputs: re-read the artifact on every invocation, including warm builds.
        doLast {
            com.fuzevpn.build.WireGuardAarPolicy.verify(type, selected, patchedWireGuardAar.toPath())
        }
    }
    wireGuardChecks[type] = verification
    if (needsPatchedRuntime) {
        dependencies.add("${type}Implementation", files(patchedWireGuardAar).builtBy(verification))
    } else {
        dependencies.add("${type}Implementation", "com.wireguard.android:tunnel:1.0.20260102")
    }
}

androidComponents.onVariants { variant ->
    val verification = wireGuardChecks.getValue(requireNotNull(variant.buildType))
    val suffix = variant.name.replaceFirstChar { it.uppercaseChar() }
    tasks.matching { it.name == "pre${suffix}Build" || it.name == "generate${suffix}BuildConfig" }
        .configureEach { dependsOn(verification) }
    val mergedManifest = variant.artifacts.get(SingleArtifact.MERGED_MANIFEST)
    val permissionCheck = tasks.register("verify${suffix}MergedPermissions") {
        group = "verification"
        description = "Reject unreviewed permissions in the final $suffix app manifest"
        inputs.file(mergedManifest)
        // Inputs establish the dependency on manifest merging. No outputs keeps
        // the permission check active on warm builds and direct packaging calls.
        doLast {
            com.fuzevpn.build.AndroidManifestPolicy.verify(mergedManifest.get().asFile.toPath())
        }
    }
    tasks.matching { it.name in setOf("package$suffix", "package${suffix}Bundle", "bundle$suffix", "assemble$suffix") }
        .configureEach { dependsOn(permissionCheck) }
}

kotlin {
    jvmToolchain(17)
}

flutter {
    source = "../.."
}

dependencies {
    implementation("androidx.core:core-ktx:1.16.0")
    // Prepare the Play product catalog; no purchase is launched by this build.
    implementation("com.android.billingclient:billing:9.1.0")
    // Explicit button flow; consumer R8 rules are supplied by these libraries.
    implementation("androidx.credentials:credentials:1.6.0")
    implementation("androidx.credentials:credentials-play-services-auth:1.6.0")
    implementation("com.google.android.libraries.identity.googleid:googleid:1.2.1")
    // Keep these explicit so a locally built WireGuard AAR has the same
    // runtime dependencies as the official Maven publication's POM.
    implementation("androidx.annotation:annotation:1.9.1")
    implementation("androidx.collection:collection:1.5.0")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.10.2")

    testImplementation("junit:junit:4.13.2")
    testImplementation("org.json:json:20240303")
    testImplementation("org.jetbrains.kotlinx:kotlinx-coroutines-test:1.10.2")
    androidTestImplementation("androidx.test:core-ktx:1.6.1")
    androidTestImplementation("androidx.test.ext:junit:1.2.1")
    androidTestImplementation("androidx.test:runner:1.6.2")
    androidTestImplementation("androidx.test.uiautomator:uiautomator:2.3.0")
}
