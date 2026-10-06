pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        properties.getProperty("flutter.sdk")
            ?: error("flutter.sdk is not set in android/local.properties")
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "9.3.0" apply false
    // Flutter 3.44.7's Gradle integration still uses AGP's legacy variant
    // API. The two compatibility flags in gradle.properties therefore keep
    // AGP 9.3's legacy DSL until Flutter ships its built-in-Kotlin migration.
    id("org.jetbrains.kotlin.android") version "2.3.20" apply false
}

include(":app")
