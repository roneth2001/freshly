plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android") // use Kotlin plugin id for KTS
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.freshly_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    defaultConfig {
        applicationId = "com.example.freshly_app"
        minSdk = flutter.minSdkVersion
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    // ✅ Java 17 + core library desugaring (KTS syntax)
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    // ✅ Kotlin JVM target as String in KTS
    kotlinOptions {
        jvmTarget = "17"
    }

    // (optional but helpful if multiple JDKs installed)
    // kotlin {
    //     jvmToolchain(17)
    // }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Required when desugaring is enabled
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
    // your other dependencies...
}
