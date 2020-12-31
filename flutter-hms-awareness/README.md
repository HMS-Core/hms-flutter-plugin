# Huawei Awareness Kit Flutter Plugin

---

## Contents

  - [1. Introduction](#1-introduction)
  - [2. Installation Guide](#2-installation-guide)
    - [Creating Project in App Gallery Connect](#creating-project-in-app-gallery-connect)
    - [Configuring the Signing Certificate Fingerprint](#configuring-the-signing-certificate-fingerprint)
    - [Integrating Flutter Awareness Plugin](#integrating-flutter-awareness-plugin)
  - [3. API Reference](#3-api-reference)
    - [AwarenessCaptureClient](#awarenesscaptureclient)
    - [AwarenessBarrierClient](#awarenessbarrierclient)
    - [AwarenessUtilsClient](#awarenessutilsclient)
    - [Data Types](#data-types)
  - [4. Configuration and Description](#4-configuration-and-description)
    - [Preparing for Release](#preparing-for-release)
  - [5. Sample Project](#5-sample-project)
  - [6. Questions or Issues](#6-questions-or-issues)
  - [7. Licensing and Terms](#7-licensing-and-terms)

---

## 1. Introduction

HUAWEI Awareness Kit provides your app with the ability to obtain contextual information including users' current time, location, behavior, audio device status, ambient light, weather, and nearby beacons. Your app can gain insight into a user's current situation more efficiently, making it possible to deliver a smarter, more considerate user experience.

- Capture Client

   The Capture API allows your app to request the current user status, such as time, location, behavior, and whether a headset is connected. For example, after your app runs, it can request the user's time and location in order to recommend entertainment activities available nearby at weekends to the user.

- Barrier Client

  The Barrier API allows your app to set a barrier for specific contextual conditions. When the conditions are met, your app will receive a notification. For example, a notification is triggered when an audio device connects to a mobile phone for an audio device status barrier about connection or illuminance is less than 100 lux for an ambient light barrier whose trigger condition is set for illuminance that is less than 100 lux. You can also combine different types of barriers for your app to support different use cases. For example, your app can recommend nearby services if the user has stayed in a specified business zone (geofence) for the preset period of time (time barrier).

This plugin enables communication between HUAWEI Awareness Kit SDK and Flutter platform. It exposes all functionality provided by HUAWEI Awareness Kit SDK.

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


### Configuring the Signing Certificate Fingerprint

**Step 1:** Go to **Project Setting** > **General information**. In the **App information** field, click the icon next to SHA-256 certificate fingerprint, and enter the obtained **SHA256 certificate fingerprint**.

**Step 2:** After completing the configuration, click check mark.

### Integrating Flutter Awareness Plugin

**Step 1:** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) and select **My projects**.

**Step 2:** Find your app project, and click the desired app name.

**Step 3:** Go to **Project Setting** > **General information**. In the **App information** section, click **agconnect-services.json** to download the configuration file.

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
              classpath 'com.huawei.agconnect:agcp:1.4.2.301'
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

- Set your package name in **defaultConfig** > **applicationId** and set **minSdkVersion** to **24** or **higher**.

- Package name must match with the **package_name** entry in **agconnect-services.json** file.

  ```gradle
      defaultConfig {
              applicationId "<package_name>"
              minSdkVersion 24
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

- For Obfuscation Scripts, please refer to [Configuring Obfuscation Scripts](https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides/config-obfuscation-scripts-0000001050033103).

**Step 10:** On your Flutter project directory find and open your **pubspec.yaml** file and add library to dependencies.

- To download the package from [pub.dev](https://pub.dev/publishers/developer.huawei.com/packages).

  ```yaml
  dependencies:
    huawei_awareness: { library version }
  ```

  **or**

  If you downloaded the package from the HUAWEI Developer website, specify the **library path** on your local device.

  ```yaml
  dependencies:
    huawei_awareness:
      # Replace {library path} with actual library path of Huawei Awareness Plugin for Flutter.
      path: { library path }
  ```

  - Replace {library path} with the actual library path of Flutter Awareness Plugin. The following are examples:
    - Relative path example: `path: ../huawei_awareness`
    - Absolute path example: `path: D:\Projects\Libraries\huawei_awareness`

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

### AwarenessCaptureClient

Main entry of capture APIs of HUAWEI Awareness Kit to obtain the headset status, behavior, time, location, beacon status, ambient light, weather, Bluetooth car stereo connection status, phone status, and capability support status.

#### Method Summary

| Method                                                       | Return Type                     | Description                                                  |
| ------------------------------------------------------------ | ------------------------------- | ------------------------------------------------------------ |
| [getBeaconStatus(List\<BeaconFilter> filters)](#futurebeaconresponse-getbeaconstatuslistbeaconfilter-filters-async) | Future\<BeaconResponse>         | Uses a variable number of the **filters** parameters to obtain beacon information. |
| [getBehavior()](#futurebehaviorresponse-getbehavior-async)   | Future\<BehaviorResponse>       | Obtains current user behavior.                               |
| [getHeadsetStatus()](#futureheadsetresponse-getheadsetstatus-async) | Future\<HeadsetResponse>        | Obtains headset connection status.                           |
| [getLocation()](#futurelocationresponse-getlocation-async)   | Future\<LocationResponse>       | Obtains the current location (latitude and longitude) of a device. |
| [getCurrentLocation()](#futurelocationresponse-getcurrentlocation-async) | Future\<LocationResponse>       | Re-obtains the latest device location information (latitude and longitude). |
| [getTimeCategories()](#futuretimecategoriesresponse-gettimecategories-async) | Future\<TimeCategoriesResponse> | Obtains the current time.                                    |
| [getTimeCategoriesByUser(double latitude, double longitude)](#futuretimecategoriesresponse-gettimecategoriesbyuserdouble-latitude-double-longitude-async) | Future\<TimeCategoriesResponse> | Obtains the current time of a specified location.            |
| [getTimeCategoriesByCountryCode(String countryCode)](#futuretimecategoriesresponse-gettimecategoriesbycountrycodestring-countrycode-async) | Future\<TimeCategoriesResponse> | Obtains the current time by country/region code.             |
| [getTimeCategoriesByIP()](#futuretimecategoriesresponse-gettimecategoriesbyip-async) | Future\<TimeCategoriesResponse> | Obtains the current time by IP address.                      |
| [getTimeCategoriesForFuture(int futureTimestamp)](#futuretimecategoriesresponse-gettimecategoriesforfutureint-futuretimestamp-async) | Future\<TimeCategoriesResponse> | Obtains the time of a specified date by IP address.          |
| [getLightIntensity()](#futurelightintensityresponse-getlightintensity-async) | Future\<LightIntensityResponse> | Obtains the illuminance.                                     |
| [getWeatherByDevice()](#futureweatherresponse-getweatherbydevice-async) | Future\<WeatherResponse>        | Obtains the weather of the current location of a device.     |
| [getWeatherByPosition(WeatherPosition weatherPosition)](#futureweatherresponse-getweatherbypositionweatherposition-weatherposition-async) | Future\<WeatherResponse>        | Obtains weather information about a specified address.       |
| [getBluetoothStatus(int deviceType)](#futurebluetoothresponse-getbluetoothstatusint-devicetype-async) | Future\<BluetoothResponse>      | Obtains the Bluetooth connection status.                     |
| [getScreenStatus()](#futurescreenstatusresponse-getscreenstatus-async) | Future\<ScreenStatusResponse>   | Obtains the screen status response of a device.              |
| [getWifiStatus()](#futurewifiresponse-getwifistatus-async)   | Future\<WiFiResponse>           | Obtains the Wi-Fi connection status of a device.             |
| [getApplicationStatus(String packageName)](#futureapplicationresponse-getapplicationstatusstring-packagename-async) | Future\<ApplicationResponse>    | Obtains the app status of a device.                          |
| [getDarkModeStatus()](#futuredarkmoderesponse-getdarkmodestatus-async) | Future\<DarkModeResponse>       | Obtains the dark mode status of a device.                    |
| [querySupportingCapabilities()](#futurecapabilityresponse-querysupportingcapabilities-async) | Future\<CapabilityResponse>     | Obtains capabilities supported by Awareness Kit on the current device. |
| [enableUpdateWindow(bool status)](#futurevoid-enableupdatewindowbool-status-async) | Future\<void>                   | Enables/disables update window.                              |

#### Methods

##### Future\<BeaconResponse> getBeaconStatus(List\<BeaconFilter> filters) *async*

Uses a variable number of the **filters** parameters to obtain beacon information.

###### Parameters

| Name    | Type                | Description    |
| ------- | ------------------- | -------------- |
| filters | List\<BeaconFilter> | Beacon filter. |

###### Return Type

| Type                    | Description                                              |
| ----------------------- | -------------------------------------------------------- |
| Future\<BeaconResponse> | Response to the request for obtaining the beacon status. |

###### Call Example

```dart
BeaconFilter filter1 = BeaconFilter.matchByBeaconContent(
  beaconNamespace: "beacon-namespace",
  beaconType: "beacon-type",
  beaconContent: Uint8List.fromList(utf8.encode("beacon-content")),
);

BeaconResponse response = await AwarenessCaptureClient.getBeaconStatus(filters: [filter1]);
```

##### Future\<BehaviorResponse> getBehavior() *async*

Obtains current user behavior, for example, running, walking, cycling, or driving.

###### Return Type

| Type                      | Description                                              |
| ------------------------- | -------------------------------------------------------- |
| Future\<BehaviorResponse> | Response to the request for obtaining the user behavior. |

###### Call Example

```dart
BehaviorResponse response = await AwarenessCaptureClient.getBehavior();
```

##### Future\<HeadsetResponse> getHeadsetStatus() *async*

Obtains headset connection status.

###### Return Type

| Type                     | Description                                               |
| ------------------------ | --------------------------------------------------------- |
| Future\<HeadsetResponse> | Response to the request for obtaining the headset status. |

###### Call Example

```dart
HeadsetResponse response = await AwarenessCaptureClient.getHeadsetStatus();
```

##### Future\<LocationResponse> getLocation() *async*

Obtains the current location (latitude and longitude) of a device. The location information obtained by using this method is the value queried last time and cached on the device.

###### Return Type

| Type                      | Description                             |
| ------------------------- | --------------------------------------- |
| Future\<LocationResponse> | Response to the location query request. |

###### Call Example

```dart
LocationResponse response = await AwarenessCaptureClient.getLocation();
```

##### Future\<LocationResponse> getCurrentLocation() *async*

Re-obtains the latest device location information (latitude and longitude). When this method is used to obtain the location information, the system obtains the location information again based on the current location of the device, returns the location information, and updates the location information cached on the device.

###### Return Type

| Type                      | Description                             |
| ------------------------- | --------------------------------------- |
| Future\<LocationResponse> | Response to the location query request. |

###### Call Example

```dart
LocationResponse response = await AwarenessCaptureClient.getCurrentLocation();
```

##### Future\<TimeCategoriesResponse> getTimeCategories() *async*

Obtains the current time.

###### Return Type

| Type                            | Description                                     |
| ------------------------------- | ----------------------------------------------- |
| Future\<TimeCategoriesResponse> | Response to the request for obtaining the time. |

###### Call Example

```dart
TimeCategoriesResponse response = await AwarenessCaptureClient.getTimeCategories();
```

##### Future\<TimeCategoriesResponse> getTimeCategoriesByUser(double latitude, double longitude) *async*

Obtains the current time of a specified location.

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| latitude  | double | Latitude.   |
| longitude | double | Longitude.  |

###### Return Type

| Type                            | Description                                     |
| ------------------------------- | ----------------------------------------------- |
| Future\<TimeCategoriesResponse> | Response to the request for obtaining the time. |

###### Call Example

```dart
TimeCategoriesResponse response = await AwarenessCaptureClient.getTimeCategoriesByUser(
    latitude: 22.4943, longitude: 113.7436);
```

##### Future\<TimeCategoriesResponse> getTimeCategoriesByCountryCode(String countryCode) *async*

Obtains the current time by country/region code that complies with ISO 3166-1 alpha-2.

###### Parameters

| Name        | Type   | Description                                                |
| ----------- | ------ | ---------------------------------------------------------- |
| countryCode | String | Country/Region code that complies with ISO 3166-1 alpha-2. |

###### Return Type

| Type                            | Description                                     |
| ------------------------------- | ----------------------------------------------- |
| Future\<TimeCategoriesResponse> | Response to the request for obtaining the time. |

###### Call Example

```dart
TimeCategoriesResponse response = await AwarenessCaptureClient.getTimeCategoriesByCountryCode(countryCode: "TR");
```

##### Future\<TimeCategoriesResponse> getTimeCategoriesByIP() *async*

When this method is used, the time of the location corresponding to the IP address is returned. Note that the result returned through this method is less accurate than that returned through **getTimeCategories**, but this method does not require the precise location permission. You can select a method based on your actual requirements.

###### Return Type

| Type                            | Description                                     |
| ------------------------------- | ----------------------------------------------- |
| Future\<TimeCategoriesResponse> | Response to the request for obtaining the time. |

###### Call Example

```dart
TimeCategoriesResponse response = await AwarenessCaptureClient.getTimeCategoriesByIP();
```

##### Future\<TimeCategoriesResponse> getTimeCategoriesForFuture(int futureTimestamp) *async*

 Obtains the time of a specified date by IP address. You can specify a future date and use this method to query its time. Note that cross-year query is not supported.

###### Parameters

| Name            | Type | Description                                                  |
| --------------- | ---- | ------------------------------------------------------------ |
| futureTimestamp | int  | Timestamp of the specified date. You can only set this parameter to a timestamp in the current year, because cross-year query is not supported. The timestamp is the total number of milliseconds from 00:00:00 on January 1, 1970 (GMT) to the current time. |

###### Return Type

| Type                            | Description                                     |
| ------------------------------- | ----------------------------------------------- |
| Future\<TimeCategoriesResponse> | Response to the request for obtaining the time. |

###### Call Example

```dart
TimeCategoriesResponse response = await AwarenessCaptureClient.getTimeCategoriesForFuture(
    futureTimestamp: time_stamp);
```

##### Future\<LightIntensityResponse> getLightIntensity() *async*

Obtains the illuminance. 

###### Return Type

| Type                            | Description                                            |
| ------------------------------- | ------------------------------------------------------ |
| Future\<LightIntensityResponse> | Response to the request for obtaining the illuminance. |

###### Call Example

```dart
LightIntensityResponse response = await AwarenessCaptureClient.getLightIntensity();
```

##### Future\<WeatherResponse> getWeatherByDevice() *async*

Obtains the weather of the current location of a device.

###### Return Type

| Type                     | Description                            |
| ------------------------ | -------------------------------------- |
| Future\<WeatherResponse> | Response to the weather query request. |

###### Call Example

```dart
WeatherResponse response = await AwarenessCaptureClient.getWeatherByDevice();
```

##### Future\<WeatherResponse> getWeatherByPosition(WeatherPosition weatherPosition) *async*

Obtains weather information about a specified address. 

An address has five attributes: country, province, city, district, and county. The city must be set and other four attributes are optional. It is recommended that all attributes be specified to constitute an accurate address so that the returned weather information will be more accurate. When entering an address, you need to specify the language type of the address. The system returns the weather information in the corresponding language based on the language type.

For example, you can enter London, or England, London, and then specify **en_GB** as the locale to obtain the weather of London.

###### Parameters

| Name            | Type            | Description                                                  |
| --------------- | --------------- | ------------------------------------------------------------ |
| weatherPosition | WeatherPosition | Address information for weather query, including the address and language type. |

###### Return Type

| Type                     | Description                            |
| ------------------------ | -------------------------------------- |
| Future\<WeatherResponse> | Response to the weather query request. |

###### Call Example

```dart
WeatherPosition position = WeatherPosition(city: "London", locale: "en_GB", country: "United Kingdom"));
WeatherResponse response = await AwarenessCaptureClient.getWeatherByPosition(weatherPosition: position);
```

##### Future\<BluetoothResponse> getBluetoothStatus(int deviceType) *async*

Obtains the Bluetooth connection status.

###### Parameters

| Name       | Type | Description            |
| ---------- | ---- | ---------------------- |
| deviceType | int  | Bluetooth device type. |

###### Return Type

| Type                       | Description                                                  |
| -------------------------- | ------------------------------------------------------------ |
| Future\<BluetoothResponse> | Response to the request for obtaining the Bluetooth car stereo status. |

###### Call Example

```dart
BluetoothResponse response = await AwarenessCaptureClient.getBluetoothStatus(
    deviceType:BluetoothStatus.DeviceCar);
```

##### Future\<ScreenStatusResponse> getScreenStatus() *async*

Obtains the screen status response of a device.

###### Return Type

| Type                          | Description                                              |
| ----------------------------- | -------------------------------------------------------- |
| Future\<ScreenStatusResponse> | Response to the request for obtaining the screen status. |

###### Call Example

```dart
ScreenStatusResponse response = await AwarenessCaptureClient.getScreenStatus();
```

##### Future\<WiFiResponse> getWifiStatus() *async*

Obtains the Wi-Fi connection status of a device.

###### Return Type

| Type                  | Description                                             |
| --------------------- | ------------------------------------------------------- |
| Future\<WiFiResponse> | Response to the request for obtaining the Wi-Fi status. |

###### Call Example

```dart
WiFiResponse response = await AwarenessCaptureClient.getWifiStatus();
```

##### Future\<ApplicationResponse> getApplicationStatus(String packageName) *async*

Obtains the app status of a device.

###### Parameters

| Name        | Type   | Description   |
| ----------- | ------ | ------------- |
| packageName | String | Package name. |

###### Return Type

| Type                         | Description                                                  |
| ---------------------------- | ------------------------------------------------------------ |
| Future\<ApplicationResponse> | Response to the request for obtaining the app status corresponding to a package. |

###### Call Example

```dart
ApplicationResponse response = await AwarenessCaptureClient.getApplicationStatus(
    packageName: "package_name");
```

##### Future\<DarkModeResponse> getDarkModeStatus() *async*

Obtains the dark mode status of a device. The dark mode capture function is available only on devices with API level 29 or later.

###### Return Type

| Type                      | Description                                                 |
| ------------------------- | ----------------------------------------------------------- |
| Future\<DarkModeResponse> | Response to the request for obtaining the dark mode status. |

###### Call Example

```dart
DarkModeResponse response = await AwarenessCaptureClient.getDarkModeStatus();
```

##### Future\<CapabilityResponse> querySupportingCapabilities() *async*

Obtains capabilities supported by Awareness Kit on the current device.

###### Return Type

| Type                        | Description                                                  |
| --------------------------- | ------------------------------------------------------------ |
| Future\<CapabilityResponse> | Response to the request for obtaining supported capabilities. |

###### Call Example

```dart
CapabilityResponse capabilities = await AwarenessCaptureClient.querySupportingCapabilities();
```

##### Future\<void> enableUpdateWindow(bool status) *async*

Indicates whether to display a dialog box before Awareness Kit or HMS Core (APK) starts an upgrade in your app.

###### Parameters

| Name   | Type | Description                         |
| ------ | ---- | ----------------------------------- |
| status | bool | Indicates whether to enable or not. |

###### Return Type

| Type          | Description                                          |
| ------------- | ---------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example

```dart
await AwarenessCaptureClient.enableUpdateWindow(true);
```

### AwarenessBarrierClient

Main entry of barrier APIs of HUAWEI Awareness Kit to register and obtain barriers on device.

#### Method Summary

| Method                                                       | Return Type                   | Description                                       |
| ------------------------------------------------------------ | ----------------------------- | ------------------------------------------------- |
| [queryBarriers(BarrierQueryRequest request)](#futurebarrierqueryresponse-querybarriersbarrierqueryrequest-request-async) | Future\<BarrierQueryResponse> | Queries the current status of a target barrier/s. |
| [deleteBarrier(BarrierDeleteRequest request)](#futurebool-deletebarrierbarrierdeleterequest-request-async) | Future\<bool>                 | Deletes barrier/s.                                |
| [updateBarrier(AwarenessBarrier barrier, bool autoRemove)](#futurebool-updatebarrierawarenessbarrier-barrier-bool-autoremove-async) | Future\<bool>                 | Adds or updates barriers.                         |
| [enableUpdateWindow(bool status)](#barrierenable) | Future\<void>                 | Enables/disables update window.                   |

#### Stream Summary

| Method                                                       | Return Type            | Description                                             |
| ------------------------------------------------------------ | ---------------------- | ------------------------------------------------------- |
| [onBarrierStatusStream](#streambarrierstatus-onbarrierstatusstream) | Stream\<BarrierStatus> | The listenable stream that emits BarrierStatus objects. |

#### Methods

##### Future\<BarrierQueryResponse> queryBarriers(BarrierQueryRequest request) *async*

Queries the current status of a target barrier/s.

###### Parameters

| Name    | Type                | Description                                          |
| ------- | ------------------- | ---------------------------------------------------- |
| request | BarrierQueryRequest | Query request containing query condition parameters. |

###### Return Type

| Type                          | Description                                                  |
| ----------------------------- | ------------------------------------------------------------ |
| Future\<BarrierQueryResponse> | Target barrier information, including the key value and current status. |

###### Call Example

```dart
BarrierQueryResponse response = await AwarenessBarrierClient.queryBarriers(BarrierQueryRequest.all());
```

##### Future\<bool> deleteBarrier(BarrierDeleteRequest request) *async*

Deletes barrier/s.

###### Parameters

| Name    | Type                 | Description                                            |
| ------- | -------------------- | ------------------------------------------------------ |
| request | BarrierDeleteRequest | Delete request containing delete condition parameters. |

###### Return Type

| Type          | Description                                         |
| ------------- | --------------------------------------------------- |
| Future\<bool> | The value true indicates successful task execution. |

###### Call Example

```dart
bool status = await AwarenessBarrierClient.deleteBarrier(BarrierDeleteRequest.all());
```

##### Future\<bool> updateBarrier(AwarenessBarrier barrier, bool autoRemove) *async*

Adds or updates barriers.

If a barrier is added using a key that has been registered, the new barrier will replace the original one. No matter whether the new barrier is registered successfully, all callback requests of the original one will be invalid.

###### Parameters

| Name       | Type             | Description                                          |
| ---------- | ---------------- | ---------------------------------------------------- |
| barrier    | AwarenessBarrier | AwarenessBarrier object to be added or updated.      |
| autoRemove | bool             | Indicates whether to enable the autoRemove function. |

- autoRemove as **true**: The autoRemove function is enabled. When the number of registered barriers exceeds the upper limit, the system automatically deletes the earliest registered barrier and registers a new one.
- autoRemove as **false**: The autoRemove function is not enabled. When the number of registered barriers exceeds the upper limit, the system does not delete the earliest registered barrier. As a result, a new barrier fails to be registered.

###### Return Type

| Type          | Description                                         |
| ------------- | --------------------------------------------------- |
| Future\<bool> | The value true indicates successful task execution. |

###### Call Example

```dart
HeadsetBarrier headsetBarrier = HeadsetBarrier.keeping(
    barrierLabel: "Headset Barrier", 
    headsetStatus: HeadsetStatus.Connected);

bool status = await AwarenessBarrierClient.updateBarriers(barrier: headsetBarrier);
```

##### <a name="barrierenable"></a> Future\<void>enableUpdateWindow(bool status) *async*

Indicates whether to display a dialog box before Awareness Kit or HMS Core (APK) starts an upgrade in your app.

###### Parameters

| Name   | Type | Description                         |
| ------ | ---- | ----------------------------------- |
| status | bool | Indicates whether to enable or not. |

###### Return Type

| Type          | Description                                          |
| ------------- | ---------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example

```dart
await AwarenessBarrierClient.enableUpdateWindow(true);
```

#### Streams

##### Stream\<BarrierStatus> onBarrierStatusStream

The listenable stream that emits BarrierStatus objects.

###### Return Type

| Type                   | Description                                             |
| ---------------------- | ------------------------------------------------------- |
| Stream\<BarrierStatus> | The listenable stream that emits BarrierStatus objects. |

###### Call Example

```dart
_onStatusReceived(BarrierStatus status){
    String barrierLabel = status.barrierLabel;
    log(barrierLabel, name: "Barrier Label");
}

_onStatusReceiveError(Object error) {
  print("onStatusReceiveError: " + error.toString());
}

AwarenessBarrierClient.onBarrierStatusStream.listen(_onStatusReceived, onError: _onStatusReceiveError);
```

### AwarenessUtilsClient

Main entry of utility APIs of HUAWEI Awareness Kit for permissions and HMSLogger handling.

#### Method Summary

| Method                                                       | Return Type   | Description                                                  |
| ------------------------------------------------------------ | ------------- | ------------------------------------------------------------ |
| [enableLogger()](#futurevoid-enablelogger-async)             | Future\<void> | This method enables the HMSLogger capability which is used for sending usage analytics of Awareness SDK's methods to improve the service quality. |
| [disableLogger()](#futurevoid-disablelogger-async)           | Future\<void> | This method disables the HMSLogger capability which is used for sending usage analytics of Awareness SDK's methods to improve the service quality. |
| [hasLocationPermission()](#futurebool-haslocationpermission-async) | Future\<bool> | This API is used to check location permission is available or not. |
| [hasBackgroundLocationPermission()](#futurebool-hasbackgroundlocationpermission-async) | Future\<bool> | This API is used to check background location permission is available or not. |
| [hasActivityRecognitionPermission()](#futurebool-hasactivityrecognitionpermission-async) | Future\<bool> | This API is used to check activity permission is available or not. |
| [requestLocationPermission()](#futurebool-requestlocationpermission-async) | Future\<bool> | This API is used to request location permission.             |
| [requestBackgroundLocationPermission()](#futurebool-requestbackgroundlocationpermission-async) | Future\<bool> | This API is used to request background location permission.  |
| [requestActivityRecognitionPermission()](#futurebool-requestactivityrecognitionpermission-async) | Future\<bool> | This API is used to request activity recognition permission. |

#### Methods

##### Future\<void> enableLogger() *async*

This method enables the HMSLogger capability which is used for sending usage analytics of Awareness SDK's methods to improve the service quality.

###### Return Type

| Type          | Description                                          |
| ------------- | ---------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example

```dart
AwarenessUtilsClient.enableLogger();
```

##### Future\<void> disableLogger() *async*

This method disables the HMSLogger capability which is used for sending usage analytics of Awareness SDK's methods to improve the service quality.

###### Return Type

| Type          | Description                                          |
| ------------- | ---------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example

```dart
AwarenessUtilsClient.disableLogger();
```

##### Future\<bool> hasLocationPermission() *async*

This API is used to check location permission is available or not.

###### Return Type

| Type          | Description                                                |
| ------------- | ---------------------------------------------------------- |
| Future\<bool> | Returns true if permission is granted, else returns false. |

###### Call Example

```dart
bool locationPermission = await AwarenessUtilsClient.hasLocationPermission();
```

##### Future\<bool> hasBackgroundLocationPermission() *async*

This API is used to check background location permission is available or not.

###### Return Type

| Type          | Description                                                |
| ------------- | ---------------------------------------------------------- |
| Future\<bool> | Returns true if permission is granted, else returns false. |

###### Call Example

```dart
bool backgroundLocationPermission = await AwarenessUtilsClient.hasBackgroundLocationPermission();
```

##### Future\<bool> hasActivityRecognitionPermission() *async*

This API is used to check activity recognition permission is available or not.

###### Return Type

| Type          | Description                                                |
| ------------- | ---------------------------------------------------------- |
| Future\<bool> | Returns true if permission is granted, else returns false. |

###### Call Example

```dart
bool activityRecognitionPermission = await AwarenessUtilsClient.hasActivityRecognitionPermission();
```

##### Future\<bool> requestLocationPermission() *async* 

This API is used to request location permission.

###### Return Type

| Type          | Description                                                |
| ------------- | ---------------------------------------------------------- |
| Future\<bool> | Returns true if permission is granted, else returns false. |

###### Call Example

```dart
bool status = await AwarenessUtilsClient.requestLocationPermission();
```

##### Future\<bool> requestBackgroundLocationPermission() *async*

This API is used to request background location permission.

###### Return Type

| Type          | Description                                                |
| ------------- | ---------------------------------------------------------- |
| Future\<bool> | Returns true if permission is granted, else returns false. |

###### Call Example

```dart
bool status = await AwarenessUtilsClient.requestBackgroundLocationPermission();
```

##### Future\<bool> requestActivityRecognitionPermission() *async*

This API is used to request activity recognition permission.

###### Return Type

| Type          | Description                                                |
| ------------- | ---------------------------------------------------------- |
| Future\<bool> | Returns true if permission is granted, else returns false. |

###### Call Example

```dart
bool status = await AwarenessUtilsClient.requestActivityRecognitionPermission();
```

### Data Types

#### Data Types Summary

| Class                  | Description                                                  |
| ---------------------- | ------------------------------------------------------------ |
| AmbientLightBarrier    | Illuminance barriers, including below, above, and range barriers. |
| BeaconBarrier          | Beacon barriers, including the discover, keep, and missed barriers. |
| BehaviorBarrier        | Behavior barriers, including the beginning, ending, and keeping barriers of behaviors. |
| BluetoothBarrier       | Bluetooth barriers, including the connecting, disconnecting, and keeping barriers. |
| CombinationBarrier     | Obtains the integrated barriers after the specific logic operation is executed. |
| HeadsetBarrier         | Headset barriers, including the connecting, disconnecting, and keeping barriers. |
| LocationBarrier        | Location barriers, including the enter, exit, and stay barriers. |
| ScreenBarrier          | Screen barriers, including the status keeping, screen-on, screen-off, and screen-unlock barriers. |
| TimeBarrier            | Time barriers, including the barriers to be triggered at a time or periodically based on time. |
| WifiBarrier            | Wi-Fi barriers, including the keeping, connecting, disconnecting, enabling, and disabling barriers. |
| Barrier                | Registered barrier information.                              |
| BarrierStatus          | The barrier status includes the barrier label, current status, previous status, and last status update time. |
| BarrierDeleteRequest   | Deletes a barrier based on the key value.                    |
| BarrierQueryRequest    | Barrier query request.                                       |
| BarrierQueryResponse   | Barrier query response.                                      |
| ApplicationResponse    | Response to the request for obtaining the app status corresponding to a package. |
| BeaconResponse         | Response to the request for obtaining the beacon status.     |
| BehaviorResponse       | Response to the request for obtaining the user behavior.     |
| BluetoothResponse      | Response to the request for obtaining the Bluetooth car stereo status. |
| CapabilityResponse     | Response to the request for obtaining supported capabilities. |
| DarkModeResponse       | Response to the request for obtaining the dark mode status.  |
| HeadsetResponse        | Response to the request for obtaining the headset status.    |
| LightIntensityResponse | Response to the request for obtaining the illuminance.       |
| LocationResponse       | Response to the location query request.                      |
| ScreenStatusResponse   | Response to the request for obtaining the screen status.     |
| TimeCategoriesResponse | Response to the request for obtaining the time.              |
| WeatherResponse        | Response to the weather query request.                       |
| WifiResponse           | Response to the request for obtaining the Wi-Fi status.      |
| BeaconData             | Beacon information.                                          |
| DetectedBehavior       | Type and confidence of a detected behavior.                  |
| WeatherPosition        | Request parameter class, which is used to pass address information to obtain weather information. |
| Aqi                    | Air quality indexes.                                         |
| City                   | City information including the city code, province name, time zone, and city/district name. |
| DailyLiveInfo          | Information about a living index on a day.                   |
| DailySituation         | Weather conditions in the daytime or at night.               |
| DailyWeather           | Weather information of the current day and the next six to seven days. |
| HourlyWeather          | Weather information in the current hour and the next 24 hours. |
| LiveInfo               | Living index level for the day and the next one or two days. |
| Situation              | Current weather information.                                 |
| WeatherSituation       | Current weather information, which consists of the current weather information (specified by Situation) and city information (specified by City). |
| BeaconFilter           | Represents filter for beacons.                               |
| ApplicationStatus      | Represents constants for Application Status.                 |
| AwarenessStatusCodes   | Represents constants for Awareness Status Codes.             |
| BluetoothStatus        | Represents constants for Bluetooth Status.                   |
| CapabilityStatus       | Represents constants for Capability Status.                  |
| HeadsetStatus          | Represents constants for Headset Status.                     |
| ScreenStatus           | Represents constants for Screen Status.                      |
| WeatherId              | Represents constants for Weather ID.                         |
| WiFiStatus             | Represents constants for WiFi Status.                        |

- For more detailed information about classes and constants, please refer to Official Huawei Awareness Flutter Plugin Documentation.

#### AmbientLightBarrier

Illuminance barriers, including below, above, and range barriers.

##### Properties

| Name              | Type   | Description          |
| ----------------- | ------ | -------------------- |
| barrierLabel      | String | Barrier label.       |
| minLightIntensity | double | Minimum illuminance. |
| maxLightIntensity | double | Maximum illuminance. |

##### Constructor Summary

| Constructor                                                  | Description                          |
| ------------------------------------------------------------ | ------------------------------------ |
| AmbientLightBarrier.above(String barrierLabel, double minLightIntensity) | Illuminance barrier named **above**. |
| AmbientLightBarrier.below(String barrierLabel, double maxLightIntensity) | Illuminance barrier named **below**. |
| AmbientLightBarrier.range(String barrierLabel, double minLightIntensity, double maxLightIntensity) | Illuminance barrier named **range**. |

##### Constructors

###### AmbientLightBarrier.above(String barrierLabel, double minLightIntensity)

When the illuminance is within the range specified by [minLightIntensity, Float.MAX_VALUE), the barrier status is **True** and a barrier event is reported. When the illuminance is not within the range, the barrier status is **False** and a barrier event is reported.

**Parameters**

| Name              | Type   | Description          |
| ----------------- | ------ | -------------------- |
| barrierLabel      | String | Barrier label.       |
| minLightIntensity | double | Minimum illuminance. |

###### AmbientLightBarrier.below(String barrierLabel, double maxLightIntensity)

When the illuminance is within the range specified by [0, maxLightIntensity), the barrier status is **True** and a barrier event is reported. When the illuminance is not within the range, the barrier status is **False** and a barrier event is reported.

**Parameters**

| Name              | Type   | Description          |
| ----------------- | ------ | -------------------- |
| barrierLabel      | String | Barrier label.       |
| maxLightIntensity | double | Maximum illuminance. |

###### AmbientLightBarrier.range(String barrierLabel, double minLightIntensity, double maxLightIntensity)

 When the illuminance is within the range specified by [minLightIntensity, maxLightIntensity), the barrier status is **True** and a barrier event is reported. When the illuminance is not within the range, the barrier status is **False** and a barrier event is reported.

**Parameters**

| Name              | Type   | Description          |
| ----------------- | ------ | -------------------- |
| barrierLabel      | String | Barrier label.       |
| minLightIntensity | double | Minimum illuminance. |
| maxLightIntensity | double | Maximum illuminance. |

#### BeaconBarrier

Beacon barriers, including the discover, keep, and missed barriers.

##### Properties

| Name         | Type                | Description     |
| ------------ | ------------------- | --------------- |
| barrierLabel | String              | Barrier label.  |
| filters      | List\<BeaconFilter> | Beacon filters. |

##### Constructor Summary

| Constructor                                                  | Description                        |
| ------------------------------------------------------------ | ---------------------------------- |
| BeaconBarrier.discover(String barrierLabel, List\<BeaconFilter> filters) | Beacon barrier named **discover**. |
| BeaconBarrier.missed(String barrierLabel, List\<BeaconFilter> filters) | Beacon barrier named **missed**.   |
| BeaconBarrier.keep(String barrierLabel, List\<BeaconFilter> filters) | Beacon barrier named **keep**.     |

- To use this barrier, you need to add the **android.permission.ACCESS_FINE_LOCATION** and **android.permission.BLUETOOTH** permissions.

##### Constructors

###### BeaconBarrier.discover(String barrierLabel, List\<BeaconFilter> filters)

After this barrier is added, when a beacon of a specified type is found, the barrier status is **True** and a barrier event is reported. After 5s, the barrier status changes to **False**.

**Parameters**

| Name         | Type                | Description     |
| ------------ | ------------------- | --------------- |
| barrierLabel | String              | Barrier label.  |
| filters      | List\<BeaconFilter> | Beacon filters. |

###### BeaconBarrier.missed(String barrierLabel, List\<BeaconFilter> filters)

After this barrier is added, when a beacon of a specified type is lost, the barrier status is **True** and a barrier event is reported. After 5s, the barrier status changes to **False**.

**Parameters**

| Name         | Type                | Description     |
| ------------ | ------------------- | --------------- |
| barrierLabel | String              | Barrier label.  |
| filters      | List\<BeaconFilter> | Beacon filters. |

###### BeaconBarrier.keep(String barrierLabel, List\<BeaconFilter> filters)

After this barrier is added, when a nearby beacon of a specified type is found and not lost, the barrier status is **True** and a barrier event is reported.

**Parameters**

| Name         | Type                | Description     |
| ------------ | ------------------- | --------------- |
| barrierLabel | String              | Barrier label.  |
| filters      | List\<BeaconFilter> | Beacon filters. |

#### BehaviorBarrier

Behavior barriers, including the beginning, ending, and keeping barriers of behaviors.

##### Properties

| Name          | Type       | Description                          |
| ------------- | ---------- | ------------------------------------ |
| barrierLabel  | String     | Barrier label.                       |
| behaviorTypes | List\<int> | One or more behavior type constants. |

##### Constants

- For details please refer to Official Huawei Awareness Flutter Plugin Documentation.

##### Constructor Summary

| Constructor                                                  | Description                           |
| ------------------------------------------------------------ | ------------------------------------- |
| BehaviorBarrier.keeping(String barrierLabel, List\<int> behaviorTypes) | Behavior barrier named **keeping**.   |
| BehaviorBarrier.beginning(String barrierLabel, List\<int> behaviorTypes) | Behavior barrier named **beginning**. |
| BehaviorBarrier.ending(String barrierLabel, List\<int> behaviorTypes) | Behavior barrier named **ending**.    |

##### Constructors

###### BehaviorBarrier.keeping(String barrierLabel, List\<int> behaviorTypes)

After the barrier in a specified behavior status (excluding **Unkown**) is added, when a user is in the behavior status, the barrier status is **True** and a barrier event is reported.

**Parameters**

| Name          | Type       | Description                          |
| ------------- | ---------- | ------------------------------------ |
| barrierLabel  | String     | Barrier label.                       |
| behaviorTypes | List\<int> | One or more behavior type constants. |

###### BehaviorBarrier.beginning(String barrierLabel, List\<int> behaviorTypes)

After the barrier in a specified behavior status (excluding **Unkown**) is added, when a user is in the behavior status, the barrier status is **True** and a barrier event is reported. After 5s, the barrier status changes to **False**.

**Parameters**

| Name          | Type       | Description                          |
| ------------- | ---------- | ------------------------------------ |
| barrierLabel  | String     | Barrier label.                       |
| behaviorTypes | List\<int> | One or more behavior type constants. |

###### BehaviorBarrier.ending(String barrierLabel, List\<int> behaviorTypes)

After the barrier in a specified behavior status (excluding **Unkown**) is added, when a user stops the behavior, the barrier status is **True** and a barrier event is reported. After 5s, the barrier status changes to **False**.

**Parameters**

| Name          | Type       | Description                          |
| ------------- | ---------- | ------------------------------------ |
| barrierLabel  | String     | Barrier label.                       |
| behaviorTypes | List\<int> | One or more behavior type constants. |

#### BluetoothBarrier

Bluetooth barriers, including the connecting, disconnecting, and keeping barriers.

##### Properties

| Name            | Type   | Description                                |
| --------------- | ------ | ------------------------------------------ |
| barrierLabel    | String | Barrier label.                             |
| bluetoothStatus | int    | Connection status of the Bluetooth device. |
| deviceType      | int    | Bluetooth device type.                     |

##### Constructor Summary

| Constructor                                                  | Description                                |
| ------------------------------------------------------------ | ------------------------------------------ |
| BluetoothBarrier.keeping(String barrierLabel, int bluetoothStatus, int deviceType) | Bluetooth barrier named **keeping**.       |
| BluetoothBarrier.connecting(String barrierLabel, int deviceType) | Bluetooth barrier named **connecting**.    |
| BluetoothBarrier.disconnecting(String barrierLabel, int deviceType) | Bluetooth barrier named **disconnecting**. |

- To use this barrier, you need to add the **android.permission.BLUETOOTH** permission.

##### Constructors

###### BluetoothBarrier.keeping(String barrierLabel, int bluetoothStatus, int deviceType)

After you add this barrier for a Bluetooth state such as **Connected** or **Disconnected**, if the Bluetooth keeps in this state, the barrier status is **True** and a barrier event is reported.

**Parameters**

| Name            | Type   | Description                                |
| --------------- | ------ | ------------------------------------------ |
| barrierLabel    | String | Barrier label.                             |
| bluetoothStatus | int    | Connection status of the Bluetooth device. |
| deviceType      | int    | Bluetooth device type.                     |

###### BluetoothBarrier.connecting(String barrierLabel, int deviceType)

After you add this barrier, if a Bluetooth device is connected, the barrier status is **True** and a barrier event is reported. After 5s, the barrier status changes to **False**. 

**Parameters**

| Name         | Type   | Description            |
| ------------ | ------ | ---------------------- |
| barrierLabel | String | Barrier label.         |
| deviceType   | int    | Bluetooth device type. |

###### BluetoothBarrier.disconnecting(String barrierLabel, int deviceType)

After you add this barrier, if a Bluetooth device is disconnected, the barrier status is **True** and a barrier event is reported. After 5s, the barrier status changes to **False**. 

**Parameters**

| Name         | Type   | Description            |
| ------------ | ------ | ---------------------- |
| barrierLabel | String | Barrier label.         |
| deviceType   | int    | Bluetooth device type. |

#### CombinationBarrier

Obtains the integrated barriers after the specific logic operation is executed.

##### Properties

| Name         | Type   | Description    |
| ------------ | ------ | -------------- |
| barrierLabel | String | Barrier label. |

##### Constructor Summary

| Constructor                                                  | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| CombinationBarrier.not(String barrierLabel, AwarenessBarrier barrier) | Obtains the barrier after the **NOT** logic operation is executed. |
| CombinationBarrier.and(String barrierLabel, List\<AwarenessBarrier> barriers) | Obtains the integrated barriers after the **AND** logic operation is executed. |
| CombinationBarrier.or(String barrierLabel, List\<AwarenessBarrier> barriers) | Obtains the barrier after the **OR** logic operation is executed. |

##### Constructors

###### CombinationBarrier.not(String barrierLabel, AwarenessBarrier barrier)

Obtains the barrier after the **NOT** logic operation is executed.

**Parameters**

| Name         | Type             | Description    |
| ------------ | ---------------- | -------------- |
| barrierLabel | String           | Barrier label. |
| barrier      | AwarenessBarrier | Barrier.       |

###### CombinationBarrier.and(String barrierLabel, List\<AwarenessBarrier> barriers)

Obtains the integrated barriers after the **AND** logic operation is executed.

**Parameters**

| Name         | Type                    | Description    |
| ------------ | ----------------------- | -------------- |
| barrierLabel | String                  | Barrier label. |
| barriers     | List\<AwarenessBarrier> | Barriers.      |

###### CombinationBarrier.or(String barrierLabel, List\<AwarenessBarrier> barriers)

Obtains the barrier after the **OR** logic operation is executed.

**Parameters**

| Name         | Type                    | Description    |
| ------------ | ----------------------- | -------------- |
| barrierLabel | String                  | Barrier label. |
| barriers     | List\<AwarenessBarrier> | Barriers.      |

#### HeadsetBarrier

Headset barriers, including the connecting, disconnecting, and keeping barriers.

##### Properties

| Name          | Type   | Description     |
| ------------- | ------ | --------------- |
| barrierLabel  | String | Barrier label.  |
| headsetStatus | int    | Headset status. |

##### Constructor Summary

| Constructor                                                  | Description                              |
| ------------------------------------------------------------ | ---------------------------------------- |
| HeadsetBarrier.keeping(String barrierLabel, int headsetStatus) | Headset barrier named **keeping**.       |
| HeadsetBarrier.connecting(String barrierLabel)               | Headset barrier named **connecting**.    |
| HeadsetBarrier.disconnecting(String barrierLabel)            | Headset barrier named **disconnecting**. |

- To use this barrier, you need to add the **android.permission.BLUETOOTH** permission.

##### Constructors

###### HeadsetBarrier.keeping(String barrierLabel, int headsetStatus)

After you add this barrier with headset status **Connected** and **Disconnected**, when the headset is in specified state, the barrier status is **True** and a barrier event is reported. 

**Parameters**

| Name          | Type   | Description     |
| ------------- | ------ | --------------- |
| barrierLabel  | String | Barrier label.  |
| headsetStatus | int    | Headset status. |

###### HeadsetBarrier.connecting(String barrierLabel)

 After this barrier is added, when a headset is connected to a device, the barrier status is **True** and a barrier event is reported. After 5s, the barrier status changes to **False**.

**Parameters**

| Name         | Type   | Description    |
| ------------ | ------ | -------------- |
| barrierLabel | String | Barrier label. |

###### HeadsetBarrier.disconnecting(String barrierLabel)

After this barrier is added, when a headset is disconnected, the barrier status is **True** and a barrier event is reported. After 5s, the barrier status changes to **False**. 

**Parameters**

| Name         | Type   | Description    |
| ------------ | ------ | -------------- |
| barrierLabel | String | Barrier label. |

#### LocationBarrier

Location barriers, including the enter, exit, and stay barriers.

##### Properties

| Name           | Type   | Description                                                  |
| -------------- | ------ | ------------------------------------------------------------ |
| barrierLabel   | String | Barrier label.                                               |
| latitude       | double | Center latitude of an area. The unit is degree and the value range is [–90°,90°]. |
| longitude      | double | Center longitude of an area. The unit is degree and the value range is (–180°,180°]. |
| radius         | double | Radius of an area. The unit is meter.                        |
| timeOfDuration | int    | Minimum stay time in a specified area. The unit is millisecond. |

##### Constructor Summary

| Constructor                                                  | Description              |
| ------------------------------------------------------------ | ------------------------ |
| LocationBarrier.enter(String barrierLabel, double latitude, double longitude, double radius) | Barrier named **enter**. |
| LocationBarrier.stay(String barrierLabel, double latitude, double longitude, double radius, int timeOfDuration) | Barrier named **exit**.  |
| LocationBarrier.exit(String barrierLabel, double latitude, double longitude, double radius) | Barrier named **stay**.  |

- To use this barrier, you need to add the **android.permission.ACCESS_FINE_LOCATION** permission. For Android 10 or later, you also need to add the **android.permission.ACCESS_BACKGROUND_LOCATION** permission.

##### Constructors

###### LocationBarrier.enter(String barrierLabel, double latitude, double longitude, double radius)

After this barrier is added, when a user enters a specified area, the barrier status is **True** and a barrier event is reported. After 5s, the barrier status changes to **False**.

**Parameters**

| Name         | Type   | Description                                                  |
| ------------ | ------ | ------------------------------------------------------------ |
| barrierLabel | String | Barrier label.                                               |
| latitude     | double | Center latitude of an area. The unit is degree and the value range is [–90°,90°]. |
| longitude    | double | Center longitude of an area. The unit is degree and the value range is (–180°,180°]. |
| radius       | double | Radius of an area. The unit is meter.                        |

###### LocationBarrier.stay(String barrierLabel, double latitude, double longitude, double radius, int timeOfDuration)

After this barrier is added, when a user exits from a specified area, the barrier status is **True** and a barrier event is reported. After 5s, the barrier status changes to **False**.

**Parameters**

| Name           | Type   | Description                                                  |
| -------------- | ------ | ------------------------------------------------------------ |
| barrierLabel   | String | Barrier label.                                               |
| latitude       | double | Center latitude of an area. The unit is degree and the value range is [–90°,90°]. |
| longitude      | double | Center longitude of an area. The unit is degree and the value range is (–180°,180°]. |
| radius         | double | Radius of an area. The unit is meter.                        |
| timeOfDuration | int    | Minimum stay time in a specified area. The unit is millisecond. |

###### LocationBarrier.exit(String barrierLabel, double latitude, double longitude, double radius)

After this barrier is added, if a user is in a specified area, the barrier status is **True**; if a user enters the area and stays in the area for a specified time period, the barrier status is **True** and a barrier event is reported.

**Parameters**

| Name         | Type   | Description                                                  |
| ------------ | ------ | ------------------------------------------------------------ |
| barrierLabel | String | Barrier label.                                               |
| latitude     | double | Center latitude of an area. The unit is degree and the value range is [–90°,90°]. |
| longitude    | double | Center longitude of an area. The unit is degree and the value range is (–180°,180°]. |
| radius       | double | Radius of an area. The unit is meter.                        |

#### ScreenBarrier

Screen barriers, including the status keeping, screen-on, screen-off, and screen-unlock barriers. You should remind users that the screen status of their phones may be monitored by the app.

##### Properties

| Name         | Type   | Description    |
| ------------ | ------ | -------------- |
| barrierLabel | String | Barrier label. |
| screenStatus | int    | Screen status. |

##### Constructor Summary

| Constructor                                                  | Description                                   |
| ------------------------------------------------------------ | --------------------------------------------- |
| ScreenBarrier.keeping(String barrierLabel, int screenStatus) | Screen status barrier named **keeping**.      |
| ScreenBarrier.screenOn(String barrierLabel)                  | Screen status barrier named **screenOn**.     |
| ScreenBarrier.screenOff(String barrierLabel)                 | Screen status barrier named **screenOff**.    |
| ScreenBarrier.screenUnlock(String barrierLabel)              | Screen status barrier named **screenUnlock**. |

##### Constructors

###### ScreenBarrier.keeping(String barrierLabel, int screenStatus)

After you add this barrier for a screen state such as **ScreenOn**, **ScreenOff**, or **Unlock**, if the screen keeps in this state, the barrier status is **True** and a barrier event is reported.

**Parameters**

| Name         | Type   | Description    |
| ------------ | ------ | -------------- |
| barrierLabel | String | Barrier label. |
| screenStatus | int    | Screen status. |

###### ScreenBarrier.screenOn(String barrierLabel)

After this barrier is added, when the screen is on but locked, the barrier status is **True** and a barrier event is reported. After 5s, the barrier status changes to **False**.

**Parameters**

| Name         | Type   | Description    |
| ------------ | ------ | -------------- |
| barrierLabel | String | Barrier label. |

###### ScreenBarrier.screenOff(String barrierLabel)

After this barrier is added, when the screen is off, the barrier status is **True** and a barrier event is reported. After 5s, the barrier status changes to **False**.

**Parameters**

| Name         | Type   | Description    |
| ------------ | ------ | -------------- |
| barrierLabel | String | Barrier label. |

###### ScreenBarrier.screenUnlock(String barrierLabel)

After this barrier is added, when the screen is unlocked, the barrier status is **True** and a barrier event is reported. After 5s, the barrier status changes to **False**.

**Parameters**

| Name         | Type   | Description    |
| ------------ | ------ | -------------- |
| barrierLabel | String | Barrier label. |

#### TimeBarrier

Time barriers, including the barriers to be triggered at a time or periodically based on time.

##### Properties

| Name                    | Type   | Description                                 |
| ----------------------- | ------ | ------------------------------------------- |
| barrierLabel            | String | Barrier label.                              |
| timeInstant             | int    | Sunrise or sunset.                          |
| startTimeOffset         | int    | Start time offset of the time barrier.      |
| stopTimeOffset          | int    | Stop time offset of the time barrier.       |
| startTimeOfDay          | int    | Start time of the barrier, in milliseconds. |
| stopTimeOfDay           | int    | Stop time of the barrier, in milliseconds.  |
| startTimeStamp          | int    | Start timestamp.                            |
| stopTimeStamp           | int    | Stop timestamp.                             |
| dayOfWeek               | int    | Day of a week.                              |
| startTimeOfSpecifiedDay | int    | Start time of the barrier, in milliseconds. |
| stopTimeOfSpecifiedDay  | int    | Stop time of the barrier, in milliseconds.  |
| inTimeCategory          | int    | Time.                                       |
| timeZoneId              | String | Sets the time zone.                         |

##### Constants

- For more datailed information, please refer to Official Huawei Awareness Flutter Plugin Documentation.

##### Constructor Summary

| Constructor                                                  | Description                           |
| ------------------------------------------------------------ | ------------------------------------- |
| TimeBarrier.inSunriseOrSunsetPeriod(String barrierLabel, int timeInstant, int startTimeOffset, int stopTimeOffset) | Sunrise and sunset barrier.           |
| TimeBarrier.duringPeriodOfDay(String barrierLabel, int startTimeOfDay, int stopTimeOfDay, String timeZoneId) | Barrier of a specified time period.   |
| TimeBarrier.duringTimePeriod(String barrierLabel, int startTimeStamp, int stopTimeStamp) | Time period barrier.                  |
| TimeBarrier.duringPeriodOfWeek(String barrierLabel, int dayOfWeek, int startTimeOfSpecifiedDay, int stopTimeOfSpecifiedDay, String timeZoneId) | Barrier for a specific day of a week. |
| TimeBarrier.inTimeCategory(String barrierLabel, int inTimeCategory) | Time barrier.                         |

- **android.permission.ACCESS_FINE_LOCATION** permission is required for **TimeBarrier.inSunriseOrSunsetPeriod**, **TimeBarrier.duringPeriodOfDay** and **TimeBarrier.duringPeriodOfWeek** barriers. 

##### Constructors

###### TimeBarrier.inSunriseOrSunsetPeriod(String barrierLabel, int timeInstant, int startTimeOffset, int stopTimeOffset)

After this barrier is added, when the time is in the specified time period using the sunrise or sunset time as the benchmark, the barrier status is **True**. Otherwise, the barrier status is **False**.

**Parameters**

| Name            | Type   | Description                                                  |
| --------------- | ------ | ------------------------------------------------------------ |
| barrierLabel    | String | Barrier label.                                               |
| timeInstant     | int    | Sunrise or sunset.                                           |
| startTimeOffset | int    | Start time offset of the time barrier. The unit is millisecond. The value range is milliseconds from –24 hours to +24 hours. The value must be less than the value of **stopTimeOffset**. |
| stopTimeOffset  | int    | Stop time offset of the time barrier. The unit is millisecond. The value range is milliseconds from –24 hours to +24 hours. The value must be greater than the value of **startTimeOffset**. |

###### TimeBarrier.duringPeriodOfDay(String barrierLabel, int startTimeOfDay, int stopTimeOfDay, String timeZoneId)

After this barrier is added, when the time is in the specified time period of a specified time zone, the barrier status is **True**. Otherwise, the barrier status is **False**.  

**Parameters**

| Name           | Type   | Description                                                  |
| -------------- | ------ | ------------------------------------------------------------ |
| barrierLabel   | String | Barrier label.                                               |
| startTimeOfDay | int    | Start time of the barrier, in milliseconds. The value **0** indicates 00:00. The maximum value is the number of milliseconds of 24 hours. |
| stopTimeOfDay  | int    | Stop time of the barrier, in milliseconds. The value of **stopTimeOfDay** must be greater than or equal to the value of **startTimeOfDay**. |
| timeZoneId     | String | Time zone specified by you. If the time zone does not exist, the time zone of the area where the user is located is used. |

###### TimeBarrier.duringTimePeriod(String barrierLabel, int startTimeStamp, int stopTimeStamp)

After this barrier is added, when the time is in the specified time period, the barrier status is **True**. Otherwise, the barrier status is **False**.

**Parameters**

| Name           | Type   | Description                                                  |
| -------------- | ------ | ------------------------------------------------------------ |
| barrierLabel   | String | Barrier label.                                               |
| startTimeStamp | int    | Start timestamp. The value must be greater than or equal to **0**. |
| stopTimeStamp  | int    | Stop timestamp. The value of **stopTimeStamp** must be greater than or equal to that of **startTimeStamp**. |

###### TimeBarrier.duringPeriodOfWeek(String barrierLabel, int dayOfWeek, int startTimeOfSpecifiedDay, int stopTimeOfSpecifiedDay, String timeZoneId)

After this barrier is added, when the time is in the specified time period on a day of a week in a specified time zone, the barrier status is **True**. Otherwise, the barrier status is **False**. 

**Parameters**

| Name                    | Type   | Description                                                  |
| ----------------------- | ------ | ------------------------------------------------------------ |
| barrierLabel            | String | Barrier label.                                               |
| dayOfWeek               | int    | Day of a week.                                               |
| startTimeOfSpecifiedDay | int    | Start time of the barrier, in milliseconds. The value **0** indicates 00:00. The maximum value is the number of milliseconds of 24 hours. |
| stopTimeOfSpecifiedDay  | int    | Stop time of the barrier, in milliseconds. The value of **stopTimeOfSpecifiedDay** must be greater than or equal to the value of **startTimeOfSpecifiedDay**. |
| timeZoneId              | String | Sets the time zone. If the time zone does not exist, the time zone of the area where the user is located is used. |

###### TimeBarrier.inTimeCategory(String barrierLabel, int inTimeCategory)

After this barrier is added, the barrier status is **True** for the specified time. Otherwise, the barrier status is **False**.

**Parameters**

| Name           | Type   | Description    |
| -------------- | ------ | -------------- |
| barrierLabel   | String | Barrier label. |
| inTimeCategory | int    | Time.          |

#### WiFiBarrier

Wi-Fi barriers, including the keeping (Wi-Fi status keeping), connecting (Wi-Fi connection), disconnecting (Wi-Fi disconnection), enabling (WLAN enabling), and disabling (WLAN disabling) barriers. 

##### Properties

| Name         | Type   | Description                                   |
| ------------ | ------ | --------------------------------------------- |
| barrierLabel | String | Barrier label.                                |
| wifiStatus   | int    | Wi-Fi status.                                 |
| bssid        | String | (BSSID) Physical address of the Wi-Fi source. |
| ssid         | String | (SSID) Name of the Wi-Fi source.              |

##### Constructor Summary

| Constructor                                                  | Description                                   |
| ------------------------------------------------------------ | --------------------------------------------- |
| WiFiBarrier.keeping(String barrierLabel, int wifiStatus, String bssid, String ssid) | Wi-Fi status barrier named **keeping**.       |
| WiFiBarrier.connecting(String barrierLabel, String bssid, String ssid) | Wi-Fi status barrier named **connecting**.    |
| WiFiBarrier.disconnecting(String barrierLabel, String bssid, String ssid) | Wi-Fi status barrier named **disconnecting**. |
| WiFiBarrier.enabling(String barrierLabel)                    | Wi-Fi status barrier named **enabling**.      |
| WiFiBarrier.disabling(String barrierLabel)                   | Wi-Fi status barrier named **disabling**.     |

##### Constructors

###### WiFiBarrier.keeping(String barrierLabel, int wifiStatus, String bssid, String ssid)

After you add this barrier for a Wi-Fi state such as **Enabled**, **Disabled**, **Connected**, or **Disconnected**, if the Wi-Fi keeps in this state, the barrier status is **True** and a barrier event is reported.

**Parameters**

| Name         | Type   | Description                                                  |
| ------------ | ------ | ------------------------------------------------------------ |
| barrierLabel | String | Barrier label.                                               |
| wifiStatus   | int    | Wi-Fi status.                                                |
| bssid        | String | If the value of **wifiStatus** is **Connected** or **Disabled**, the BSSID (physical address of the Wi-Fi source) of the Wi-Fi barrier can be specified. The value **null** indicates any BSSID. If the value of **wifiStatus** is **Enabled** or **Disabled**, the BSSID is invalid. |
| ssid         | String | If the value of **wifiStatus** is **Connected** or **Disconnected**, the SSID (name of the Wi-Fi source) of the Wi-Fi barrier can be specified. The value **null** indicates any SSID. If the value of **wifiStatus** is **Enabled** or **Disabled**, the SSID is invalid. |

###### WiFiBarrier.connecting(String barrierLabel, String bssid, String ssid)

When a device connects to a Wi-Fi, the barrier status is **True** and a barrier event is reported. The value automatically changes to **False** 5s later. If GPS is disabled on the device, the barrier status cannot be correctly determined.

**Parameters**

| Name         | Type   | Description                                                  |
| ------------ | ------ | ------------------------------------------------------------ |
| barrierLabel | String | Barrier label.                                               |
| bssid        | String | BSSID (physical address of the Wi-Fi source) of a specific Wi-Fi. The value **null** indicates any BSSID. |
| ssid         | String | SSID (name of the Wi-Fi source) of a specific Wi-Fi. The value **null** indicates any SSID. |

###### WiFiBarrier.disconnecting(String barrierLabel, String bssid, String ssid)

When a device disconnects from a Wi-Fi, the barrier status is **True** and a barrier event is reported. The value automatically changes to **False** 5s later.

**Parameters**

| Name         | Type   | Description                                                  |
| ------------ | ------ | ------------------------------------------------------------ |
| barrierLabel | String | Barrier label.                                               |
| bssid        | String | BSSID (physical address of the Wi-Fi source) of a specific Wi-Fi. The value **null** indicates any BSSID. |
| ssid         | String | SSID (name of the Wi-Fi source) of a specific Wi-Fi. The value **null** indicates any SSID. |

###### WiFiBarrier.enabling(String barrierLabel)

When a device enables WLAN, the barrier status is **True** and a barrier event is reported. The value automatically changes to **False** 5s later.  

**Parameters**

| Name         | Type   | Description    |
| ------------ | ------ | -------------- |
| barrierLabel | String | Barrier label. |

###### WiFiBarrier.disabling(String barrierLabel)

When a device disables WLAN, the barrier status is **True** and a barrier event is reported. The value automatically changes to **False** 5s later.

**Parameters**

| Name         | Type   | Description    |
| ------------ | ------ | -------------- |
| barrierLabel | String | Barrier label. |

#### Barrier

Registered barrier information. 

##### Properties

| Name          | Type          | Description     |
| ------------- | ------------- | --------------- |
| barrierLabel  | String        | Barrier label.  |
| barrierStatus | BarrierStatus | Barrier status. |

##### Constructor Summary

| Constructor                                               | Description          |
| --------------------------------------------------------- | -------------------- |
| Barrier(String barrierLabel, BarrierStatus barrierStatus) | Default constructor. |

##### Constructors

###### Barrier(String barrierLabel, BarrierStatus barrierStatus)

Constructor for **Barrier** object. 

**Parameters**

| Name          | Type          | Description     |
| ------------- | ------------- | --------------- |
| barrierLabel  | String        | Barrier label.  |
| barrierStatus | BarrierStatus | Barrier status. |

#### BarrierStatus

The barrier status includes the barrier label, current status, previous status, and last status update time.

##### Properties

| Name                  | Type   | Description                                      |
| --------------------- | ------ | ------------------------------------------------ |
| barrierLabel          | String | Key value that uniquely identifies a barrier.    |
| lastBarrierUpdateTime | int    | The timestamp of the last barrier status change. |
| lastStatus            | int    | The previous barrier status.                     |
| presentStatus         | int    | The current barrier status.                      |

##### Constants

| Constant | Type | Value | Description                 |
| -------- | ---- | :---: | --------------------------- |
| True     | int  |   1   | Barrier status **TRUE**.    |
| False    | int  |   0   | Barrier status **FALSE**.   |
| Unknown  | int  |   2   | Barrier status **UNKNOWN**. |

##### Constructor Summary

| Constructor                                                  | Description          |
| ------------------------------------------------------------ | -------------------- |
| BarrierStatus(String barrierLabel, int lastBarrierUpdateTime, int lastStatus, int presentStatus) | Default constructor. |

##### Constructors

###### BarrierStatus(String barrierLabel, int lastBarrierUpdateTime, int lastStatus, int presentStatus)

Constructor for **BarrierStatus** object.

**Parameters**

| Name                  | Type   | Description                                      |
| --------------------- | ------ | ------------------------------------------------ |
| barrierLabel          | String | Key value that uniquely identifies a barrier.    |
| lastBarrierUpdateTime | int    | The timestamp of the last barrier status change. |
| lastStatus            | int    | The previous barrier status.                     |
| presentStatus         | int    | The current barrier status.                      |

#### BarrierDeleteRequest

Deletes a barrier based on the key value. 

##### Constructor Summary

| Constructor                                         | Description                                                  |
| --------------------------------------------------- | ------------------------------------------------------------ |
| BarrierDeleteRequest.all()                          | Creates a **BarrierDeleteRequest** object that deletes all registered barriers. |
| BarrierDeleteRequest.withLabel(String barrierLabel) | Creates a **BarrierDeleteRequest** object that deletes the specified barrier. |

##### Constructors

###### BarrierDeleteRequest.all()

Creates a **BarrierDeleteRequest** object that deletes all registered barriers. 

###### BarrierDeleteRequest.withLabel(String barrierLabel)

Creates a **BarrierDeleteRequest** object that deletes the specified barrier.

**Parameters**

| Name         | Type   | Description    |
| ------------ | ------ | -------------- |
| barrierLabel | String | Barrier label. |

#### BarrierQueryRequest

Barrier query request.

##### Constructor Summary

| Constructor                                                | Description                                                  |
| ---------------------------------------------------------- | ------------------------------------------------------------ |
| BarrierQueryRequest.all()                                  | Creates a **BarrierQueryRequest** object that queries all registered barriers. |
| BarrierQueryRequest.forBarriers(List\<String> barrierKeys) | Creates a **BarrierQueryRequest** object that queries the specified barriers. |

##### Constructors

###### BarrierQueryRequest.all()

Creates a **BarrierQueryRequest** object that queries all registered barriers.

###### BarrierQueryRequest.forBarriers(List\<String> barrierKeys)

Creates a **BarrierQueryRequest** object that queries the specified barriers.

**Parameters**

| Name        | Type          | Description     |
| ----------- | ------------- | --------------- |
| barrierKeys | List\<String> | Barrier labels. |

#### BarrierQueryResponse

Barrier query response.

##### Properties

| Name     | Type           | Description                  |
| -------- | -------------- | ---------------------------- |
| barriers | List\<Barrier> | List of registered barriers. |

##### Constructor Summary

| Constructor                                   | Description          |
| --------------------------------------------- | -------------------- |
| BarrierQueryResponse(List\<Barrier> barriers) | Default constructor. |

##### Constructors

###### BarrierQueryResponse(List\<Barrier> barriers)

Constructor for **BarrierQueryResponse** object.

**Parameters**

| Name     | Type                    | Description                  |
| -------- | ----------------------- | ---------------------------- |
| barriers | List\<Barrier> barriers | List of registered barriers. |

#### ApplicationResponse

Response to the request for obtaining the app status corresponding to a package, which can be obtained by calling the **getApplicationStatus** method provided by **AwarenessCaptureClient**.

##### Properties

| Name              | Type | Description             |
| ----------------- | ---- | ----------------------- |
| applicationStatus | int  | The application status. |

##### Constructor Summary

| Constructor                                | Description          |
| ------------------------------------------ | -------------------- |
| ApplicationResponse(int applicationStatus) | Default constructor. |

##### Constructors

###### ApplicationResponse(int applicationStatus)

Constructor for **ApplicationResponse** object.

**Parameters**

| Name              | Type | Description             |
| ----------------- | ---- | ----------------------- |
| applicationStatus | int  | The application status. |

#### BeaconResponse

Response to the request for obtaining the beacon status, which can be obtained by calling the **getBeaconStatus** method provided by **AwarenessCaptureClient**. 

##### Properties

| Name    | Type              | Description                       |
| ------- | ----------------- | --------------------------------- |
| beacons | List\<BeaconData> | Beacon device status information. |

##### Constructor Summary

| Constructor                               | Description          |
| ----------------------------------------- | -------------------- |
| BeaconResponse(List\<BeaconData> beacons) | Default constructor. |

##### Constructors

###### BeaconResponse(List\<BeaconData> beacons)

Constructor for **BeaconResponse** object.

**Parameters**

| Name    | Type              | Description                       |
| ------- | ----------------- | --------------------------------- |
| beacons | List\<BeaconData> | Beacon device status information. |

#### BehaviorResponse

Response to the request for obtaining the user behavior, which can be obtained by calling the **getBehavior** method provided by **AwarenessCaptureClient**.

##### Properties

| Name                  | Type                    | Description                                                  |
| --------------------- | ----------------------- | ------------------------------------------------------------ |
| elapsedRealtimeMillis | int                     | Actual time (in milliseconds) used for this detection since startup. |
| time                  | int                     | Timestamp of the current detection.                          |
| mostLikelyBehavior    | DetectedBehavior        | Most likely behavior.                                        |
| probableBehavior      | List\<DetectedBehavior> | Detected behaviors, which are sorted by confidence (most likely first). |

##### Constructor Summary

| Constructor                                                  | Description          |
| ------------------------------------------------------------ | -------------------- |
| BehaviorResponse(int elapsedRealtimeMillis, int time, DetectedBehavior mostLikelyBehavior, List\<DetectedBehavior> probableBehavior) | Default constructor. |

##### Constructors

###### BehaviorResponse(int elapsedRealtimeMillis, int time, DetectedBehavior mostLikelyBehavior, List\<DetectedBehavior> probableBehavior)

Constructor for **BehaviorResponse** object.

**Parameters**

| Name                  | Type                    | Description                                                  |
| --------------------- | ----------------------- | ------------------------------------------------------------ |
| elapsedRealtimeMillis | int                     | Actual time (in milliseconds) used for this detection since startup. |
| time                  | int                     | Timestamp of the current detection.                          |
| mostLikelyBehavior    | DetectedBehavior        | Most likely behavior.                                        |
| probableBehavior      | List\<DetectedBehavior> | Detected behaviors, which are sorted by confidence (most likely first). |

#### BluetoothResponse

Response to the request for obtaining the Bluetooth car stereo status, which can be obtained by calling the **getBluetoothStatus** method provided by **AwarenessCaptureClient**.

##### Properties

| Name            | Type | Description       |
| --------------- | ---- | ----------------- |
| bluetoothStatus | int  | Bluetooth status. |

##### Constructor Summary

| Constructor                            | Description          |
| -------------------------------------- | -------------------- |
| BluetoothResponse(int bluetoothStatus) | Default constructor. |

##### Constructors

###### BluetoothResponse(int bluetoothStatus)

Constructor for **BluetoothResponse** object.

**Parameters**

| Name            | Type | Description       |
| --------------- | ---- | ----------------- |
| bluetoothStatus | int  | Bluetooth status. |

#### CapabilityResponse

Response to the request for obtaining supported capabilities, which can be obtained by calling the **querySupportingCapabilities** method provided by **AwarenessCaptureClient**.

##### Properties

| Name                      | Type       | Description                                                  |
| ------------------------- | ---------- | ------------------------------------------------------------ |
| deviceSupportCapabilities | List\<int> | Status constants of capabilities supported by Awareness Kit on the current device. |

##### Constructor Summary

| Constructor                                              | Description          |
| -------------------------------------------------------- | -------------------- |
| CapabilityResponse(List\<int> deviceSupportCapabilities) | Default constructor. |

##### Constructors

###### CapabilityResponse(List\<int> deviceSupportCapabilities)

Constructor for **CapabilityResponse** object.

**Parameters**

| Name                      | Type       | Description                                                  |
| ------------------------- | ---------- | ------------------------------------------------------------ |
| deviceSupportCapabilities | List\<int> | Status constants of capabilities supported by Awareness Kit on the current device. |

#### DarkModeResponse

Response to the request for obtaining the dark mode status, which can be obtained by calling the **getDarkModeStatus** method provided by **AwarenessCaptureClient**. 

##### Properties

| Name         | Type | Description       |
| ------------ | ---- | ----------------- |
| isDartModeOn | bool | Dark mode status. |

##### Constructor Summary

| Constructor                         | Description          |
| ----------------------------------- | -------------------- |
| DarkModeResponse(bool isDarkModeOn) | Default constructor. |

##### Constructors

###### DarkModeResponse(bool isDarkModeOn)

Constructor for **DarkModeResponse** object.

**Parameters**

| Name         | Type | Description       |
| ------------ | ---- | ----------------- |
| isDarkModeOn | bool | Dark mode status. |

#### HeadsetResponse

Response to the request for obtaining the headset status, which can be obtained by calling the **getHeadsetStatus** method provided by **AwarenessCaptureClient**. 

##### Properties

| Name          | Type | Description     |
| ------------- | ---- | --------------- |
| headsetStatus | int  | Headset status. |

##### Constructor Summary

| Constructor                        | Description          |
| ---------------------------------- | -------------------- |
| HeadsetResponse(int headsetStatus) | Default constructor. |

##### Constructors

###### HeadsetResponse(int headsetStatus)

Constructor for **HeadsetResponse** object.

**Parameters**

| Name          | Type | Description     |
| ------------- | ---- | --------------- |
| headsetStatus | int  | Headset status. |

#### LightIntensityResponse

Response to the request for obtaining the illuminance, which can be obtained by calling the **getLightIntensity** method provided by **AwarenessCaptureClient**.

##### Properties

| Name           | Type   | Description        |
| -------------- | ------ | ------------------ |
| lightIntensity | double | Illuminance value. |

##### Constructor Summary

| Constructor                                   | Description          |
| --------------------------------------------- | -------------------- |
| LightIntensityResponse(double lightIntensity) | Default constructor. |

##### Constructors

###### LightIntensityResponse(double lightIntensity)

Constructor for **LightIntensityResponse** object.

**Parameters**

| Name           | Type   | Description        |
| -------------- | ------ | ------------------ |
| lightIntensity | double | Illuminance value. |

#### LocationResponse

Response to the location query request. Your app can call the **getLocation** method provided by **AwarenessCaptureClient** to obtain the last geographical location response or call the **getCurrentLocation** method to obtain the current geographical location response.

##### Properties

| Name                         | Type   | Description                                                  |
| ---------------------------- | ------ | ------------------------------------------------------------ |
| latitude                     | double | Latitude, in degrees.                                        |
| longitude                    | double | Longitude, in degrees.                                       |
| altitude                     | double | Altitude if available, in meters above the WGS 84 reference ellipsoid. |
| speed                        | double | Speed if it is available, in meters/second over ground.      |
| bearing                      | double | The bearing, in degrees.                                     |
| accuracy                     | double | Estimated horizontal accuracy of this location, radial, in meters. |
| verticalAccuracyMeters       | double | Estimated vertical accuracy of this location, in meters.     |
| bearingAccuracyDegrees       | double | Estimated bearing accuracy of this location, in degrees.     |
| speedAccuracyMetersPerSecond | double | Estimated speed accuracy of this location, in meters per second. |
| time                         | int    | Time in milliseconds since January 1, 1970.                  |
| fromMockProvider             | bool   | Location provider status.                                    |

##### Constructor Summary

| Constructor                                                  | Description          |
| ------------------------------------------------------------ | -------------------- |
| LocationResponse(double latitude, double longitude, double altitude, double speed, double bearing, double accuracy, double verticalAccuracyMeters, double bearingAccuracyDegrees, double speedAccuracyMetersPerSecond, int time, bool fromMockProvider) | Default constructor. |

##### Constructors

###### LocationResponse(double latitude, double longitude, double altitude, double speed, double bearing, double accuracy, double verticalAccuracyMeters, double bearingAccuracyDegrees, double speedAccuracyMetersPerSecond, int time, bool fromMockProvider)  

Constructor for **LocationResponse** object.

**Parameters**

| Name                         | Type   | Description                                                  |
| ---------------------------- | ------ | ------------------------------------------------------------ |
| latitude                     | double | Latitude, in degrees.                                        |
| longitude                    | double | Longitude, in degrees.                                       |
| altitude                     | double | Altitude if available, in meters above the WGS 84 reference ellipsoid. |
| speed                        | double | Speed if it is available, in meters/second over ground.      |
| bearing                      | double | The bearing, in degrees.                                     |
| accuracy                     | double | Estimated horizontal accuracy of this location, radial, in meters. |
| verticalAccuracyMeters       | double | Estimated vertical accuracy of this location, in meters.     |
| bearingAccuracyDegrees       | double | Estimated bearing accuracy of this location, in degrees.     |
| speedAccuracyMetersPerSecond | double | Estimated speed accuracy of this location, in meters per second. |
| time                         | int    | Time in milliseconds since January 1, 1970.                  |
| fromMockProvider             | bool   | Location provider status.                                    |

#### ScreenStatusResponse

Response to the request for obtaining the screen status. You can call the **getScreenStatus** method provided by AwarenessCaptureClient to obtain the response instance of the screen status.

##### Properties

| Name         | Type | Description                         |
| ------------ | ---- | ----------------------------------- |
| screenStatus | int  | Displays screen status information. |

##### Constructor Summary

| Constructor                            | Description          |
| -------------------------------------- | -------------------- |
| ScreenStatusResponse(int screenStatus) | Default constructor. |

##### Constructors

###### ScreenStatusResponse(int screenStatus)

Constructor for **ScreenStatus** object.

**Parameters**

| Name         | Type | Description                         |
| ------------ | ---- | ----------------------------------- |
| screenStatus | int  | Displays screen status information. |

#### TimeCategoriesResponse

Response to the request for obtaining the time, which can be obtained by calling the **getTimeCategories** method provided by **AwarenessCaptureClient**.

##### Properties

| Name           | Type       | Description      |
| -------------- | ---------- | ---------------- |
| timeCategories | List\<int> | Time categories. |

##### Constructor Summary

| Constructor                                       | Description          |
| ------------------------------------------------- | -------------------- |
| TimeCategoriesResponse(List\<int> timeCategories) | Default constructor. |

##### Constructors

###### TimeCategoriesResponse(List\<int> timeCategories)

Constructor for **TimeCategoriesResponse** object. 

**Parameters**

| Name           | Type       | Description      |
| -------------- | ---------- | ---------------- |
| timeCategories | List\<int> | Time categories. |

#### WeatherResponse

Response to the weather query request. You can call the **getWeatherByDevice** method provided by **AwarenessCaptureClient** to obtain the weather of the current location of a device, or call the **getWeatherByPosition** method to obtain the weather of a specified position.

##### Properties

| Name             | Type                 | Description                                                  |
| ---------------- | -------------------- | ------------------------------------------------------------ |
| dailyWeather     | List\<DailyWeather>  | Weather information of the next seven days.                  |
| hourlyWeather    | List\<HourlyWeather> | Weather information in the next 24 hours.                    |
| liveInfo         | List\<LiveInfo>      | The living index of the current day and the next one to two days. |
| aqi              | Aqi                  | The AQI information.                                         |
| weatherSituation | WeatherSituation     | Weather and city information.                                |

##### Constants

- For details please refer to Official Huawei Awareness Flutter Plugin Documentation.

##### Constructor Summary

| Constructor                                                  | Description          |
| ------------------------------------------------------------ | -------------------- |
| WeatherResponse(List\<DailyWeather> dailyWeather, List\<HourlyWeather> hourlyWeather, List\<LiveInfo> liveInfo, Aqi aqi, WeatherSituation weatherSituation) | Default constructor. |

##### Constructors

###### WeatherResponse(List\<DailyWeather> dailyWeather, List\<HourlyWeather> hourlyWeather, List\<LiveInfo> liveInfo, Aqi aqi, WeatherSituation weatherSituation)

Constructor for **WeatherResponse** object.

**Parameters**

| Name             | Type                 | Description                                                  |
| ---------------- | -------------------- | ------------------------------------------------------------ |
| dailyWeather     | List\<DailyWeather>  | Weather information of the next seven days.                  |
| hourlyWeather    | List\<HourlyWeather> | Weather information in the next 24 hours.                    |
| liveInfo         | List\<LiveInfo>      | The living index of the current day and the next one to two days. |
| aqi              | Aqi                  | The AQI information.                                         |
| weatherSituation | WeatherSituation     | Weather and city information.                                |

#### WiFiResponse

Response to the request for obtaining the Wi-Fi status, which can be obtained by calling the **getWifiStatus** method provided by **AwarenessCaptureClient**.

##### Properties

| Name   | Type   | Description               |
| ------ | ------ | ------------------------- |
| status | int    | Wi-Fi status of a device. |
| bssid  | String | Wi-Fi BSSID.              |
| ssid   | String | Wi-Fi SSID.               |

##### Constructor Summary

| Constructor                                         | Description          |
| --------------------------------------------------- | -------------------- |
| WiFiResponse(int status, String bssid, String ssid) | Default constructor. |

##### Constructors

###### WiFiResponse(int status, String bssid, String ssid)

Constructor for **WiFiResponse** object.

**Parameters**

| Name   | Type   | Description               |
| ------ | ------ | ------------------------- |
| status | int    | Wi-Fi status of a device. |
| bssid  | String | Wi-Fi BSSID.              |
| ssid   | String | Wi-Fi SSID.               |

#### BeaconData

Beacon information.

##### Properties

| Name      | Type       | Description          |
| --------- | ---------- | -------------------- |
| beaconId  | String     | Beacon broadcast ID. |
| namespace | String     | Beacon namespace.    |
| type      | String     | Beacon type.         |
| content   | List\<int> | Beacon information.  |

##### Constructor Summary

| Constructor                                                  | Description          |
| ------------------------------------------------------------ | -------------------- |
| BeaconData(String beaconId, String namespace, String type, List\<int> content) | Default constructor. |

##### Constructors

###### BeaconData(String beaconId, String namespace, String type, List\<int> content)

Constructor for **BeaconData** object.

**Parameters**

| Name      | Type       | Description          |
| --------- | ---------- | -------------------- |
| beaconId  | String     | Beacon broadcast ID. |
| namespace | String     | Beacon namespace.    |
| type      | String     | Beacon type.         |
| content   | List\<int> | Beacon information.  |

#### DetectedBehavior

Type and confidence of a detected behavior.

##### Properties

| Name       | Type | Description                                                  |
| ---------- | ---- | ------------------------------------------------------------ |
| confidence | int  | Confidence, indicating the possibility that a user is executing the behavior. The value ranges from 0 to 100. |
| type       | int  | Detected behavior.                                           |

##### Constructor Summary

| Constructor                                | Description          |
| ------------------------------------------ | -------------------- |
| DetectedBehavior(int confidence, int type) | Default constructor. |

##### Constructors

###### DetectedBehavior(int confidence, int type)

Constructor for **DetectedBehavior** object.

**Parameters**

| Name       | Type | Description                                                  |
| ---------- | ---- | ------------------------------------------------------------ |
| confidence | int  | Confidence, indicating the possibility that a user is executing the behavior. The value ranges from 0 to 100. |
| type       | int  | Detected behavior.                                           |

#### WeatherPosition

Request parameter class, which is used to pass address information to obtain weather information. The address information includes six attributes: country, province, city, district, county, and language type.

An address has five attributes: country, province, city, district, and county. The city must be set and other four attributes are optional. For example, if you want to query the weather of London, you can pass only the **city** attribute "**London**" or both the **country** attribute "**United Kingdom**" and **city** attribute "**London**".

The language type is of the locale format. For example, **en_GB** indicates British English. Note that the language type is mandatory and must meet the locale format language code_country/region code.

If the input address information is invalid, the weather information obtained by the getWeatherByPosition(WeatherPosition position) method is empty.

##### Properties

| Name     | Type   | Description                                                  |
| -------- | ------ | ------------------------------------------------------------ |
| country  | String | Country name.                                                |
| province | String | Province name.                                               |
| city     | String | City name, which is mandatory.                               |
| district | String | District name.                                               |
| county   | String | County name.                                                 |
| locale   | String | Language type of the passed address, for example, **zh_CN** or **en_US**. Note that the language type is mandatory and must meet the locale format language code_country/region code. |

##### Constructor Summary

| Constructor                                                  | Description         |
| ------------------------------------------------------------ | ------------------- |
| WeatherPosition(String country, String province, String city, String district, String county, String locale) | Default contructor. |

##### Constructors

###### WeatherPosition(String country, String province, String city, String district, String county, String locale)

Constructor for **WeatherPosition** object. 

**Parameters**

| Name     | Type   | Description                                                  |
| -------- | ------ | ------------------------------------------------------------ |
| country  | String | Country name.                                                |
| province | String | Province name.                                               |
| city     | String | City name, which is mandatory.                               |
| district | String | District name.                                               |
| county   | String | County name.                                                 |
| locale   | String | Language type of the passed address, for example, **zh_CN** or **en_US**. Note that the language type is mandatory and must meet the locale format language code_country/region code. |

#### Aqi

Air quality indexes. The indexes include those about the concentration of carbon monoxide (CO), nitrogen dioxide (NO2), ozone (O3), PM10, PM2.5, and sulphur dioxide (SO2), as well as the AQI. This class supports only data in China.

##### Properties

| Name     | Type | Description                                                  |
| -------- | ---- | ------------------------------------------------------------ |
| aqiValue | int  | AQI information.                                             |
| co       | int  | CO concentration index, which is the average value in 8 hours, in mg/m3. |
| no2      | int  | NO2 concentration index, which is the average value in 1 hour, in μg/m3. |
| o3       | int  | O3 concentration index, which is the average value in 1 hour, in μg/m3. |
| pm10     | int  | PM10 concentration index (the diameter of particles is less than or equal to 10 μm), which is the average value in 24 hours, in μg/m3. |
| pm25     | int  | PM2.5 concentration index (the diameter of particles is less than or equal to 2.5 μm), which is the average value in 24 hours, in μg/m3. |
| so2      | int  | SO2 concentration index, which is the average value in 1 hour, in μg/m3. |

- For details please refer to Official Huawei Awareness Flutter Plugin Documentation.

#### City

City information including the city code, province name, time zone, and city/district name. 

##### Properties

| Name         | Type   | Description                                                  |
| ------------ | ------ | ------------------------------------------------------------ |
| cityCode     | String | Code used in Awareness Kit to identify the state/province, city, county, and town in the world. |
| name         | String | Time zone of the city in Alson format. Example: Asia/shanghai |
| provinceName | String | Province name, which may be set to null.                     |
| timeZone     | String | City/district/town name.                                     |

- For details please refer to Official Huawei Awareness Flutter Plugin Documentation.

#### DailyLiveInfo

Information about a living index on a day. The indexes are about dressing, sports, temperature, car washing, tourism, and UV. This class supports only data in China.

##### Properties

| Name          | Type   | Description                                                  |
| ------------- | ------ | ------------------------------------------------------------ |
| dateTimeStamp | int    | Timestamp of a living index, which is 00:00 of the local location. |
| level         | String | Level of a living index. For example, a dressing index has six levels from 1 to 6. |

- For details please refer to Official Huawei Awareness Flutter Plugin Documentation.

#### DailySituation

Weather conditions in the daytime or at night, including the weather ID, wind speed, wind level, and wind direction.

##### Properties

| Name        | Type   | Description                                                  |
| ----------- | ------ | ------------------------------------------------------------ |
| cnWeatherId | int    | The weather ID. Weather IDs vary with the current weather. For example, **1** indicates sunny, **7** indicates cloudy, and **18** indicates rain. |
| weatherId   | int    | The weather ID. Weather IDs vary with the current weather. For example, **1** indicates sunny, **7** indicates cloudy, and **18** indicates rain. |
| windDir     | String | The wind direction. The options are **NE** (northeast), **E** (east), **SE** (southeast), **S** (south), **SW** (southwest), **W** (west), **N** (north), and **NW** (northwest). |
| windLevel   | int    | The wind level. The value ranges from **0** to **17**. The value **0** indicates a breeze in China and no wind outside China. |
| windSpeed   | int    | Obtains the wind speed (unit: km/h).                         |

- For details please refer to Official Huawei Awareness Flutter Plugin Documentation.

#### DailyWeather

Weather information of the current day and the next six to seven days, including the moonrise, moonset, sunrise, sunset, lowest temperature and highest temperature (Celsius and Fahrenheit), local timestamp in the early morning, month phase, weather in daytime (specified by DailySituation), and weather at night (specified by DailySituation).

##### Properties

| Name           | Type           | Description                                                  |
| -------------- | -------------- | ------------------------------------------------------------ |
| aqiValue       | int            | AQI information.                                             |
| dateTimeStamp  | int            | The timestamp of the weather of a day, which is 00:00 of the local location. |
| maxTempC       | int            | The highest temperature (Celsius) of a day.                  |
| maxTempF       | int            | The highest temperature (Fahrenheit) of a day.               |
| minTempC       | int            | The lowest temperature (Celsius) of a day.                   |
| minTempF       | int            | The lowest temperature (Fahrenheit) of a day.                |
| moonRise       | int            | The moonrise of a day.                                       |
| moonSet        | int            | The moonset of a day.                                        |
| moonPhase      | String         | The Moon phase of a day. The options are **New**, **Waxingcrescent**, **First**, **WaxingGibbous**, **Full**, **WaningGibbous**, **Last**, and **WaningCrescent**. |
| situationDay   | DailySituation | The weather information in the daytime.                      |
| situationNight | DailySituation | The weather information at night.                            |
| sunRise        | int            | The sunrise of a day.                                        |
| sunSet         | int            | The sunset of a day.                                         |

- For details please refer to Official Huawei Awareness Flutter Plugin Documentation.

#### HourlyWeather

Weather information in the current hour and the next 24 hours, including the weather ID, time, temperature (Celsius and Fahrenheit), rainfall probability, and whether it is in the daytime or at night.

##### Properties

| Name            | Type | Description                                                  |
| --------------- | ---- | ------------------------------------------------------------ |
| cnWeatherId     | int  | Weather IDs vary with the current weather. For example, **1** indicates sunny, **7** indicates cloudy, and **18** indicates rain. |
| dateTimeStamp   | int  | The timestamp in the current hour.                           |
| isDayNight      | bool | Status indicates whether it is in the daytime or at night.   |
| rainProbability | int  | The rainfall probability, in percentage.                     |
| tempC           | int  | The current temperature (Celsius).                           |
| tempF           | int  | The current temperature (Fahrenheit).                        |
| weatherId       | int  | Weather IDs vary with the current weather. For example, **1** indicates sunny, **7** indicates cloudy, and **18** indicates rain. |

- For details please refer to Official Huawei Awareness Flutter Plugin Documentation.

#### LiveInfo

Living index level for the day and the next one or two days, including the code and level for the current day and next one to two days. This class supports only data in China.

##### Properties

| Name      | Type                 | Description                                                  |
| --------- | -------------------- | ------------------------------------------------------------ |
| code      | String               | The living index code.                                       |
| levelList | List\<DailyLiveInfo> | Index level information of the current day and the next one to two days. |

- For details please refer to Official Huawei Awareness Flutter Plugin Documentation.

#### Situation

Current weather information. The information includes the weather ID, humidity, atmospheric temperature (Celsius and Fahrenheit), somatosensory temperature (Celsius and Fahrenheit), wind direction, wind level, wind speed, atmospheric pressure, UV intensity, and update time. 

##### Properties

| Name         | Type   | Description                                                  |
| ------------ | ------ | ------------------------------------------------------------ |
| cnWeatherId  | int    | The weather ID. Weather IDs vary with the current weather. For example, **1** indicates sunny, **7** indicates cloudy, and **18** indicates rain. |
| humidity     | String | The humidity, in percentage.                                 |
| pressure     | int    | The atmospheric pressure, in hPa.                            |
| realFeelC    | int    | The somatosensory temperature (Celsius).                     |
| realFeelF    | int    | The somatosensory temperature (Fahrenheit).                  |
| temperatureC | int    | The current atmospheric temperature (Celsius).               |
| temperatureF | int    | The current temperature (Fahrenheit).                        |
| updateTime   | int    | The release time of the weather broadcast.                   |
| uvIndex      | int    | The current UV intensity.                                    |
| weatherId    | int    | The weather ID. Weather IDs vary with the current weather. For example, **1** indicates sunny, **7** indicates cloudy, and **18** indicates rain. |
| windDir      | String | The wind direction. The options are **NE** (northeast), **E** (east), **SE** (southeast), **S** (south), **SW** (southwest), **W** (west), **N** (north), and **NW** (northwest). |
| windSpeed    | int    | The wind speed (unit: km/h).                                 |
| windLevel    | int    | The wind level. The value ranges from **0** to **17**. **0**: no wind |

- For details please refer to Official Huawei Awareness Flutter Plugin Documentation.

#### WeatherSituation

Current weather information, which consists of the current weather information (specified by Situation) and city information (specified by City). 

##### Properties

| Name      | Type      | Description                                                  |
| --------- | --------- | ------------------------------------------------------------ |
| city      | City      | The city information of the current weather.                 |
| situation | Situation | The current weather information. The information includes the weather ID, humidity, atmospheric temperature (Celsius and Fahrenheit), somatosensory temperature (Celsius and Fahrenheit), wind direction, wind level, wind speed, atmospheric pressure, UV intensity, and update time. |

- For details please refer to Official Huawei Awareness Flutter Plugin Documentation.

#### BeaconFilter

Represents filter for beacons.

##### Properties

| Name            | Type      | Description                                                  |
| --------------- | --------- | ------------------------------------------------------------ |
| beaconNamespace | String    | Beacon namespace.                                            |
| beaconType      | String    | Beacon type.                                                 |
| beaconContent   | Uint8List | Beacon context.                                              |
| beaconId        | String    | Beacon broadcast ID. Currently, the Eddystone-UID and iBeacon ID (combination of UUID, major, and minor values) are supported. |

##### Constructor Summary

| Constructor                                                  | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| BeaconFilter.matchByNameType(String beaconNamespace, String beaconType) | Creates a beacon filter based on the beacon namespace and type. |
| BeaconFilter.matchByBeaconContent(String beaconNamespace, String beaconType, Uint8List beaconContent) | Creates a beacon filter based on the specified beacon namespace, type, and content. |
| BeaconFilter.matchByBeaconId(String beaconId)                | Creates a beacon filter based on a specified beacon broadcast ID. |

##### Constructors

###### BeaconFilter.matchByNameType(String beaconNamespace, String beaconType)

Creates a beacon filter based on the beacon namespace and type.

**Parameters**

| Name            | Type   | Description       |
| --------------- | ------ | ----------------- |
| beaconNamespace | String | Beacon namespace. |
| beaconType      | String | Beacon type.      |

###### BeaconFilter.matchByBeaconContent(String beaconNamespace, String beaconType, Uint8List beaconContent)

Creates a beacon filter based on the specified beacon namespace, type, and content.

**Parameters**

| Name            | Type      | Description       |
| --------------- | --------- | ----------------- |
| beaconNamespace | String    | Beacon namespace. |
| beaconType      | String    | Beacon type.      |
| beaconContent   | Uint8List | Beacon context.   |

###### BeaconFilter.matchByBeaconId(String beaconId)

Creates a beacon filter based on a specified beacon broadcast ID.

**Parameters**

| Name     | Type   | Description                                                  |
| -------- | ------ | ------------------------------------------------------------ |
| beaconId | String | Beacon broadcast ID. Currently, the Eddystone-UID and iBeacon ID (combination of UUID, major, and minor values) are supported. |

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

<img src="https://github.com/HMS-Core/hms-flutter-plugin/raw/master/flutter-hms-awareness/.docs/mainPage.jpg" width = 40% height = 40% style="margin:1.5em">

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

Huawei Awareness Kit Flutter Plugin is licensed under [Apache 2.0 license](LICENSE)
