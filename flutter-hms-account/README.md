# Huawei Account Kit Flutter Plugin

## Table Of Contents

- Introduction
- Installation Guide
- API Reference
- Configuration Description
- Licensing and Terms

## Introduction

This plugin enables communication between Huawei Account SDK and Flutter platform. It enables user login processes to be carried out quickly and easily with HUAWEI Account Kit's two factor authentication.

## Installation Guide

- Before you get started, you must register as a HUAWEI developer and complete identity verification on the [HUAWEI Developer](https://developer.huawei.com/consumer/en/) website. For details, please refer to [Register a HUAWEI ID](https://developer.huawei.com/consumer/en/doc/10104).

- Create an app by referring to [Creating an AppGallery Connect Project](https://developer.huawei.com/consumer/en/doc/development/AppGallery-connect-Guides/agc-get-started#h1-1587521853252) and [Adding an App to the Project](https://developer.huawei.com/consumer/en/doc/development/AppGallery-connect-Guides/agc-get-started#h1-1587521946133).

- A signing certificate fingerprint is used to verify the authenticity of an app when it attempts to access an HMS Core (APK) through the HMS SDK. Before using the HMS Core (APK), you must locally generate a signing certificate fingerprint and configure it in AppGallery Connect.  For details, please refer to [Generating a Signing Certificate](https://developer.huawei.com/consumer/en/codelab/HMSPreparation/index.html#3).

- Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) and select **My apps**. Then, on the **Project Setting** page, set **SHA-256 certificate fingerprint** to the SHA-256 fingerprint from [Configuring the Signing Certificate Fingerprint](https://developer.huawei.com/consumer/en/doc/development/HMS-Guides/location-preparation#h1-1574146444641).

- In [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html), on **My apps** page, find your app from the list and click the app name. Go to **Development > Overview > App Information**. Click **agconnect-service.json** to download configuration file.

- Copy the **agconnect-service.json** file to the **android/app** directory of your project.

- Open the **build.gradle** file in the **android** directory of your project.
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
                classpath 'com.huawei.agconnect:agcp:1.3.1.300'
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

- Open the **build.gradle** file in the **android/app** directory.

    - Add `apply plugin: 'com.huawei.agconnect'` line after the `apply plugin: 'com.android.application'` line.

        ```gradle
        apply plugin: 'com.android.application'
        apply plugin: 'com.huawei.agconnect'
        apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"
        ```

    - Set your package name in **defaultConfig** > **applicationId** and set **minSdkVersion** to **19** or **higher**.
        Package name must match with the **package_name** entry in **agconnect-services.json** file.
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
                    signingConfig signingConfigs.config
                }
            }
        }
        ```

- On your Flutter project directory find and open your **pubspec.yaml** file and add library to dependencies. For more details please refer the [Using packages](https://flutter.dev/docs/development/packages-and-plugins/using-packages#dependencies-on-unpublished-packages) document.

    ```yaml
    dependencies:
        huawei_account:
            # Replace {library path} with actual library path of Huawei Account Kit Flutter Plugin.
            path: {library path}
    ```

- Run following command to update package info.

    ```
    [project_path]> flutter pub get
    ```

- Run following command to start the app.

    ```
    [project_path]> flutter run
    ```

## API Reference

This section does not cover all of the API, to read more, visit [HUAWEI Developer][developermain] website.

### Hms Account

#### Methods

| Return Type | Method | Description |
| ---- | ---- | ----- |
| Future\<AuthHuaweiId\> | signIn(AuthParamHelper authParamHelper) | Obtains the Intent of the authorization page by using authParamHelper object |
| Future\<AuthHuaweiId\> | signInWithAuthorizationCode(AuthParamHelper authParamHelper) | Obtains the Intent of the authorization page by using authParamHelper object |
| Future\<AuthHuaweiId\> | silentSignIn(AuthParamHelper authParamHelper) | Performs a silent authorization, no authorization page will be shown. |
| Future\<bool\> | signOut() | This API is called to sign out of a HUAWEI ID from an app. |
| Future\<bool\>| revokeAuthorization() | Cancels the authorization. Users will be redirected to authorization page while resigning in. |
| Future\<String\> | obtainHashCode() | Obtains the applications hash code which is unique in each app |
| Future | smsVerification(SmsListener listener) | Starts listening upcoming messages that contains app's hashcode |
| typedef void | SmsListener({String message, String errorCode}) | A function type defined for listening messages. Returns the message or the errorCode through smsVerification() method. |
| Future\<AuthHuaweiId\> | getAuthResult() | Obtains the latest authorization information. |
| Future\<AuthHuaweiId\> | getAuthResultWithScopes(List\<String\> scopeList) | Obtains the AuthHuaweiId instance with parameter that List object. |
| Future\<bool\>| containScopes(Map\<String, dynamic\> authData, List\<String\> scopeList) | Checks whether the user with the designated HUAWEI ID has been assigned all permissions specified by scopeList. |
| Future\<bool\> | addAuthScopes(int requestCode, List\<String\> scopeList) | Requests the permission specified by scopeList from a HUAWEI ID. |
| Future\<bool\> | deleteAuthInfo(String accessToken) | Clears the local cache. |
| Future\<String\> | requestUnionId(String huaweiAccountName) | Obtains a union id. |
| Future\<String\> | requestAccessToken(Account account, List\<String\> scopeList) | Obtains an access token. |
| Future\<String\> | buildNetworkUrl(String domainName, bool isHttps) | Returns cookie url based on the domain name and isHttps. |
| Future\<String\> | buildNetworkCookie(String cookieName, String cookieValue, String domain, String path, bool isHttpOnly, bool isSecure, double maxAge) | Constructs a cookie by combining input values. |

#### Data Types

##### AuthHuaweiId

| Properties | Type | Description |
| ---- | ----- | ----- |
| account | Account | Obtains the account information that contains type and name values. |
| accessToken | String | Obtains the access token |
| displayName | String | Obtains the display name |
| email | String | Obtains the email |
| familyName | String | Obtains the family name |
| givenName | String | Obtains the given name |
| idToken | String | Obtains the id token |
| authorizationCode | String | Obtains the authorization code |
| unionId | String | Obtains the union id |
| avatarUriString | String | Obtains the profile picture url |
| openId | String | Obtains the open id |
| uid | String | Obtains the uid |
| countryCode | String | Registration country code |
| serviceCountryCode | String | Service country code |
| authorizedScopes| List\<String\> | Obtains the authorized scopes |
| status | int | User status. 1: Normal; 2: Dbank suspended; 3: Deregistered, 4: All services are suspended. |
| gender | int | User Gender. -1: Unknown, 0: male, 1: female, 2: confidential. |


##### AuthParams

| Properties | Type | Value | Description |
| ---- | ----- | ----- | ----- |
| defaultAuthRequestParam | int | 0 | Default authorization parameter of HUAWEI ID. |
| defaultAuthRequestParamGame | int | 1 | Default authorization parameter of game applications. |


##### AuthParamHelper

| Properties | Type | Description |
| ---- | ----- | ----- |
| authParamHelpers | Map\<String, dynamic\> | This property is used in signIn methods to customize authorization. |

| Methods | Return Type | Description |
| ----- | ---- | ---- |
| setDefaultParam(int defaultParam) | void | Allows you to choose an AuthParams type |
| setRequestCode(int requestCode) | void | Allows you to choose a request code. |
| setIdToken() | void | Requests a HUAWEI ID user to authorize ID token to an app. |
| setProfile() | void | Requests a HUAWEI ID user to authorize the profile information to an app. |
| setAccessToken() | void | Requests a HUAWEI ID user to authorize Access Token to an app. |
| setAuthorizationCode() | void | Requests a HUAWEI ID user to authorize Authorization Code to an app. |
| setEmail() | void | Requests a HUAWEI ID user to authorize the email address to an app. |
| setId() | void | Requests a HUAWEI ID user to authorize unionId to an app. |
| addToScopeList(List\<String\> scopelist) | void | Adds a specified Scope to the authorization configuration. |


##### Scope

| Properties | Type | Value | Description |
| ---- | ----- | ----- | ---- |
| profile | String | profile | Value for profile scope |
| openId | String | openid | Value for openid scope |
| email | String | email | Value for email scope |
| game | String | https://www.huawei.com/auth/games | Value for game scope |


##### Account

| Properties | Type | Description |
| ----- | ----- | ------ |
| type | String | Account type of HUAWEI ID |
| name | String | Account name of HUAWEI ID |


##### Error Codes

| Properties | Type | Value | Description |
| ----- | ----- | ------ | ------ |
| SIGN_IN_FAIL | String | 101 | Error code for signIn() method |
| SIGN_IN_WITH_AUTHORIZATION_CODE_FAIL | String | 102 | Error code for signInWithAuthorizationCode() method |
| SILENT_SIGN_IN_FAIL | String | 103 | Error code for silentSignIn() method |
| SIGN_OUT_FAIL | String | 104 | Error code for signOut() method |
| REVOKE_AUTHORIZATION_FAIL | String | 105 | Error code for revokeAuthorization() method |
| SMS_VERIFICATION_FAIL | String | 106 | Error code for smsVerification() method |
| OBTAIN_HASH_CODE_FAIL | String | 107 | Error code for obtainHashCode() method |
| BUILD_NETWORK_COOKIE_FAIL | String | 108 | Error code for buildNetworkCookie() method |
| BUILD_NETWORK_URL_FAIL | String | 109 | Error code for buildNetworkUrl() method |
| ADD_AUTH_SCOPES_FAIL | String | 200 | Error code for addAuthScopes() method |
| GET_AUTH_RESULT_FAIL | String | 201 | Error code for getAuthResult() method |
| GET_AUTH_RESULT_WITH_SCOPES_FAIL | String | 202 | Error code for getAuthResultWithScopes() method |
| CONTAIN_SCOPES_FAIL | String | 203 | Error code for containScopes() method |
| DELETE_AUTH_INFO_FAIL | String | 204 | Error code for deleteAuthInfo() method |
| REQUEST_UNION_ID_FAIL | String | 205 | Error code for requestUnionId() method |
| REQUEST_ACCESS_TOKEN_FAIL | String | 206 | Error code for requestAccessToken() method |
| TIME_OUT | String | 207 | Error code for smsVerification() method when verification time is out |


### HuaweiIdAuthButton

A customizable button to use in authorization pages.

#### Properties

| Type | Name | Description |
| --- | --- | --- |
| enum | AuthButtonTheme | FULL_TITLE represents that button has a logo and a title, NO_TITLE represents that button has only a logo. |
| enum | AuthButtonBackground | Color options are BLUE, BLACK, GREY, RED and WHITE. |
| enum | AuthButtonRadius | Property to set button's corner radius. The options are SMALL, MEDIUM and LARGE. |
| Function | onPressed | Allows button to take a function. |
| double | width | Sets the width. |
| double | padding | Sets the vertical padding. |
| Color | textColor | Sets the button text color. |
| double | fontSize | Sets the button text size. |
| FontWeight | fontWeight | Sets the button text weight. |


## Configuration Description

No

## Licensing And Terms

Huawei Account Kit Flutter Plugin uses the Apache 2.0 license.

[developer]: <https://developer.huawei.com/consumer/en>
[developermain]: <https://developer.huawei.com/en>
[register]: <https://developer.huawei.com/consumer/en/doc/10104>
[project]: <https://developer.huawei.com/consumer/en/doc/development/AppGallery-connect-Guides/agc-get-started#h1-1587521853252>
[app]: <https://developer.huawei.com/consumer/en/doc/development/AppGallery-connect-Guides/agc-get-started#h1-1587521946133>
