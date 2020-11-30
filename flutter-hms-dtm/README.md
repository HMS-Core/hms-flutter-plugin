# Huawei DTM Kit Flutter Plugin

---

## Contents

  - [1. Introduction](#1-introduction)
  - [2. Installation Guide](#2-installation-guide)
    - [2.1. Creating Project in App Gallery Connect](#21-creating-project-in-app-gallery-connect)
    - [2.2 Configuring the Signing Certificate Fingerprint](#22-configuring-the-signing-certificate-fingerprint)
    - [2.3. Integrating Flutter DTM Plugin](#23-integrating-flutter-dtm-plugin)
    - [2.4. Operations On The Server](#24-operations-on-the-server)
  - [3. API Reference](#3-api-reference)
    - [3.1. HMSDTM](#31-hmsdtm)
      - [3.1.1. Public Method Summary](#311-public-method-summary)
      - [3.1.2. Public Methods](#312-public-methods)
  - [4. Configuration and Description](#4-configuration-and-description)
    - [4.1. Importing a DTM Configuration File](#41-importing-a-dtm-configuration-file)
    - [4.2. Using the Debug Mode](#42-using-the-debug-mode)
    - [4.3. For Third Party Analytics Platforms](#43-for-third-party-analytics-platforms)
    - [4.4. Preparing for Release](#44-preparing-for-release)
  - [5. Sample Project](#5-sample-project)
  - [6. Questions or Issues](#6-questions-or-issues)
  - [7. Licensing and Terms](#7-licensing-and-terms)

---

## 1. Introduction

**HUAWEI Dynamic Tag Manager (DTM)** is a dynamic tag management system. With DTM, you can dynamically update tracking tags on a web-based user interface to track specific events and report data to third-party analytics platforms, tracking your marketing activity data as needed. Huawei DTM Plugin allows you to report your events to other platforms simultaneously via Custom Tags. To do so, you must integrate the third-party analytics platform which you would like to use in your application.

This plugin enables communication between HUAWEI DTM Kit SDK and Flutter platform. It exposes all functionality provided by HUAWEI DTM Kit SDK.

---

## 2. Installation Guide

- Before you get started, you must register as a HUAWEI developer and complete identity verification on the [HUAWEI Developer](https://developer.huawei.com/consumer/en/) website. For details, please refer to [Register a HUAWEI ID](https://developer.huawei.com/consumer/en/doc/10104).

- Create an app in your project is required in AppGallery Connect in order to communicate with Huawei services. To create an app, perform the following steps:

### 2.1. Creating Project in App Gallery Connect

**Step 1.** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en) and select My projects.

**Step 2.** Click your project from the project list.

**Step 3.** Go to **Project Setting** > **General information**, and click **Add app**.
If an app exists in the project, and you need to add a new one, expand the app selection area on the top of the page and click **Add app**.↵

**Step 4.** On the **Add app** page, enter app information, and click **OK**.

- A signing certificate fingerprint is used to verify the authenticity of an app when it attempts to access an HMS Core service through the HMS Core SDK. Before using HMS Core (APK), you must locally generate a signing certificate fingerprint and configure it in AppGallery Connect. Ensure that the JDK has been installed on your computer.

### 2.2. Configuring the Signing Certificate Fingerprint

**Step 1:** Go to **Project Setting** > **General information**. In the **App information** field, click the  icon next to SHA-256 certificate fingerprint, and enter the obtained **SHA256 certificate fingerprint**.

**Step 2:**  After completing the configuration, click OK.

For details, please refer to [Generating a Signing Certificate](https://developer.huawei.com/consumer/en/codelab/HMSPreparation/index.html#3).

### 2.3. Integrating Flutter DTM Plugin

**Step 1:** Sign in [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) to AppGallery Connect and select **My projects**.

**Step 2:** Find your app project, and click the desired app name.

**Step 3:** Go to **Project Setting >  > General information**. In the **App information** field, click **agconnect-service.json** to download configuration file.

**Step 4:** Create a Flutter project if you do not have one.

**Step 5:** Copy the **agconnect-service.json** file to the **android/app** directory of your Flutter project.

**Step 6:** Copy the signature file that is generated in **Generating a Signature File** to the android/app directory of your Flutter project.

**Step 7:** Check whether the **agconnect-services.json** file and signature file are successfully added to the **android/app** directory of the Flutter project.

**Step 8:** Open the **build.gradle** file in the **android** directory of your project.

- Go to **buildscript** then configure the Maven repository address and agconnect plugin for the  HMS SDK.

    ```gradle
        buildscript {
            repositories {
                google()
                jcenter()
                maven { url 'https://developer.huawei.com/repo/' }
            }

            dependencies {
                /*
                 * <Other dependencies>
                 */
                classpath 'com.huawei.agconnect:agcp:1.4.1.300'
            }
        }
    ```

- Go to **allprojects** then configure the Maven repository address for the HMS SDK.

    ```gradle
        allprojects {
            repositories {
                google()
                jcenter()
                maven { url 'https://developer.huawei.com/repo/' }
            }
        }
     ```

**Step 9:** Open the **build.gradle** file in the **android/app** directory.

- Add `apply plugin: 'com.huawei.agconnect'` line after other `apply` entries.

    ```gradle
        apply plugin: 'com.android.application'
        apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"
        apply plugin: 'com.huawei.agconnect'
    ```

- Set your package name in **defaultConfig** > **applicationId** and set **minSdkVersion** to **19** or **higher**.

- Package name must match with the **package_name** entry in **agconnect-services.json** file.
    ```gradle
        defaultConfig {
                applicationId "<package_name>"
                minSdkVersion 19
                /*
                 * <Other configurations>
                 */
            }
     ```

- Copy the signature file that generated in [Generating a Signing Certificate](https://developer.huawei.com/consumer/en/codelab/HMSPreparation/index.html#3) to **android/app** directory.

- Configure the signature in **android** according to the signature file information.

    ```gradle
        android {
            /*
             * <Other configurations>
             */

            signingConfigs {
                config {
                    storeFile file('<keystore_file>.jks')
                    storePassword '<keystore_password>'
                    keyAlias '<key_alias>'
                    keyPassword '<key_password>'
                }
            }

            buildTypes {
                debug {
                    signingConfig signingConfigs.config
                }
                release {
                    minifyEnabled true
                    shrinkResources true
                    proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
                    signingConfig signingConfigs.config
                }
            }
        }
    ```

- For Obfuscation Scripts, please refer to [Configuring Obfuscation Scripts](https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides/android-config-obfuscation-scripts-0000001050043957).

**Step 10:** On your Flutter project directory find and open your **pubspec.yaml** file and add library to dependencies. For more details please refer the [Using packages](https://flutter.dev/docs/development/packages-and-plugins/using-packages#dependencies-on-unpublished-packages) document.

```yaml
    dependencies:
        huawei_dtm:
            # Replace {library path} with actual library path of Huawei DTM Flutter Plugin.
            path: {library path}
```

- Replace {library path} with the actual library path of Flutter DTM Plugin. The following are examples:
    - Relative path example:
        `path: ../huawei_dtm`
    - Absolute path example:
        `path: D:\Projects\Libraries\huawei_dtm`

**or**

Download the package from [pub.dev](https://pub.dev/publishers/developer.huawei.com/packages) and add it to dependencies in **pubspec.yaml** file.

```yaml
    dependencies:
        huawei_dtm: {library version}
```

**Step 11:** Run following command to update package info.

```
    [project_path]> flutter pub get
```

**Step 12:** Run following command to start the app.

```
    [project_path]> flutter run
```
### 2.4. Operations On The Server

To access the DTM portal, follow the steps in [Operations on the Server](https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides/android-permission-0000001056203546).

---

## 3. API Reference

### 3.1. HMSDTM

Entry class for using Huawei DTM Kit's APIs.

#### 3.1.1. Public Method Summary

|Method |Return Type |Description |
|-------|------------|------------|
|onEvent(String key, Map\<String, dynamic> value) | Future\<void> |This API is called to record events. |
|setCustomVariable(String varName, dynamic value) | Future\<void> |This API sets the return value in ICustomVariable interface. |
|get customTagStream |Stream\<Map\<String, dynamic>> |This API listens to the triggered Custom Tags, when used with *listen* method. |
|enableLogger() |Future\<void> |This method enables HMSLogger capability which is used for sending usage analytics of DTM SDK's methods to improve the service quality. |
|disableLogger() |Future\<void> |This method disables HMSLogger capability which is used for sending usage analytics of DTM SDK's methods to improve the service quality. |

#### 3.1.2. Public Methods

##### Future\<void> onEvent(String key, Map\<String, dynamic> value) *async*

Records an event.

###### Parameters

|Name  |Type |Description |
|------|-----|------------|
|key   |String |Event ID, a string containing a maximum of 256 characters. |
|value |Map\<String, dynamic> |Information carried in the event. The number of key-value pairs in a bundle must not exceed 2048. In addition, its size cannot exceed 200 KB. |

###### Return Type

|Return Type |Description |
|------------|------------|
|Future\<void> |Future result of an execution that returns no value. |

###### Call Example
```dart
    const eventName = "Platform";
    const bundle = {
      "platformName": "Flutter",
    };
    await HMSDTM.onEvent(eventName, bundle);
```

##### Future\<void> setCustomVariable(String varName, dynamic value) *async*

Sets the return value in ICustomVariable interface.

###### Parameters

|Name  |Type |Description |
|------|-----|------------|
|varName |String |The name returned to the server in CustomVariable. |
|value |dynamic |The value returned to the server in CustomVariable. |

###### Return Type

|Return Type |Description |
|------------|------------|
|Future\<void> |Future result of an execution that returns no value. |

###### Call Example

```dart
    const varName = "CustomVariable";
    const value = 50;
    await HMSDTM.setCustomVariable(varName, value);
```

##### Stream\<Map\<String, dynamic>> get customTagStream

Listens to the triggered Custom Tags, when used with *listen* method. Call *listen* method to start the stream and after the listening is done, call *cancel()* in order to prevent memory leaks.

###### Return Type

|Return Type |Description |
|------------|------------|
|Stream\<Map\<String, dynamic>> |Stream object to listen to Custom Tags. |

###### Call Example

```dart
    HMSDTM.customTagStream.listen((event) {
      // Call your own method to handle custom tag responses.
    });
```

##### Future\<void> enableLogger() *async*

This method enables HMSLogger capability which is used for sending usage analytics of DTM SDK's methods to improve the service quality.

###### Return Type

|Return Type  |Description    |
|-------------|---------------|
|Future\<void>|Future result of an execution that returns no value.|

###### Call Example

```dart
    await HMSDTM.enableLogger();
```

##### Future\<void> disableLogger() *async*

This method disables HMSLogger capability which is used for sending usage analytics of DTM SDK's methods to improve the service quality.

###### Return Type

|Return Type  |Description    |
|-------------|---------------|
|Future\<void>|Future result of an execution that returns no value.|

###### Call Example

```dart
    await HMSDTM.disableLogger();
```

##### Note

> HMS Logger is used for sending usage analytics of DTM SDK's methods in order to improve the service quality. HMSLogger is enabled by default on the Huawei DTM Kit Plugin for Flutter, it can be disabled with the `disableLogger()` method.

---

## 4. Configuration and Description

### 4.1. Importing a DTM Configuration File

Create the **android/app/src/main/assets/containers** directory in your project and move the generated configuration file **DTM-\**\**\**\*.json** to this directory.

### 4.2. Using the Debug Mode

During development, you can enable the debug mode to view the event records in real time, observe the results, and adjust the event tracking scheme as needed.

- **Huawei Analytics**

To enable or disable the debug mode, perform the following steps:
  - Run the following command on an Android device to enable the debug mode:

  	```
  	adb shell setprop debug.huawei.hms.analytics.app <package_name>
  	```

  - After the debug mode is enabled, all events will be reported in real time.
  - Run the following command to disable the debug mode:

  	```
  	adb shell setprop debug.huawei.hms.analytics.app .none.
  	```

- **Third-Party Platforms**

If you use a third-party template (such as a template of Adjust or AppsFlyer):

  - Run the following command to enable the debug mode:

  	```
  	adb shell setprop debug.huawei.hms.dtm.app <package_name>
  	```

  - Run the following command to disable the debug mode:

  	```
  	adb shell setprop debug.huawei.hms.dtm.app .none.
  	```

### 4.3. For Third Party Analytics Platforms

If you are using a third party platform, you must do the configurations of the platform you are using.

Examples for some platforms:
- [Get started with Google Analytics](https://firebase.google.com/docs/analytics/get-started?platform=android)
- [Get started with Apps Flyer](https://support.appsflyer.com/hc/en-us/articles/207033486-Getting-started-step-by-step#basic-attribution)

### 4.4. Preparing for Release

Before building a release version of your app you may need to customize the <span>**proguard-rules</span>.pro** obfuscation configuration file to prevent the Analytics Kit and DTM from being obfuscated. Add the configurations below to exclude the HMS Core SDK from obfuscation. For more information on this topic refer to [this Android developer guide](https://developer.android.com/studio/build/shrink-code).

**<flutter_project>/android/app/proguard-rules&#46; pro**

```
-ignorewarnings
-keepattributes *Annotation*
-keepattributes Exceptions
-keepattributes InnerClasses
-keepattributes Signature
-keep class com.hianalytics.android.**{*;}
-keep class com.huawei.updatesdk.**{*;}
-keep class com.huawei.hms.**{*;}
```

**<flutter_project>/android/app/build.gradle**

```gradle
buildTypes {
    debug {
        signingConfig signingConfigs.config
    }
    release {
        signingConfig signingConfigs.config
        // Enables code shrinking, obfuscation and optimization for release builds
        minifyEnabled true
        // Unused resources will be removed, resources defined in the res/raw/keep.xml will be kept.
        shrinkResources true
        proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
    }
}
```

---

## 5. Sample Project

This plugin includes a demo project in the [example](example) folder, there you can find more usage examples.

<img src="https://raw.githubusercontent.com/HMS-Core/hms-flutter-plugin/master/flutter-hms-dtm/.docs/homeScreen.jpg" width = 40% height = 40% style="margin:1.5em">

---

## 6. Questions or Issues

If you have questions about how to use HMS samples, try the following options:
- [Stack Overflow](https://stackoverflow.com/questions/tagged/huawei-mobile-services) is the best place for any programming questions. Be sure to tag your question with 
**huawei-mobile-services**.
- [Github](https://github.com/HMS-Core/hms-flutter-plugin) is the official repository for these plugins, You can open an issue or submit your ideas.
- [Huawei Developer Forum](https://forums.developer.huawei.com/forumPortal/en/home?fid=0101187876626530001) HMS Core Module is great for general questions, or seeking recommendations and opinions.
- [Huawei Developer Docs](https://developer.huawei.com/consumer/en/doc/overview/HMS-Core-Plugin) is place to official documentation for all HMS Core Kits, you can find detailed documentations in there.

If you run into a bug in our samples, please submit an issue to the [GitHub repository](https://github.com/HMS-Core/hms-flutter-plugin).

---

## 7. Licensing and Terms

Huawei DTM Kit Flutter Plugin is licensed under [Apache 2.0 license](LICENSE)
