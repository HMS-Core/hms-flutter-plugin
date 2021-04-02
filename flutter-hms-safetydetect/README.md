# Huawei Safety Detect Kit Flutter Plugin

---

## Contents

  - [1. Introduction](#1-introduction)
  - [2. Installation Guide](#2-installation-guide)
    - [Creating a Project in App Gallery Connect](#creating-a-project-in-appgallery-connect)
    - [Configuring the Signing Certificate Fingerprint](#configuring-the-signing-certificate-fingerprint)
    - [Integrating the Flutter Safety Detect Plugin](#integrating-the-flutter-safety-detect-plugin)
  - [3. API Reference](#3-api-reference)
    - [SafetyDetect](#safety-detect)
    - [Data Types](#data-types)
    - [Constants](#constants)
  - [4. Configuration and Description](#4-configuration-and-description)
  - [5. Sample Project](#5-sample-project)
  - [6. Questions or Issues](#6-questions-or-issues)
  - [7. Licensing and Terms](#7-licensing-and-terms)

---

## 1. Introduction

**HUAWEI Safety Detect** builds robust security capabilities, including system integrity check (SysIntegrity), app security check (AppsCheck), malicious URL check (URLCheck), fake user detection (UserDetect), and malicious WiFi detection (WifiDetect), into your app, effectively protecting it against security threats.
This plugin enables communication between HUAWEI Safety Detect Kit SDK and Flutter platform. It exposes all functionality provided by HUAWEI Safety Detect Kit SDK.

---

## 2. Installation Guide

Before you get started, you must register as a HUAWEI Developer and complete identity verification on the [HUAWEI Developer](https://developer.huawei.com/consumer/en/) website. For details, please refer to [Register a HUAWEI ID](https://developer.huawei.com/consumer/en/doc/10104).

### Creating a Project in AppGallery Connect
Creating an app in the AppGallery Connect is required in order to communicate with the Huawei services. To create an app, perform the following steps:

**Step 1.** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html)  and select **My projects**.

**Step 2.** Select your project from the project list or create a new one by clicking the **Add Project** button.

**Step 3.** Go to **Project Setting** > **General information**, and click **Add app**.
If an app exists in the project and you need to add a new one, expand the app selection area on the top of the page and click **Add app**.

**Step 4.** On the **Add app** page, enter the app information, and click **OK**.

### Configuring the Signing Certificate Fingerprint

A signing certificate fingerprint is used to verify the authenticity of an app when it attempts to access an HMS Core (APK) through the HMS SDK. Before using the HMS Core (APK), you must locally generate a signing certificate fingerprint and configure it in the **AppGallery Connect**. You can refer to 3rd and 4th steps of [Generating a Signing Certificate](https://developer.huawei.com/consumer/en/codelab/HMSPreparation/index.html#2) codelab tutorial for the certificate generation. Perform the following steps after you have generated the certificate.

**Step 1:** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) and select your project from **My Projects**. Then go to **Project Setting** > **General information**. In the **App information** field, click the add icon next to SHA-256 certificate fingerprint, and enter the obtained **SHA-256 certificate fingerprint**.

**Step 2:**  After completing the configuration, click **OK** (Check mark icon) to save the changes.

### Integrating the Flutter Safety Detect Plugin

**Step 1:** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) and select your project from **My Projects**. Then go to **Project Settings > Manage APIs** and make sure the **Safety Detect** is enabled.

**Step 2:** Go to **Project Setting > General information** page, under the **App information** field, click **agconnect-services.json** to download the configuration file.

**Step 3:** Copy the **agconnect-services.json** file to the **android/app** directory of your project.

**Step 4:** Open the **build.gradle** file in the **android** directory of your project.

- Navigate to the **buildscript** section and configure the Maven repository address and agconnect plugin for the HMS SDK.

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

- Go to **allprojects** and configure the Maven repository address for the HMS SDK.
  
  ```gradle
  allprojects {
    repositories {
        google()
        jcenter()
        maven { url 'https://developer.huawei.com/repo/' }
    }
  }
  ```

**Step 5:** Open the **build.gradle** file in the **android/app/** directory.

- Add `apply plugin: 'com.huawei.agconnect'` line after other `apply` entries.
  ```gradle
  apply plugin: 'com.android.application'
  apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"
  apply plugin: 'com.huawei.agconnect'
  ```

- Set your package name in **defaultConfig > applicationId** and set **minSdkVersion** to **19** or higher. Package name must match with the **package_name** entry in the **agconnect-services.json** file. 

  ```gradle
  defaultConfig {
      applicationId "<package_name>"
      minSdkVersion 19
      /*
      * <Other configurations>
      */
  }
  ```

**Step 6:** Create a file **<app_dir>/android/key.properties** that contains a reference to your **keystore** which you generated on the previous step ([Generating a Signing Certificate](https://developer.huawei.com/consumer/en/codelab/HMSPreparation/index.html#2)). Add the following lines to the **key.properties** file and change the values regarding to the **keystore** you've generated.  

```
storePassword=<your_keystore_password>
keyPassword=<your_key_password>
keyAlias=<your_key_alias>
storeFile=<location of the keystore file, for example: D:\\Users\\<user_name>\\key.jks>
```
> Warning: Keep this file private and don't include it on the public source control.

**Step 7:** Add the following code to the first line of **android/app/build.gradle** for reading the **key.properties** file:

```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}
```

**Step 8:**  Edit **buildTypes** as follows and add the **signingConfigs** below:

```gradle
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
        signingConfig signingConfigs.config
    }
}
```

**Step 9:** On your Flutter project directory, find and open your **pubspec.yaml** file and add the **huawei_safetydetect** library to dependencies. For more details please refer to the [Using packages](https://flutter.dev/docs/development/packages-and-plugins/using-packages#dependencies-on-unpublished-packages) document.

  - To download the package from [pub.dev](https://pub.dev/publishers/developer.huawei.com/packages).

    ```yaml
      dependencies:
        huawei_safetydetect: {library version}
    ```

    **or**

    If you downloaded the package from the HUAWEI Developer website, specify the **library path** on your local device.

    ```yaml
      dependencies:
        huawei_safetydetect:
            # Replace {library path} with actual library path of Huawei Safety Detect Plugin for Flutter.
            path: {library path}
    ```

    - Replace {library path} with the actual library path of the Flutter Safety Detect Kit Plugin. The following are examples:
      - Relative path example: `path: ../huawei_safetydetect`
      - Absolute path example: `path: D:\Projects\Libraries\huawei_safetydetect`

**Step 10:** Run the following command to update the package info.

```
[project_path]> flutter pub get
```

**Step 11:** Import the library to access the methods.

```dart
import 'package:huawei_safetydetect/huawei_safetydetect.dart';
```

**Step 12:** Run the following command to start the app.

```
[project_path]> flutter run
```

---

## 3. API Reference

### Safety Detect
The plugin class that provides HUAWEI Safety Detect APIs which can be called to check the system security.

#### Public Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
|[getAppID](#futurestring-get-getappid-async)   |   Future\<String>   |   Obtains the Application ID from the **agconnect-services.json** file.   |
|[sysIntegrity](#futurestring-sysintegrityuint8list-nonce-string-appid-async)   |   Future\<String>   |   Initiates a request to check the system integrity of the current device.   |
|[isVerifyAppsCheck](#futurebool-isverifyappscheck-async)   |   Future\<bool>   |   Checks whether app security check is enabled.   |
|[enableAppsCheck](#futurebool-enableappscheck-async)   |   Future\<bool>    |   Enables app security check.   |
|[getMaliciousAppsList](#futurelistmaliciousappdata-getmaliciousappslist-async)   |   Future\<List\<[MaliciousAppData](#maliciousappdata)>>   |   Initiates an app security check request.   |
|[initUrlCheck](#futurevoid-initurlcheck-async)   |   Future\<void>   |   Initializes URL check.   |
|[urlCheck](#futurelisturlcheckthreat-urlcheckstring-url-string-appid-listurlthreattypes-urlthreattypes-async)   |   Future\<List\<[UrlCheckThreat](#urlcheckthreat)>>   |   Initiates a URL check request.   |
|[shutdownUrlCheck](#futurevoid-shutdownurlcheck-async)   |   Future\<void>    |   Disables URL check.   |
|[initUserDetect](#futurevoid-inituserdetect-async)   |   Future\<void>    |   Initializes fake user detection.   |
|[userDetection](#futurestring-userdetectionstring-appid-async)   |   Future\<String>   |   Initiates a fake user detection request. **Note:** This function is not available in the Chinese Mainland. |
|[shutdownUserDetect](#futurevoid-shutdownuserdetect-async)   |   Future\<void>   |  Disables fake user detection.   |
|[getWifiDetectStatus](#futurewifidetectresponse-getwifidetectstatus-async)   |   Future\<[WifiDetectResponse](#wifidetectresponse)>   |   Obtains the malicious Wi-Fi check result. **Note:** This feature is available only in the Chinese Mainland.   |
|[initAntiFraud](#futurevoid-initantifraudstring-appid-async)   |   Future\<void>   |   Initializes imperceptible fake user detection.   |
|[releaseAntiFraud](#futurevoid-releaseantifraud-async)   |   Future\<void>    |   Disables imperceptible fake user detection. |
|[getRiskToken](#futurestring-getrisktoken-async)   |   Future\<String>   |   Obtains a risk token.   |
|[enableLogger](#futurevoid-enablelogger-async)   |   Future\<void>   |   Enables HMS Plugin Method Analytics which is used for sending usage analytics of Safety Detect SDK's methods to improve the service quality.   |
|[disableLogger](#futurevoid-disablelogger-async)   |   Future\<void>   |   Disables HMS Plugin Method Analytics which is used for sending usage analytics of Safety Detect SDK's methods to improve the service quality.   |
#### Public Methods
##### Future\<String> *get* getAppID *async*
Obtains the Application ID from the **agconnect-services.json** file.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<String> |The Application ID.|
###### Call Example

```dart
// Example for obtaining the appID on a stateful widget's init state
String appId;

@override
void initState() {
  super.initState();
  getAppId();
}

void getAppId() async {
  String res = await SafetyDetect.getAppID;
  if (!mounted) return;
  setState(() {
      appId = res;
  });
}
```



##### Future\<String> sysIntegrity(Uint8List nonce, String appId) *async*

Initiates a request to check the system integrity of the current device.
###### Parameters
| Parameter   | Type        | Description |
|-------------|-------------|-------------|
|  nonce | Uint8List | Cryptographic nonce value, which is used to prevent replay attacks. Ensure that the nonce value passed each time when the sysIntegrity API is called is unique. A nonce value consists of 16 to 66 bytes. |
| appId | String | The App ID applied in the AppGallery Connect. HMS Core (APK) needs to authenticate the app ID. You need to enable the Safety Detect service on the Manage APIs page in the AppGallery Connect. Since you have created an app during development preparations, you can obtain the app ID from the **agconnect-services.json** file by the [getAppID](#futurestring-get-getappid-async) method. |
###### Return Type
| Type        | Description |
|-------------|-------------|
|Future\<String>          |System integrity check result which is in JSON Web Signature (JWS)-format, encoded using **Base64URL**. If an exception or error occurs, **null** will be returned.<br /> <br />Fields in JWS-format **Header** are as follows:<pre lang="json">{<br />  "alg": "RS256",<br />  "x5c": ["",""]<br />}</pre>**Note:**<br />"**alg**": signature algorithm name. The value **RS256** indicates the **SHA256withRSA** algorithm. "**x5c**": certificate chain used by Huawei signature server for JWS signing. The value **x5c[0]** indicates the certificate for JWS signing and **x5c[1]** indicates the CA certificate of a Huawei device.<br /> <br />Fields in JWS-format **Payload** are as follows:<pre lang="json">{<br />  "nonce": "bSshKk0YTZrfOl5IjK7HcQ==",<br />  "timestampMs": 1571708929141,<br />  "apkPackageName": "com.huawei.hms.safetydetectsample",<br />  "apkDigestSha256": "6Ihk8Wcv1MLm0O5KUCEVYCI/0KWzAHn9DyN38R3WYu8=",,<br />  "apkCertificateDigestSha256": "["yT5JtXRgeIgXssx1gQTsMA9GzM9ER4xAgCsCC69Fz3I="],<br />  "basicIntegrity": false,<br />}</pre><br />**Note:**<br />"**nonce**": Base64-encoding result of the nonce value passed when the **sysIntegrity** API is called.<br />"**timestampMs**": timestamp generated by the Huawei signing server.<br />"**apkPackageName**": your package name<br />"**apkDigestSha256**": SHA-256 digest of your app's Android package (APK).<br />"**apkCertificateDigestSha256**": SHA-256 digest of your app's signing certificate.<br />"**basicIntegrity**": system integrity check result. The value **true** indicates that the system is integral.<br />"**advice**": suggestions in handling the system integrity check result. The value **RESTORE_TO_FACTORY_ROM** indicates restoration to factory settings. |

###### Call Example

```dart
void checkSysIntegrity() async {
    Random secureRandom = Random.secure();
    List randomIntegers = List<int>();
    for (var i = 0; i < 24; i++) {
        randomIntegers.add(secureRandom.nextInt(255));
    }
    Uint8List nonce = Uint8List.fromList(randomIntegers);
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
        String sysintegrityresult = await SafetyDetect.sysIntegrity(nonce, appId);
        List<String> jwsSplit = sysintegrityresult.split(".");
        String decodedText = utf8.decode(base64Url.decode(jwsSplit[1]));
        Map<String, dynamic> jsonMap = json.decode(decodedText);
        bool basicIntegrity = jsonMap['basicIntegrity'];
        print("BasicIntegrity is ${basicIntegrity.toString()}");
        print("SysIntegrityCheck result is: $decodedText");
    } on PlatformException catch (e) {
        print("Error occured while getting SysIntegrityResult. Error is : ${e.toString()}");
    }
}
```



##### Future\<bool> isVerifyAppsCheck() *async*

Checks whether app security check is enabled.
###### Return Type
| Type        | Description |
|-------------|-------------|
|Future\<bool>          |Whether app security check is enabled. (App security check is enabled by default and cannot be disabled. Therefore, the value **true** is always returned.)|
###### Call Example

```dart
void verifyAppsCheck() async {
  bool result = await SafetyDetect.isVerifyAppsCheck();
  print("AppsCheck is " + (result ? "verified." : "not verified."));
}
```



##### Future\<bool> enableAppsCheck() *async*

Enables app security check.
###### Return Type
| Type        | Description |
|-------------|-------------|
|Future\<bool>          |Result of enabling app security check. (App security check is enabled by default and cannot be disabled. Therefore, the value **true** is always returned.)|
###### Call Example

```dart
void enableAppsCheck() async {
  bool result = await SafetyDetect.enableAppsCheck();
  print("AppsCheck is " + (result ? "enabled" : "disabled"));
}
```

##### Future\<List\<MaliciousAppData>> getMaliciousAppsList() *async*

Initiates an app security check request.
###### Return Type
| Type        | Description |
|-------------|-------------|
|Future\<List\<[MaliciousAppData](#maliciousappdata)>>          |App security check result list.|
###### Call Example

```dart
void getMaliciousAppsList() async {
  List<MaliciousAppData> maliciousApps = [];
  maliciousApps = await SafetyDetect.getMaliciousAppsList();
  String maliciousAppsResult = maliciousApps.length == 0
        ? "No malicious apps detected."
        : "Malicious Apps:" + maliciousApps.toString();
  print(maliciousAppsResult);
}
```



##### Future\<void> initUrlCheck() *async*

Initializes URL check.
###### Return Type
| Type        | Description |
|-------------|-------------|
|Future\<void>          |Future result of an execution that returns no value.|
###### Call Example

```dart
SafetyDetect.initUrlCheck();
```

##### Future\<List\<UrlCheckThreat>> urlCheck(String url, String appId, List\<UrlThreatTypes> urlThreatTypes)  *async*

Initiates a URL check request.
###### Parameters
| Parameter   | Type        | Description |
|-------------|-------------|-------------|
|  url   |  String  | URL to check, including the protocol, host, and path but excluding query parameters. The SDK will discard all passed query parameters. |
| appId | String | The App ID applied in the AppGallery Connect. HMS Core (APK) needs to authenticate the app ID. You need to enable the Safety Detect service on the Manage APIs page in the AppGallery Connect. Since you have created an app during development preparations, you can obtain the app ID from the **agconnect-services.json** file by the [getAppID](#futurestring-get-getappid-async) method. |
| urlThreatTypes | List\<[UrlThreatType](#enum-urlthreattype)> | Concerned threat types for URLs to check. |
###### Return Type
| Type        | Description |
|-------------|-------------|
|Future\<List\<[UrlCheckThreat](#urlcheckthreat)>>          |URL check results.|
###### Call Example

```dart
void urlCheck() async {
  String concernedUrl = "http://example.com/hms/safetydetect/malware";
  String urlCheckRes = "";
  List<UrlThreatType> threatTypes = [
    UrlThreatType.malware,
    UrlThreatType.phishing];
  List<UrlCheckThreat> urlCheckResults =
    await SafetyDetect.urlCheck(concernedUrl, appId, threatTypes);
  if (urlCheckResults.length == 0) {
      urlCheckRes = "No threat is detected for the URL: $concernedUrl";
    } else {
      urlCheckResults.forEach((element) {
        urlCheckRes += "${element.getUrlThreatType} is detected on the URL: $concernedUrl";
     });
   }
  print(urlCheckRes);
}
```

##### Future\<void> shutdownUrlCheck() *async*

Disables URL check.
###### Return Type
| Type        | Description |
|-------------|-------------|
|Future\<void>          |Future result of an execution that returns no value.|
###### Call Example

```dart
SafetyDetect.shutdownUrlCheck();
```

##### Future\<void> initUserDetect() *async*

Initializes fake user detection.
###### Return Type
| Type        | Description |
|-------------|-------------|
|Future\<void>          |Future result of an execution that returns no value.|
###### Call Example

```dart
SafetyDetect.initUserDetect();
```

##### Future\<String> userDetection(String appId) *async*

Initiates a fake user detection request.

> Note: This function is not available in the Chinese Mainland.

###### Parameters
| Parameter   | Type        | Description |
|-------------|-------------|-------------|
|  appId |  String  | The App ID applied in the AppGallery Connect. HMS Core (APK) needs to authenticate the app ID. You need to enable the Safety Detect service on the Manage APIs page in the AppGallery Connect. Since you have created an app during development preparations, you can obtain the app ID from the **agconnect-services.json** file by the [getAppID](#futurestring-get-getappid-async) method. |
###### Return Type
| Type        | Description |
|-------------|-------------|
|Future\<String>          |Response token returned by the **userDetection** API. You can use the response token to obtain the fake user detection result from the cloud of **UserDetect**.|
###### Call Example

```dart
void userDetection() async {
    try {
        String token = await SafetyDetect.userDetection(appId);
        print("User verification succeded, user token: $token");
    } on PlatformException catch (e) {
        print("Error occurred: ${e.code}:" +
              SafetyDetectStatusCodes[e.code]);
    }
}
```

##### Future\<void> shutdownUserDetect() *async*

Disables fake user detection.
###### Return Type
| Type        | Description |
|-------------|-------------|
|Future\<void>          |Future result of an execution that returns no value.|
###### Call Example

```dart
SafetyDetect.shutdownUserDetect();
```

##### Future\<WifiDetectResponse> getWifiDetectStatus() *async*

Obtains the malicious Wi-Fi check result.

> **Note:** This feature is available only in the Chinese Mainland.

###### Return Type
| Type        | Description |
|-------------|-------------|
|Future\<[WifiDetectResponse](#wifidetectresponse)>          |Malicious Wi-Fi check result. Result will contain the obtained wifi options. <br />The options are as follows:<br />**0**: No Wi-Fi is connected.<br />**1**: The Wi-Fi is secure.<br />**2**: The Wi-Fi is insecure.|
###### Call Example

```dart
void getWifiDetectStatus() async {
    try {
        WifiDetectResponse wifiDetectStatus =
            await SafetyDetect.getWifiDetectStatus();
        print("Wifi detect status is: " +
              wifiDetectStatus.getWifiDetectType.toString());
    } on PlatformException catch (e) {
        String resultCodeDesc = SafetyDetectStatusCodes[e.code];
        print("Error occurred with status code: ${e.code}, Description: $resultCodeDesc");
    }
}
```

##### Future\<void> initAntiFraud(String appId) *async*

Initializes imperceptible fake user detection.
###### Parameters
| Parameter   | Type        | Description |
|-------------|-------------|-------------|
|  appId |  String  | The App ID applied in the AppGallery Connect. HMS Core (APK) needs to authenticate the app ID. You need to enable the Safety Detect service on the Manage APIs page in the AppGallery Connect. Since you have created an app during development preparations, you can obtain the app ID from the **agconnect-services.json** file by the [getAppID](#futurestring-get-getappid-async) method. |
###### Return Type
| Type        | Description |
|-------------|-------------|
|Future\<void>          |Future result of an execution that returns no value.|
###### Call Example

```dart
void initAntiFraud() async {
  SafetyDetect.initAntiFraud(appId);
  print("Anti Fraud enabled");
}
```

##### Future\<void> releaseAntiFraud() *async*

Disables imperceptible fake user detection. 
###### Return Type
| Type        | Description |
|-------------|-------------|
|Future\<void>          |Future result of an execution that returns no value.|
###### Call Example

```dart
void releaseAntiFraud() async {
    SafetyDetect.releaseAntiFraud();
    print("Anti Fraud disabled");
}
```

##### Future\<String> getRiskToken() *async*

Obtains a risk token.
###### Return Type
| Type        | Description |
|-------------|-------------|
|Future\<String>          |Risk token.|
###### Call Example

```dart
void getRiskToken() async {
    String riskToken = await SafetyDetect.getRiskToken();
    print("Risk token obtained: $riskToken");
}
```

##### Future\<void> enableLogger() *async*

Enables HMS Plugin Method Analytics which is used for sending usage analytics of Safety Detect SDK's methods to improve the service quality.
###### Return Type
| Type        | Description |
|-------------|-------------|
|Future\<void>          |Future result of an execution that returns no value.|
###### Call Example

```dart
SafetyDetect.enableLogger(); // Enables HMSLogger
```

##### Future\<void> disableLogger() *async*

Disables HMS Plugin Method Analytics which is used for sending usage analytics of Safety Detect SDK's methods to improve the service quality.
###### Return Type
| Type        | Description |
|-------------|-------------|
|Future\<void>          |Future result of an execution that returns no value.|

###### Call Example

```dart
SafetyDetect.disableLogger(); // Disables HMSLogger
```

### Data Types

This section contains data types for interaction with the HUAWEI Safety Detect Flutter Plugin APIs. The following table describes detailed information about data types.

#### Data Types Summary
| Classes | Description |
|-----------|-------------|
| [MaliciousAppData](#maliciousappdata) | Malicious app entity class which contains the verify apps check result.|
| [UrlCheckThreat](#urlcheckthreat) | Url check threat entity class which contains the url check threat result. |
| [WifiDetectResponse](#wifidetectresponse) | Wifi detect response entity class which contains the wifi detect result. |

### MaliciousAppData

Malicious app entity class which contains the verify apps check result.

#### Public Properties
| Name           | Type   | Description                                                  |
| -------------- | ------ | ------------------------------------------------------------ |
| apkCategory    | int    | Integer value of a malicious app type.<br />Values are as follows:<br />**1**: risk app<br />**2**: virus app<br />The corresponding [MaliciousAppType](#enum-maliciousapptype) can be obtained with [getMaliciousAppType](#maliciousapptype-get-getmaliciousapptype) method. |
| apkPackageName | String | Package name of a malicious app.                             |
| apkSha256      | String | Base64 encoding result of the SHA-256 value of a malicious app. |
#### Public Method Summary
| Method              | Return Type                                | Description                                                  |
| ------------------- | ------------------------------------------ | ------------------------------------------------------------ |
| getMaliciousAppType | [MaliciousAppType](#enum-maliciousapptype) | Obtains the MaliciousAppType that corresponds to the detected **apkCategory** of the current MaliciousAppData instance. |
| toMap               | Map\<String, dynamic>                      | Obtains the map representation of the current MaliciousAppData instance. |
| toString            | String                                     | Obtains the string representation of the current MaliciousAppData instance. |
#### Public Methods
##### MaliciousAppType *get* getMaliciousAppType
Obtains the [MaliciousAppType](#enum-maliciousapptype) that corresponds to the detected **apkCategory** of the current MaliciousAppData instance.
###### Return Type
| Type                  | Description         |
| --------------------- | ------------------- |
| [MaliciousAppType](#enum-maliciousapptype) | Malicious App Type. |
##### Map\<String, dynamic> toMap()
Obtains the map representation of the current MaliciousAppData instance.
###### Return Type
| Type                  | Description                                                |
| --------------------- | ---------------------------------------------------------- |
| Map\<String, dynamic> | Map representation of the current MaliciousAppData object. |
##### String toString()
Obtains the string representation of the current MaliciousAppData instance.
###### Return Type
| Type   | Description                                                  |
| ------ | ------------------------------------------------------------ |
| String | String representation of the current MaliciousAppData object. |

### UrlCheckThreat

Url check threat entity class which contains the url check threat result.

#### Public Method Summary
| Method            | Return Type        | Description                                                  |
| ----------------- | ------------------ | ------------------------------------------------------------ |
| getUrlCheckResult | int                | Obtains the integer value of the URL check result's threat type. The options are as follows:<br />**1**: MALWARE<br />**3**: PHISHING |
| getUrlThreatType  | [UrlThreatType](#enum-urlthreattype) | Obtains the UrlThreatType of the URL check result.           |
#### Public Methods
##### int *get* getUrlCheckResult
Obtains the integer value of the URL check result's threat type. The options are as follows:

- **1**: MALWARE
- **3**: PHISHING

###### Return Type
| Type | Description                       |
| ---- | --------------------------------- |
| int  | Integer value of the threat type. |
##### UrlThreatType *get* getUrlThreatType
Obtains the [UrlThreatType](#enum-urlthreattype) of the URL check result.
###### Return Type
| Type               | Description  |
| ------------------ | ------------ |
| [UrlThreatType](#enum-urlthreattype) | Threat type. |

### WifiDetectResponse

Wifi detect response entity class which contains the wifi detect result.

#### Public Method Summary
| Method              | Return Type         | Description                                                  |
| ------------------- | ------------------- | ------------------------------------------------------------ |
| getWifiDetectStatus | int                 | Obtains the security check result of a Wi-Fi network. This helps your app protect the payment and privacy security of your users, preventing economic loss and privacy breach. |
| getWifiDetectType   | [WifiDetectType](#enum-wifidetecttype) | Obtains the WifiDetectType of the wifiDetectStatus.          |
#### Public Methods
##### int *get* getWifiDetectStatus
Obtains the security check result of a Wi-Fi network. This helps your app protect the payment and privacy security of your users, preventing economic loss and privacy breach.
###### Return Type
| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| int  | Security status of the current Wi-Fi.<br />The options are as follows:<br />**0**: No Wi-Fi is connected.<br />**1**: The Wi-Fi is secure.<br />**2**: The Wi-Fi is insecure.<br />To obtain the corresponding [WifiDetectType](#enum-wifidetecttype) of the result please use the **getWifiDetectType** method |
##### WifiDetectType *get* getWifiDetectType
Obtains the [WifiDetectType](#enum-wifidetecttype) of the wifiDetectStatus.
###### Return Type
| Type                | Description       |
| ------------------- | ----------------- |
| [WifiDetectType](#enum-wifidetecttype) | Wifi Detect Type. |

### Constants

This section contains detailed information about constants provided by the HUAWEI Safety Detect Kit Flutter Plugin.

### enum MaliciousAppType

Threat Types that can be detected during app check.

| Value             | Description |
| ----------------- | ----------- |
| virus_level_risk  | Risk app.   |
| virus_level_virus | Virus app.  |

### enum UrlThreatType

Threat Types that can be detected during an url check.

| Value    | Description        |
| -------- | ------------------ |
| malware  | Malware URL type.  |
| phishing | Phishing URL type. |

### enum WifiDetectType

Security status type of the current Wi-Fi.

| Value         | Description            |
| ------------- | ---------------------- |
| no_wifi       | No Wi-Fi is connected. |
| secure_wifi   | The Wi-Fi is secure.   |
| insecure_wifi | The Wi-Fi is insecure. |

### SafetyDetectStatusCodes

Status codes of the HUAWEI Safety Detect SDK. These status codes are included in a constant Map in the library for an easy conversion between status code and result code.

###### Usage Sample:

```dart
void getWifiDetectStatus() async {
    try {
        WifiDetectResponse wifiDetectStatus =
            await SafetyDetect.getWifiDetectStatus();
        print("Wifi detect status is: " +
              wifiDetectStatus.getWifiDetectType.toString());
    } on PlatformException catch (e) {
        String resultCodeDesc = SafetyDetectStatusCodes[e.code];
        print("Error occurred with status code: ${e.code}, Description: $resultCodeDesc");
    }
}
```

| Result Code                             | Value | Description                                                  | Solution                                                     |
| --------------------------------------- | ----- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| SDK_INTERNAL_ERROR                      | 19001 | HMS Core SDK internal error.                                 | Go to **Support** > **Customer Service** > **Submit Question Online**, select the relevant topic, and submit your question. Huawei will get back to you as soon as possible. |
| NETWORK_ERROR                           | 19002 | Network exception.                                           | Verify that your phone has access to the Internet.           |
| UNSUPPORTED_AREA                        | 19003 | The API is unavailable in this region.                       | Verify that this API is supported in the region where the user is located. |
| INVALID_APPID_APPCHECK                  | 19004 | Invalid app ID in the request.                               | Verify that the app ID in the request is valid.              |
| UNSUPPORTED_EMUI_VERSION                | 19202 | The HMS Core (APK) version on the user device does not support the Safety Detect service. | Update HMS Core (APK) to the latest version.                 |
| APPS_CHECK_FAILED_VIRUS_NUMBER_EXCEEDED | 19402 | The number of apps to check exceeds the maximum allowed by **AppCheck**. | Reduce the number of apps to check.                          |
| PARAM_ERROR_EMPTY                       | 19150 | A mandatory parameter in the request is empty.               | Verify that all mandatory parameters in the request are correctly set. |
| PARAM_ERROR_INVALID                     | 19151 | Parameter verification failed.                               | Verify that parameters in the request are valid.             |
| APPS_CHECK_INTERNAL_ERROR               | 19401 | An internal error occurred during app security check.        | Contact Huawei technical support.                            |
| URL_CHECK_INNER_ERROR                   | 19600 | An internal error occurred during malicious URL check.       | Contact Huawei technical support.                            |
| CHECK_WITHOUT_INIT                      | 19601 | **URLCheck** initialization failed.                          | Call the **initUrlCheck()** API first to initialize **URLCheck**. |
| URL_CHECK_THREAT_TYPE_INVALID           | 19602 | The **URLCheck** API does not support the passed URL categories. Currently, Safety Detect can only identify phishing and malware URLs. | Verify that the passed URL categories are valid.             |
| URL_CHECK_REQUEST_PARAM_INVALID         | 19603 | Invalid parameters for calling **urlCheck**.                 | Verify that relevant parameters are valid.                   |
| URL_CHECK_REQUEST_APPID_INVALID         | 19604 | The app ID passed for calling **urlCheck** is invalid.       | Verify that the passed app ID is valid.                      |
| DETECT_FAIL                             | 19800 | Fake user detection failed.                                  | Try again. If the detection fails for three times, risks exist. |
| USER_DETECT_TIMEOUT                     | 19801 | Fake user detection timed out, for example, when the user enters the verification code. | Try again.                                                   |
| USER_DETECT_INVALID_APPID               | 19802 | The app ID passed for calling **userDetection** is invalid.  | Verify that the passed app ID is valid.                      |
| ANTI_FRAUD_INIT_FAIL                    | 19820 | Failed to initialize imperceptible fake user detection.      | Contact Huawei technical support.                            |
| ANTI_FRAUD_INIT_PARAM_INVALID           | 19821 | The app ID passed to the **initAntiFraud** API is incorrect. | Verify the passed parameter.                                 |
| RISK_TOKEN_GET_FAIL                     | 19830 | Failed to obtain the risk token.                             | Initializes the API again.                                   |
| RISK_TOKEN_INNER_ERROR                  | 19831 | An internal error occurred on the API for obtaining a risk token. | Contact Huawei technical support.                            |
| UNKOWN_ERROR_STATUS_CODE                | -1    | Unkown error code.                                           | -                                                            |

---

## 4. Configuration and Description

### Preparing for Release

Before building a release version of your app you may need to customize the **proguard-rules**.pro obfuscation configuration file to prevent the HMS Core SDK from being obfuscated. Add the configurations below to exclude the HMS Core SDK from obfuscation. For more information on this topic refer to [this Android developer guide](https://developer.android.com/studio/build/shrink-code).

**\<flutter_project>/android/app/proguard-rules.pro**

```
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
```

**\<flutter_project>/android/app/build.gradle**

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

<img src="https://github.com/HMS-Core/hms-flutter-plugin/raw/master/flutter-hms-safetydetect/example/.docs/screenshot1.jpg" width = 40% height = 40% style="margin:1.5em"><img src="https://github.com/HMS-Core/hms-flutter-plugin/raw/master/flutter-hms-safetydetect/example/.docs/screenshot2.jpg" width = 40% height = 40% style="margin:1.5em">

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

Huawei Safety Detect Kit Flutter Plugin is licensed under [Apache 2.0 license](LICENSE)
