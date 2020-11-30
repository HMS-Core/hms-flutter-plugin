# Huawei Contact Shield Kit Flutter Plugin

---

## Contents

  - [1. Introduction](#1-introduction)
  - [2. Installation Guide](#2-installation-guide)
    - [Creating a Project in App Gallery Connect](#creating-a-project-in-appgallery-connect)
    - [Configuring the Signing Certificate Fingerprint](#configuring-the-signing-certificate-fingerprint)
    - [Integrating the Flutter Contact Shield Plugin](#integrating-the-flutter-contact-shield-plugin)
  - [3. API Reference](#3-api-reference)
    - [HuaweiContactShield](#huaweicontactshield)
  - [4. Configuration and Description](#4-configuration-and-description)
  - [5. Sample Project](#5-sample-project)
  - [6. Questions or Issues](#6-questions-or-issues)
  - [7. Licensing and Terms](#7-licensing-and-terms)

---

## 1. Introduction

Huawei Contact Shield is a basic contact tracing service developed based on the Bluetooth low energy (BLE) technology. Global public health institutions can authorize developers to develop COVID-19 contact tracing apps using Contact Shield APIs. These apps can interact with other devices while protecting user privacy to check whether a user has been in contact with a person tested positive for COVID-19. If so, the user will be notified and instructed to take relevant measures, effectively controlling the spread of the virus.

To protect user privacy, Huawei has taken many measures. For details, please refer to [Privacy Statement](https://developer.huawei.com/consumer/en/doc/Contact-Shield-V1/privacy-statement-0000001055690991-V1).

HMS Core Contact Shield is [compatible](https://developer.huawei.com/consumer/en/doc/Contact-Shield-V1/faq-0000001051061622-V1#EN-US_TOPIC_0000001051061622__section15791112111716) with industry-recognized protocols to make contact tracing more accurate. If you have any questions or suggestions, please send an email to nearybyservice@huawei.com.

**Restrictions:**

- HMS Core Contact Shield depends on the BLE technology. Therefore, HMS Core Contact Shield cannot run on a mobile phone that does not support the BLE technology.
- The available storage space must be greater than 100 MB.

This plugin enables communication between HUAWEI Contact Shield Kit SDK and Flutter platform. It exposes all functionality provided by HUAWEI Contact Shield Kit SDK.

---

## 2. Installation Guide

Before you get started, you must register as a HUAWEI Developer and complete identity verification on the [HUAWEI Developer](https://developer.huawei.com/consumer/en/) website. For details, please refer to [Register a HUAWEI ID](https://developer.huawei.com/consumer/en/doc/10104).

### Creating a Project in AppGallery Connect

Creating an app in AppGallery Connect is required in order to communicate with the Huawei services. To create an app, perform the following steps:

**Step 1.** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) and select **My projects**.

**Step 2.** Select your project from the project list or create a new one by clicking the **Add Project** button.

**Step 3.** Go to **Project Setting** > **General information**, and click **Add app**.
If an app exists in the project and you need to add a new one, expand the app selection area on the top of the page and click **Add app**.

**Step 4.** On the **Add app** page, enter the app information, and click **OK**.

### Configuring the Signing Certificate Fingerprint

A signing certificate fingerprint is used to verify the authenticity of an app when it attempts to access an HMS Core (APK) through the HMS SDK. Before using the HMS Core (APK), you must locally generate a signing certificate fingerprint and configure it in the **AppGallery Connect**. You can refer to 3rd and 4th steps of [Generating a Signing Certificate](https://developer.huawei.com/consumer/en/codelab/HMSPreparation/index.html#2) codelab tutorial for the certificate generation. Perform the following steps after you have generated the certificate.

**Step 1:** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) and select your project from **My Projects**. Then go to **Project Setting** > **General information**. In the **App information** field, click the icon next to SHA-256 certificate fingerprint, and enter the obtained **SHA-256 certificate fingerprint**.

**Step 2:** After completing the configuration, click **OK** to save the changes. (Check mark icon)

### Enabling the Huawei Contact Shield

**Step 1:** Sign in to [HUAWEI Developers](https://developer.huawei.com/consumer/en/) and click [Console](https://developer.huawei.com/consumer/en/console) in the upper right corner. Go to **HMS API Services > My APIs**, select the project for which you want to enable HUAWEI Contact Shield, and click **Add API from library**. The API Library page is displayed.

**Step 2:** Click **Contact Shield**.

**Step 3:** Click **Enable** to enable the Contact Shield service.

**Step 4:** Sign the HUAWEI Contact Shield Agreement.

**Step 5:** Go to **HMS API Services > My APIs**. The Contact Shield API is displayed.

### Applying to Use the Service

To protect users' rights and interests, Huawei strictly controls the permissions of developers to use Contact Shield. If you need to use Contact Shield, send an application email to contactshield@huawei.com in the following format. Huawei will get back to you soon after the review is complete.

| Item                                                                                        | Description                                                                                                           |
| ------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| App package name: **`com.xxx.xxx`**                                                         | Provide the package name of your app that needs to use Contact Shield.                                                |
| App ID: **123456789** (example)                                                             | Provide the ID of your app that needs to use Contact Shield.                                                          |
| Contact person: **Bob** (example)                                                           | Provide your contact name for us to contact you.                                                                      |
| Contact phone number: **xxx**                                                               | Provide your phone number for us to contact you.                                                                      |
| Have contact with Huawei expansion personnel: **Yes**, Huawei expansion personnel: **Lisa** | If you have contacted Huawei expansion personnel, please provide their name so we can better serve you in the future. |
| Have authorization from the government: **Yes** (Provide a written authorization document.) | Only developers authorized by governments can use Contact Shield to develop apps.                                     |
| Screenshot of the web page indicating service enabling success                              | Provide your screenshot of the service enabling success web page.                                                     |

### Integrating the Flutter Contact Shield Plugin

**Step 1:** Go to **Project Setting > General information** page, under the **App information** field, click **agconnect-services.json** to download the configuration file.

**Step 2:** Copy the **agconnect-services.json** file to the **android/app** directory of your project.

**Step 3:** Open the **build.gradle** file in the **android** directory of your project.

- Navigate to the **buildscript** section and configure the Maven repository address and agconnect plugin for the HMS SDK.

  ```groovy
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

- Go to **allprojects** and configure the Maven repository address for the HMS SDK.

  ```groovy
  allprojects {
    repositories {
        google()
        jcenter()
        maven { url 'https://developer.huawei.com/repo/' }
    }
  }
  ```

**Step 4:** Open the **build.gradle** file in the **android/app/** directory.

- Add `apply plugin: 'com.huawei.agconnect'` line at the end of the file.

  ```groovy
  ...

  apply plugin: 'com.huawei.agconnect'
  ```

- Set your package name in **defaultConfig > applicationId** and set **minSdkVersion** to **21** or higher. Package name must match with the **package_name** entry in **agconnect-services.json** file.

  ```groovy
  defaultConfig {
      applicationId "<package_name>"
      minSdkVersion 21
      /*
       * <Other configurations>
       */
  }
  ```

**Step 5:** Create a file **<app_dir>/android/key.properties** that contains a reference to your keystore which you generated on the previous step ([Generating a Signing Certificate](https://developer.huawei.com/consumer/en/codelab/HMSPreparation/index.html#2)). Add the following lines to the **key.properties** file and change the values regarding to the keystore you've generated.

```groovy
storeFile=<keystore_file>
storePassword=<keystore_password>
keyAlias=<key_alias>
keyPassword=<key_password>
```

> **WARNING:** Keep this file private and don't include it on the public source control.

**Step 6:** Add the following code to **build.gradle** before `android` block for reading the **key.properties** file:

```groovy
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    ...
}
```

**Step 7:** Edit **buildTypes** as follows and add **signingConfigs** below:

```groovy
signingConfigs {
    config {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
        storePassword keystoreProperties['storePassword']
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
```

**Step 8:** On your Flutter project directory, find and open your **pubspec.yaml** file and add the **huawei_contactshield** library to dependencies. For more details please refer to the [Using packages](https://flutter.dev/docs/development/packages-and-plugins/using-packages#dependencies-on-unpublished-packages) document.

- Get library via `pub` package manager.

  ```yaml
  dependencies:
    huawei_contactshield: { library version }
  ```

  **or**

- If you downloaded the package from the HUAWEI Developer website, specify the **library path** on your local device.

  ```yaml
  dependencies:
    huawei_contactshield:
      # Replace {library path} with actual library path of Huawei Contact Shield Kit Plugin for Flutter.
      path: { library path }
  ```

  - Replace {library path} with the actual library path of Flutter Contact Shield Plugin. The following are examples:
    - Relative path example: `path: ../huawei_contactshield`
    - Absolute path example: `path: D:\Projects\Libraries\huawei_contactshield`

**Step 9:** Run the following command to update package info.

```bash
[project_path]> flutter pub get
```

**Step 10:** Import the library to access all the classes and methods.

```dart
import 'package:huawei_contactshield/huawei_contactshield.dart';
```

**Step 11** Run the following command to start the app.

```bash
[project_path]> flutter run
```

---

## 3. API Reference

### ContactShieldEngine

Entry class for using Huawei Contact Shield Kit's APIs.

#### Properties

| Name                  | Type                                            | Description                                                                                                                                                                                                                                                              |
| --------------------- | ----------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| contactShieldCallback | [ContactShieldCallback](#contactshieldcallback) | Callback that will be triggered when [putSharedKeyFiles](#futurevoid-putsharedkeyfilesliststring-filepaths-diagnosisconfiguration-config-string-token-async) or [startContactShieldOld](#futurevoid-startcontactshieldoldint-incubationperiod-async) methods are called. |

#### Constants

| Constant                                | Type   | Value             | Description                                                |
| --------------------------------------- | ------ | ----------------- | ---------------------------------------------------------- |
| DEFAULT_INCUBATION_PERIOD               | int    | 14                | Default incubation period for COVID-19.                    |
| <a name="token-window-mode"></a>TOKEN_A | String | TOKEN_WINDOW_MODE | Token indicating that the Window mode needs to be enabled. |

#### Constructor Summary

| Constructor           | Description          |
| --------------------- | -------------------- |
| ContactShieldEngine() | Default constructor. |

#### Constructors

##### ContactShieldEngine()

Default constructor of the Contact Shield Engine.

#### Method Summary

| Method                                                                                                                                                                                              | Return Type                                     | Description                                                                                                                                                                                                                                                                                             |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [isContactShieldRunning()](#futurebool-iscontactshieldrunning-async)                                                                                                                                | Future\<void>                                   | Checks whether Contact Shield is running.                                                                                                                                                                                                                                                               |
| [startContactShieldOld(int incubationPeriod)](#futurevoid-startcontactshieldoldint-incubationperiod-async)                                                                                          | Future\<bool>                                   | Enables Contact Shield.<br/><br/>This API has been deprecated. To ensure that the functions of earlier versions are normal, this API can still be used in the current version.                                                                                                                          |
| [startContactShield(int incubationPeriod)](#futurevoid-startcontactshieldint-incubationperiod-async)                                                                                                | Future\<void>                                   | Enables Contact Shield. When a user exits the app, Contact Shield is still running in the background.                                                                                                                                                                                                   |
| [startContactShieldNonPersistent(int incubationPeriod)](#futurevoid-startcontactshieldnonpersistentint-incubationperiod-async)                                                                      | Future\<void>                                   | Enables Contact Shield. When a user exits the app, Contact Shield stops running.                                                                                                                                                                                                                        |
| [getPeriodicKey()](#futurelistperiodickey-getperiodickey-async)                                                                                                                                     | Future\<List\<[PeriodicKey](#periodickey)>>     | Obtains the periodic key list from the Contact Shield SDK.<br/><br/>The periodic key list obtained by calling this API does not contain the periodic key of the current day.                                                                                                                            |
| [putSharedKeyFilesOld(List\<String> filePaths, DiagnosisConfiguration config, String token)](#futurevoid-putsharedkeyfilesoldliststring-filepaths-diagnosisconfiguration-config-string-token-async) | Future\<void>                                   | Provides the shared key list file obtained from the diagnosis server to the Contact Shield SDK.                                                                                                                                                                                                         |
| [putSharedKeyFiles(List\<String> filePaths, DiagnosisConfiguration config, String token)](#futurevoid-putsharedkeyfilesliststring-filepaths-diagnosisconfiguration-config-string-token-async)       | Future\<void>                                   | Provides the shared key list file obtained from the diagnosis server to the Contact Shield SDK.<br/>If the Window mode is used, that is, **[TOKEN_A](#token-window-mode)**, a maximum of 60 calls are allowed within 24 hours. A common token can be called for a maximum of 200 times within 24 hours. |
| [getContactDetail(String token)](#futurelistcontactdetail-getcontactdetailstring-token-async)                                                                                                       | Future\<List\<[ContactDetail](#contactdetail)>> | Obtains the latest diagnosis result details from Contact Shield.<br/><br/>This API has been deprecated. To ensure that the functions of earlier versions are normal, this API can still be used in the current version.                                                                                 |
| [getContactSketch(String token)](#futurecontactsketch-getcontactsketchstring-token-async)                                                                                                           | Future\<[ContactSketch](#contactsketch)>        | Obtains the latest diagnosis result summary from Contact Shield.                                                                                                                                                                                                                                        |
| [getContactWindow(String token)](#futurelistcontactwindow-getcontactwindowstring-token-async)                                                                                                       | Future\<List\<[ContactWindow](#contactwindow)>> | Obtains the latest diagnosis result details from Contact Shield in Window mode.                                                                                                                                                                                                                         |
| [clearData()](#futurevoid-cleardata-async)                                                                                                                                                          | Future\<void>                                   | Deletes all data stored on the device by Contact Shield.                                                                                                                                                                                                                                                |
| [stopContactShield()](#futurevoid-stopcontactshield-async)                                                                                                                                          | Future\<void>                                   | Disables Contact Shield.                                                                                                                                                                                                                                                                                |
| [enableLogger()](#futurevoid-enablelogger-async)                                                                                                                                                    | Future\<void>                                   | Enables HMS Logger.                                                                                                                                                                                                                                                                                     |
| [disableLogger()](#futurevoid-disablelogger-async)                                                                                                                                                  | Future\<void>                                   | Disables HMS Logger.                                                                                                                                                                                                                                                                                    |

#### Methods

##### Future\<bool> isContactShieldRunning() _async_

Checks whether Contact Shield is running.

###### Return Type

| Type          | Description                                 |
| ------------- | ------------------------------------------- |
| Future\<bool> | Future result of the Contact Shield status. |

###### Call Example

```dart
bool status = await ContactShieldEngine().isContactShieldRunning();
```

##### Future\<void> startContactShieldOld(int incubationPeriod) _async_

Enables Contact Shield. Before calling this method, your app must obtain the user's authorization for contact tracing.

> **NOTE:** This API has been deprecated. To ensure that the functions of earlier versions are normal, this API can still be used in the current version.

###### Parameters

| Name             | Type | Description                                                                                                                      |
| ---------------- | ---- | -------------------------------------------------------------------------------------------------------------------------------- |
| incubationPeriod | int  | Incubation period for COVID-19. This parameter is optional and its default value is **`14`** in days. The value range is [1,60]. |

###### Return Type

| Type          | Description                                          |
| ------------- | ---------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example

```dart
// Create instance of the ContactShieldEngine
ContactShieldEngine engine = ContactShieldEngine();

// Create callback which will handle incoming result
ContactShieldCallback callback = ContactShieldCallback(
  onHasContact: (token) {
    String status = 'Contact Status: Has contact. Token: $token';
    print(status);
  },
  onNoContact: (token) {
    String status = 'Contact Status: No contact. Token: $token';
    print(status);
  },
);

// Assign your callback to ContactShieldEngine
engine.contactShieldCallback = callback;

// Call the method
await engine.startContactShieldOld();
```

##### Future\<void> startContactShield(int incubationPeriod) _async_

Enables Contact Shield. When a user exits the app, Contact Shield is still running in the background.

Before calling this method, your app must obtain the user's authorization for contact tracing.

###### Parameters

| Name             | Type | Description                                                                                                                      |
| ---------------- | ---- | -------------------------------------------------------------------------------------------------------------------------------- |
| incubationPeriod | int  | Incubation period for COVID-19. This parameter is optional and its default value is **`14`** in days. The value range is [1,60]. |

###### Return Type

| Type          | Description                                          |
| ------------- | ---------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example

```dart
await ContactShieldEngine().startContactShield();
```

##### Future\<void> startContactShieldNonPersistent(int incubationPeriod) _async_

Enables Contact Shield. When a user exits the app, Contact Shield stops running.

Before calling this method, your app must obtain the user's authorization for contact tracing.

###### Parameters

| Name             | Type | Description                                                                                                                      |
| ---------------- | ---- | -------------------------------------------------------------------------------------------------------------------------------- |
| incubationPeriod | int  | Incubation period for COVID-19. This parameter is optional and its default value is **`14`** in days. The value range is [1,60]. |

###### Return Type

| Type          | Description                                          |
| ------------- | ---------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example

```dart
await ContactShieldEngine().startContactShieldNonPersistent();
```

##### Future\<List\<[PeriodicKey](#periodickey)>> getPeriodicKey() _async_

Obtains the periodic key list from the Contact Shield SDK. Before calling this method, your app must obtain the user's authorization. Your app can upload these periodic keys to the diagnosis server.

> **NOTE:** The periodic key list obtained by calling this API does not contain the periodic key of the current day.

###### Return Type

| Type                                        | Description                                                       |
| ------------------------------------------- | ----------------------------------------------------------------- |
| Future\<List\<[PeriodicKey](#periodickey)>> | Future result of an execution that returns list of periodic keys. |

###### Call Example

```dart
List<PeriodicKey> periodicKeys = await ContactShieldEngine().getPeriodicKey();
```

##### Future\<void> putSharedKeyFilesOld(List\<String> filePaths, [DiagnosisConfiguration](#diagnosisconfiguration) config, String token) _async_

Provides the shared key list file obtained from the diagnosis server to the Contact Shield SDK for future calls of APIs such as [getContactSketch()](#futurecontactsketch-getcontactsketchstring-token-async).

> **NOTE:** This API has been deprecated. To ensure that the functions of earlier versions are normal, this API can still be used in the current version.

###### Parameters

| Name      | Type                                              | Description                      |
| --------- | ------------------------------------------------- | -------------------------------- |
| filePaths | List\<String>                                     | Paths of the shared keys.        |
| config    | [DiagnosisConfiguration](#diagnosisconfiguration) | Current diagnosis configuration. |
| token     | String                                            | Token.                           |

###### Return Type

| Type          | Description                                          |
| ------------- | ---------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example

```dart
List<String> filePaths = <String>[
  '/storage/emulated/0/keys1.zip',
  '/storage/emulated/0/keys2.zip',
];

DiagnosisConfiguration config = DiagnosisConfiguration();

await ContactShieldEngine().putSharedKeyFilesOld(filePaths, config, 'TOKEN_TEST');
```

##### Future\<void> putSharedKeyFiles(List\<String> filePaths, [DiagnosisConfiguration](#diagnosisconfiguration) config, String token) _async_

Provides the shared key list file obtained from the diagnosis server to the Contact Shield SDK for future calls of APIs such as [getContactSketch()](#futurecontactsketch-getcontactsketchstring-token-async).

If the Window mode is used, that is, **[TOKEN_A](#token-window-mode)**, a maximum of 60 calls are allowed within 24 hours. A common token can be called for a maximum of 200 times within 24 hours.

###### Parameters

| Name      | Type                                              | Description                      |
| --------- | ------------------------------------------------- | -------------------------------- |
| filePaths | List\<String>                                     | Paths of the shared keys.        |
| config    | [DiagnosisConfiguration](#diagnosisconfiguration) | Current diagnosis configuration. |
| token     | String                                            | Token.                           |

###### Return Type

| Type          | Description                                          |
| ------------- | ---------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example

```dart
// Create instance of the ContactShieldEngine
ContactShieldEngine engine = ContactShieldEngine();

// Create callback which will handle incoming result
ContactShieldCallback callback = ContactShieldCallback(
  onHasContact: (token) {
    String status = 'Contact Status: Has contact. Token: $token';
    print(status);
  },
  onNoContact: (token) {
    String status = 'Contact Status: No contact. Token: $token';
    print(status);
  },
);

// Assign your callback to ContactShieldEngine
engine.contactShieldCallback = callback;

// Confiugre arguments

List<String> filePaths = <String>[
  '/storage/emulated/0/keys1.zip',
  '/storage/emulated/0/keys2.zip',
];

DiagnosisConfiguration config = DiagnosisConfiguration();

// Call the method
await engine.putSharedKeyFiles(filePaths, config, 'TOKEN_TEST');
```

##### Future\<List\<[ContactDetail](#contactdetail)>> getContactDetail(String token) _async_

Obtains the latest diagnosis result details from Contact Shield.

> **NOTICE:**
> The diagnosis is asynchronous. When token != [TOKEN_A](#token-window-mode), the original mode is used. When this method is called to obtain the latest diagnosis result, a [ContactDetail](#contactdetail) list is returned.
>
> This API has been deprecated. To ensure that the functions of earlier versions are normal, this API can still be used in the current version.

###### Parameters

| Name  | Type   | Description |
| ----- | ------ | ----------- |
| token | String | Token.      |

###### Return Type

| Type                                            | Description                                                         |
| ----------------------------------------------- | ------------------------------------------------------------------- |
| Future\<List\<[ContactDetail](#contactdetail)>> | Future result of an execution that returns list of contact details. |

###### Call Example

```dart
String token = 'TOKEN_TEST';

List<ContactDetail> contactDetails = await ContactShieldEngine().getContactDetail(token);
```

##### Future\<[ContactSketch](#contactsketch)> getContactSketch(String token) _async_

Obtains the latest diagnosis result summary from Contact Shield.

> **NOTICE:** The diagnosis is asynchronous. When token != [TOKEN_A](#token-window-mode), the original mode is used. When this method is called to obtain the latest diagnosis result, a [ContactSketch](#contactsketch) instance is returned.

###### Parameters

| Name  | Type   | Description |
| ----- | ------ | ----------- |
| token | String | Token.      |

###### Return Type

| Type                                     | Description                                                |
| ---------------------------------------- | ---------------------------------------------------------- |
| Future\<[ContactSketch](#contactsketch)> | Future result of an execution that returns contact sketch. |

###### Call Example

```dart
String token = 'TOKEN_TEST';

List<ContactSketch> contactSketch = await ContactShieldEngine().getContactSketch(token);
```

##### Future\<List\<[ContactWindow](#contactwindow)>> getContactWindow(String token) _async_

Obtains the latest diagnosis result details from Contact Shield in Window mode.

> **NOTICE:** The diagnosis is asynchronous. When token == [TOKEN_A](#token-window-mode), the original mode is used. When this method is called to obtain the latest diagnosis result, a [ContactWindow](#contactwindow) list is returned.

###### Parameters

| Name  | Type   | Description                                                                               |
| ----- | ------ | ----------------------------------------------------------------------------------------- |
| token | String | Token. This parameter is optional and its default value is [TOKEN_A](#token-window-mode). |

###### Return Type

| Type                                            | Description                                                         |
| ----------------------------------------------- | ------------------------------------------------------------------- |
| Future\<List\<[ContactWindow](#contactwindow)>> | Future result of an execution that returns list of contact windows. |

###### Call Example

```dart
List<ContactWindow> contactWindows = await ContactShieldEngine().getContactWindow();
```

##### Future\<void> clearData() _async_

Deletes all data stored on the device by Contact Shield, including periodic keys, historical shared keys detected, supplementary data, and diagnosis records.

###### Return Type

| Type          | Description                                          |
| ------------- | ---------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example

```dart
await ContactShieldEngine().clearData();
```

##### Future\<void> stopContactShield() _async_

Disables Contact Shield. In this case, related data and keys are retained on the device and will not be deleted.

###### Return Type

| Type          | Description                                          |
| ------------- | ---------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example

```dart
await ContactShieldEngine().stopContactShield();
```

##### Future\<void> enableLogger() _async_

This method enables the HMSLogger capability which is used for sending usage analytics of Map SDK's methods to improve the service quality.

###### Return Type

| Type          | Description                                          |
| ------------- | ---------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example

```dart
await ContactShieldEngine().enableLogger();
```

##### Future\<void> disableLogger() _async_

This method disables the HMSLogger capability which is used for sending usage analytics of Map SDK's methods to improve the service quality.

###### Return Type

| Type          | Description                                          |
| ------------- | ---------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example

```dart
await ContactShieldEngine().disableLogger();
```

### ContactDetail

Defines the contact diagnosis result details.

#### Properties

| Name                 | Type       | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| -------------------- | ---------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| attenuationDurations | List\<int> | Time-related details for the contact in a list. The unit is minute.<br/>attenuationDurations[0]: The sum of contact durations when the signal attenuation is less than the lower threshold.<br/>attenuationDurations[1]: The sum of contact durations when the signal attenuation is greater than or equal to the lower threshold and less than the upper threshold.<br/>attenuationDurations[2]: The sum of contact durations when the signal attenuation is greater than the upper threshold. |
| attenuationRiskValue | int        | The signal attenuation level during the contact. The signal attenuation level is related to the transmit power and received signal strength indicator (RSSI) and can reflect the distance between two devices. The value ranges from 0 to 255.                                                                                                                                                                                                                                                  |
| dayNumber            | int        | The time when the contact occurred. The value is the number of days that have elapsed since the Unix epoch.                                                                                                                                                                                                                                                                                                                                                                                     |
| durationMinutes      | int        | The duration of the contact, in minutes. To protect privacy, even if durationMinutes is set to a value greater than 60, the duration of the contact is still 60 minutes.                                                                                                                                                                                                                                                                                                                        |
| initialRiskLevel     | int        | The initial risk level corresponding to a shared key that is successfully matched.                                                                                                                                                                                                                                                                                                                                                                                                              |
| totalRiskValue       | int        | The current risk level corresponding to a shared key that is successfully matched. The value ranges from 0 to 4096.                                                                                                                                                                                                                                                                                                                                                                             |

#### Constructor Summary

| Constructor                                                                                                                                                                                                                                    | Description                                            |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------ |
| ContactDetail({List\<int> attenuationDurations, int attenuationRiskValue = 0,  int dayNumber = 0, int durationMinutes = 0, int initialRiskLevel = 0, int totalRiskValue = 0}) : attenuationDurations = attenuationDurations ?? \<int>[0, 0, 0] | Default constructor.                                   |
| ContactDetail.fromMap(Map\<String, dynamic> map)                                                                                                                                                                                               | Creates **ContactDetail** object from the Map.         |
| ContactDetail.fromJson(String json)                                                                                                                                                                                                            | Creates **ContactDetail** object from the JSON string. |

#### Constructors

##### ContactDetail({List\<int> attenuationDurations, int attenuationRiskValue = 0,  int dayNumber = 0, int durationMinutes = 0, int initialRiskLevel = 0, int totalRiskValue = 0}) : attenuationDurations = attenuationDurations ?? \<int>[0, 0, 0]

Default constructor for **ContactDetail** object.

##### ContactDetail.fromMap(Map\<String, dynamic> map)

Creates **ContactDetail** object from the Map.

##### ContactDetail.fromJson(String json)

Creates **ContactDetail** object from the JSON string.

### ContactSketch

Defines the contact diagnosis result summary.

#### Properties

| Name                 | Type       | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| -------------------- | ---------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| attenuationDurations | List\<int> | Time-related details for the contacts of all matched shared keys in a list. The unit is minute.<br/>attenDurations[0]: The sum of contact durations when the signal attenuation is less than the lower threshold.<br/>attenDurations[1]: The sum of contact durations when the signal attenuation is greater than or equal to the lower threshold and less than the upper threshold.<br/>attenDurations[2]: The sum of contact durations when the signal attenuation is greater than the upper threshold. |
| daysSinceLastHit     | int        | The number of days elapsed since the last successful matching of a shared key. The daysSinceLastHit field is valid only when the value of numberOfHits is greater than 0. The value 0 indicates today, the value 1 indicates yesterday, and the value 2 indicates the day before yesterday. The others follow the same rule.                                                                                                                                                                              |
| maxRiskValue         | int        | The highest risk level among all shared keys that are successfully matched. The value is an integer ranging from 0 to 8.                                                                                                                                                                                                                                                                                                                                                                                  |
| numberOfHits         | int        | The number of shared keys that are successfully matched.                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| summationRiskValue   | int        | The sum of contact risk values of all matched shared keys.                                                                                                                                                                                                                                                                                                                                                                                                                                                |

#### Constructor Summary

| Constructor                                                                                                                                                                                                         | Description                                            |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------ |
| ContactSketch({List\<int> attenuationDurations, int daysSinceLastHit = 0, int maxRiskValue = 0, int numberOfHits = 0, int summationRiskValue = 0}) : attenuationDurations = attenuationDurations ?? \<int>[0, 0, 0] | Default constructor.                                   |
| ContactSketch.fromMap(Map\<String, dynamic> map)                                                                                                                                                                    | Creates **ContactSketch** object from the Map.         |
| ContactSketch.fromJson(String json)                                                                                                                                                                                 | Creates **ContactSketch** object from the JSON string. |

#### Constructors

##### ContactSketch({List\<int> attenuationDurations, int daysSinceLastHit = 0, int maxRiskValue = 0, int numberOfHits = 0, int summationRiskValue = 0}) : attenuationDurations = attenuationDurations ?? \<int>[0, 0, 0]

Default constructor for **ContactSketch** object.

##### ContactSketch.fromMap(Map\<String, dynamic> map)

Creates **ContactSketch** object from the Map.

##### PlaceHolder.fromJson(String json)

Creates **ContactSketch** object from the JSON string.

### ContactWindow

Class for storing the contact duration in Window mode when token = [TOKEN_A](#token-window-mode)

#### Properties

| Name       | Type                         | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| ---------- | ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| dateMillis | int                          | The date when the contact occurs.                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| reportType | int                          | The diagnosis type that is set when a shared key is uploaded. The diagnosis type options can be defined as required.<br/>Example:<br/>The value of **REPORT_TYPE_UNKNOW** is **0**.<br/>The value of **REPORT_TYPE_CONFIRMED_TEST** is **1**.<br/>The value of **REPORT_TYPE_CONFIRMED_CLINICAL_DIAGNOSIS** is **2**.<br/>The value of **REPORT_TYPE_SELF_REPORT** is **3**.<br/>The value of **REPORT_TYPE_RECURSIVE** is **4**.<br/>The value of **REPORT_TYPE_REVOKED** is **5**. |
| scanInfos  | List\<[ScanInfo](#scaninfo)> | The [ScanInfo](#scaninfo) list recorded during the contact.                                                                                                                                                                                                                                                                                                                                                                                                                          |

#### Constructor Summary

| Constructor                                                                                                                                                                                                                                                                                                                                                         | Description                                            |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------ |
| ContactWindow({int dateMillis = 0, int reportType = 0, List\<[ScanInfo](#scaninfo)> scanInfos}) : scanInfos = scanInfos ?? \<[ScanInfo](#scaninfo)>[[ScanInfo()](#scaninfoint-averageattenuation--0-int-minimumattenuation--0-int-secondssincelastscan--0), [ScanInfo()](#scaninfoint-averageattenuation--0-int-minimumattenuation--0-int-secondssincelastscan--0)] | Default constructor.                                   |
| ContactWindow.fromMap(Map\<String, dynamic> map)                                                                                                                                                                                                                                                                                                                    | Creates **ContactWindow** object from the Map.         |
| ContactWindow.fromJson(String json)                                                                                                                                                                                                                                                                                                                                 | Creates **ContactWindow** object from the JSON string. |

#### Constructors

##### ContactWindow({int dateMillis = 0, int reportType = 0, List\<[ScanInfo](#scaninfo)> scanInfos}) : scanInfos = scanInfos ?? \<[ScanInfo](#scaninfo)>[[ScanInfo()](#scaninfoint-averageattenuation--0-int-minimumattenuation--0-int-secondssincelastscan--0), [ScanInfo()](#scaninfoint-averageattenuation--0-int-minimumattenuation--0-int-secondssincelastscan--0)]

Default constructor for **ContactWindow** object.

##### ContactWindow.fromMap(Map\<String, dynamic> map)

Creates **ContactWindow** object from the Map.

##### ContactWindow.fromJson(String json)

Creates **ContactWindow** object from the JSON string.

### DiagnosisConfiguration

Defines default configurations for Contact Shield.

#### Properties

| Name                          | Type       | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| ----------------------------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| attenuationDurationThresholds | List\<int> | Signal attenuation threshold details. Value contains two thresholds, each ranging from 0 to 255.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| attenuationRiskValues         | List\<int> | Signal attenuation risk values. The definition of each value is as follows:<br/>attenuationRiskValues[0]: The attenuation is greater than 73.<br/>attenuationRiskValues[1]: The attenuation is greater than 63 and less than or equal to 73.<br/>attenuationRiskValues[2]: The attenuation is greater than 51 and less than or equal to 63.<br/>attenuationRiskValues[3]: The attenuation is greater than 33 and less than or equal to 51.<br/>attenuationRiskValues[4]: The attenuation is greater than 27 and less than or equal to 33.<br/>attenuationRiskValues[5]: The attenuation is greater than 15 and less than or equal to 27.<br/>attenuationRiskValues[6]: The attenuation is greater than 10 and less than or equal to 15.<br/>attenuationRiskValues[7]: The attenuation is less than or equal to 10.                                                                                                                                                                                                                                                                                                                               |
| attenuationWeight             | int        | Attenuation weight.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| daysAfterContactedRiskValues  | List\<int> | The the risk value associated with the last contact based on the number of days elapsed since the last contact.<br/>The definition of each value is as follows:<br/> daysAfterContactedRiskValues[0]: The number of days elapsed since the last contact is greater than or equal to 14.<br/>daysAfterContactedRiskValues[1]: The number of days elapsed since the last contact is greater than or equal to 12.<br/>daysAfterContactedRiskValues[2]: The number of days elapsed since the last contact is greater than or equal to 10.<br/>daysAfterContactedRiskValues[3]: The number of days elapsed since the last contact is greater than or equal to 8.<br/>daysAfterContactedRiskValues[4]: The number of days elapsed since the last contact is greater than or equal to 6.<br/>daysAfterContactedRiskValues[5]: The number of days elapsed since the last contact is greater than or equal to 4.<br/>daysAfterContactedRiskValues[6]: The number of days elapsed since the last contact is greater than or equal to 2.<br/>daysAfterContactedRiskValues[7]: There is no restriction on the number of days elapsed since the last contact. |
| daysAfterContactedWeight      | int        | The number of days elapsed since the last contact.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| durationRiskValues            | List\<int> | The risk value associated with the last contact based on the duration (in minutes) of the last contact. The definition of each value is as follows:<br/>durationRiskValues[0]: There is no contact.<br/>durationRiskValues[1]: The contact duration is less than or equal to 5 minutes.<br/>durationRiskValues[2]: The contact duration is less than or equal to 10 minutes.<br/>durationRiskValues[3]: The contact duration is less than or equal to 15 minutes.<br/>durationRiskValues[4]: The contact duration is less than or equal to 20 minutes.<br/>durationRiskValues[5]: The contact duration is less than or equal to 25 minutes.<br/>durationRiskValues[6]: The contact duration is less than or equal to 30 minutes.<br/>durationRiskValues[7]: The contact duration is over 30 minutes.                                                                                                                                                                                                                                                                                                                                             |
| durationWeight                | int        | Duration weight.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| initialRiskLevelRiskValues    | List\<int> | The initial contact risk value. The definition of each value is as follows:<br/>initialRiskLevelRiskValues[0]: RISK_LEVEL_LOWEST<br/>initialRiskLevelRiskValues[1]: RISK_LEVEL_LOW<br/>initialRiskLevelRiskValues[2]: RISK_LEVEL_MEDIUM_LOW<br/>initialRiskLevelRiskValues[3]: RISK_LEVEL_MEDIUM<br/>initialRiskLevelRiskValues[4]: RISK_LEVEL_MEDIUM_HIGH<br/>initialRiskLevelRiskValues[5]: RISK_LEVEL_HIGH<br/>initialRiskLevelRiskValues[6]: RISK_LEVEL_EXT_HIGH<br/>initialRiskLevelRiskValues[7]: RISK_LEVEL_HIGHEST                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| initialRiskLevelWeight        | int        | Initial risk level weight.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| minimumRiskValueThreshold     | int        | The lowest risk value that would be recorded.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |

#### Constructor Summary

| Constructor                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | Description                                                     |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------- |
| DiagnosisConfiguration({List\<int> attenuationDurationThresholds, List\<int> attenuationRiskValues, int attenuationWeight = 50, List\<int> daysAfterContactedRiskValues, int daysAfterContactedWeight = 50, List\<int> durationRiskValues, int durationWeight = 50, List\<int> initialRiskLevelRiskValues, int initialRiskLevelWeight = 50, int minimumRiskValueThreshold = 1}) : attenuationDurationThresholds = attenuationDurationThresholds ?? \<int>[50, 74], attenuationRiskValues = attenuationRiskValues ?? \<int>[4, 4, 4, 4, 4, 4, 4, 4], daysAfterContactedRiskValues = daysAfterContactedRiskValues ?? \<int>[4, 4, 4, 4, 4, 4, 4, 4], durationRiskValues = durationRiskValues ?? \<int>[4, 4, 4, 4, 4, 4, 4, 4], initialRiskLevelRiskValues = initialRiskLevelRiskValues ?? \<int>[4, 4, 4, 4, 4, 4, 4, 4] | Default constructor.                                            |
| DiagnosisConfiguration.fromMap(Map\<String, dynamic> map)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | Creates **DiagnosisConfiguration** object from the Map.         |
| DiagnosisConfiguration.fromJson(String json)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | Creates **DiagnosisConfiguration** object from the JSON string. |

#### Constructors

##### DiagnosisConfiguration({List\<int> attenuationDurationThresholds, List\<int> attenuationRiskValues, int attenuationWeight = 50, List\<int> daysAfterContactedRiskValues, int daysAfterContactedWeight = 50, List\<int> durationRiskValues, int durationWeight = 50, List\<int> initialRiskLevelRiskValues, int initialRiskLevelWeight = 50, int minimumRiskValueThreshold = 1}) : attenuationDurationThresholds = attenuationDurationThresholds ?? \<int>[50, 74], attenuationRiskValues = attenuationRiskValues ?? \<int>[4, 4, 4, 4, 4, 4, 4, 4], daysAfterContactedRiskValues = daysAfterContactedRiskValues ?? \<int>[4, 4, 4, 4, 4, 4, 4, 4], durationRiskValues = durationRiskValues ?? \<int>[4, 4, 4, 4, 4, 4, 4, 4], initialRiskLevelRiskValues = initialRiskLevelRiskValues ?? \<int>[4, 4, 4, 4, 4, 4, 4, 4]

Default constructor for **DiagnosisConfiguration** object.

##### DiagnosisConfiguration.fromMap(Map\<String, dynamic> map)

Creates **DiagnosisConfiguration** object from the Map.

##### DiagnosisConfiguration.fromJson(String json)

Creates **DiagnosisConfiguration** object from the JSON string.

### PeriodicKey

Defines a periodic key.

#### Properties

| Name                 | Type      | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| -------------------- | --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| content              | Uint8List | The 16-byte content of the periodic key.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| initialRiskLevel     | int       | The initial risk level corresponding to the periodic key. The value is an integer ranging from 0 to 8.<br/>The following are the suggested risk types and their meaning. Before uploading each key to the server, set initialRiskLevel. The options include:<br/>**0**: currently not used<br/>**1**: low risk<br/>**2**: medium risk<br/>**3**: high risk<br/>**4**: confirmed positive with COVID-19<br/>**5**: self-report<br/>**6**: confirmed negative with COVID-19<br/>**7**: recursive case<br/>**8**: reserved field |
| periodicKeyLifeTime  | int       | The number of time segments elapsed since the periodic key takes effect. Each time segment contains 10 minutes.                                                                                                                                                                                                                                                                                                                                                                                                               |
| periodicKeyValidTime | int       | The time segment to which the periodic key effective time belongs.                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| reportType           | int       | The diagnosis type that is specified when a shared key is uploaded. The diagnosis type options can be defined as required. Example:<br/>The value of **REPORT_TYPE_UNKNOW** is **0**.<br/>The value of **REPORT_TYPE_CONFIRMED_TEST** is **1**.<br/>The value of **REPORT_TYPE_CONFIRMED_CLINICAL_DIAGNOSIS** is **2**.<br/>The value of **REPORT_TYPE_SELF_REPORT** is **3**.<br/>The value of **REPORT_TYPE_RECURSIVE** is **4**.<br/>The value of **REPORT_TYPE_REVOKED** is **5**.                                        |

#### Constructor Summary

| Constructor                                                                                                                               | Description                                          |
| ----------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| PeriodicKey({Uint8List content, int initialRiskLevel = 0, int periodicKeyLifeTime = 0, int periodicKeyValidTime = 0, int reportType = 0}) | Default constructor.                                 |
| PeriodicKey.fromMap(Map\<String, dynamic> map)                                                                                            | Creates **PeriodicKey** object from the Map.         |
| PeriodicKey.fromJson(String json)                                                                                                         | Creates **PeriodicKey** object from the JSON string. |

#### Constructors

##### PeriodicKey({Uint8List content, int initialRiskLevel = 0, int periodicKeyLifeTime = 0, int periodicKeyValidTime = 0, int reportType = 0})

Default constructor for **PeriodicKey** object.

##### PeriodicKey.fromMap(Map\<String, dynamic> map)

Creates **PeriodicKey** object from the Map.

##### PeriodicKey.fromJson(String json)

Creates **PeriodicKey** object from the JSON string.

### ScanInfo

Class for storing scanning results.

#### Properties

| Name                 | Type | Description                                                                            |
| -------------------- | ---- | -------------------------------------------------------------------------------------- |
| averageAttenuation   | int  | The average of all attenuations detected during the scanning, in dB.                   |
| minimumAttenuation   | int  | The minimum attenuation.                                                               |
| secondsSinceLastScan | int  | The number of seconds elapsed since last scanning. The value ranges from 120s to 180s. |

#### Constructor Summary

| Constructor                                                                                      | Description                                       |
| ------------------------------------------------------------------------------------------------ | ------------------------------------------------- |
| ScanInfo({int averageAttenuation = 0, int minimumAttenuation = 0, int secondsSinceLastScan = 0}) | Default constructor.                              |
| ScanInfo.fromMap(Map\<String, dynamic> map)                                                      | Creates **ScanInfo** object from the Map.         |
| ScanInfo.fromJson(String json)                                                                   | Creates **ScanInfo** object from the JSON string. |

#### Constructors

##### ScanInfo({int averageAttenuation = 0, int minimumAttenuation = 0, int secondsSinceLastScan = 0})

Default constructor for **ScanInfo** object.

##### ScanInfo.fromMap(Map\<String, dynamic> map)

Creates **ScanInfo** object from the Map.

##### ScanInfo.fromJson(String json)

Creates **ScanInfo** object from the JSON string.

### ContactShieldCallback

Class which allows developers to define callback to handle contact status.

#### Type Definition Summary

| Name                                                   | Return Type | Parameters   |
| ------------------------------------------------------ | ----------- | ------------ |
| [OnHasContact](#typedef-void-onhascontactstring-token) | void        | String token |
| [OnNoContact](#typedef-void-onnocontactstring-token)   | void        | String token |

#### Type Definitions

##### typedef void OnHasContact(String token)

Contact status type definition used as type for callback function which notifies the app that a shared key matches historical contact records stored on the device.

##### typedef void OnNoContact(String token)

Contact status type definition used as type for callback function which notifies the app that a shared key has not matched any historical contact records stored on the device.

#### Properties

| Name         | Type                                                   | Description                                                                                                                    |
| ------------ | ------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ |
| onHasContact | [OnHasContact](#typedef-void-onhascontactstring-token) | Callback function that notifies the app that a shared key matches historical contact records stored on the device.             |
| onNoContact  | [OnNoContact](#typedef-void-onnocontactstring-token)   | Callback function that notifies the app that a shared key has not matched any historical contact records stored on the device. |

#### Constructor Summary

| Constructor                                                                                                                                                    | Description          |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------- |
| ContactShieldCallback({[OnHasContact](#typedef-void-onhascontactstring-token) onHasContact, [OnNoContact](#typedef-void-onnocontactstring-token) onNoContact}) | Default constructor. |

#### Constructors

##### ContactShieldCallback({[OnHasContact](#typedef-void-onhascontactstring-token) onHasContact, [OnNoContact](#typedef-void-onnocontactstring-token) onNoContact})

Default constructor for **ContactShieldCallback** object.

### RiskLevel

Class which holds risk level constants.

#### Constants

| Constant               | Type | Value | Description             |
| ---------------------- | ---- | ----- | ----------------------- |
| RISK_LEVEL_INVALID     | int  | 0     | Invalid risk level.     |
| RISK_LEVEL_LOWEST      | int  | 1     | Lowest risk level.      |
| RISK_LEVEL_LOW         | int  | 2     | Low risk level.         |
| RISK_LEVEL_MEDIUM_LOW  | int  | 3     | Low-medium risk level.  |
| RISK_LEVEL_MEDIUM      | int  | 4     | Medium risk level.      |
| RISK_LEVEL_MEDIUM_HIGH | int  | 5     | Medium-high risk level. |
| RISK_LEVEL_HIGH        | int  | 6     | High risk level.        |
| RISK_LEVEL_EXT_HIGH    | int  | 7     | Very high risk level.   |
| RISK_LEVEL_HIGHEST     | int  | 8     | Highest risk level.     |

## 4. Configuration and Description

### Configuring Obfuscation Scripts

In order to prevent error while release build, you may need to add following lines in **proguard-rules.pro** file.

```text
-ignorewarnings
-keepattributes *Annotation*
-keepattributes Exceptions
-keepattributes InnerClasses
-keepattributes Signature
-keep class com.hianalytics.android.**{*;}
-keep class com.huawei.updatesdk.**{*;}
-keep class com.huawei.hms.**{*;}
-keep class com.huawei.hms.flutter.** { *; }

# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn io.flutter.embedding.**
-repackageclasses
```

### Contact Shield Permissions

To use Contact Shield you need to declare required permissions inside **AndroidManifest.xml** file as shown below.

```xml
<manifest ...>
    <uses-permission android:name="android.permission.INTERNET " />
    <uses-permission android:name="android.permission.BLUETOOTH" />

  <application ...>
    <activity ...>
      <!-- Other configurations -->
    </activity>
  </application>
</manifest>
```

---

## 5. Sample Project

This plugin includes a demo project in the [example](example) folder, there you can find more usage examples.

---

## 6. Questions or Issues

If you have questions about how to use HMS samples, try the following options:

- [Stack Overflow](https://stackoverflow.com/questions/tagged/huawei-mobile-services) is the best place for any programming questions. Be sure to tag your question with **huawei-mobile-services**.
- [Github](https://github.com/HMS-Core/hms-flutter-plugin) is the official repository for these plugins, You can open an issue or submit your ideas.
- [Huawei Developer Forum](https://forums.developer.huawei.com/forumPortal/en/home?fid=0101187876626530001) HMS Core Module is great for general questions, or seeking recommendations and opinions.
- [Huawei Developer Docs](https://developer.huawei.com/consumer/en/doc/overview/HMS-Core-Plugin) is place to official documentation for all HMS Core Kits, you can find detailed documentations in there.

If you run into a bug in our samples, please submit an issue to the [GitHub repository](https://github.com/HMS-Core/hms-flutter-plugin).

---

## 7. Licensing and Terms

Huawei Contact Shield Kit Flutter Plugin is licensed under [Apache 2.0 license](LICENSE)
