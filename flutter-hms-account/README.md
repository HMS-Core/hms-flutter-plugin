# Huawei Account Kit Flutter Plugin

---

## Contents

  - [1. Introduction](#1-introduction)
  - [2. Installation Guide](#2-installation-guide)
    - [Creating Project in App Gallery Connect](#creating-project-in-app-gallery-connect)
    - [Configuring the Signing Certificate Fingerprint](#configuring-the-signing-certificate-fingerprint)
    - [Integrating Flutter Account Plugin](#integrating-flutter-account-plugin)
  - [3. API Reference](#3-api-reference)
    - [HmsAuthService](#hmsauthservice)
    - [HmsAuthManager](#hmsauthmanager)
    - [HmsAuthTool](#hmsauthtool)
    - [HmsNetworkTool](#hmsnetworktool)
    - [HmsSmsManager](#hmssmsmanager)
    - [Data Types](#data-types)
  - [4. Configuration and Description](#4-configuration-and-description)
    - [Preparing for Release](#preparing-for-release)
  - [5. Sample Project](#5-sample-project)
  - [6. Questions or Issues](#6-questions-or-issues)
  - [7. Licensing and Terms](#7-licensing-and-terms)

---

## 1. Introduction

Flutter Account Kit Plugin enables communication between Huawei Account SDK and Flutter platform. It enables user login processes to be carried out quickly and easily with HUAWEI Account Kit's two factor authentication. Detailed information about the API's which are provided by this plugin can be found below.
- **HmsAuthService**: Provides a set of API's that allows you to sign in to an app with a HUAWEI ID.
- **HmsAuthManager**: Contains API's that are entry points for the HUAWEI ID sign-in service.
- **HmsAuthTool**: Provides API's to obtain and delete authorization information.
- **HmsNetworkTool**: Allows you to construct a cookie based on specified parameters.
- **HmsSmsManager**: Enables the service of reading SMS messages until the SMS messages that meet the rules are obtained or the service times out (the timeout duration is 5 minutes).

This plugin enables communication between HUAWEI Account Kit SDK and Flutter platform. It exposes all functionality provided by HUAWEI Account Kit SDK.

---

## 2. Installation Guide

- Before you get started, you must register as a HUAWEI developer and complete identity verification on the [HUAWEI Developer](https://developer.huawei.com/consumer/en/) website. For details, please refer to [Register a HUAWEI ID](https://developer.huawei.com/consumer/en/doc/10104).

- Create an app in your project is required in AppGallery Connect in order to communicate with Huawei services. To create an app, perform the following steps:

### Creating Project in App Gallery Connect

**Step 1.** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en) and select **My projects**.

**Step 2.** Click your project from the project list.

**Step 3.** Go to **Project Setting** > **General information**, and click **Add app**. If an app exists in the project, and you need to add a new one, expand the app selection area on the top of the page and click **Add app**.

**Step 4.** On the **Add app** page, enter app information, and click **OK**.

- A signing certificate fingerprint is used to verify the authenticity of an app when it attempts to access an HMS Core service through the HMS Core SDK. Before using HMS Core (APK), you must locally generate a signing certificate fingerprint and configure it in AppGallery Connect. Ensure that the JDK has been installed on your computer.

- To use HUAWEI Account, you need to enable the Account service. For details, please refer to [Enabling Services](https://developer.huawei.com/consumer/en/doc/distribution/app/agc-enable_service#h1-1574822945685).

### Configuring the Signing Certificate Fingerprint

**Step 1:** Go to **Project Setting** > **General information**. In the **App information** field, click the icon next to SHA-256 certificate fingerprint, and enter the obtained **SHA256 certificate fingerprint**.

**Step 2:** After completing the configuration, click check mark.

### Integrating Flutter Account Plugin

**Step 1:** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) and select **My projects**.

**Step 2:** Find your app project, and click the desired app name.

**Step 3:** Go to **Project Setting** > **General information**. In the **App information** section, click **agconnect-service.json** to download the configuration file.

**Step 4:** Create a Flutter project if you do not have one.

**Step 5:** Copy the **agconnect-service.json** file to the **android/app** directory of your Flutter project.

**Step 6:** Copy the signature file that generated in [Generating a Signing Certificate](https://developer.huawei.com/consumer/en/codelab/HMSPreparation/index.html#3) section, to the android/app directory of your Flutter project.

**Step 7:** Check whether the **agconnect-services.json** file and signature file are successfully added to the **android/app** directory of the Flutter project.

**Step 8:** Open the **build.gradle** file in the **android** directory of your Flutter project.

- Go to **buildscript** then configure the Maven repository address and agconnect plugin for the HMS SDK.

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

- Add `apply plugin: 'com.huawei.agconnect'` line after the `apply` entries.

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

- Configure the signature in **android** according to the signature file information and configure Obfuscation Scripts.

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

- For Obfuscation Scripts, please refer to [Configuring Obfuscation Scripts](https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides/config-obfuscation-script-0000001056835760).

**Step 10:** On your Flutter project directory find and open your **pubspec.yaml** file and add library to dependencies.

- To download the package from [pub.dev](https://pub.dev/publishers/developer.huawei.com/packages).

  ```yaml
  dependencies:
    huawei_account: { library version }
  ```

  **or**

  If you downloaded the package from the HUAWEI Developer website, specify the **library path** on your local device.

  ```yaml
  dependencies:
    huawei_account:
      # Replace {library path} with actual library path of Huawei Account Plugin for Flutter.
      path: { library path }
  ```

  - Replace {library path} with the actual library path of Flutter Account Plugin. The following are examples:
    - Relative path example: `path: ../huawei_account`
    - Absolute path example: `path: D:\Projects\Libraries\huawei_account`

**Step 11:** Run following command to update package info.

```
  [project_path]> flutter pub get
```

**Step 12:** Run following command to start the app.

```
  [project_path]> flutter run
```

---

## 3. API Reference

### HmsAuthService

#### Public Method Summary

| Method                                                                                                        | Return Type               | Description |
| ------------------------------------------------------------------------------------------------------------- | ------------------------- | ----------- |
| [signIn(HmsAuthParamHelper helper)](#futurehmsauthhuaweiid-signinhmsauthparamhelper-helper-async)             | Future\<[HmsAuthHuaweiId](#hmsauthhuaweiid)\> | Obtains the intent of the HUAWEI ID sign-in authorization page. |
| [silentSignIn(HmsAuthParamHelper helper)](#futurehmsauthhuaweiid-silentsigninhmsauthparamhelper-helper-async) | Future\<[HmsAuthHuaweiId](#hmsauthhuaweiid)\> | Obtains the sign-in information (or error information) about the HUAWEI ID that has been used to sign in to the app |
| [signOut()](#futurebool-signout-async)                                                                        | Future\<bool\>            | Signs out of the HUAWEI ID. |
| [revokeAuthorization()](#futurebool-revokeauthorization-async)                                                | Future\<bool\>            | Cancels the authorization from the HUAWEI ID user. |
| [enableLogger()](#futurevoid-enablelogger)                                                                    | Future\<void\>            | Enables HMS Plugin Method Analytics. |
| [disableLogger()](#futurevoid-disablelogger)                                                                  | Future\<void\>            | Disables HMS Plugin Method Analytics. |

#### Public Methods

##### Future\<[HmsAuthHuaweiId](#hmsauthhuaweiid)\> signIn({[HmsAuthParamHelper](#hmsauthparamhelper) helper}) async

This method is used to obtain the intent of the HUAWEI ID sign-in authorization page. When this method is called, an authorization page shows up. After signing in, the HUAWEI ID information is obtained via **HmsAuthHuaweiId** object.

###### Parameters

| Parameter | Description                     |
| --------- | ------------------------------- |
| helper    | Customizes the signing request. |

###### Return

| Type                                          | Description                                                                               |
| --------------------------------------------- | ----------------------------------------------------------------------------------------- |
| Future\<[HmsAuthHuaweiId](#hmsauthhuaweiid)\> | Returns the HmsAuthHuaweiId object on a successful operation, throws Exception otherwise. |

###### Call Example
```dart
// Create an instance of HmsAuthParamHelper
final helper = new HmsAuthParamHelper();

// Request user to authorize the app to obtain idToken and accessToken
helper..setIdToken()..setAccessToken();

try {
  // The parameter is optional You can call the method directly.
  final HmsAuthHuaweiId id = await HmsAuthService.signIn(authParamHelper: helper);
} on Exception catch(e) {
  print(e.toString());
}
```

##### Future\<[HmsAuthHuaweiId](#hmsauthhuaweiid)\> silentSignIn({[HmsAuthParamHelper](#hmsauthparamhelper) helper}) async

This method is used to obtain the HUAWEI ID that has been used to sign in to the app. In this process, the authorization page is not displayed to the HUAWEI ID user.

###### Parameters

| Parameter | Description                     |
| --------- | ------------------------------- |
| helper    | Customizes the signing request. |

###### Return

| Type                                          | Description                                                                                   |
| --------------------------------------------- | --------------------------------------------------------------------------------------------- |
| Future\<[HmsAuthHuaweiId](#hmsauthhuaweiid)\> | Returns the **HmsAuthHuaweiId** object on a successful operation, throws Exception otherwise. |

###### Call Example
```dart
final helper = new HmsAuthParamHelper();

helper..setIdToken()..setAccessToken();

try {
  final HmsAuthHuaweiId id = await HmsAuthService.silentSignIn(authParamHelper: helper);
} on Exception catch(e) {
  print(e.toString());
}
```

##### Future\<bool\> signOut() async

This method is used to sign out a HUAWEI ID. The HMS Core Account SDK deletes the cached HUAWEI ID information.

###### Return

| Type           | Description                                                         |
| -------------- | ------------------------------------------------------------------- |
| Future\<bool\> | Returns true on a successful operation, throws Exception otherwise. |

###### Call Example
```dart
try {
  final bool res = await HmsAuthService.signOut();
} on Exception catch(e) {
  print(e.toString());
}
```

##### Future\<bool\> revokeAuthorization() async

This method is used to cancel the authorization from the HUAWEI ID user. All user data will be removed after this method. On another signing attempt, the authorization page will be shown.

###### Return

| Type           | Description                                                         |
| -------------- | ------------------------------------------------------------------- |
| Future\<bool\> | Returns true on a successful operation, throws Exception otherwise. |

###### Call Example
```dart
try {
  final bool res = await HmsAuthService.revokeAuthorization();
} on Exception catch(e) {
  print(e.toString());
}
```

##### Future\<void\> enableLogger()

This method is used to enable HMS Plugin Method Analytics.

###### Return

| Type | Description |
| ---- | ----------- |
| Future\<void\> | This method does not return anything. |

###### Call Example
```dart
HmsAuthService.enableLogger();
```

##### Future\<void\> disableLogger()

This method is used to disable HMS Plugin Method Analytics.

###### Return

| Type | Description |
| ---- | ----------- |
| Future\<void\> | This method does not return anything. |

###### Call Example
```dart
HmsAuthService.disableLogger();
```

### HmsAuthManager

#### Public Method Summary

| Method | Return Type | Description |
| ------ | ----------- | ----------- |
| [getAuthResult()](#futurehmsauthhuaweiid-getauthresult-async) | Future\<[HmsAuthHuaweiId](#hmsauthhuaweiid)\> | Obtains the information about the HUAWEI ID in the latest sign-in. |
| [getAuthResultWithScopes(List\<String\> scopeList)](#futurehmsauthhuaweiid-getauthresultwithscopesliststring-scopelist-async) | Future\<[HmsAuthHuaweiId](#hmsauthhuaweiid)\> | Obtains an **HmsAuthHuaweiId** instance. |
| [addAuthScopes(int requestCode, List\<String\> scopeList)](#futurebool-addauthscopesint-requestcode-liststring-scopelist-async) | Future\<bool\> | Requests the permission specified by **scopeList** from a HUAWEI ID. |
| [containScopes(HmsAuthHuaweiId authHuaweiId, List\<String\> scopeList)](#futurebool-containscopeshmsauthhuaweiid-authhuaweiid-liststring-scopelist-async) | Future\<bool\> | Checks whether a specified HUAWEI ID has been assigned all permission specified by **scopeList**. |

#### Public Methods

##### Future\<[HmsAuthHuaweiId](#hmsauthhuaweiid)\> getAuthResult() async

This method is used to obtain the information about the HUAWEI ID in the latest sign-in.

###### Return

| Type                                          | Description                                                              |
| --------------------------------------------- | ------------------------------------------------------------------------ |
| Future\<[HmsAuthHuaweiId](#hmsauthhuaweiid)\> | Returns the HUAWEI ID information if there's a signing in attempt before |

###### Call Example

```dart
final HmsAuthHuaweiId id = await HmsAuthManager.getAuthResult();
```

##### Future\<[HmsAuthHuaweiId](#hmsauthhuaweiid)\> getAuthResultWithScopes(List\<String\> scopeList) async

This method is used to obtain an **HmsAuthHuaweiId** instance.

###### Parameters

| Parameter | Description   |
| --------- | ------------- |
| scopeList | Scope values. |

###### Return

| Type                                          | Description                                                                              |
| --------------------------------------------- | ---------------------------------------------------------------------------------------- |
| Future\<[HmsAuthHuaweiId](#hmsauthhuaweiid)\> | Returns the HUAWEI ID information on a successful operation, throws Exception otherwise. |

###### Call Example

```dart
try {
  final HmsAuthHuaweiId id =
    await HmsAuthManager.getAuthResultWithScopes([HmsScope.email]);
} on Exception catch(e) {
  print(e.toString());
}
```

##### Future\<bool\> addAuthScopes(int requestCode, List\<String\> scopeList) async

This method requests the permission specified by **scopeList** from a HUAWEI ID.

###### Parameters

| Parameter   | Description                                              |
| ----------- | -------------------------------------------------------- |
| requestCode | Request code that will be used while adding auth scopes. |
| scopeList   | Scope list.                                              |

###### Return

| Type           | Description                                                         |
| -------------- | ------------------------------------------------------------------- |
| Future\<bool\> | Returns true on a successful operation, throws Exception otherwise. |

###### Call Example
```dart
try {
  final bool res = await HmsAuthManager.addAuthScopes(
    // Specify a request code
    requestCode: 8888,
    // Then specify desired scopes
    scopeList: [HmsScope.email]
  );
} on Exception catch(e) {
  print(e.toString());
}
```

##### Future\<bool\> containScopes([HmsAuthHuaweiId](#hmsauthhuaweiid) authHuaweiId, List\<String\> scopeList) async

This method checks whether a specified HUAWEI ID has been assigned all permission specified by **scopeList**.

###### Parameters

| Parameter    | Description                   |
| ------------ | ----------------------------- |
| authHuaweiId | Signed HUAWEI ID information. |
| scopeList    | Scope list.                   |

###### Return

| Type           | Description                                                                 |
| -------------- | --------------------------------------------------------------------------- |
| Future\<bool\> | Returns true on a successful operation, throws Exception otherwise.         |

###### Call Example
```dart
try {
  final bool res = await HmsAuthManager.containScopes(
    // Specify the ID that is returned from signing in
    authHuaweiId: _signInResult,
    // Check if the email permission is requested from the HUAWEI ID
    scopeList: [HmsScope.email]
  )
} on Exception catch(e) {
  print(e.toString());
}
```

### HmsAuthTool

#### Public Method Summary

| Method | Return Type | Description |
| ------ | ----------- | ----------- |
| [requestUnionId(HmsAccount account)](#futurestring-requestunionidhmsaccount-account-async) | Future\<String\> | Obtains a union id. |
| [requestAccessToken(HmsAccount account, List\<String\> scopeList)](#futurestring-requestaccesstokenhmsaccount-account-liststring-scopelist-async) | Future\<String\> | Obtains an access token. |
| [deleteAuthInfo(String accessToken)](#futurebool-deleteauthinfostring-accesstoken-async) | Future\<bool\> | Clears the local cache. |

#### Public Methods

##### Future\<String\> requestUnionId([HmsAccount](#hmsaccount) account) async

This method is used to obtain a union id.

###### Parameters

| Parameter | Description                                        |
| --------- | -------------------------------------------------- |
| account   | Account information obtained from signed HUAWEI ID |

###### Return

| Type             | Description                                                                 |
| ---------------- | --------------------------------------------------------------------------- |
| Future\<String\> | Returns the union id on a successful operation, throws Exception otherwise. |

###### Call Example
```dart
try {
  // Specify the HmsAccount object obtained from signing in.
  final String unionId = await HmsAuthTool.requestUnionId(account: _accountInfo);
} on Exception catch(e) {
  print(e.toString());
}
```

##### Future\<String\> requestAccessToken([HmsAccount](#hmsaccount), List\<String\> scopeList) async

This method is used to obtain an access token.

###### Parameters

| Parameter | Description                                        |
| --------- | -------------------------------------------------- |
| account   | Account information obtained from signed HUAWEI ID |
| scopeList | Scope list                                         |

###### Return

| Type             | Description                                                                     |
| ---------------- | ------------------------------------------------------------------------------- |
| Future\<String\> | Returns the access token on a successful operation, throws Exception otherwise. |

###### Call Example
```dart
try {
  final String accessToken = await HmsAuthTool.requestAccessToken(
    account: _accountInfo,
    scopeList: [HmsScope.email]
  );
}
```

##### Future\<bool\> deleteAuthInfo(String accessToken) async

This method is used to clear the local cache.

###### Parameters

| Parameter   | Description                                 |
| ----------- | ------------------------------------------- |
| accessToken | Access token obtained from signed HUAWEI ID |

###### Return

| Type           | Description                                                         |
| -------------- | ------------------------------------------------------------------- |
| Future\<bool\> | Returns true on a successful operation, throws exception otherwise. |

###### Call Example
```dart
try {
  // Specify the access token obtained from signed HUAWEI ID
  final bool res = await HmsAuthTool.deleteAuthInfo(accessToken: _accessToken);
} on Exception catch(e) {
  print(e.toString());
}
```

### HmsNetworkTool

#### Public Method Summary

| Method | Return Type | Description |
| ------ | ----------- | ----------- |
| [buildNetworkCookie(String cookieName, String cookieValue, String domain, String path, bool isHttpOnly, bool isSecure, double maxAge)](#futurestring-buildnetworkcookiestring-cookiename-string-cookievalue-string-domain-string-path-bool-ishttponly-bool-issecure-double-maxage-async) | Future\<String\> | Constructs a cookie by combining entered values. |
| [buildNetworkUrl(String domain, bool isUseHttps)](#futurestring-buildnetworkurlstring-domain-bool-isusehttps-async) | Future\<String\> | Obtains a cookie URL based on the domain name and isUseHttps. |

#### Public Methods

##### Future\<String\> buildNetworkCookie(String cookieName, String cookieValue, String domain, String path, bool isHttpOnly, bool isSecure, double maxAge) async

This method is used to construct a cookie by combining entered values.

###### Parameters

| Parameter   | Description                                                                                                                                                                   |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| cookieName  | Cookie name.                                                                                                                                                                  |
| cookieValue | Cookie value.                                                                                                                                                                 |
| domain      | Cookie domain name.                                                                                                                                                           |
| path        | Page URL for accessing the cookie.                                                                                                                                            |
| isHttpOnly  | Indicates whether cookie information is contained only in the HTTP request header and cannot be accessed through **document.cookie**. The options are **true** and **false**. |
| isSecure    | Indicates whether to use HTTPS or HTTP to transmit the cookie.                                                                                                                |
| maxAge      | Cookie lifetime, in seconds.                                                                                                                                                  |

###### Return

| Type             | Description                                                                     |
| ---------------- | ------------------------------------------------------------------------------- |
| Future\<String\> | Returns the cookie value on a successful operation, throws Exception otherwise. |

###### Call Example
```dart
try {
  final String cookie = await HmsNetworkTool.buildNetworkCookie(
    cookieName: "cookie name",
    cookieValue: "cookie value",
    domain: "domain",
    path: "path",
    isHttpOnly: false,
    isSecure: true,
    maxAge: 18000
  );
} on Exception catch(e) {
  print(e.toString());
}
```

##### Future\<String\> buildNetworkUrl(String domain, bool isUseHttps) async

This method is used to obtain a cookie URL based on the domain name and isUseHttps.

###### Parameters

| Parameter  | Description                                                                                          |
| ---------- | ---------------------------------------------------------------------------------------------------- |
| domain     | Domain name.                                                                                         |
| isUseHttps | Indicates whether to use HTTPS or HTTP. The options are as follows: **true**: HTTPS; **false**: HTTP |

###### Return

| Type             | Description                                                            |
| ---------------- | ---------------------------------------------------------------------- |
| Future\<String\> | Returns the URL on a successful operation, throws Exception otherwise. |

###### Call Example

```dart
try {
  final String url = await HmsNetworkTool.buildNetworkUrl(
    domain: "domain name",
    isUseHttps: true
  );
}
```

### HmsSmsManager

#### Public Method Summary

| Method | Return Type | Description |
| ------ | ----------- | ----------- |
| [smsVerification(SmsListener listener)](#futurevoid-smsverificationsmslistener-listener-async) | Future\<void\> | Starts listening upcoming sms messages to the app before timing out. |
| [obtainHashcode()](#futurestring-obtainhashcode-async) | Future\<String\> | Obtains the application's unique hashcode value. |

#### Public Methods

##### Future\<void\> smsVerification([SmsListener](#smslistener) listener) async

This method starts listening upcoming sms messages to the app which contain the app's unique hashcode value. The [SmsListener](#smslistener) delivers the message itself on success or an error code on time out.

###### Parameters

| Parameter                   | Description                                                                                           |
| --------------------------- | ----------------------------------------------------------------------------------------------------- |
| [SmsListener](#smslistener) | Responses to the sms manager api and returns the message or an error code depending on the situation. |

###### Return

| Type           | Description                                                              |
| -------------- | ------------------------------------------------------------------------ |
| Future\<void\> | This method only starts listening sms messages. Does not return a value. |

###### Call Example

```dart
HmsSmsManager.smsVerification(({errorCode, message}) {
  if (message != null) {
    // Use the message
  } else {
    print("Error code: $errorCode");
  }
});
```

##### Future\<String\> obtainHashcode() async

This method is used to obtain application's unique hashcode value. If you want to use sms verification service, you need to specify this hashcode in the message. Otherwise the service can not recognize the message.

###### Return

| Type             | Description                                                                       |
| ---------------- | --------------------------------------------------------------------------------- |
| Future\<String\> | Returns the hashcode value on a successful operation, throws Exception otherwise. |

###### Call Example

```dart
try {
  final String hashcode = await HmsSmsManager.obtainHashcode();
} on Exception catch(e) {
  print(e.toString());
}
```

### Data Types

#### Data Types Summary

| Type | Description |
| ----- | ----------- |
| [SmsListener](#smslistener) | During the sms verification, returns the message or an error code depending on the sutiation. |
| [HmsAuthParamHelper](#hmsauthparamhelper) | Contains properties and methods to customize the signing requests. |
| [HmsAuthParams](#hmsauthparams) | Contains default authorization parameters for signing requests. |
| [HmsScope](#hmsscope) | Contains constant scope values. |
| [HmsAccount](#hmsaccount) | Contains account informaiton obtained from signed HUAWEI ID. |
| [HmsAuthHuaweiId](#hmsauthhuaweiid) | Contains signed HUAWEI ID information. |
| [HmsAuthButton](#hmsauthbutton) | A special button for the HUAWEI Account Flutter Plugin. |
| [HmsAccountErrorCodes](#hmsaccounterrorcodes) | Contains specific error codes for the plugin methods. |

#### HmsAuthParamHelper

##### Public Method Summary

| Method                              | Return Type | Description |
| ----------------------------------- | ----------- | ----------- |
| setDefaultParam(int param)          | void        | Sets the default authorization parameter of a HUAWEI ID. 0 indicates the default authorization param of a HUAWEI ID. 1 indicates the default authorization parameter of a game. |
| setIdToken()                        | void        | Requests a HUAWEI ID user to authorize an app to obtain the ID token. |
| setProfile()                        | void        | Requests a HUAWEI ID user to authorize an app to obtain the account information, such as the nickname and profile picture. |
| setAccessToken()                    | void        | Requests a HUAWEI ID user to authorize an app to obtain the access token. |
| setAuthorizationCode()              | void        | Requests a HUAWEI ID user to authorize an app to obtain the authorization code. If this is used, you do not need to call **setIdToken()**. When your app server uses the authorization code to exchange a token with the HUAWEI ID OAuth server, the ID token will be returned in the result. |
| setEmail()                          | void        | Requests a HUAWEI ID user to authorize an app to obtain the email address. |
| setId()                             | void        | Requests a HUAWEI ID user to authorize an app to obtain the UnionID. |
| setScopeList(List\<String\> scopes) | void        | Adds a specified scope to authorization configurations to request a HUAWEI ID user to authorize an app to obtain the permission specified by scope. |
| setRequestCode(int requestCode)     | void        | Sets the request code which will be used while signing in. |

##### Public Methods

Instead of calling the methods one by one, you can call any number of these methods simultaneously using cascades.

```dart
// Create an instance of HmsAuthParamHelper object

final helper = new HmsAuthParamHelper();

// Then, call its methods as follows
helper
  ..setIdToken()
  ..setAccessToken()
  ..setAuthorizationCode()
  ..setEmail()
  ..setProfile()
  ..setId()
```

##### Public Properties

| Name        | Type                   | Description                                                                          |
| ----------- | ---------------------- | ------------------------------------------------------------------------------------ |
| requestData | Map\<String, dynamic\> | Contains default request configurations for signing in. Values are all customizable. |

#### HmsAuthParams

##### Public Properties

| Name                        | Type | Value | Description                                 |
| --------------------------- | ---- | ----- | ------------------------------------------- |
| defaultAuthRequestParam     | int  | 0     | Default authorization param of a HUAWEI ID. |
| defaultAuthRequestParamGame | int  | 1     | Default authorization parameter of a game.  |

#### HmsScope

##### Public Properties

| Name    | Type   | Value                             | Description                                                                 |
| ------- | ----   | --------------------------------- | --------------------------------------------------------------------------- |
| email   | String | email                             | Email address of a HUAWEI ID.                                               |
| profile | String | profile                           | Basic information of a HUAWEI ID, such as the profile picture and nickname. |
| openId  | String | openid                            | OpenID of a HUAWEI ID.                                                      |
| game    | String | https://www.huawei.com/auth/games | Special scope of games.                                                     |

#### HmsAccount

##### Public Properties

| Name | Type   | Description         |
| ---- | ------ | ------------------- |
| name | String | Name of the account |
| type | String | Type of the account |

##### Public Constructor Summary

| Constructor                            | Description         |
| -------------------------------------- | ------------------- |
| HmsAccount({String name, String type}) | Default constructor |

##### Public Constructors

###### HmsAccount({String name, String type})

Constructs for **HmsAccount** object.

#### HmsAuthHuaweiId

##### Public Properties

| Name               | Type   | Description |
| ------------------ | ------ | ----------- |
| accessToken        | String | Obtains the access token from HUAWEI ID information. |
| account            | [HmsAccount](#hmsaccount) | Obtains an android.accounts. Account object based on the email address that is obtained by HUAWEI ID. |
| displayName        | String | Obtains the nickname from HUAWEI ID information if the authorization parameter specified by [HmsAuthParams](#hmsauthparams).**defaultAuthRequestParam** or **setProfile()** is carried during authorization. Otherwise the value is null. |
| email              | String | Obtains the email address from HUAWEI ID information if **setEmail()** is carried during authorization. Otherwise the value is null. |
| familyName         | String | Obtains the family name from HUAWEI ID information if the authorization parameter specified by [HmsAuthParams](#hmsauthparams).**defaultAuthRequestParam** or **setProfile()** is carried during authorization. Otherwise the value is null. |
| givenName          | String | Obtains the given name from HUAWEI ID information if the authorization parameter specified by [HmsAuthParams](#hmsauthparams).**defaultAuthRequestParam** or **setProfile()** is carried during authorization. Otherwise the value is null. |
| authorizedScopes   | List\<dynamic\> | Obtains the authorized scopes in [HmsScope](#hmsscope) from HUAWEI ID information. |
| idToken            | String | Obtains the ID token from HUAWEI ID information if the authorization parameter specified by **setIdToken()** is carried during authorization. Otherwise the value is null. |
| avatarUriString    | String | Obtains the profile picture URI from HUAWEI ID information if the authorization parameter specified by [HmsAuthParams](#hmsauthparams).**defaultAuthRequestParam** or **setProfile()** is carried during authorization. Otherwise the value is null. |
| authorizationCode  | String | Obtains the authorization code from HUAWEI ID information. If no authorization code is carried, value null is returned. The app can use the authorization code to obtain the access token from the HUAWEI ID server. |
| unionId            | String | Obtains the UnionID from HUAWEI ID information if the authorization parameter specified by **setId()** is carried during the authorization. Otherwise the value is null. |
| openId             | String | Obtains the OpenID from HUAWEI ID information if the authorization parameter specified by **setId()** is carried during the authorization. Otherwise the value is null. |

##### Public Constructor Summary

| Constructor | Description |
| ----------- | ----------- |
| HmsAuthHuaweiId({String accessToken, HmsAccount account, String displayName, String email, String familyName, String givenName, List\<dynamic\> authorizedScopes, String idToken, String avatarUriString, String authorizationCode, String unionId, String openId}) | Default constructor |

##### Public Constructors

###### HmsAuthHuaweiId({String accessToken, HmsAccount account, String displayName, String email, String familyName, String givenName, List\<dynamic\> authorizedScopes, String idToken, String avatarUriString, String authorizationCode, String unionId, String openId})

Constructs for **HmsAuthHuaweiId** object.

##### Public Method Summary

| Method | Return Type | Description |
| ------ | ----------- | ----------- |
| [createDefault()](#hmsauthhuaweiid-createdefault) | HmsAuthHuaweiId | Creates an instance with null parameters. |

##### Public Methods

###### HmsAuthHuaweiId createDefault()

This method is used to create an instance of **HmsAuthHuaweiId** object with null parameters.

###### Return

| Type | Description |
| ---- | ----------- |
| HmsAuthHuaweiId | Default instance. |

###### Call Example

```dart
final HmsAuthHuaweiId id = HmsAuthHuaweiId().createDefault();
```

#### SmsListener

##### typedef void SmsListener

Listener for upcoming messages to the application.

##### Definition

###### SmsListener({String message, String errorCode})

This is a function type defined to listen and return upcoming messages to the application. On a successful sms verification, this listener returns the received message. Otherwise, on time out for example, it returns the error code.

###### Parameters

| Parameter | Description                   |
| --------- | ----------------------------- |
| message   | Successfuly received message. |
| errorCode | Obtained error code.          |

#### HmsAuthButton

##### Public Properties

| Name                 | Type         | Description                                                                                                       |
| -------------------- | ------------ | ----------------------------------------------------------------------------------------------------------------- |
| AuthButtonTheme      | enum         | **FULL_TITLE** indicates that button has a logo and a title, **NO_TITLE** represents that button has only a logo. |
| AuthButtonBackground | enum         | Sets the button color. Color options are **BLUE**, **BLACK**, **GREY**, **RED** and **WHITE**.                    |
| AuthButtonRadius     | enum         | Property to set button's corner radius. The options are **SMALL**, **MEDIUM** and **LARGE**.                      |
| onPressed            | VoidCallback | Required parameter to specify an action when button is pressed.                                                   |
| width                | double       | Sets the button width.                                                                                            |
| padding              | double       | Sets the button padding.                                                                                          |
| textColor            | Color        | Sets the button text color.                                                                                       |
| fontSize             | double       | Sets the size of button text.                                                                                     |
| fontWeight           | FontWeight   | Sets the font weight of button text.                                                                              |

##### Public Constructor Summary

| Constructor | Description |
| ----------- | ----------- |
| HmsAuthButton({Key key, @required VoidCallback onPressed, double width, AuthButtonRadius borderRadius, AuthButtonBackground buttonColor, FontWeight fontWeight, double fontSize, Color textColor, AuthButtonTheme theme, double padding}) | Default constructor |

##### Public Constructors

###### HmsAuthButton({Key key, @required VoidCallback onPressed, double width, AuthButtonRadius borderRadius, AuthButtonBackground buttonColor, FontWeight fontWeight, double fontSize, Color textColor, AuthButtonTheme theme, double padding})

Constructs for **HmsAuthButton** object.

#### HmsAccountErrorCodes

##### Public Properties

| Name                                | Type   | Value | Description                                                                                             |
| ----------------------------------- | ------ | ----- | ------------------------------------------------------------------------------------------------------- |
| NULL_AUTH_SERVICE                   | String | 0001  | When a method that requires an authorization done before is triggered, this error is shown in exception |
| ILLEGAL_PARAMETER                   | String | 0002  | This code is shown in exception when some required parameters are missing                               |
| GET_AUTH_RESULT_WITH_SCOPES_FAILURE | String | 100   | Indicates that the problem was originated from **getAuthResultWithScopes()** method.                    |
| ADD_AUTH_SCOPES_FAILURE             | String | 101   | Indicates that the problem was originated from **addAuthScopes()** method.                              |
| CONTAIN_SCOPES_FAILURE              | String | 102   | Indicates that the problem was originated from **containScopes()** method.                              |
| SIGN_IN_FAILURE                     | String | 103   | Indicates that the problem was originated from **signIn()** method.                                     |
| SILENT_SIGN_IN_FAILURE              | String | 104   | Indicates that the problem was originated from **silentSignIn()** method.                               |
| SIGN_OUT_FAILURE                    | String | 105   | Indicates that the problem was originated from **signOut()** method.                                    |
| REVOKE_AUTHORIZATION_FAILURE        | String | 106   | Indicates that the problem was originated from **revokeAuthorization()** method.                        |
| REQUEST_UNION_ID_FAILURE            | String | 107   | Indicates that the problem was originated from **requestUnionId()** method.                             |
| REQUEST_ACCESS_TOKEN_FAILURE        | String | 108   | Indicates that the problem was originated from **requestAccessToken()** method.                         |
| DELETE_AUTH_INFO_FAILURE            | String | 109   | Indicates that the problem was originated from **deleteAuthInfo()** method.                             |
| BUILD_NETWORK_COOKIE_FAILURE        | String | 110   | Indicates that the problem was originated from **buildNetworkCookie()** method.                         |
| BUILD_NETWORK_URL_FAILURE           | String | 111   | Indicates that the problem was originated from **buildNetworkUrl()** method.                            |
| SMS_VERIFICATION_FAILURE            | String | 112   | Indicates that the problem was originated from **smsVerification()** method.                            |
| OBTAIN_HASHCODE_VALUE_FAILURE       | String | 113   | Indicates that the problem was originated from **obtainHashcode()** method.                             |
| SMS_VERIFICATION_TIME_OUT           | String | 114   | Indicates that the sms verification process failed because of time out.                                 |

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

Huawei Account Kit Flutter Plugin is licensed under [Apache 2.0 license](LICENSE)
