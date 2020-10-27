# Huawei Analytics Kit Flutter Plugin

---

## Contents

  - [1. Introduction](#1-introduction)
  - [2. Installation Guide](#2-installation-guide)
    * [Creating a Project in App Gallery Connect](#creating-a-project-in-appgallery-connect)
    * [Configuring the Signing Certificate Fingerprint](#configuring-the-signing-certificate-fingerprint)
    * [Integrating the Flutter Analytics Plugin](#integrating-the-flutter-analytics-plugin)
      - [Android App Development](#android-app-development)
      - [iOS App Development](#ios-app-development)
      - [Events](#events)
  - [3. API Reference](#3-api-reference)
  - [4. Configuration Description](#4-configuration-description)
  - [5. Sample Project](#5-sample-project)
  - [6. Questions or Issues](#6-questions-or-issues)
  - [7. Licensing and Terms](#7-licensing-and-terms)

---

## 1. Introduction

This plugin enables communication between Huawei Analytics SDK and Flutter platform. 

Analytics Kit offers you a range of preset analytics models so you can gain a deeper insight into your users, products, and content. With this insight, you can take a data-driven approach to market your apps and optimize your products.

##### **With Analytics Kit's on-device data collection SDK, you can:**

- Track and report on custom events.

- Set up to 25 user attributes.

- Automate event collection and session calculation.

- Preset event IDs and parameters.

##### Use Case

- Analyze user behavior using both predefined and custom events.

- Use audience building to tailor your marketing activity to your users' behaviors and preferences.

- Use dashboards and analytics to measure your marketing activity and identify areas to improve.

---

## 2. Installation Guide

Before you get started, you must register as a HUAWEI Developer and complete identity verification on the [HUAWEI Developer](https://developer.huawei.com/consumer/en/) website. For details, please refer to [Register a HUAWEI ID](https://developer.huawei.com/consumer/en/doc/10104).

### Creating a Project in AppGallery Connect

Creating an app in AppGallery Connect is required in order to communicate with the Huawei services. To create an app, perform the following steps:

**Step 1.** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html)  and select **My projects**.

**Step 2.** Select your project from the project list or create a new one by clicking the **Add Project** button.

**Step 3.** Go to **Project Setting** > **General information**, and click **Add app**.
If an app exists in the project and you need to add a new one, expand the app selection area on the top of the page and click **Add app**.

**Step 4.** On the **Add app** page, enter the app information, and click **OK**.

### Configuring the Signing Certificate Fingerprint

A signing certificate fingerprint is used to verify the authenticity of an app when it attempts to access an HMS Core (APK) through the HMS SDK. Before using the HMS Core (APK), you must locally generate a signing certificate fingerprint and configure it in the **AppGallery Connect**. You can refer to 3rd and 4th steps of [Generating a Signing Certificate](https://developer.huawei.com/consumer/en/codelab/HMSPreparation/index.html#2) codelab tutorial for the certificate generation. Perform the following steps after you have generated the certificate.

**Step 1:** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) and select your project from **My Projects**. Then go to **Project Setting** > **General information**. In the **App information** field, click the  icon next to SHA-256 certificate fingerprint, and enter the obtained **SHA-256 certificate fingerprint**.

**Step 2:**  After completing the configuration, click **OK** to save the changes. (Check mark icon)

###  Integrating the Flutter Analytics Plugin

####  Android App Development

**Step 1:** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) and select your project from **My Projects**. Then go to **Growing > Analytics Kit** and click **Enable Now** to enable the Huawei Analytics Kit Service. You can also check **Manage APIs** tab on the **Project Settings** page for the enabled HMS services on your app.

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

- Set your package name in **defaultConfig > applicationId** and set **minSdkVersion** to **17** or higher. Package name must match with the **package_name** entry in **agconnect-services.json** file. 

  ```gradle
  defaultConfig {
      applicationId "<package_name>"
      minSdkVersion 17
      /*
      * <Other configurations>
      */
  }
  ```

**Step 6:** Copy the signature file that generated in [Generating a Signing Certificate](https://developer.huawei.com/consumer/en/codelab/HMSPreparation/index.html#2) to android/app directory.

**Step 7:**  Edit **buildTypes** as follows and add **signingConfigs** below:

```gradle
signingConfigs {
    config {
        storeFile file('<keystore_file>.jks/.keystore')
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
```

**NOTE**

  - Before obtaining the agconnect-services.json file, ensure that HUAWEI Analytics Kit has been enabled. For details about how to enable HUAWEI Analytics Kit, please refer to **Enabling Required Services**.
 - If you have made any changes in the development module, such as setting the data storage location and enabling or managing APIs, you need to download the latest agconnect-services.json file and replace the existing file in the app directory.

**Step 8:** On your Flutter project directory, find and open your **pubspec.yaml** file and add the
 **huawei_analytics** library to dependencies. For more details please refer to the [Using packages](https://flutter.dev/docs/development/packages-and-plugins/using-packages#dependencies-on-unpublished-packages) document.

  - To download the package from [pub.dev](https://pub.dev/publishers/developer.huawei.com/packages).

    ```yaml
      dependencies:
        huawei_analytics: {library version}
    ```

    **or**

    If you downloaded the package from the HUAWEI Developer website, specify the **library path** on your local device.

    ```yaml
      dependencies:
        huawei_analytics:
            # Replace {library path} with actual library path of Huawei Analytics Kit Plugin for Flutter.
            path: {library path}
    ```

    - Replace {library path} with the actual library path of Analytics Analytics Plugin. The following are examples:
      - Relative path example: `path: ../huawei_analytics`
      - Absolute path example: `path: D:\Projects\Libraries\huawei_analytics`


**Step 9:** Run the following command to update package info.

```
[project_path]> flutter pub get
```

**Step 10:** Import the library to access the methods.

```dart
import 'package:huawei_analytics/huawei_analytics.dart';
```

**Step 11:** Run the following command to start the app.

```
[project_path]> flutter run
```

####  iOS App Development

**Step 1:** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) and select your project from **My Projects**. Then go to **Growing > Analytics Kit** and click **Enable Now** to enable the Huawei Analytics Kit Service. You can also check **Manage APIs** tab on the **Project Settings** page for the enabled HMS services on your app.

**Step 2:** Go to **Project Setting > General information** page, under the **App information** field, click **agconnect-services.plist** to download the configuration file.

**Step 3:** Copy the **agconnect-services.plist** file to the app's root directory of your Xcode project.

**NOTE**

  - Before obtaining the agconnect-services.plist file, ensure that HUAWEI Analytics Kit has been enabled. For details
      about how to enable HUAWEI Analytics Kit, please refer to **Enabling Required Services**.

 - If you have made any changes in the development module, such as setting the data storage location and enabling or
    managing APIs, you need to download the latest agconnect-services.plist file and replace the existing file in the app
   directory.

**Step 4:** On your Flutter project directory, find and open your **pubspec.yaml** file and add the **huawei_analytics** library to dependencies. For more details please refer to the [Using packages](https://flutter.dev/docs/development/packages-and-plugins/using-packages#dependencies-on-unpublished-packages) document.

  - To download the package from [pub.dev](https://pub.dev/publishers/developer.huawei.com/packages).

    ```yaml
      dependencies:
        huawei_analytics: {library version}
    ```

    **or**

    If you downloaded the package from the HUAWEI Developer website, specify the **library path** on your local device.

    ```yaml
      dependencies:
        huawei_analytics:
            # Replace {library path} with actual library path of Huawei Analytics Kit Plugin for Flutter.
            path: {library path}
    ```

    - Replace {library path} with the actual library path of Analytics Analytics Plugin. The following are examples:
      - Relative path example: `path: ../huawei_analytics`
      - Absolute path example: `path: D:\Projects\Libraries\huawei_analytics`

**Step 5:** Run the following command to update package info.

```
[project_path]> flutter pub get
```

**Step 6:** Import the library to access the methods.

```dart
import 'package:huawei_analytics/huawei_analytics.dart';
```

**Step 7:** Run the following command to start the app.

```
[project_path]> flutter run
```

#### Using the Debug Mode

During the development, you can use DebugView to view the event records in real time, observe the results, and adjust the event reporting policies.

##### Enabling/Disabling the Debug Mode

- To enable the debug mode:

  Choose **Product** > **Scheme** > **Edit Scheme** from the Xcode menu. On the **Arguments** page, click **+** to add the **-HADebugEnabled** parameter. After the parameter is added, click **Close** to save the setting.

- To disable the debug mode:

  ```
  -HADebugDisabled
  ```

After the data is successfully reported, you can go to **HUAWEI Analytics** > **App Debugging** to view the reported data, as shown in the following figure.

#### Adjusting the Log Level by Adding Arguments

You can adjust the log level by adding arguments.

The available options include **-HALogLevelDebug**, **-HALogLevelInfo**, **-HALogLevelWarn**, and **-HALogLevelError**. For example, if you want to set the log level to **-HALogLevelDebug**:

1. Choose **Product** > **Scheme** > **Edit Scheme** from the Xcode menu.
2. On the **Arguments** page, click **+** to add the **-HALogLevelDebug** parameter.
3. After the parameter is added, click **Close** to save the setting.

####  Events

The HUAWEI Analytics Kit server provides three types of events for developers, including automatically collected events, preset events, and custom events.

#####  Automatically Collected Event

Such events can be automatically collected without tracing points, and the only requirement is that the  function of collecting system events is enabled. (The function is automatically enabled during initiation.) 
[More Details](https://developer.huawei.com/consumer/en/doc/development/HMS-Guides/event_description)

#####  Preset Events

The HMS Core Analytics Plugin predefines some event IDs based on common application scenarios. It is recommended that predefined constants be used for burying tracing points and analysis. The system provides various insight reports based on preset events.

#####  Custom Events

You can report custom events for personalized analysis requirements that cannot be met by automatically collected events and preset events.

To access PresetEvents, you can use this :

[HmsAnalytics.HAEventType](#haeventtype)

To access preset bundleName, you can use this :

[HmsAnalytics.HaParamType](#haparamtype)

---

## 3. API Reference

### HMSAnalytics

Contains classes that provide methods to perform operations such as event logging and reporting, real-time data collection and reporting, user attribute configuration, automatic event collection, and session calculation.

#### Public Constructor Summary

| Constructor    | Description          |
| -------------- | -------------------- |
| HMSAnalytics() | Default constructor. |

#### Public Method Summary

| Method                        		       |          Return Type          |                         Description                          |
| ---------------------------------------------------- | ----------------------------- | ------------------------------------------------------------ |
| [enableLog()](#futurevoid-enablelog-async) | Future\<void\>                | This API is called to enable the HUAWEI Analytics Kit log function. |
| [enableLog(String LogLevel)](#futurevoid-enablelogstring-loglevel-async) | Future\<void\>                | This API is called to enable debug logs and set the minimum log level (minimum level of log records that will be printed). |
| [setUserId(String id)](#futurevoid-setuseridstring-userid-async) | Future\<void\>                | This API is called to set user IDs.              |
| [setUserProfile(String key, String value)](#futurevoid-setuserprofilestring-key-string-value-async) | Future\<void\>                | This API is called to set user attributes.          |
| [setPushToken(String token)](#futurevoid-setpushtokenstring-token-async) | Future\<void\>                | This API is called to set the push token, which can be obtained from HUAWEI Push Kit. |
| [setMinActivitySessions(int interval)](#futurevoid-setminactivitysessionsint-interval-async) | Future\<void\>                | This API is called to set the minimum interval between two sessions. |
| [setSessionDuration(int duration)](#futurevoid-setsessiondurationint-duration-async) | Future\<void\>                | This API is called to set the session timeout interval.    |
| [onEvent(String key, Map<String, dynamic> value)](#futurevoid-oneventstring-key-mapstring-dynamic-value-async) | Future\<void\>                | This API is called to record events.             |
| [clearCachedData()](#futurevoid-clearcacheddata-async) | Future\<void\>                | This API is called to delete all collected data cached locally, including cached data that failed to be sent. |
| [getAAID()](#futurestring-getaaid-async) | Future\<String\> 	       | This API is called to obtain the app instance ID from AppGalleryConnect. |
| [getUserProfiles(bool preDefined)](#futuremapstring-dynamic-getuserprofilesbool-predefined-async) | Future\<Map<String, String>\> | This API is called to obtain user attributes.         |
| [pageStart(String pageName, String pageClassOverride)](#futurevoid-pagestartstring-pagename-string-pageclassoverride-async) | Future\<void\> 	       | This API is called to customize the screen start event.    |
| [pageEnd(String pageName)](#futurevoid-pageendstring-pagename-async) | Future\<void\>                | This API is called to customize the screen end event.     |
| [enableLogger()](#futurevoid-enablelogger-async) | Future\<void\>                | Enables HMS Plugin Method Analytics.             |
| [disableLogger()](#futurevoid-disablelogger-async) | Future\<void\>                | Disables HMS Plugin Method Analytics.             |
| [setReportPolicies(String policyType, [int timer])](#futurevoid-setreportpoliciesint-scheduledtime-bool-applaunch-bool-movebackground-int-cachethreshold-async) | Future\<void\>                | Sets data reporting policies.                 |

#### Public  Constructors

##### HMSAnalytics()

Constructor for *HMSAnalytics* object.

#### Public Methods

##### Future\<void> enableLog() *async*

Provides methods to enable debug log recording for debugging during the development phase. This function is specifically used by Android Platforms.

| Return Type    | Description               |
| -------------- | ------------------------- |
| Future\<void\> | Future result of an execution that returns no value. |

##### Future\<void> enableLog(String logLevel) *async*

Enables the debug log function and sets the minimum log level. This function is specifically used by Android Platforms.

| Parameter | Description                                                  |
| --------- | ------------------------------------------------------------ |
| logLevel  | Level of recorded debug logs. Log level: - DEBUG - INFO - WARN - ERROR |

| Return Type    | Description               |
| -------------- | ------------------------- |
| Future\<void\> | Future result of an execution that returns no value. |

##### Future\<void> setUserId(String userId) *async*

Sets a user ID.

When the API is called, a new session is generated if the old value of id is not empty and is different from the new value. If you do not want to use id to identify a user (for example, when a user signs out), you must set id to Null.

id is used by Analytics Kit to associate user data. The use of id must comply with related privacy regulations. You need to declare the use of such information in the privacy statement of your app.

| Parameter | Description                                                  |
| --------- | ------------------------------------------------------------ |
| userId    | User ID, a string containing a maximum of 256 characters. The value cannot be empty. |

| Return Type    | Description     |
| -------------- | --------------- |
| Future\<void\> | Future result of an execution that returns no value. |

##### Future\<void> setUserProfile(String key, String value) *async*

Sets user attributes. The values of user attributes remain unchanged throughout the app lifecycle and during each session. A maximum of 25 user attributes are supported. If the name of an attribute set later is the same as that of an existing attribute, the value of the existing attribute is updated.

| Parameter | Description                                                  |
| --------- | ------------------------------------------------------------ |
| key       | Name of the user attribute, a string containing a maximum of 256 characters. The value cannot be empty. It can consist of digits, letters, and underscores (_) but cannot start with a digit or underscore (_). |
| value     | Value of the user attribute, a string containing a maximum of 256 characters. The value cannot be empty. |

| Return Type    | Description           |
| -------------- | --------------------- |
| Future\<void\> | Future result of an execution that returns no value. |

##### Future\<void> setPushToken(String token) *async*

Sets the push token. After obtaining a push token through Push Kit, call this method to save the push token so that you can use the audience defined by HUAWEI Analytics to create HCM notification tasks. This function is specifically used by Android Platforms.

| Parameter | Description                                                  |
| --------- | ------------------------------------------------------------ |
| token     | Push token, a string containing a maximum of 256 characters. The value cannot be empty. |

| Return Type    | Description                                                |
| -------------- | ---------------------------------------------------------- |
| Future\<void\> | Future result of an execution that returns no value. |

##### Future\<void> setMinActivitySessions(int interval) *async*

Sets the minimum interval for starting a new session. A new session is generated when an app is switched back to the foreground after it runs in the background for the specified minimum interval. By default, the minimum interval is 30,000 milliseconds (that is, 30 seconds). This function is specifically used by Android Platforms.

| Parameter | Description                                               |
| --------- | --------------------------------------------------------- |
| interval  | Minimum interval for updating a session, in milliseconds. |

| Return Type    | Description                                           |
| -------------- | ----------------------------------------------------- |
| Future\<void\> | Future result of an execution that returns no value. |

##### Future\<void> setSessionDuration(int duration) *async*

Sets the session timeout interval. A new session is generated when an app is running in the foreground but the interval between two adjacent events exceeds the specified timeout interval. By default, the timeout interval is 1,800,000 milliseconds (that is, 30 minutes).

| Parameter | Description                                |
| --------- | ------------------------------------------ |
| duration  | Session timeout interval, in milliseconds. |

| Return Type    | Description                        |
| -------------- | ---------------------------------- |
| Future\<void\> | Future result of an execution that returns no value. |

##### Future\<void> onEvent(String key, Map<String, dynamic> value) *async*

Records an event.

| Parameter | Description                                                  |
| --------- | ------------------------------------------------------------ |
| key       | Event ID, a string containing a maximum of 256 characters. The value cannot be empty or the ID of an [automatically collected event](https://developer.huawei.com/consumer/en/doc/HMSCore-Guides/android-automatic-event-collection-0000001051757143-V5). It can consist of digits, letters, and underscores (_) but cannot contain spaces or start with a digit.Example: **event_description10** |
| value     | Information carried in the event. The number of key-value pairs in a bundle must not exceed 2048. In addition, its size cannot exceed 200 KB. |

| Return Type    | Description            |
| -------------- | ---------------------- |
| Future\<void\> | Future result of an execution that returns no value. |

##### Future\<void> clearCachedData() *async*

Deletes all collected data cached locally, including cached data that failed to be sent.

| Return Type    | Description                                         |
| -------------- | --------------------------------------------------- |
| Future\<void\> | Future result of an execution that returns no value. |

##### Future\<String> getAAID() *async*

Obtains the app instance ID from AppGallery Connect.

| Return Type    | Description                  |
| -------------- | ---------------------------- |
| Future\<String\> | Obtains the app instance ID. |

##### Future\<Map<String, dynamic>\> getUserProfiles(bool preDefined) *async*

Obtains predefined and custom user attributes in A/B Testing.

| Parameter  | Description                                                  |
| ---------- | ------------------------------------------------------------ |
| preDefined | Indicates whether to obtain predefined user attributes. **true : ** Obtains predefined user attributes. **false :** Obtains custom user attributes. |

| Return Type                    | Description                                       |
| ------------------------------ | ------------------------------------------------- |
| Future\<Map<String, dynamic>\> | Obtains the predefined or custom user attributes. |

##### Future\<void> pageStart(String pageName, String pageClassOverride) *async*

Customizes a page entry event. The API applies only to non-activity pages because automatic collection is supported for activity pages. If this API is called for an activity page, statistics on page entry and exit events will be inaccurate.

After this API is called, the **pageEnd()** API must be called. This function is specifically used by Android Platforms.

| Parameter         | Description                                                  |
| ----------------- | ------------------------------------------------------------ |
| pageName          | Name of the current page, a string containing a maximum of 256 characters. The value cannot be empty. |
| pageClassOverride | Class name of the current page, a string containing a maximum of 256 characters. The value cannot be empty. |

| Return Type    | Description                        |
| -------------- | ---------------------------------- |
| Future\<void\> | Future result of an execution that returns no value. |

##### Future\<void> pageEnd(String pageName) *async*

Customizes a page end event. The API applies only to non-activity pages because automatic collection is supported for activity pages. If this API is called for an activity page, statistics on page entry and exit events will be inaccurate. Before this API is called, the **pageStart()** API must be called. This function is specifically used by Android Platforms.

| Parameter | Description                                                  |
| --------- | ------------------------------------------------------------ |
| pageName  | Name of the current page, a string containing a maximum of 256 characters. The value cannot be empty. It must be the same as the value of **pageName** passed in **pageStart()**. |

| Return Type    | Description                       |
| -------------- | --------------------------------- |
| Future\<void\> | Future result of an execution that returns no value. |

##### Future\<void> enableLogger() *async*

This method **enables** the HMSLogger capability which is used for sending usage analytics of Analytics SDK's methods to improve the service quality. This function is specifically used by Android Platforms.

| Return Type    | Description                                          |
| -------------- | ---------------------------------------------------- |
| Future\<void\> | Future result of an execution that returns no value. |

##### Future\<void> disableLogger() *async*

This method **disables** the HMSLogger capability which is used for sending usage analytics of Analytics SDK's methods to improve the service quality. This function is specifically used by Android Platforms.

| Return Type    | Description                                          |
| -------------- | ---------------------------------------------------- |
| Future\<void\> | Future result of an execution that returns no value. |

##### Future\<void> setReportPolicies({int scheduledTime, bool appLaunch, bool moveBackground, int cacheThreshold}) *async*

Sets data reporting policies. This function is specifically used by IOS Platforms.

| Parameter      | Description                                                  |
| -------------- | ------------------------------------------------------------ |
| scheduledTime  | Sets the policy of reporting data at the scheduled interval. You can configure the interval as needed. The value ranges from 60 to 1800, in seconds. |
| appLaunch      | Sets the policy of reporting data upon app launch.           |
| moveBackground | Sets the policy of reporting data when the app moves to the background. This policy is enabled by default. |
| cacheThreshold | Sets the policy of reporting data when the specified threshold is reached. This policy is enabled by default. You can configure the interval as needed. The value ranges from 30 to 1000. The default value is **200**. |

| Return Type    | Description                   |
| -------------- | ----------------------------- |
| Future\<void\> | Future result of an execution that returns no value. |


### HAEventType

Provides the IDs of all predefined events.

#### Public Constants

<details>
  <summary>Click to expand/collapse Constants table</summary>

| Constants             | Type   | Description                                                  |
| --------------------- | ------ | ------------------------------------------------------------ |
| CREATEPAYMENTINFO     | String | Event reported when a user has added payment information but has not initiated payment during check-out.It can be used with [STARTCHECKOUT](https://developer.huawei.com/consumer/en/doc/development/HMSCore-References-V5/android-api-haeventtype-0000001051318956-V5#EN-US_TOPIC_0000001055186011__p16469189799) and [COMPLETEPURCHASE](https://developer.huawei.com/consumer/en/doc/development/HMSCore-References-V5/android-api-haeventtype-0000001051318956-V5#EN-US_TOPIC_0000001055186011__p2047015915919) to construct funnel analysis for the check-out process. |
| ADDPRODUCT2CART       | String | Event reported when a user adds a product to the shopping cart.It can be used with [VIEWPRODUCT](https://developer.huawei.com/consumer/en/doc/development/HMSCore-References-V5/android-api-haeventtype-0000001051318956-V5#EN-US_TOPIC_0000001055186011__p647212913913) and [STARTCHECKOUT](https://developer.huawei.com/consumer/en/doc/development/HMSCore-References-V5/android-api-haeventtype-0000001051318956-V5#EN-US_TOPIC_0000001055186011__p16469189799) to construct funnel analysis for product purchase. It can also be used to analyze products that users are interested in, helping you promote the products to the users. |
| ADDPRODUCT2WISHLIST   | String | Event reported when a user adds a product to wishlist.It can be used to analyze products that users are interested in, helping you promote the products to the users. |
| STARTAPP              | String | Event reported when a user launches the app.                 |
| STARTCHECKOUT         | String | Event reported when a user clicks the check-out button after placing an order. It can be used with [VIEWPRODUCT](https://developer.huawei.com/consumer/en/doc/development/HMSCore-References-V5/android-api-haeventtype-0000001051318956-V5#EN-US_TOPIC_0000001055186011__p647212913913) and [COMPLETEPURCHASE](https://developer.huawei.com/consumer/en/doc/development/HMSCore-References-V5/android-api-haeventtype-0000001051318956-V5#EN-US_TOPIC_0000001055186011__p2047015915919) to construct funnel analysis for the e-commerce purchase conversion rate. |
| VIEWCAMPAIGN          | String | Event reported when a user views details of a marketing campaign. It can be used to analyze the conversion rate of a marketing campaign. |
| VIEWCHECKOUTSTEP      | String | Event reported when a user views steps of the check-out process. |
| WINVIRTUALCOIN        | String | Event reported when a user obtains virtual currency. It can be used to analyze the difficulty for users to obtain virtual currency, which helps you optimize the product design. |
| COMPLETEPURCHASE      | String | Event reported after a user purchases a product. It can be used to analyze the products or contents that users are more interested in, which helps you optimize the operations policy. |
| OBTAINLEADS           | String | Event reported when a sales lead is obtained. For example, it can be reported after a user taps the ad you placed and fills in and submits the contact information. In this case, the event is used to evaluate the possible revenue brought by the lead to you. In addition, the event can also be used to evaluate the ROI of the placed ad. |
| JOINUSERGROUP         | String | Event reported when a user joins in a group, for example, joining in a group chat in a social app. It can be used to evaluate the attractiveness of your product's social features to users. |
| COMPLETELEVEL         | String | Event reported when a user completes a game level in a game app. It can be used with [STARTLEVEL](https://developer.huawei.com/consumer/en/doc/development/HMSCore-References-V5/android-api-haeventtype-0000001051318956-V5#EN-US_TOPIC_0000001055186011__p154711393911) to analyze whether the game level design is proper and formulate targeted optimization policies. |
| STARTLEVEL            | String | Event reported when a user starts a game level in a game app. It can be used with [COMPLETELEVEL](https://developer.huawei.com/consumer/en/doc/development/HMSCore-References-V5/android-api-haeventtype-0000001051318956-V5#EN-US_TOPIC_0000001055186011__p3470129393) to analyze whether the game level design is proper and formulate targeted optimization policies. |
| UPGRADELEVEL          | String | Event reported when a user levels up in a game app. It can be used to analyze whether your product's user level design is optimal and formulate targeted optimization policies. |
| SIGNIN                | String | Event reported when a user signs in to an app requiring sign-in. It can be used to analyze users' sign-in habits and formulate targeted operations policies. |
| SIGNOUT               | String | Event reported when a user signs out.                        |
| SUBMITSCORE           | String | Event reported when a user submits the score in a game or education app. It can be used to analyze the difficulty of product content and formulate targeted optimization policies. |
| CREATEORDER           | String | Event reported when a user creates an order.                 |
| REFUNDORDER           | String | Event reported when the refund is successful for a user. It can be used to analyze loss caused by the refund and formulate targeted optimization policies. |
| DELPRODUCTFROMCART    | String | Event reported when a user removes a product from the shopping cart. It can be used for targeted marketing to the user. |
| SEARCH                | String | Event reported when a user searches for content in an app. It can be used with events such as [VIEWSEARCHRESULT](https://developer.huawei.com/consumer/en/doc/development/HMSCore-References-V5/android-api-haeventtype-0000001051318956-V5#EN-US_TOPIC_0000001055186011__p104721291092) and [VIEWPRODUCT](https://developer.huawei.com/consumer/en/doc/development/HMSCore-References-V5/android-api-haeventtype-0000001051318956-V5#EN-US_TOPIC_0000001055186011__p647212913913) to analyze the accuracy of search results. |
| VIEWCONTENT           | String | Event reported when a user taps content, for example, tapping a product in the product list in an e-commerce app to view the product details. It can be used to analyze the products that users are interested in. |
| UPDATECHECKOUTOPTION  | String | Event reported when a user sets some check-out options during the check-out process. It can be used to analyze check-out preferences of users. |
| SHARECONTENT          | String | Event reported when a user shares a product or content through a social channel. It can be used to analyze users' loyalty to the product. |
| REGISTERACCOUNT       | String | Event reported when a user registers an account. It can be used to analyze the user sources and optimize operations policies. |
| CONSUMEVIRTUALCOIN    | String | Event reported when a user consumes virtual currency. It can be used to analyze the products that users are more interested in. |
| STARTTUTORIAL         | String | Event reported when a user starts to use the tutorial. It can be used with [COMPLETETUTORIAL](https://developer.huawei.com/consumer/en/doc/development/HMSCore-References-V5/android-api-haeventtype-0000001051318956-V5#EN-US_TOPIC_0000001055186011__p747279391) to evaluate the tutorial quality and formulate targeted optimization policies. |
| COMPLETETUTORIAL      | String | Event reported when a user completes the tutorial. It can be used with [STARTTUTORIAL](https://developer.huawei.com/consumer/en/doc/development/HMSCore-References-V5/android-api-haeventtype-0000001051318956-V5#EN-US_TOPIC_0000001055186011__p5472591591) to evaluate the tutorial quality and formulate targeted optimization policies. |
| OBTAINACHIEVEMENT     | String | Event reported when a user unlocks an achievement. It can be used to analyze whether the achievement level design is optimal and formulate targeted optimization policies. |
| VIEWPRODUCT           | String | Event reported when a user browses a product. It can be used to analyze the products that users are interested in, or used with other events for funnel analysis. |
| VIEWPRODUCTLIST       | String | Event reported when a user browses a list of products, for example, browsing the list of products by category. It can be used to analyze the types of contents that users are more interested in. |
| VIEWSEARCHRESULT      | String | Event reported when a user views the search results. It can be used with [VIEWPRODUCT](https://developer.huawei.com/consumer/en/doc/development/HMSCore-References-V5/android-api-haeventtype-0000001051318956-V5#EN-US_TOPIC_0000001055186011__p647212913913) and [SEARCH](https://developer.huawei.com/consumer/en/doc/development/HMSCore-References-V5/android-api-haeventtype-0000001051318956-V5#EN-US_TOPIC_0000001055186011__p859120345586) to measure the accuracy of the search algorithm. |
| UPDATEMEMBERSHIPLEVEL | String | Event reported when a user purchases membership or signs in for the first time after membership expires. It can be used to analyze user habits. |
| FILTRATEPRODUCT       | String | Event reported when a user sets conditions to filter products displayed. It can be used to analyze user preferences. |
| VIEWCATEGORY          | String | Event reported when a user taps a product category. It can be used to analyze popular product categories or user preferences. |
| UPDATEORDER           | String | Event reported when a user modifies an order.                |
| CANCELORDER           | String | Event reported when a user cancels an order.                 |
| COMPLETEORDER         | String | Event reported when a user confirms the reception.           |
| CANCELCHECKOUT        | String | Event reported when a user cancels an ongoing payment of a submitted order. It can be used to analyze the cause of user churn. |
| OBTAINVOUCHER         | String | Event reported when a user claims a voucher.                 |
| CONTACTCUSTOMSERVICE  | String | Event reported when a user contacts customer service personnel to query product details or make a complaint. |
| RATE                  | String | Event reported when a user comments on an app, service, or product. |
| INVITE                | String | Event reported when a user invites other users to use the app through the social channel. |

</details>

### HAParamType

Provides the IDs of all predefined parameters, including the IDs of predefined parameters and user attributes.

#### Public Constants

<details>
  <summary>Click to expand/collapse Constants table</summary>

| Constants        | Type   | Description                                                  |
| ---------------- | ------ | ------------------------------------------------------------ |
| ACHIEVEMENTID    | String | ID of an achievement.                                        |
| STORENAME        | String | Store or organization where a transaction occurred.          |
| ROLENAME         | String | Role of a user.                                              |
| OPTION           | String | Check-out option entered by a user in the current check-out step. |
| STEP             | String | Current step of a user in the check-out process.             |
| CONTENTTYPE      | String | Content type selected by a user.                             |
| VOUCHER          | String | Voucher used in the transaction.                             |
| CURRNAME         | String | Currency type of the revenue, which is used with **REVENUE**. |
| DESTINATION      | String | Flight or travel destination.                                |
| ENDDATE          | String | Project end date, check-out date, or lease end date.         |
| FLIGHTNO         | String | Flight number generated by your transaction system.          |
| USERGROUPID      | String | ID of the user group that a user joins.                      |
| POSITIONID       | String | Index of a product in the list.                              |
| BRAND            | String | Product brand.                                               |
| CATEGORY         | String | Product category.                                            |
| PRODUCTID        | String | Product ID.                                                  |
| PRODUCTLIST      | String | Product list displayed to a user.                            |
| PRODUCTNAME      | String | Product name.                                                |
| PRODUCTFEATURE   | String | Product features.                                            |
| LEVELID          | String | Game level.                                                  |
| LEVELNAME        | String | Name of a game level.                                        |
| PLACE            | String | ID of the product location.                                  |
| CHANNEL          | String | Channel through which a user signs in.                       |
| BOOKINGDAYS      | String | Number of days booked for a hotel reservation.               |
| PASSENGERSNUMBER | String | Number of guests booked for a hotel reservation.             |
| BOOKINGROOMS     | String | Number of rooms booked for a hotel reservation.              |
| ORIGINATINGPLACE | String | Departure location.                                          |
| PRICE            | String | Purchase price.                                              |
| QUANTITY         | String | Purchase quantity.                                           |
| SCORE            | String | Score in a game.                                             |
| SEARCHKEYWORDS   | String | Search string or keyword.                                    |
| SHIPPING         | String | Shipping fee generated for the transaction.                  |
| BEGINDATE        | String | Departure date, hotel check-in date, or lease start date.    |
| RESULT           | String | Operation result.                                            |
| TAXFEE           | String | Tax generated for the transaction.                           |
| KEYWORDS         | String | Keywords of a marketing activity, for example, keywords for search advertising. |
| TRANSACTIONID    | String | E-commerce transaction ID.                                   |
| CLASS            | String | Level of a room booked for a hotel reservation.              |
| REVENUE          | String | Context-specific value that is automatically accumulated for each event type. |
| VIRTUALCURRNAME  | String | Virtual currency type.                                       |
| CLICKID          | String | ID generated by the ad network and used to record ad clicks. |
| PROMOTIONNAME    | String | Name of a marketing activity.                                |
| CONTENT          | String | Marketing content of a marketing activity.                   |
| EXTENDPARAM      | String | Custom parameter.                                            |
| MATERIALNAME     | String | Name of the creative material used in a marketing activity.  |
| MATERIALSLOT     | String | ID of the slot where a creative material is displayed.       |
| PLACEID          | String | ID of the product location.                                  |
| MEDIUM           | String | Type of a marketing activity, for example, CPC or email.     |
| SOURCE           | String | ID of a marketing activity provider, for example, HUAWEI PPS. |
| ACOUNTTYPE       | String | Account type of a user, for example, email or mobile number. |
| REGISTMETHOD     | String | User source.                                                 |
| OCCURREDTIME     | String | Time when an account is registered.                          |
| EVTRESULT        | String | Sign-in result.                                              |
| PREVLEVEL        | String | Level before the change.                                     |
| CURRVLEVEL       | String | Current level.                                               |
| REASON           | String | Change reason.                                               |
| VOUCHERS         | String | Names of vouchers applicable to a product.                   |
| MATERIALSLOTTYPE | String | Type of the slot where a creative material is displayed, for example, the ad slot, operations slot, or banner. |
| LISTID           | String | Product ID list.                                             |
| FILTERS          | String | Filter condition.                                            |
| SORTS            | String | Sorting condition.                                           |
| ORDERID          | String | Order ID generated by your transaction system.               |
| PAYTYPE          | String | Payment mode selected by a user.                             |
| EXPIREDATE       | String | Expiration time of a voucher.                                |
| VOUCHERTYPE      | String | Voucher type.                                                |
| SERVICETYPE      | String | Type of a service provided for a user, for example, consultation or complaint. |
| DETAILS          | String | Details of user evaluation on an object.                     |
| COMMENTTYPE      | String | Evaluated object.                                            |

</details>

You can read more and get detailed information about the references described above from [developer.huawei.com](https://developer.huawei.com)

---

## 4. Configuration Description

### Preparing for Release

Before building a release version of your app you may need to customize the **proguard-rules**.pro obfuscation configuration file to prevent the HMS Core SDK from being obfuscated. Add the configurations below to exclude the HMS Core SDK from obfuscation. For more information on this topic refer to [this Android developer guide](https://developer.android.com/studio/build/shrink-code).

**<flutter_project>/android/app/proguard-rules. pro**

```
-ignorewarnings
-keepattributes *Annotation*
-keepattributes Exceptions
-keepattributes InnerClasses
-keepattributes Signature
-keepattributes SourceFile,LineNumberTable
-keep class com.hianalytics.android.**{*;}
-keep class com.huawei.updatesdk.**{*;}
-keep class com.huawei.hms.**{*;}
```

**<flutter_project>/android/app/build.gradle**

```
buildTypes {
    debug {
        signingConfig signingConfigs.config
    }
    release {
        
        // Enables code shrinking, obfuscation and optimization for release builds
        minifyEnabled true
        // Unused resources will be removed, resources defined in the res/raw/keep.xml will be kept.
        shrinkResources true
        proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
	
	signingConfig signingConfigs.config
    }
}
```
---

## 5. Sample Project

This plugin includes a demo project in the **example** folder, there you can find more usage examples.

<img src="https://github.com/HMS-Core/hms-flutter-plugin/tree/master/flutter-hms-analytics/.docs/images/ios.jpg" width
 = 40% height = 40% style="margin:1.5em">
<img src="https://github.com/HMS-Core/hms-flutter-plugin/tree/master/flutter-hms-analytics/.docs/images/android.jpg" width = 40% height = 40% style="margin:1.5em">

---

## 6. Questions or Issues

If you have questions about how to use HMS samples, try the following options:

- [Stack Overflow](https://stackoverflow.com/questions/tagged/huawei-mobile-services) is the best place for any programming questions. Be sure to tag your question with **huawei-mobile-services**.
- [Github](https://github.com/HMS-Core/hms-flutter-plugin) is the official repository for these plugins, You can open an issue or submit your ideas.
- [Huawei Developer Forum](https://forums.developer.huawei.com/forumPortal/en/home?fid=0101187876626530001) HMS Core Module is great for general questions, or seeking recommendations and opinions.
- [Huawei Developer Docs](https://developer.huawei.com/consumer/en/doc/overview/HMS-Core-Plugin) is place to official documentation for all HMS Core Kits, you can find detailed documentations in there.

If you run into a bug in our samples, please submit an issue to the Github Repository.

---

## 7. Licensing and Terms

Huawei Analytics Kit Flutter Plugin - is licensed under [Apache 2.0 license](LICENSE)