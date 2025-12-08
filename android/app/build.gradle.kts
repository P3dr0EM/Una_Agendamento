plugins {
    id("com.android.application")
    id("kotlin-android")
    // O Plugin do Flutter deve ser aplicado após o Android e Kotlin.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

dependencies {
    // Firebase
    implementation(platform("com.google.firebase:firebase-bom:34.3.0"))
    implementation("com.google.firebase:firebase-analytics")
    
    // Suporte a recursos Java modernos (Desugaring)
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
    
    // Multidex
    implementation("androidx.multidex:multidex:2.0.1")
}

android {
    namespace = "com.example.una_agendamento"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.una_agendamento"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    // 2. Um único bloco buildTypes consolidado
    buildTypes {
        getByName("debug") {
            signingConfig = signingConfigs.getByName("debug")
        }
        getByName("release") {
            // Usando a chave de debug para release TEMPORARIAMENTE para facilitar testes.
            // Para produção real, você criaria uma entrada "release" no signingConfigs acima.
            signingConfig = signingConfigs.getByName("debug")
            
            // AS DUAS PRECISAM ESTAR ALINHADAS (ambas false para evitar erros de build rápido)
            isMinifyEnabled = false
            isShrinkResources = false
            
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}