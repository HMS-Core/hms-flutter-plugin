# Huawei Nearby Service Flutter Plugin

---

## Contents

- [1. Introduction](#1-introduction)
- [2. Installation Guide](#2-installation-guide)
    - [Creating a Project in App Gallery Connect](#creating-a-project-in-appgallery-connect)
    - [Configuring the Signing Certificate Fingerprint](#configuring-the-signing-certificate-fingerprint)
    - [Integrating the Flutter Nearby Service Plugin](#integrating-the-flutter-nearby-service-plugin)
- [3. API Reference](#3-api-reference)
  - [Discovery Engine](#discovery-engine)
  - [Transfer Engine](#transfer-engine)
  - [Wifi Share Engine](#wifi-share-engine)
  - [Message Engine](#message-engine)
- [4. Configuration and Description](#4-configuration-and-description)
- [5. Sample Project](#5-sample-project)
- [6. Questions or Issues](#6-questions-or-issues)
- [7. Licensing and Terms](#7-licensing-and-terms)

---

## 1. Introduction

Nearby Data Communication allows devices to easily discover nearby devices and set up communication with them using technologies such as Bluetooth and Wi-Fi. The plugin provides Nearby Connection, Nearby Message, and Nearby Wi-Fi Sharing APIs provided by the **HUAWEI Nearby Service SDK**.

- Nearby Connection

    Discovers devices and sets up secure communication channels with them without connecting to the Internet and transfers byte arrays, files, and streams to them; supports seamless nearby interactions, such as multi-player gaming, real-time collaboration, resource broadcasting, and content sharing.

- Nearby Message

    Allows message publishing and subscription between nearby devices that are connected to the Internet. A subscriber (app) can obtain the message content from the cloud service based on the sharing code broadcast by a publisher (beacon or another app).

- Nearby Wi-Fi Sharing

    Provides the Wi-Fi configuration sharing function to help users connect their own or friends' smart devices to the Wi-Fi network in one-click mode.

## 2. Installation Guide

Before you get started, you must register as a HUAWEI Developer and complete identity verification on the [HUAWEI Developers](https://developer.huawei.com/consumer/en/). For details, please refer to [Register a HUAWEI ID](https://developer.huawei.com/consumer/en/doc/10104).


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

**Step 2:** After completing the configuration, click **OK** (Check mark icon) to save the changes.

### Integrating the Flutter Nearby Service Plugin

**Step 1:** Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) and select your project from **My Projects**. Then go to **Project Settings > Manage APIs** and make sure the **Nearby Service** is enabled.

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
        classpath 'com.huawei.agconnect:agcp:1.4.2.301'
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

- Set your package name in **defaultConfig > applicationId** and set **minSdkVersion** to **21** or higher. Package name must match with the **package_name** entry in the **agconnect-services.json** file. 

  ```gradle
  defaultConfig {
      applicationId "<package_name>"
      minSdkVersion 21
      /*
      * <Other configurations>
      */
  }
  ```

  **Step 6:** Configure the signature in **android** according to the signature file information.

    ```gradle
        android {
            /*
             * <Other configurations>
             */

            signingConfigs {
                config {
                    storeFile file('<keystore_file>')
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
                    /*
                    * <Other configurations>
                    */
                    signingConfig signingConfigs.config
                }
            }
        }
    ```

  **Step 7:** On your Flutter project directory, find and open your **pubspec.yaml** file and add the **huawei_nearbyservice** library to dependencies. For more details please refer to the [Using packages](https://flutter.dev/docs/development/packages-and-plugins/using-packages#dependencies-on-unpublished-packages) document.

  - To download the package from [pub.dev](https://pub.dev/publishers/developer.huawei.com/packages).

    ```yaml
      dependencies:
        huawei_nearbyservice: {library version}
    ```

    **or**

    If you downloaded the package from the HUAWEI Developers, specify the **library path** on your local device.

    ```yaml
      dependencies:
        huawei_nearbyservice:
            # Replace {library path} with actual library path of Huawei Nearby Service Plugin for Flutter.
            path: {library path}
    ```

    - Replace {library path} with the actual library path of the Flutter Nearby Service Plugin. The following are examples:
      - Relative path example: `path: ../huawei_nearbyservice`
      - Absolute path example: `path: D:\Projects\Libraries\huawei_nearbyservice`


    **Step 8:** Run the following command to update the package info.
    ```
    [project_path]> flutter pub get
    ```

    **Step 9:** Import the library to access the methods.

    ```dart
    import 'package:huawei_nearbyservice/huawei_nearbyservice.dart';
    ```

    **Step 10:** Run the following command to start the app.

    ```
    [project_path]> flutter run
    ```
---

## 3. API Reference

### HMSNearby

The plugin class which provides some general methods.

#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
| [getVersion](#static-futurestring-getversion)  | Future\<String\> | Obtains the Nearby Service SDK version number. |
| [equalsMessage](#static-futurebool-equalsmessagemessage-object-message-other)  | Future\<bool\> | Checks whether two Messages are equal on the platform side. |
| [enableLogger](#static-futurevoid-enablelogger)  | Future\<void\> | **Enables** HMS Plugin Method Analytics. |
| [disableLogger](#static-futurevoid-disablelogger) | Future<void\> | **Disables** HMS Plugin Method Analytics. |

#### Methods
##### static Future\<String\> getVersion()
Obtains the Nearby Service SDK version number.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<String> |Nearby Service SDK version number.|

###### Call Example
```dart
String version = await HMSNearby.getVersion();
```
##### static Future\<bool\> equalsMessage(Message object, Message other)
Checks whether two Messages are equal on the platform side.

###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| object | [Message](#Message) | Message to be compared. |
| other | [Message](#Message) | Message to be compared. |

###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<bool> | Whether the messages are equal. |
###### Call Example
```dart
msg = Message(content: utf8.encode("Hello there!"));
msg2 = Message(content: utf8.encode("Hello back!"));
bool equals = HMSNearby.equalsMessage(msg, msg2);
```

##### static Future\<void\> enableLogger()
**Enables** HMS Plugin Method Analytics which is used for sending usage analytics of Nearby Service SDK's methods to improve the service quality.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> |Future result of an execution that returns no value.|
###### Call Example
```dart
HMSNearby.enableLogger();
```
##### static Future\<void\> disableLogger()
**Disables** HMS Plugin Method Analytics which is used for sending usage analytics of Nearby Service SDK's methods to improve the service quality.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> |Future result of an execution that returns no value.|
###### Call Example
```dart
HMSNearby.disableLogger();
```

---
### HMSNearbyApiContext

Provides APIs for setting and obtaining API credentials.

#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
| [instance](#static-hmsnearbyapicontext-get-instance) | HMSNearbyApiContext | Obtains the singleton instance of the class. |
| [setApiKey](#futurevoid-setapikeystring-apikey) | Future\<void\>  | Sets the API credential for your app. |
| [getApiKey](#futurevoid-getapikeystring-apikey) | Future\<void\>  | Obtains the current API credential. |

#### Methods
##### static HMSNearbyApiContext get instance
Obtains the singleton instance of the class.
###### Return Type
| Type        | Description |
|-------------|-------------|
| HMSNearbyApiContext | Singleton instance of the class. |
###### Call Example
```dart
instance = HMSNearbyApiContext.instance;
```
##### Future\<void\> setApiKey(String apiKey) *async*
Sets the API credential for your app.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| apiKey | String | API Credential. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void\> | Future result of an execution that returns no value. |
###### Call Example
```dart
await HMSNearbyApiContext.instance.setApiKey('sample-api-key');
```
##### Future\<String\> getApiKey() *async*
Obtains the current API credential.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<String\> | Current API credential. |
###### Call Example
```dart
String apiKey = await HMSNearbyApiContext.instance.getApiKey();
```
---
### Discovery Engine
This section contains the classes related to the Discovery Engine.
### HMSDiscoveryEngine
An entry class for broadcasting, scanning, and connection. This class implements related methods for these features.
#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
| [instance](#static-hmsdiscoveryengine-get-instance) | HMSDiscoveryEngine | Obtains the singleton instance of the class. |
| [acceptConnect](#futurevoid-acceptconnectstring-endpointid) | Future\<void\> | Accepts a connection. |
| [disconnect](#futurevoid-disconnectstring-endpointid) | Future\<void\> | Disconnects from a remote endpoint. |
| [rejectConnect](#futurevoid-requestconnectstring-name-string-endpointid) | Future\<void\> | Rejects a connection request from a remote endpoint. |
| [requestConnect](#futurevoid-requestconnectstring-name-string-enpointid) | Future\<void\> | Sends a request to connect to a remote endpoint. |
| [startBroadcasting](#futurevoid-startbroadcastingstring-name-string-serviceid-broadcastoption-broadcastoption) | Future\<void\> | Starts broadcasting. |
| [startScan](#futurevoid-startscanstring-serviceid-scanoption-scanoption) | Future\<void\> | Starts to scan for remote endpoints with the specified **serviceId**. |
| [stopBroadcasting](#futurevoid-stopbroadcasting) | Future\<void\> | Stops broadcasting. |
| [stopScan](#futurevoid-stopscan) | Future\<void\> | Stops discovering devices. |
| [disconnectAll](#futurevoid-disconnectall) | Future\<void\> | Disconnects all connections. |
| [connectOnEstablish](#streamconnectonestablishresponse-get-connectonestablish) | Stream\<ConnectOnEstablishResponse\> | Returns a stream that fires events when a connection has been established and both ends need to confirm whether to accept the connection. |
| [connectOnResult](#streamconnectonresultresponse-get-connectonresult) | Stream\<ConnectOnResultResponse\> | Returns a stream that fires events when either end accepts or rejects the connection. |
| [connectOnDisconnected](#streamstring-get-connectondisconnected) | Stream\<String\> | Returns a stream that fires events when the remote endpoint disconnects or the connection is unreachable. |
| [scanOnFound](#streamscanonfoundresponse-get-scanonfound) | Stream\<ScanOnFoundResponse\> | Returns a stream that fires events when an endpoint is discovered. |
| [scanOnLost](#streamstring-get-scanonlost) | Stream\<String\> | Returns a stream that fires events when an endpoint is no longer discoverable. |
#### Methods
##### static HMSDiscoveryEngine get instance
Obtains the singleton instance of the class.
###### Return Type
| Type        | Description |
|-------------|-------------|
| HMSDiscoveryEngine | Singleton instance of the class. |
###### Call Example
```dart
instance = HMSDiscoveryEngine.instance;
```
##### Future\<void\> acceptConnect(String endpointId)
Accepts a connection. This API must be called before data transmission. If the connection request is not accepted within 8 seconds, the connection fails and needs to be re-initiated.
- STATUS_SUCCESS: The connection is accepted.
- STATUS_ALREADY_CONNECTED: The app has already been connected to the remote endpoint.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| endpointId | String | ID of the remote endpoint. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> | Future result of an execution that returns no value. Throws platform exception otherwise.|
###### Call Example
```dart
await HMSDiscoveryEngine.instance.acceptConnect('com.example.myapplication');
```
##### Future\<void\> disconnect(String endpointId)
Disconnects from a remote endpoint. Once this API is called, this endpoint cannot send or receive data.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| endpointId | String | ID of the remote endpoint. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> |Future result of an execution that returns no value.|
###### Call Example
```dart
await HMSDiscoveryEngine.instance.disconnect('com.example.myapplication');
```
##### Future\<void\> rejectConnect(String endpointId)
Rejects a connection request from a remote endpoint.
- STATUS_SUCCESS: The connection is successfully rejected.
- STATUS_ALREADY_CONNECTED: The app has already been connected to the remote endpoint.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| endpointId | String | ID of the remote endpoint. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> | Future result of an execution that returns no value. Throws platform exception otherwise. |
###### Call Example
```dart
await HMSDiscoveryEngine.instance.rejectConnect('com.example.myapplication');
```
##### Future\<void\> requestConnect({String name, String endpointId})
Sends a request to connect to a remote endpoint.
- STATUS_SUCCESS: The connection request is sent.
- STATUS_ALREADY_CONNECTED: The app has already been connected to the remote endpoint.
- STATUS_BLUETOOTH_OPERATION_FAILED: The connection failed due to a Bluetooth error.
- STATUS_FAILURE: The connection failed due to another reason.
###### Parameters
| Parameter   | Type        | Description |
|-------------|-------------|-------------|
| name | String | Local endpoint name. |
| endpointId | String | ID of the remote endpoint. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> |Future result of an execution that returns no value. Throws platform exception otherwise.|
###### Call Example
```dart
await HMSDiscoveryEngine.instance
          .requestConnect(name: 'endpointName', endpointId: 'com.example.myapplication');
```
##### Future\<void\> startBroadcasting({String name, String serviceId, BroadcastOption broadcastOption})
Starts broadcasting. The result codes are described as follows:
- STATUS_SUCCESS: Broadcasting started successfully.
- STATUS_ALREADY_BROADCASTING: Broadcasting is going on.
- STATUS_API_DISORDER: API calls are out of order.
- STATUS_MISSING_PERMISSION_ACCESS_COARSE_LOCATION: The location permission is missing.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| name | String | Local endpoint name. |
| serviceId | String | Service ID. The app package name is recommended. |
| broadcastOption | String | Broadcasting options specified in the connection policy. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> |Future result of an execution that returns no value. Throws platform exception otherwise.|
###### Call Example
```dart
await HMSDiscoveryEngine.instance.startBroadcasting(
    name: "MY-SERVICE",
    serviceId: "com.example.myapplication",
    broadcastOption: BroadcastOption(DiscoveryPolicy.p2p),
);
```
##### Future\<void\> startScan({String serviceId, ScanOption scanOption})
Starts to scan for remote endpoints with the specified service ID. The result codes are described as follows:
- STATUS_SUCCESS: Scanning started successfully.
- STATUS_ALREADY_SCANNING: The app has discovered the service.
- STATUS_API_DISORDER: API calls are out of order.
- STATUS_MISSING_PERMISSION_ACCESS_COARSE_LOCATION: The location permission is missing.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| serviceId | String | Service ID. The app package name is recommended. |
| scanOption | [ScanOption](#scanoption) | Scanning options specified in the connection policy. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> |Future result of an execution that returns no value. Throws platform exception otherwise.|
###### Call Example
```dart
 await HMSDiscoveryEngine.instance.startScan(
          serviceId: "com.example.myapplication", scanOption: ScanOption(DiscoveryPolicy.p2p));
```
##### Future\<void\> stopBroadcasting()
Stops broadcasting.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> |Future result of an execution that returns no value.|
###### Call Example
```dart
 await HMSDiscoveryEngine.instance.stopBroadcasting();
```
##### Future\<void\> stopScan()
Stops discovering devices.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> |Future result of an execution that returns no value.|
###### Call Example
```dart
 await HMSDiscoveryEngine.instance.stopScan();
```
##### Future\<void\> disconnectAll()
Disconnects all connections.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> |Future result of an execution that returns no value.|
###### Call Example
```dart
 await HMSDiscoveryEngine.instance.disconnectAll();
```
##### Stream\<ConnectOnEstablishResponse\> get connectOnEstablish
Returns a stream that fires events when a connection has been established and both ends need to confirm whether to accept the connection.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Stream\<ConnectOnEstablishResponse\> | A stream that fires events when a connection has been established and both ends need to confirm whether to accept the connection. |
###### Call Example
```dart
 HMSDiscoveryEngine.instance.connectOnEstablish
    .listen((ConnectOnResultResponse response) {
  // Perform operations
});
```
##### Stream\<ConnectOnResultResponse\> get connectOnResult
Returns a stream that fires events when either end accepts or rejects the connection.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Stream\<[ConnectOnResultResponse](#connectonresultresponse)\> | A stream that fires events when either end accepts or rejects the connection. **ConnectOnResultResponse** indicates whether the remote point accepts or rejects the connection. You can call the **connectResult.statusCode** property of the ConnectOnResultResponse class to obtain the status code STATUS_SUCCESS or STATUS_CONNECT_REJECTED. |
###### Call Example
```dart
 HMSDiscoveryEngine.instance.connectOnResult
    .listen((ConnectOnResultResponse response) {
  // Perform operations
});
```
##### Stream\<String\> get connectOnDisconnected
Returns a stream that fires events when the remote endpoint disconnects or the connection is unreachable.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Stream\<String\> | A stream that fires events when the remote endpoint disconnects or the connection is unreachable. |
###### Call Example
```dart
 HMSDiscoveryEngine.instance.connectOnDisconnected
    .listen((String endpoint) {
  // Perform operations
});
```
##### Stream\<ScanOnFoundResponse\> get scanOnFound
Returns a stream that fires events when an endpoint is discovered.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Stream\<ScanOnFoundResponse\> | A stream that fires events when an endpoint is discovered. **ScanOnFoundResponse** indicates the ID of the remote endpoint and information about the discovered endpoint. |
###### Call Example
```dart
 HMSDiscoveryEngine.instance.scanOnFound
        .listen((ScanOnFoundResponse response) {
      // Perform operations
    });
```
##### Stream\<String\> get scanOnLost 
Returns a stream that fires events when an endpoint is no longer discoverable. The method applies only to endpoints for which [scanOnFound](#streamscanonfoundresponse-get-scanonfound) is called.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Stream\<String\> | A stream that fires events when an endpoint is discovered. The string value is the ID of the remote endpoint. |
###### Call Example
```dart
 HMSDiscoveryEngine.instance.scanOnLost
        .listen((ScanOnFoundResponse response) {
      // Perform operations
    });
```
---
### BleSignal
Obtains the BLE signal.
#### Constants
|Name         | Type        | Description | Value       |
|-------------|-------------|-------------|-------------|
| bleUnknownTxPower | int | Unknown transmit power level. | 0x80 |

#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| rssi | final int | Received signal strength in dBm. The value range is [–127,127]. |
| txPower | final int | Transmit power from 1 m away, in dBm. |

#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| BleSignal({int rssi, int txPower}) | BleSignal constructor. |
| BleSignal.fromMap(Map\<String, dynamic> map) | Creates an instance of the class from a provided Map object. | 

#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [toMap](#ble-tomap) | Map\<String, dynamic> | Converts an instance of the class into a map object. |

#### Constructors
##### BleSignal({int rssi, int txPower})
Constructs a BleSignal instance. For parameter descriptions, see class properties.
##### factory BleSignal.fromMap(Map\<dynamic, dynamic> map)
Creates an instance of the class from a provided Map object.
#### Methods
##### <a name="ble-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
signal = BleSignal({rssi: 13, txPower: 35});
Map<String, dynamic> map = signal.toMap();
```
---
### BroadcastOption
Obtains options for broadcasting.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| policy | final DiscoveryPolicy | The current policy of the BroadcastOption object. |

#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| BroadcastOption(DiscoveryPolicy policy) | BroadcastOption constructor. |
| BroadcastOption.fromMap(Map\<dynamic, dynamic> map) | Creates an instance of the class from a provided Map object. | 

#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [equals](#broadcast-equals) | bool | Checks whether any other object is the same as this object. |
| [toMap](#broadcast-tomap) | Map\<String, dynamic> | Converts an instance of the class into a map object. |

#### Constructors
##### BroadcastOption(DiscoveryPolicy policy)
Constructs a BroadcastOption instance. For parameter descriptions, see class properties.
##### factory BroadcastOption.fromMap(Map\<dynamic, dynamic> map)
Creates an instance of the class from a provided Map object.
#### Methods
##### <a name="broadcast-equals"></a> bool equals(object) 
Checks whether any other object is the same as this object.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| object | dynamic | Object to be compared. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| bool | Whether two objects are equal. |
###### Call Example
```dart
bool equals = BroadcastOption(DiscoveryPolicy.p2p).equals(object);
```
##### <a name="broadcast-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
option = BroadcastOption(DiscoveryPolicy.p2p);
Map<String, dynamic> map = option.toMap();
```
---
### ConnectInfo
Obtains the information about a connection.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| endpointName | final String | The name of the remote endpoint. |
| authCode | final String | The symmetric authentication codes from both ends. |
| isRemoteConnect | final bool | If the connection request is initiated by the remote endpoint, **true**. Otherwise, **false**. |
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| ConnectInfo({String endpointName, String authCode, bool isRemoteConnect}) | ConnectInfo constructor. |
| ConnectInfo.fromMap(Map\<dynamic, dynamic> map) | Creates an instance of the class from a provided Map object. | 
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [toMap](#connectinfo-tomap) | Map\<String, dynamic> | Converts an instance of the class into a map object. |
#### Constructors
##### ConnectInfo({String endpointName, String authCode, bool isRemoteConnect})
Constructs a ConnectInfo instance. For parameter descriptions, see class properties.
##### factory ConnectInfo.fromMap(Map\<dynamic, dynamic> map)
Creates an instance of the class from a provided Map object.
#### Methods
##### <a name="connectinfo-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
info = ConnectInfo({endpointName: 'name', authCode: 'code', isRemoteConnect: true});
Map<String, dynamic> map = info.toMap();
```
---
### ConnectResult
Returns the connection result.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| statusCode | final int | The connection status code, which can be STATUS_SUCCESS or STATUS_CONNECT_REJECTED. |
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| ConnectResult(int statusCode) | ConnectResult constructor. |
| ConnectResult.fromMap(Map\<dynamic, dynamic> map) | Creates an instance of the class from a provided Map object. | 
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [toMap](#connectresult-tomap) | Map\<String, dynamic> | Converts an instance of the class into a map object. |
#### Constructors
##### ConnectResult(int statusCode)
Constructs a ConnectInfo instance. For parameter descriptions, see class properties.
##### factory ConnectResult.fromMap(Map\<dynamic, dynamic> map)
Creates an instance of the class from a provided Map object.
#### Methods
##### <a name="connectresult-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
result = ConnectResult(8010);
Map<String, dynamic> map = result.toMap();
```
---
### DiscoveryPolicy
Obtains the policy used for nearby device broadcasting and scanning.
#### Constants
|Name         | Type        | Description | Value       |
|-------------|-------------|-------------|-------------|
| mesh | DiscoveryPolicy | Point-to-point connection policy, which supports an M-to-N connection topology. | MESH |
| p2p | DiscoveryPolicy | Point-to-point connection policy, which supports a 1-to-1 connection topology. | P2P |
| star | DiscoveryPolicy | Point-to-point connection policy, which supports a 1-to-N connection topology. | STAR |
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [equals](#discoverypolicy-equals) | bool | Checks whether any other object is the same as this object. |
| [toString](#discoverypolicy-tostring) | String | Converts a policy into a readable character string. |
| [toMap](#discoverypolicy-tomap) | Map\<String, dynamic> | Converts an instance of the class into a map object. |
#### Methods
##### <a name="discoverypolicy-equals"></a> bool equals(object) 
Checks whether any other object is the same as this object.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| object | dynamic | Object to be compared. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| bool | Whether two objects are equal. |
###### Call Example
```dart
bool equals = DiscoveryPolicy.p2p.equals(object);
```
##### <a name="discoverypolicy-tostring"></a> @override String toString()
Converts a policy into a readable character string.
###### Return Type
| Type        | Description |
|-------------|-------------|
| String | A policy converted to a readable character string. |
###### Call Example
```dart
String desc = DiscoveryPolicy.p2p.toString();
```
##### <a name="discoverypolicy-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
Map<String, dynamic> map = DiscoveryPolicy.p2p.toMap();
```
---
### Distance
Provides distance information.
#### Constants
|Name         | Type        | Description | Value       |
|-------------|-------------|-------------|-------------|
| precisionLow | int | Precision of the distance estimated based on the BLE signal strength. | 1 |
| unknown | Distance | Unknown distance. | precision: 1, meters: double.nan |
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| precision | int | Precision of the estimated instance. |
| meters | double | Estimated distance, in m. |
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| Distance({int precision, double meters}) | Distance constructor. |
| Distance.fromMap(Map\<String, dynamic> map) | Creates an instance of the class from a provided Map object. | 
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [toMap](#distance-tomap) | Map\<String, dynamic> | Converts an instance of the class into a map object. |
#### Constructors
##### Distance({int precision, double meters})
Constructs a Distance instance. For parameter descriptions, see class properties.
##### Distance.fromMap(Map\<String, dynamic> map)
Creates an instance of the class from a provided Map object.
#### Methods
##### <a name="distance-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
Map<String, dynamic> map = Distance.unknown.toMap();
```
---
### ScanEndpointInfo
Obtains the information about the discovered endpoint.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| serviceId | final String | Unique ID of the app, which is usually the app package name. |
| name | final String | Name of the discovered endpoint. |
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| ScanEndpointInfo({String serviceId, String name}) | ScanEndpointInfo constructor. |
| ScanEndpointInfo.fromMap(Map\<dynamic, dynamic> map) | Creates an instance of the class from a provided Map object. | 
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [toMap](#scanendpointinfo-tomap) | Map\<String, dynamic> | Converts an instance of the class into a map object. |
#### Constructors
##### ScanEndpointInfo(int statusCode)
Constructs a ScanEndpointInfo instance. For parameter descriptions, see class properties.
##### factory ScanEndpointInfo.fromMap(Map\<dynamic, dynamic> map)
Creates an instance of the class from a provided Map object.
#### Methods
##### <a name="scanendpointinfo-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
info = ScanEndpointInfo({serviceId: 'name', name: 'code'});
Map<String, dynamic> map = info.toMap();
```
---
### ScanOption
Obtains options for scanning devices.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| policy | final DiscoveryPolicy | The current policy of the ScanOption object. |
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| ScanOption(DiscoveryPolicy policy) | ScanOption constructor. |
| ScanOption.fromMap(Map\<dynamic, dynamic> map) | Creates an instance of the class from a provided Map object. | 
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [equals](#scanoption-equals) | bool | Checks whether any other object is the same as this object. |
| [toMap](#scanoption-tomap) | Map\<String, dynamic> | Converts an instance of the class into a map object. |
#### Constructors
##### ScanOption(DiscoveryPolicy policy)
Constructs a ScanOption instance. For parameter descriptions, see class properties.
##### factory ScanOption.fromMap(Map\<dynamic, dynamic> map)
Creates an instance of the class from a provided Map object.
#### Methods
##### <a name="scanoption-tomap"></a> bool equals(object)
Checks whether any other object is the same as this object.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| object | dynamic | Object to be compared. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| bool | Whether the other object is equal to this object.|
###### Call Example
```dart
bool equals = ScanOption(DiscoveryPolicy.p2p).equals(object);
```
##### <a name="scanoption-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
option = ScanOption(DiscoveryPolicy.p2p);
Map<String, dynamic> map = option.toMap();
```
---
### ConnectOnEstablishResponse
Response class for the connectOnEstablish events.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| endpointId | final String | ID of the remote endpoint. |
| connectInfo | final [ConnectInfo](#connectinfo) | Connection information. |
#### Constructor Summary 
| Constructor | Description |
|-------------|-------------|
| ConnectOnEstablishResponse({String endpointId, ConnectInfo connectInfo}) | ConnectOnEstablishResponse constructor. |
| ConnectOnEstablishResponse.fromMap(Map\<dynamic, dynamic> map) | Creates an instance of the class from a provided Map object. | 
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [toMap](#connectonstablishresponse-tomap) | Map\<String, dynamic> | Converts an instance of the class into a map object. |
#### Constructors
##### ConnectOnEstablishResponse({String endpointId, ConnectInfo connectInfo})
Constructs a ConnectOnEstablishResponse instance. For parameter descriptions, see class properties.
##### factory ConnectOnEstablishResponse.fromMap(Map\<dynamic, dynamic> map)
Creates an instance of the class from a provided Map object.
#### Methods
##### <a name="connectonstablishresponse-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
response = ConnectOnEstablishResponse.fromMap(map);
Map<String, dynamic> map = response.toMap();
```

---
### ConnectOnResultResponse
Response class for the connectOnResult events.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| endpointId | final String | ID of the remote endpoint. |
| connectResult | final [ConnectResult](#connectresult) | Indicates whether the remote point accepts or rejects the connection. You can call the **statusCode** property of the [ConnectResult](#connectresult) class to obtain the status code **STATUS_SUCCESS** or **STATUS_CONNECT_REJECTED**. |
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| ConnectOnResultResponse({String endpointId, ConnectResult connectResult}) | ConnectOnResultResponse constructor. |
| ConnectOnResultResponse.fromMap(Map\<dynamic, dynamic> map) | Creates an instance of the class from a provided Map object. | 
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [toMap](#connectonresult-tomap) | Map\<String, dynamic> | Converts an instance of the class into a map object. |
#### Constructors
##### ConnectOnResultResponse({String endpointId, ConnectResult connectResult})
Constructs a ConnectOnEstablishResponse instance. For parameter descriptions, see class properties.
##### factory ConnectOnResultResponse.fromMap(Map\<dynamic, dynamic> map)
Creates an instance of the class from a provided Map object.
#### Methods
##### <a name="connectonresult-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
response = ConnectOnResultResponse.fromMap(map);
Map<String, dynamic> map = response.toMap();
```
---
### ScanOnFoundResponse
Response class for the scanOnFound events.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| endpointId | final String | ID of a remote endpoint. |
| scanEndpointInfo | final ScanEndpointInfo | Information about the discovered endpoint. |
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| ScanOnFoundResponse({String endpointId, ScanEndpointInfo scanEndpointInfo}) | ScanOnFoundResponse constructor. |
| ScanOnFoundResponse.fromMap(Map\<dynamic, dynamic> map) | Creates an instance of the class from a provided Map object. | 
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [toMap](#scanonfoundresponse-tomap) | Map\<String, dynamic> | Converts an instance of the class into a map object. |
#### Constructors
##### ScanOnFoundResponse({String endpointId, ConnectInfo connectInfo})
Constructs a ScanOnFoundResponse instance. For parameter descriptions, see class properties.
##### factory ScanOnFoundResponse.fromMap(Map\<dynamic, dynamic> map)
Creates an instance of the class from a provided Map object.
#### Methods
##### <a name="scanonfoundresponse-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
response = ScanOnFoundResponse.fromMap(map);
Map<String, dynamic> map = response.toMap();
```
---
### Transfer Engine
This section contains the classes related to the Transfer Engine.
### HMSTransferEngine
An entry class for data transmission. This class implements related transmission methods.
#### Constants
|Name         | Type        | Description | Value       |
|-------------|-------------|-------------|-------------|
| maxSizeData | int | Maximum length of bytes that can be sent when the sendData method is called. | 32768 |
#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
| [instance](#static-hmstransferengine-get-instance) | HMSTransferEngine | Obtains the singleton instance of the class.|
| [sendData](#senddata) | Future\<void> | Sends data. |
| [sendMultiEndpointData](#sendmultiendpointdata) | Future\<void> | Sends data to multiple endpoints specified in a list. The method is a variation of the preceding method. |
| [cancelDataTransfer](#futurevoid-canceldatatransferint-dataid) | Future\<void> | Cancels data transmission when sending or receiving data. |
| [dataOnReceived](#streamdataonreceivedresponse-get-dataonreceived) | Stream<DataOnReceivedResponse> | Returns a stream that fires events when a TransferData instance is received. |
| [dataOnTransferUpdate](#streamdataontransferupdateresponse-get-dataontransferupdate) | Stream<DataOnTransferUpdateResponse> | Returns a stream that fires events that allows to obtaing the data sending or receiving status. |
#### Methods
##### static HMSTransferEngine get instance
Obtains the singleton instance of the class.
###### Return Type
| Type        | Description |
|-------------|-------------|
| HMSTransferEngine | Singleton instance of the class. |
###### Call Example
```dart
instance = HMSTransferEngine.instance;
```
##### <a name="senddata"></a> Future\<void\> sendData(String endpointId, TransferData data, {bool isUri = false})
Sends data. The method can be called only when a connection has been successfully established. The result codes are as follows:

- STATUS_API_DISORDER: API calls are out of order.
- STATUS_ENDPOINT_UNKNOWN: No connection is set up.
- STATUS_SUCCESS: Data sending started successfully, which does not mean data sending completion. Data sending result can be obtained by calling onDataTransferUpdate.
- STATUS_MISSING_PERMISSION_FILE_READ_WRITE: The read and write permissions on the file are missing.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| endpointId | String | ID of the remote endpoint. |
| data | TransferData | Data to be sent. |
| isUri | bool | Whether the provided data path is a Uri. Applies to **TransferDataFile** and **TransferDataStream**. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> | Future result of an execution that returns no value. Throws platform exception otherwise.|
###### Call Example
```dart
TransferData data = TransferData.fromBytes(utf8.encode('Hello there!'));
await HMSTransferEngine.instance.sendData(_endpointId, data);
```
##### <a name="sendmultiendpointdata"></a> Future\<void\> sendMultiEndpointData(List\<String> endpointIds, TransferData data, {bool isUri = false})
Sends data to multiple endpoints specified in a list. The method is a variation of the preceding method.

The method can be called only when a connection has been successfully established. The result codes are as follows:

- STATUS_API_DISORDER: API calls are out of order.
- STATUS_ENDPOINT_UNKNOWN: No connection is set up.
- STATUS_SUCCESS: Data sending started successfully, which does not mean data sending completion. Data sending result can be obtained by calling onDataTransferUpdate.
- STATUS_MISSING_PERMISSION_FILE_READ_WRITE: The read and write permissions on the file are missing.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| endpointIds | List\<String\> | Remote endpoint ID list. |
| data | TransferData | Data to be sent. |
| isUri | bool | Whether the provided data path is a Uri. Applies to **TransferDataFile** and **TransferDataStream**. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> | Future result of an execution that returns no value. Throws platform exception otherwise.|
###### Call Example
```dart
List<String> _endpointIds = ['app1','app2','app3'];
TransferData data = TransferData.fromBytes(utf8.encode('Hello there!'));
await HMSTransferEngine.instance.sendData(_endpointIds, data);
```
##### Future\<void\> cancelDataTransfer(int dataId)
Cancels data transmission when sending or receiving data.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| dataId | String | ID of the data whose transmission is to be cancelled. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> | Future result of an execution that returns no value. |
###### Call Example
```dart
await HMSTransferEngine.instance.cancelDataTransfer(12345);
```
##### Stream\<DataOnReceivedResponse\> get dataOnReceived
Returns a stream that fires events when a [TransferData](#transferdata) instance is received. 
###### Return Type
| Type        | Description |
|-------------|-------------|
| Stream\<DataOnReceivedResponse\> | A stream that fires events when a TransferData instance is received. **DataOnReceivedResponse** contains the ID of the remote endpoint, the transferred data and an error code if there was an error during data parsing. The error code will be null otherwise.|
###### Call Example
```dart
HMSTransferEngine.instance.dataOnReceived
    .listen((DataOnReceivedResponse response) {
    // Perform operations
});
```
##### Stream\<DataOnTransferUpdateResponse\> get dataOnTransferUpdate
Returns a stream that fires events that allows to obtain the data sending or receiving status. 
###### Return Type
| Type        | Description |
|-------------|-------------|
| Stream\<DataOnTransferUpdateResponse\> | A stream that fires events that allows to obtain the data sending or receiving status. **DataOnTransferUpdateResponse** contains the ID of the remote endpoint and a **TransferStateUpdate** object provides information about transmission status. |
###### Call Example
```dart
HMSTransferEngine.instance.dataOnTransferUpdate
    .listen((DataOnTransferUpdateResponse response) {
    // Perform operations
});
```
---
### TransferData
A payload class. The payload needs to be sent and received in the same type.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| id | int | Unique ID of the payload. |
| type | int | Represents the payload type. |
| bytes | final Uint8List | Byte array. Used if data type is **Bytes**, otherwise null.  |
| file | final TransferDataFile | Obtains a payload of the file type. Used if data type is **File**, otherwise null. |
| stream | final TransferDataStream | Obtains a payload of the stream type. Used if data type is **Stream**, otherwise null. |
| hash | int | Hash value of the data object that was created and transferred **on the platform side**. This value will be returned to Flutter with the callbacks that return information on the transferred data, otherwise is null. |

#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| TransferData({int id, int type, Uint8List bytes, TransferDataStream stream, TransferDataFile file, int hash}) | TransferData constructor. |
| TransferData.fromMap(Map\<dynamic, dynamic> map) | Creates an instance of the class from a provided Map object. |
| TransferData.dataBytesFactory(Uint8List bytes, int id) | Creates a data instance of the byte type. |
| TransferData.dataFileFactory(TransferDataFile file, int id) | Creates a data instance of the file type. |
| TransferData.dataStreamFactory(TransferDataStream stream, int id) | Creates a data instance of the stream type. |
| TransferData.fromBytes(Uint8List bytes) | Creates a payload of the data packet type. |
| TransferData.fromStream({String url, Uint8List content}) | Creates a payload of the stream type. |
| TransferData.fromFile(String filePath, [int size]) | Creates a payload of the file type. |

#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [toMap](#transferdata-tomap) | Map\<dynamic, dynamic> map | Converts an instance of the class into a map object. |
#### Constructors
##### TransferData({int id, int type, Uint8List bytes, TransferDataStream stream, TransferDataFile file, int hash})
Constructs a TransferData instance. For parameter descriptions, see class properties.
##### factory TransferData.fromMap(Map\<dynamic, dynamic> map)
Creates an instance of the class from a provided Map object.
##### factory TransferData.dataBytesFactory(Uint8List bytes, int id)
Creates a data instance of the byte type.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| bytes | Uint8List | Byte array. |
| id | int | Data ID. |

##### factory TransferData.dataFileFactory(TransferDataFile file, int id)
Creates a data instance of the file type.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| file | [TransferDataFile](#transferdatafile) | File to be read. |
| id | int | Data ID. |

##### factory TransferData.dataStreamFactory(TransferDataStream stream, int id)
Creates a data instance of the stream type.

###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| file | [TransferDataStream](#transferdatastream) | Stream data. |
| id | int | Data ID. |

##### factory TransferData.fromBytes(Uint8List bytes)
Creates a payload of the data packet type. Data ID will be randomly generated on the platform side.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| bytes | Uint8List | Byte array. |
##### factory TransferData.fromStream({String url, Uint8List content})
Creates a payload of the stream type. Data ID will be randomly generated on the platform side.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| url | String | URL or Uri for the stream. Has precedence over **content**. |
| content | Uint8List | Byte array content of the stream. Used if **url** is null. |
##### factory TransferData.fromFile(String filePath, [int size])
Creates a payload of the file type. Data ID will be randomly generated on the platform side.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| filePath | String | Path to the file on the device. Can also be a Uri. |
| size | int | File size. Optional. |

###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| file | TransferDataFile | Stream data. |
| id | int | Data ID. |
#### Methods
##### <a name="transferdata-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
TransferData data = TransferData.fromBytes(utf8.encode('Hello there!'));
Map<String, dynamic> map = data.toMap();
```
---
### TransferDataStream
Represents the data stream.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| url | String | URL or URI for the stream to be transferred. Only used when sending data. Meaning, for **TransferData** objects that are returned with **dataOnReceived**, this will always be null. |
| content | Uint8List | Java InputStream converted to a byte array. This is the data that will be transferred when **sendData** is called, if **url** is null. |

#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| TransferDataStream({String url, Uint8List content}) | TransferDataStream constructor. |
| TransferDataStream.fromMap(Map\<dynamic, dynamic> map) | Creates an instance of the class from a provided Map object. |
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [toMap](#transferdatastream-tomap) | Map\<dynamic, dynamic> map | Converts an instance of the class into a map object. |
#### Constructors
##### TransferDataStream({String url, Uint8List content})
Constructs a TransferDataStream instance. For parameter descriptions, see class properties.
##### factory TransferDataStream.fromMap(Map\<dynamic, dynamic> map)
Creates an instance of the class from a provided Map object.
#### Methods
##### <a name="transferdatastream-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
TransferDataStream data = TransferDataStream.fromMap(map);
Map<String, dynamic> map = data.toMap();
```
---
### TransferDataFile
Represents the local file.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| filePath | String | Path to the file on the device. Can also be a Uri. |
| size | int | File size. Specifying this property when sending data will have no effect on the platform size. Actual size of the file will be accessible to Flutter with the response that is returned by the **dataOnReceived** stream. |

#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| TransferDataFile({String filePath, int size}) | TransferDataFile constructor. |
| TransferDataFile.fromMap(Map\<dynamic, dynamic> map) | Creates an instance of the class from a provided Map object. |
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [toMap](#transferdatafile-tomap) | Map\<dynamic, dynamic> map | Converts an instance of the class into a map object. |
#### Constructors
##### TransferDataFile({String filePath, int size})
Constructs a TransferDataFile instance. For parameter descriptions, see class properties.
##### factory TransferDataFile.fromMap(Map\<dynamic, dynamic> map)
Creates an instance of the class from a provided Map object.
#### Methods
##### <a name="transferdatafile-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
TransferDataFile data = TransferDataFile.fromMap(map);
Map<String, dynamic> map = data.toMap();
```
---
### TransferStateUpdate
Updates the data transmission status.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| status | final int | Transmission status. |
| dataId | final int | Data ID. |
| totalBytes | final int | Total number of bytes to transfer. |
| bytesTransferred | final int | Number of transferred bytes. |
| hash | final int | Hash value of the data object that was created and transferred **on the platform side**. |

#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| TransferStateUpdate({int status, int dataId, int totalBytes, int bytesTransferred, int hash}) | TransferStateUpdate constructor. |
| TransferStateUpdate.fromMap(Map\<dynamic, dynamic> map) | Creates an instance of the class from a provided Map object. |
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [equals](#transferstateupdate-equals) | bool | Checks whether any other object is the same as this object. |
| [toMap](#transferstateupdate-toMap) | Map\<dynamic, dynamic> map | Converts an instance of the class into a map object. |
#### Constructors
##### TransferStateUpdate({int status, int dataId, int totalBytes, int bytesTransferred, int hash})
Constructs a TransferStateUpdate instance. For parameter descriptions, see class properties.
##### factory TransferStateUpdate.fromMap(Map\<dynamic, dynamic> map)
Creates an instance of the class from a provided Map object.
#### Methods
##### <a name="transferstateupdate-equals"></a> bool equals(object) 
Checks whether any other object is the same as this object.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| object | dynamic | Object to be compared. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| bool | Whether two objects are equal. |
###### Call Example
```dart
TransferStateUpdate stateUpdate = TransferStateUpdate.fromMap(map); 
bool equals = stateUpdate.equals(object);
```
##### <a name="transferstateupdate-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
TransferStateUpdate data = TransferStateUpdate.fromMap(map);
Map<String, dynamic> map = data.toMap();
```
---
### DataOnReceivedResponse
Response class for the dataOnReceived events.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| endpointId | final String | ID of a remote endpoint. |
| data | final TransferData | Transferred data. |
| errorCode | final String | Used if there was an error during data parsing, otherwise null. |

#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| DataOnReceivedResponse({String endpointId, TransferData data, String errorCode}) | DataOnReceivedResponse constructor. |
| DataOnReceivedResponse.fromMap(Map\<dynamic, dynamic> map) | Creates an instance of the class from a provided Map object. |
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [toMap](#dataonreceivedresponse-tomap) | Map\<dynamic, dynamic> map | Converts an instance of the class into a map object. |
#### Constructors
##### DataOnReceivedResponse({String endpointId, TransferData data, String errorCode})
Constructs a DataOnReceivedResponse instance. For parameter descriptions, see class properties.
##### factory DataOnReceivedResponse.fromMap(Map\<dynamic, dynamic> map)
Creates an instance of the class from a provided Map object.
#### Methods
##### <a name="dataonreceivedresponse-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
DataOnReceivedResponse data = DataOnReceivedResponse.fromMap(map);
Map<String, dynamic> map = data.toMap();
```

---
### DataOnTransferUpdateResponse
Response class for the **dataOnTransferUpdate** events.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| endpointId | final String | ID of a remote endpoint. |
| transferStateUpdate | TransferStateUpdate | Updates the data transmission status. |

#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| DataOnTransferUpdateResponse({String endpointId, TransferStateUpdate transferStateUpdate}) | DataOnTransferUpdateResponse constructor. |
| DataOnTransferUpdateResponse.fromMap(Map\<dynamic, dynamic> map) | Creates an instance of the class from a provided Map object. |
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [toMap](#dataontransferupdateresponse-tomap) | Map\<dynamic, dynamic> map | Converts an instance of the class into a map object. |
#### Constructors
##### DataOnTransferUpdateResponse({String endpointId, TransferStateUpdate transferStateUpdate})
Constructs a DataOnTransferUpdateResponse instance. For parameter descriptions, see class properties.
##### factory DataOnTransferUpdateResponse.fromMap(Map\<dynamic, dynamic> map)
Creates an instance of the class from a provided Map object.
#### Methods
##### <a name="dataontransferupdateresponse-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
DataOnTransferUpdateResponse data = DataOnTransferUpdateResponse.fromMap(map);
Map<String, dynamic> map = data.toMap();
```


---
### Wifi Share Engine
This section contains the classes related to the Wifi Share Engine.
### HMSWifiShareEngine
An entry class for Wi-Fi sharing. This class provides APIs for Wi-Fi sharing.
#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
| [instance](#static-hmswifishareengine-get-instance) | HMSWifiShareEngine | Obtains the singleton instance of the class.|
| [startWifiShare](#futurevoid-startwifisharewifisharepolicy-policy) | Future\<void> | Enables the Wi-Fi sharing function. Set WifiSharePolicy based on function requirements. |
| [stopWifiShare](#futurevoid-stopwifishare) | Future\<void> | Disables the Wi-Fi sharing function. |
| [shareWifiConfig](#futurevoid-sharewificonfigstring-endpointid) | Future\<void> | Shares Wi-Fi with a remote endpoint. |
| [wifiOnFound](#streamwifionfoundresponse-get-wifionfound) | Stream\<WifiOnFoundResponse> | Returns a stream that fires events when a nearby endpoint on which Wi-Fi can be configured is discovered. Endpoint information can be obtained for the display and selection of target endpoints. |
| [wifiOnLost](#streamstring-get-wifionlost) | Stream\<String> | Returns a stream that fires events when an endpoint on which Wi-Fi can be configured is lost. |
| [wifiOnFetchAuthCode](#streamwifionfetchauthcoderesponse-get-wifionfetchauthcode) | Stream\<WifiOnFetchAuthCodeResponse> | Returns a stream that fires events when the verification code for Wi-Fi sharing is obtained. The verification code must be obtained and displayed so that users can confirm the target endpoint. |
| [wifiOnShareResult](#streamwifishareresultresponse-get-wifionshareresult) | Stream\<WifiShareResultResponse> | Returns a stream that fires events when the Wi-Fi sharing result is obtained. |

#### Methods
##### static HMSWifiShareEngine get instance
Obtains the singleton instance of the class.
###### Return Type
| Type        | Description |
|-------------|-------------|
| HMSWifiShareEngine | Singleton instance of the class. |
###### Call Example
```dart
instance = HMSWifiShareEngine.instance;
```
##### Future\<void\> startWifiShare(WifiSharePolicy policy)
Enable the Wi-Fi sharing function. Set [WifiSharePolicy](#wifisharepolicy) based on function requirements.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| policy | WifiSharePolicy | Wi-Fi sharing policy. Enable the Wi-Fi sharing mode or configuration mode as required. |

###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> | Future result of an execution that returns no value. Throws platform exception otherwise.|
###### Call Example
```dart
await HMSWifiShareEngine.instance.startWifiShare(WifiSharePolicy.set);
```
##### Future\<void\> stopWifiShare()
Disables the Wi-Fi sharing function.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> | Future result of an execution that returns no value.|
###### Call Example
```dart
 await HMSWifiShareEngine.instance.stopWifiShare();
```
##### Future\<void\> shareWifiConfig(String endpointId)
Shares Wi-Fi with a remote endpoint.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| endpointId | String | ID of a remote endpoint. |

###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> | Future result of an execution that returns no value. Throws platform exception otherwise. |
###### Call Example
```dart
await HMSWifiShareEngine.instance.shareWifiConfig('com.example.myapplication');
```
##### Stream\<WifiOnFoundResponse\> get wifiOnFound
Returns a stream that fires events when a nearby endpoint on which Wi-Fi can be configured is discovered. Endpoint information can be obtained for the display and selection of target endpoints.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Stream\<WifiOnFoundResponse\> | A stream that fires events when a nearby endpoint on which Wi-Fi can be configured is discovered. **WifiOnFoundResponse** contains the information for the display and selection of target endpoints.|
###### Call Example
```dart
HMSWifiShareEngine.instance.wifiOnFound
    .listen((WifiOnFoundResponse response) {
  // Perform operations
});
```
##### Stream\<String\> get wifiOnLost
Returns a stream that fires events when an endpoint on which Wi-Fi can be configured is lost.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Stream\<String\> | A stream that fires events when an endpoint on which Wi-Fi can be configured is lost. The string value is the ID of the remote endpoint. |
###### Call Example
```dart
HMSWifiShareEngine.instance.wifiOnLost.listen((String endpointId) {
  // Perform operations
});
```

##### Stream\<WifiOnFetchAuthCodeResponse\> get wifiOnFetchAuthCode
Returns a stream that fires events when the verification code for Wi-Fi sharing is obtained. The verification code must be displayed on the UI so that users can confirm the target endpoint.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Stream\<WifiOnFetchAuthCodeResponse\> | A stream that fires events when the verification code for Wi-Fi sharing is obtained. **WifiOnFetchAuthCodeResponse** contains the ID of the remote endpoint and the verification code. |
###### Call Example
```dart
HMSWifiShareEngine.instance.wifiOnFetchAuthCode
    .listen((WifiOnFetchAuthCodeResponse response) {
  // Perform operations
});
```
##### Stream\<WifiShareResultResponse\> get wifiOnShareResult
Returns a stream that fires events that return Wi-Fi sharing results. 
###### Return Type
| Type        | Description |
|-------------|-------------|
| Stream\<WifiShareResultResponse\> | A stream that fires events that return Wi-Fi sharing results. **WifiShareResultResponse** contains the ID of the remote endpoint and a status code that indicates Wi-Fi configuration result. |
###### Call Example
```dart
HMSWifiShareEngine.instance.wifiOnShareResult
    .listen((WifiShareResultResponse response) {
  // Perform operations
});
```
---
### WifiSharePolicy
A Wi-Fi sharing policy class. The options are the Wi-Fi sharing mode and Wi-Fi configuration mode.
#### Constants
|Name         | Type        | Description | Value       |
|-------------|-------------|-------------|-------------|
| share | WifiSharePolicy | Wi-Fi sharing mode. | SHARE |
| set | WifiSharePolicy | Wi-Fi configuration mode. | SET |

#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [equals](#wifisharepolicy-equals) | bool | Checks whether any other object is the same as this object. |
| [toString](#wifisharepolicy-tostring) | String | Converts a policy into a readable character string. |
| [toMap](#wifisharepolicy-tomap) | Map\<String, dynamic> | Converts an instance of the class into a map object. |

#### Methods
##### <a name="wifisharepolicy-equals"></a> bool equals(object) 
Checks whether any other object is the same as this object.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| object | dynamic | Object to be compared. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| bool | Whether two objects are equal. |
###### Call Example
```dart
bool equals = WifiSharePolicy.share.equals(object);
```
##### <a name="wifisharepolicy-tostring"></a> @override String toString()
Converts the WifiSharePolicy object into a readable character string.
###### Return Type
| Type        | Description |
|-------------|-------------|
| String | WifiSharePolicy object into a readable character string. |
###### Call Example
```dart
String desc = WifiSharePolicy.share.toString();
```
##### <a name="wifisharepolicy-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
Map<String, dynamic> map = WifiSharePolicy.share.toMap();
```
---
### WifiOnFoundResponse
Response class for the [wifiOnFound](#streamwifionfoundresponse-get-wifionfound) events.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| endpointId | final String | ID of a remote endpoint. |
| scanEndpointInfo | final ScanEndpointInfo | Information about the discovered endpoint. |
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| WifiOnFoundResponse({String endpointId, ScanEndpointInfo scanEndpointInfo}) | WifiOnFoundResponse constructor. |
| WifiOnFoundResponse.fromMap(Map\<dynamic, dynamic> map) | Creates an instance of the class from a provided Map object. | 
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [toMap](#wifionfoundresponse-tomap) | Map\<String, dynamic> | Converts an instance of the class into a map object. |
#### Constructors
##### WifiOnFoundResponse({String endpointId, ConnectInfo connectInfo})
Constructs a WifiOnFoundResponse instance. For parameter descriptions, see class properties.
##### factory WifiOnFoundResponse.fromMap(Map\<dynamic, dynamic> map)
Creates an instance of the class from a provided Map object.
#### Methods
##### <a name="wifionfoundresponse-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
response = WifiOnFoundResponse.fromMap(map);
Map<String, dynamic> map = response.toMap();
```
---
### WifiOnFetchAuthCodeResponse
Response class for the [wifiOnFetchAuthCode](#streamwifionfetchauthcoderesponse-get-wifionfetchauthcode)  events.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| endpointId | final String | ID of a remote endpoint. |
| authCode | final String | Wi-Fi sharing verification code. |
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| WifiOnFetchAuthCodeResponse({String endpointId, String authCode}) | WifiOnFetchAuthCodeResponse constructor. |
| WifiOnFetchAuthCodeResponse.fromMap(Map\<dynamic, dynamic> map) | Creates an instance of the class from a provided Map object. | 
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [toMap](#wifionfetchauthcoderesponse-tomap) | Map\<String, dynamic> | Converts an instance of the class into a map object. |
#### Constructors
##### WifiOnFetchAuthCodeResponse({String endpointId, String authCode})
Constructs a WifiOnFetchAuthCodeResponse instance. For parameter descriptions, see class properties.
##### factory WifiOnFetchAuthCodeResponse.fromMap(Map\<dynamic, dynamic> map)
Creates an instance of the class from a provided Map object.
#### Methods
##### <a name="wifionfetchauthcoderesponse-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
response = WifiOnFetchAuthCodeResponse.fromMap(map);
Map<String, dynamic> map = response.toMap();
```

---
### WifiShareResultResponse
Response class for the [wifiOnShareResult](#streamwifishareresultresponse-get-wifionshareresult) events.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| endpointId | final String | ID of a remote endpoint. |
| statusCode | final int | Wi-Fi configuration result status code. |
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| WifiShareResultResponse({String endpointId, int statusCode}) | WifiShareResultResponse constructor. |
| WifiShareResultResponse.fromMap(Map\<dynamic, dynamic> map) | Creates an instance of the class from a provided Map object. | 
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [toMap](#wifishareresultresponse-tomap) | Map\<String, dynamic> | Converts an instance of the class into a map object. |
#### Constructors
##### WifiShareResultResponse({String endpointId, int statusCode})
Constructs a WifiShareResultResponse instance. For parameter descriptions, see class properties.
##### factory WifiShareResultResponse.fromMap(Map\<dynamic, dynamic> map)
Creates an instance of the class from a provided Map object.
#### Methods
##### <a name="wifishareresultresponse-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
response = WifiShareResultResponse.fromMap(map);
Map<String, dynamic> map = response.toMap();
```


---
### Message Engine
This section contains the classes related to the Message Engine.

### HMSMessageEngine
Defines a set of APIs to publish or subscribe to messages between nearby devices. The APIs do not require HUAWEI ID authentication to perform operations. However, you need to apply for API_KEY on HUAWEI Developers. Other than **getPending**, all of the APIs need to be used from a foreground activity. You need to symmetrically call **put** or **unput**, **get** or **unget**, and **getPending** or **ungetPending**.
#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
| [instance](#static-hmsmessageengine-get-instance) | HMSMessageEngine | Obtains the singleton instance of the class. |
| [put](#futurevoid-putmessage-message) | Future\<void\> | Publishes a message and broadcasts a sharing code for nearby devices to scan. |
| [putWithOption](#futurevoid-putwithoptionmessage-message-messageputoption-putoption) | Future\<void\> | Publishes a message and broadcasts a sharing code for nearby devices to scan. |
| [registerStatusCallback](#futurevoid-registerstatuscallbackmessagestatuscallback-statuscallback) | Future\<void\> | Registers a status callback function, which will notify your app of key events. |
| [get](#futurevoid-getnearbymessagehandler-handler) | Future\<void\> |Obtains messages from the cloud using the default option. |
| [getWithOption](#futurevoid-getwithoptionnearbymessagehandler-handler-messagegetoption-getoption) | Future\<void\> | Subscribes to messages published by a nearby device. Only messages of the same app can be subscribed to. |
| [getPending](#futurevoid-getpendingnearbymessagehandler-handler-messagegetoption-option) | Future\<void\> | Identifies only BLE beacon messages. |
| [unput](#futurevoid-unputmessage-message-messageputoption-putoption-async) | Future\<void\> | Cancels message publishing. |
| [unregisterStatusCallback](#futurevoid-unregisterstatuscallbackmessagestatuscallback-statuscallback-async) | Future\<void\> | Cancels the status callback registered before. |
| [ungetPending](#futurevoid-ungetpending-async) | Future\<void\> | Cancels the current message subscription. |
| [unget](#futurevoid-ungetnearbymessagehandler-handler-messagegetoption-getoption-async) | Future\<void\> | Cancels a message subscription. |
| [dispose](#futurevoid-dispose-async) | Future\<void\> | Cancels the stream subscription of the Message Engine and clears callback objects. |
#### Methods
##### static HMSMessageEngine get instance
Obtains the singleton instance of the class.
###### Return Type
| Type        | Description |
|-------------|-------------|
| HMSMessageEngine | Singleton instance of the class. |
###### Call Example
```dart
instance = HMSMessageEngine.instance;
```
##### Future\<void\> put(Message message)
Publishes a message and broadcasts a token for nearby devices to scan.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| message | Message | Published message. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> | Future result of an execution that returns no value. Throws platform exception otherwise.|
###### Call Example
```dart
Message _message = Message(content: utf8.encode("Hello there!"));
await HMSMessageEngine.instance.put(_message);
```
##### Future\<void\> putWithOption(Message message, MessagePutOption putOption)
Publishes a message and broadcasts a token for nearby devices to scan. This message is published only to apps that use the same project ID and have registered the message type with the cloud for subscription.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| message | Message | Published message. |
| putOption | MessagePutOption | MessagePutOption parameters. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> |Future result of an execution that returns no value. Throws platform exception otherwise.|
###### Call Example
```dart
MessagePutOption option = MessagePutOption(
    policy: MessagePolicyBuilder().build(),
    putCallback: MessagePutCallback(
      onTimeout: () => {/* Perform operations */},
    ));
await HMSMessageEngine.instance.putWithOption(msg, option);
```
##### Future\<void\> registerStatusCallback(MessageStatusCallback statusCallback)
Registers a status callback function, which will notify your app of key events. When your app calls one of the APIs for the first time, the function will return the status.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| statusCallback | [MessageStatusCallback](#messagestatuscallback) | A callback class for MessageEngine status changes. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> | Future result of an execution that returns no value. Throws platform exception otherwise. |
###### Call Example
```dart
_statusCb = MessageStatusCallback(
  onPermissionChanged: (bool granted) => {/* Perform operations */},
);
await HMSMessageEngine.instance.registerStatusCallback(_statusCb);
```
##### Future\<void\> get(NearbyMessageHandler handler)
Obtains messages from the cloud using the default option.
###### Parameters
| Parameter   | Type        | Description |
|-------------|-------------|-------------|
| handler | [NearbyMessageHandler](#nearbymessagehandler) | NearbyMessageHandler implementation to obtain callbacks of received messages. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> |Future result of an execution that returns no value. Throws platform exception otherwise.|
###### Call Example
```dart
_handler = NearbyMessageHandler(onBleSignalChanged: (message, signal) {
  // Perform operations
}, onDistanceChanged: (Message message, Distance distance) {
  // Perform operations
}, onFound: (Message message) {
  // Perform operations
}, onLost: (Message message) {
  // Perform operations
});
await HMSMessageEngine.instance.get(_handler);
```
##### Future\<void\> getWithOption(NearbyMessageHandler handler, MessageGetOption getOption)
Registers the messages to be obtained with the cloud. Only messages with the same project ID can be obtained.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| handler | [NearbyMessageHandler](#nearbymessagehandler) | NearbyMessageHandler implementation to obtain callbacks of received messages. |
| getOption | MessageGetOption | MessageGetOption parameters. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> |Future result of an execution that returns no value. Throws platform exception otherwise.|
###### Call Example
```dart
MessageGetOption option = MessageGetOption(
    policy: MessagePolicyBuilder().build(),
    getCallback: MessageGetCallback(
      onTimeout: () => {/* Perform operations */},
    ));
await HMSMessageEngine.instance.getWithOption(handler, option);
```
##### Future\<void\> getPending(NearbyMessageHandler handler, [MessageGetOption option])
Identifies only BLE beacon messages. It subscribes to messages published by nearby devices in a persistent and low-power manner and uses the default configuration. Scanning is going on no matter whether your app runs in the background or foreground. The scanning stops when the app process is killed.

###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| handler | [NearbyMessageHandler](#nearbymessagehandler) | NearbyMessageHandler implementation to obtain callbacks of received messages. **Currently**, only the **onFound** and **onLost** methods are supported. |
| getOption | [MessageGetOption](#messagegetoption) | MessageGetOption parameters. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> |Future result of an execution that returns no value. Throws platform exception otherwise.|
###### Call Example
```dart
await HMSMessageEngine.instance.getPending(NearbyMessageHandler(
  onFound: (message) {
    // Perform operations
  },
  onLost: (message) {
    // Perform operations         
  },
));
```
##### Future\<void\> unput(Message message, [MessagePutOption putOption]) *async*
Cancels message publishing.
###### Paramaters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| message | Message | Published message.  |
| putOption | MessagePutOption | Previously used MessagePutOption parameters.  |
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> |Future result of an execution that returns no value. Throws platform exception otherwise.|
###### Call Example
```dart
Message _message = Message(content: utf8.encode("Hello there!"));
await HMSMessageEngine.instance.unput(_message);
```
##### Future\<void\> unregisterStatusCallback(MessageStatusCallback statusCallback) *async*
Cancels the status callback registered before.
###### Paramaters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| statusCallback | MessageStatusCallback | Status callback registered before. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> |Future result of an execution that returns no value. Throws platform exception otherwise.|
###### Call Example
```dart
await HMSMessageEngine.instance.unregisterStatusCallback(_statusCb);
```
##### Future\<void\> ungetPending() *async*
Cancels a registered message subscription task. 
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> |Future result of an execution that returns no value. Throws platform exception otherwise.|
###### Call Example
```dart
await HMSMessageEngine.instance.ungetPending();
```
##### Future\<void\> unget(NearbyMessageHandler handler, [MessageGetOption getOption]) *async*
Cancels the current message subscription.
###### Paramaters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| handler | [NearbyMessageHandler](#nearbymessagehandler) | Callback processing class registered by the current task when the target message is subscribed. |
| getOption | [MessageGetOption](#messagegetoption) | Previously used MessageGetOption parameters. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> |Future result of an execution that returns no value. Throws platform exception otherwise.|
###### Call Example
```dart
await HMSMessageEngine.instance.unget(_handler);
```
##### Future\<void\> dispose() *async*
Cancels the stream subscription of the Message Engine and clears callback objects.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<void> |Future result of an execution that returns no value.|
###### Call Example
```dart
HMSMessageEngine.instance.dispose();
```
---
### Message
Obtains the message that will be shared with nearby devices. The message consists of client-specified content and a type. The type can be used in **MessagePickerBuilder** to limit which messages an app can receive in a subscription.
#### Constants
|Name         | Type        | Description | Value       |
|-------------|-------------|-------------|-------------|
| maxContentSize | int | Maximum size of the message content. | 65536 |
| maxTypeLength | int | Maximum size of a message type. | 16 |
| messageNamespaceReserved | String | Namespace reserved for special messages. | _reserved_namespace |
| messageTypeEddystoneUid | String | Message type of **EddystoneUid** beacons. | _eddystone_uid |
| messageTypeIBeaconId | String | Message type of **IBeaconId** beacons. | _ibeacon_id |
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| content  | Uint8List | Message content. |
| type | String | Non-empty string for a public namespace or an empty string for the private namespace. For example, a beacon attachment is a public namespace. |
| namespace | String | Message type. An empty string is if no type is specified when the message is created. |
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [equals](#message-equals) | bool | Checks whether any other object is the same as this object. |
| [toString](#message-tostring) | String | Converts a policy into a readable character string. |
| [toMap](#message-tomap) | Map\<String, dynamic> | Converts an instance of the class into a map object. |
#### Methods
##### <a name="message-equals"></a> bool equals(object) 
Checks whether any other object is the same as this object.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| object | dynamic | Object to be compared. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| bool | Whether two objects are equal. |
###### Call Example
```dart
msg = Message(content: utf8.encode("Hello there!"));
msg2 = Message(content: utf8.encode("Hello there!"));
bool equals = msg.equals(msg2);
```
##### <a name="message-tostring"></a> @override String toString()
Converts a message into a readable character string.
###### Return Type
| Type        | Description |
|-------------|-------------|
| String | Readable character string of the Message object. |
###### Call Example
```dart
Message msg = Message(
      content: utf8.encode("Hello there!"),
      type: Message.messageTypeIBeaconId,
      namespace: Message.messageNamespaceReserved);
String str = msg.toString();
```
##### <a name="message-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
Map<String, dynamic> map =
    Message(content: utf8.encode("Hello there!")).toMap();
```
---
### MessageGetOption
Obtains options for calling [get](#futurevoid-getnearbymessagehandler-handler).
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| policy | MessagePolicy | Subscription policy. |
| messagePicker | MessagePicker | Rule for filtering messages to be received. |
| getCallback | MessageGetCallback | Subscription callback. |
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| MessageGetOption({MessagePolicy policy, MessagePicker messagePicker, MessageGetCallback getCallback}) | MessageGetOption constructor. |
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [toString](#getoption-tostring) | String | Converts a MessageGetOption object into a readable character string. |
| [toMap](#getoption-tomap) | Map\<String, dynamic> | Converts an instance of the class into a map object. |
#### Constructors
##### MessageGetOption({MessagePolicy policy, MessagePicker messagePicker, MessageGetCallback getCallback})
Constructs a MessageGetOption instance. For parameter descriptions, see class properties.
#### Methods
##### <a name="getoption-tostring"></a> @override String toString()
Converts a MessageGetOption object into a readable character string.
###### Return Type
| Type        | Description |
|-------------|-------------|
| String | MessageGetOption object into a readable character string. |
###### Call Example
```dart
String desc = MessageGetOption().toString();
```
##### <a name="getoption-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
Map<String, dynamic> map = MessageGetOption().toMap();
```
---
### MessagePutOption
Obtains options for calling [putWithOption](#futurevoid-putwithoptionmessage-message-messageputoption-putoption).
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| policy | [MessagePolicy](#messagepolicy) | Publish policy. |
| putCallback | [MessagePutCallback](#messageputcallback) | Publish callback. |
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| MessagePutOption({MessagePolicy policy, MessagePutCallback putCallback}) | MessagePutOption constructor. |
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [toMap](#putoption-tomap) | Map\<String, dynamic> | Converts an instance of the class into a map object. |
#### Constructors
##### MessagePutOption({MessagePolicy policy, MessagePutCallback putCallback})
Constructs a MessagePutOption instance. For parameter descriptions, see class properties.
#### Methods
#####  <a name="putoption-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
Map<String, dynamic> map = MessagePutOption().toMap();
```
---
### MessagePicker
Specifies the set of messages to be received. When the sharing code is discovered, the **MessagePicker** must match the message. A **MessagePicker** is the logical OR of multiple pickers.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| includeAll | MessagePicker | A picker that returns all types of messages published by the app. |
| includeAllTypes | final bool | Indicates whether to obtain all types of information. |
| eddystoneUids | final List\<UidInstance> | EddystoneUid beacon information list. |
| iBeaconIds | final List\<IBeaconInfo> | iBeacon beacon information list. |
| namespaceTypes | final List\<NamespaceType> | Domain name list. |

#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [equals](#messagepicker-equals) | bool | Checks whether any other object is the same as this object. |
| [toString](#messagepicker-tostring) | String | Converts a MessagePicker object into a readable character string. |
| [toMap](#messagepicker-tomap) | Map\<dynamic, dynamic> map | Converts an instance of the class into a map object. |
#### Methods
##### <a name="messagepicker-equals"></a> bool equals(object) 
Checks whether any other object is the same as this object.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| object | dynamic | Object to be compared. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| bool | Whether two objects are equal. |
###### Call Example
```dart
bool equals = MessagePicker.includeAll.equals(object);
```
##### <a name="messagepicker-tostring"></a> @override String toString()
Converts a MessagePicker object into a readable character string.
###### Return Type
| Type        | Description |
|-------------|-------------|
| String | Readable character string of the MessagePicker object. |
###### Call Example
```dart
String desc = MessagePicker.includeAll.toString();
```
##### <a name="messagepicker-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
Map<String, dynamic> map = MessagePicker.includeAll.toMap();
```
---
### MessagePickerBuilder
A builder class for MessagePicker.
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| MessagePickerBuilder() | Creates an instance of **MessagePickerBuilder**. |
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [build](#messagepicker-build) | MessagePicker | Creates an instance of [MessagePicker](#messagepicker). |
| [includeAll](#messagepickerbuilder-includeall) | MessagePickerBuilder | Picks among all messages published by the app. |
| [includeEddyStoneUids](#messagepickerbuilder-includeeddystoneuidslistuidinstance-eddystoneuids) | MessagePickerBuilder | Includes Eddystone UIDs. |
| [includeIBeaconIds](#messagepickerbuilder-includeibeaconidslistibeaconinfo-ibeaconids) | MessagePickerBuilder | Includes iBeacon IDs. |
| [includeNamespaceType](#messagepickerbuilder-includenamespacetypelistnamespaceType-namespaceTypes) | MessagePickerBuilder | Picks among all messages in the specified namespace and with the specified type. A namespace can be specified only for beacon messages. |
| [includePicker](#messagepickerbuilder-includepickermessagepicker-picker) | MessagePickerBuilder | Includes the previously constructed picker. |
#### Constructors
##### MessagePickerBuilder()
Creates an instance of **MessagePickerBuilder**.
#### Methods
##### MessagePicker build()
Creates an instance of MessagePicker. **You must call at least one include method before calling build()**.
###### Return Type
| Type        | Description |
|-------------|-------------|
| MessagePicker | An instance of MessagePicker. |
###### Call Example
```dart
MessagePicker picker =
      MessagePickerBuilder().includeAll().build();
```
##### MessagePickerBuilder includeAll()
Includes all messages published by the app.
###### Return Type
| Type        | Description |
|-------------|-------------|
| MessagePickerBuilder | MessagePickerBuilder object. |
###### Call Example
```dart
MessagePickerBuilder builder = MessagePickerBuilder().includeAll();
```
##### MessagePickerBuilder includeEddyStoneUids(List\<UidInstance\> eddystoneUids)
Includes Eddystone UIDs.

An Eddystone message contains the following information:
- namespace = Message.messageNamespaceReserved
- type = Message.messageTypeEddystoneUid
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| eddystoneUids | List\<UidInstance> | List of EddystoneUid instances. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| MessagePickerBuilder | MessagePickerBuilder object. |
###### Call Example
```dart
MessagePickerBuilder builder = MessagePickerBuilder().includeEddyStoneUids([
  UidInstance(uid: '123', instance: 'ins'),
  UidInstance(uid: '345', instance: 'ins')
]);
```
##### MessagePickerBuilder includeIBeaconIds(List\<IBeaconInfo\> iBeaconIds)
Includes iBeacon ID messages.

An iBeacon message contains the following information:
- namespace = Message.messageNamespaceReserved
- type = Message.messageTypeIBeaconId
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| eddystoneUids | List\<IBeaconInfo> | List of IBeacon instances. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| MessagePickerBuilder | MessagePickerBuilder object. |
###### Call Example
```dart
MessagePickerBuilder builder = MessagePickerBuilder().includeIBeaconIds([
  IBeaconInfo(uuid: '123', major: 123, minor: 123),
  IBeaconInfo(uuid: '345', major: 345, minor: 345)
]);
```
##### MessagePickerBuilder includeNamespaceType(List\<NamespaceType\> namespaceTypes)
Picks among all messages in the specified namespace and with the specified type. A namespace can be specified only for beacon messages.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| namespaceTypes | List\<NamespaceType> | List of namespace types. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| MessagePickerBuilder | MessagePickerBuilder object. |
###### Call Example
```dart
  MessagePickerBuilder builder = MessagePickerBuilder().includeNamespaceType(
      [NamespaceType('nmspace', 'type'), NamespaceType('nmspace2', 'type2')]);
```
##### MessagePickerBuilder includePicker(MessagePicker picker)
Includes the previously constructed picker.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| picker | MessagePicker | MessagePicker object. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| MessagePickerBuilder | MessagePickerBuilder object. |
###### Call Example
```dart
MessagePicker picker = MessagePickerBuilder().includeIBeaconIds([
  IBeaconInfo(uuid: '123', major: 123, minor: 123),
  IBeaconInfo(uuid: '345', major: 345, minor: 345)
]).build();
MessagePickerBuilder builder = MessagePickerBuilder().includePicker(picker);
```
---
### MessagePolicy 
Describes a set of policies for publishing or subscribing to messages.
#### Constants
|Name         | Type        | Description | Value       |
|-------------|-------------|-------------|-------------|
| findingModeBroadcast | int | Broadcasts a sharing code for other devices to scan to discover nearby devices. | 1 |
| findingModeScan | int | Broadcasts a sharing code and scans for other devices' sharing codes to discover nearby devices. | 2 |
| findingModeDefault | int | Allows messages to be transmitted over any distance. | 0 |
| distanceTypeDefault | int | Allows messages to be transmitted over any distance. | 0 |
| distanceTypeEarshot | int | Allows messages to be transmitted only within the earshot. It is recommended that this policy be used together with **findingModeBroadcast** to reduce the device discovery delay. | 1 |
| ttlSecondsDefault | int | Default TTL, in seconds. | 240 |
| ttlSecondsInfinite | int | Indefinite TTL, in seconds. | 0x7FFFFFFF |
| ttlSecondsMax | int | Maximum TTL, in seconds. | 86400 |
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| bleOnly | static final MessagePolicy | Policy that uses only BLE to discover nearby devices. |
| findingMode | int | Discovery mode. |
| distanceType | int | Distance type. |
| ttlSeconds | int | Timeout interval. |
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [equals](#messagepolicy-equals) | bool | Checks whether any other object is the same as this object. |
| [toMap](#messagepolicy-tomap) | Map\<dynamic, dynamic> map | Converts an instance of the class into a map object. |
#### Methods
##### <a name="messagepolicy-equals"></a> bool equals(object) 
Checks whether any other object is the same as this object.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| object | dynamic | Object to be compared. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| bool | Whether two objects are equal. |
###### Call Example
```dart
bool equals = MessagePolicy.bleOnly.equals(object);
```
##### <a name="messagepolicy-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
Map<String, dynamic> map = MessagePolicy.bleOnly.toMap();
```
---
### MessagePolicyBuilder
A builder class for MessagePolicy.
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| MessagePolicyBuilder() | Creates an instance of **MessagePolicyBuilder**. |
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [build](#messagepolicy-build) | MessagePolicy | Creates an instance of [MessagePolicy](#messagepolicy-build). |
| [setFindingMode](#messagepolicybuilder-setfindingmodeint-findingmode) | MessagePolicyBuilder | Sets the scanning mode. |
| [setDistanceType](#messagepolicybuilder-setdistancetypeint-distancetype) | MessagePolicyBuilder | **For message publishing**, the published message will only be delivered to subscribing devices that are at the most specified distance. **For message subscription**, messages will only be delivered if the publishing device is at the most specified distance. |
| [setTtlSeconds](#messagepolicybuilder-setttlsecondsint-ttlseconds) | MessagePolicyBuilder | Includes iBeacon IDs. |

#### Constructors
##### MessagePolicyBuilder()
Creates an instance of **MessagePolicyBuilder**.
#### Methods
##### MessagePolicy build()
Creates an instance of MessagePolicy.
###### Return Type
| Type        | Description |
|-------------|-------------|
| MessagePolicy | An instance of MessagePolicy. |
###### Call Example
```dart
MessagePolicy picker = MessagePolicyBuilder().build();
```
##### MessagePolicyBuilder setFindingMode(int findingMode)
Sets the scanning mode, which determines how devices detect each other.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| findingMode | int | Mode to detect devices, which is one of MessagePolicy.findingMode*. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| MessagePolicyBuilder | MessagePolicyBuilder object. |
###### Call Example
```dart
MessagePolicyBuilder builder =
  MessagePolicyBuilder().setFindingMode(MessagePolicy.findingModeScan);
```
##### MessagePolicyBuilder setDistanceType(int distanceType)
Sets the distance for message subscription and publishing. For message publishing, the published message will only be delivered to subscribing devices that are at the most specified distance. For message subscription, messages will only be delivered if the publishing device is at the most specified distance.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| distanceType | int | Distance type, which is one of MessagePolicy.distanceType*. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| MessagePolicyBuilder | MessagePolicyBuilder object. |
###### Call Example
```dart
MessagePolicyBuilder builder = MessagePolicyBuilder()
    .setDistanceType(MessagePolicy.distanceTypeDefault);
```
##### MessagePolicyBuilder setTtlSeconds(int ttlSeconds)
Sets the TTL of a published or subscribed message. The TTL can either be **ttlSecondsInfinite** or a value ranging from 1 to **ttlSecondsMax**. If the TTL is not set, **ttlSecondsDefault** is used by default.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| ttlSeconds | int | Time to live. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| MessagePolicyBuilder | MessagePolicyBuilder object. |
###### Call Example
```dart
MessagePolicyBuilder builder =
    MessagePolicyBuilder().setTtlSeconds(MessagePolicy.ttlSecondsMax);
```
---
### UidInstance
Obtains EddystoneUid information.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| uid | final String | 10-byte namespace of an Eddystone UID (in hexadecimal format), for example, c526dfec5403adc62585. |
| instance | final String | 6-byte instance of an Eddystone UID (in hexadecimal format), for example, 32ddbcad1576. |
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| UidInstance({String uid, String instance}) | UidInstance constructor. |
| UidInstance.fromMap(Map\<dynamic, dynamic> map) | Creates an instance of the class from a provided Map object. |
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [equals](#uidinstance-equals) | bool | Checks whether any other object is the same as this object. |
| [toString](#uidinstance-tostring) | String | Converts a UidInstance into a readable character string. |
| [toMap](#uidinstance-tomap) | Map\<String, dynamic> | Converts an instance of the class into a map object. |
#### Constructors
##### UidInstance({String uid, String instance})
Constructs a UidInstance instance. For parameter descriptions, see class properties.
##### factory UidInstance.fromMap(Map\<dynamic, dynamic> map)
Creates an instance of the class from a provided Map object.
#### Methods
##### <a name="uidinstance-equals"></a> bool equals(object) 
Checks whether any other object is the same as this object.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| object | dynamic | Object to be compared. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| bool | Whether two objects are equal. |
###### Call Example
```dart
bool equals = UidInstance(uid: 'uid').equals(object);
```
##### <a name="uidinstance-tostring"></a> @override String toString()
Converts the UidInstance object into a readable character string.
###### Return Type
| Type        | Description |
|-------------|-------------|
| String | UidInstance object into a readable character string. |
###### Call Example
```dart
String desc = UidInstance(uid: 'uid').toString();
```
##### <a name="uidinstance-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
Map<String, dynamic> map = UidInstance(uid: 'uid').toMap();
```
---
### IBeaconInfo
Obtains IBeacon information.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| uuid | final String | UUID. |
| major | final int | Major value. |
| minor | final int | Minor value. |
#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| IBeaconInfo({String uuid, int major, int minor}) | IBeaconInfo constructor. |
| IBeaconInfo.fromMap(Map\<String, dynamic> map) | Creates an instance of the class from a provided Map object. |
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [equals](#ibeacon-equals) | bool | Checks whether any other object is the same as this object. |
| [toString](#ibeacon-tostring) | String | Converts a IBeaconInfo into a readable character string. |
| [toMap](#ibeacon-tomap) | Map\<String, dynamic> | Converts an instance of the class into a map object. |
#### Constructors
##### IBeaconInfo({String uuid, int major, int minor})
Constructs a IBeaconInfo instance. For parameter descriptions, see class properties.
##### factory IBeaconInfo.fromMap(Map\<dynamic, dynamic> map)
Creates an instance of the class from a provided Map object.
#### Methods
##### <a name="ibeacon-equals"></a> bool equals(object) 
Checks whether any other object is the same as this object.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| object | dynamic | Object to be compared. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| bool | Whether two objects are equal. |
###### Call Example
```dart
bool equals = IBeaconInfo(uuid: 'uuid').equals(object);
```
##### <a name="ibeacon-tostring"></a> @override String toString()
Converts the IBeaconInfo object into a readable character string.
###### Return Type
| Type        | Description |
|-------------|-------------|
| String | IBeaconInfo object into a readable character string. |
###### Call Example
```dart
String desc = IBeaconInfo(uuid: 'uuid').toString();
```
##### <a name="ibeacon-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
Map<String, dynamic> map = IBeaconInfo(uuid: 'uuid').toMap();
```

---
### NamespaceType
Obtains namespace information.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| namespace | String | Namespace of a message. The value cannot be empty or contain asterisks (*). |
| type | String | Type of a message. The value cannot be empty or contain asterisks (*). |

#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| NamespaceType(String namespace, String type) | NamespaceType constructor. |
| NamespaceType.fromMap(Map\<String, dynamic> map) | Creates an instance of the class from a provided Map object. |
#### Method Summary
| Method  | Return Type | Description |
| ------- | ----------- | ----------- |
| [equals](#namespacetype-equals) | bool | Checks whether any other object is the same as this object. |
| [toString](#namespacetype-tostring) | String | Converts a NamespaceType into a readable character string. |
| [toMap](#namespacetype-tomap) | Map\<String, dynamic> | Converts an instance of the class into a map object. |
#### Constructors
##### NamespaceType(String namespace, String type)
Constructs a NamespaceType instance. For parameter descriptions, see class properties.
##### factory NamespaceType.fromMap(Map\<dynamic, dynamic> map)
Creates an instance of the class from a provided Map object.
#### Methods
##### <a name="namespacetype-equals"></a> bool equals(object) 
Checks whether any other object is the same as this object.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| object | dynamic | Object to be compared. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| bool | Whether two objects are equal. |
###### Call Example
```dart
bool equals = NamespaceType('nmspace', 'type').equals(object);
```
##### <a name="namespacetype-tostring"></a> @override String toString()
Converts the NamespaceType object into a readable character string.
###### Return Type
| Type        | Description |
|-------------|-------------|
| String | NamespaceType object into a readable character string. |
###### Call Example
```dart
String desc = NamespaceType('nmspace', 'type').toString();
```
##### <a name="namespacetype-tomap"></a> Map\<String, dynamic> toMap()
Converts an instance of the class into a map object.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Map\<String, dynamic> | An instance of the class converted into a map object.|
###### Call Example
```dart
Map<String, dynamic> map = NamespaceType('nmspace', 'type').toMap();
```
---
### MessageGetCallback
A callback class for events related to message subscription.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| id | int | Hash code. |
| onTimeout | [OnTimeout](#void-ontimeout) | Custom function type, called when message subscription expires in any of the following situations: **TTL ends**, **User stops the Nearby operation** |

#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| MessageGetCallback({OnTimeout onTimeout}) | MessageGetCallback constructor. |

#### Constructors
##### MessageGetCallback({OnTimeout onTimeout})
Constructs a MessageGetCallback instance. For parameter descriptions, see class properties.

---
### MessagePutCallback
Represents the callback for events related to message publishing.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| id | int | Hash code. |
| onTimeout | [OnTimeout](#void-ontimeout) | Custom function type, called when message publishing expires in any of the following situations: **TTL ends**, **The user stops publishing.** |

#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| MessagePutCallback({OnTimeout onTimeout}) | MessagePutCallback constructor. |

#### Constructors
##### MessagePutCallback({OnTimeout onTimeout})
Constructs a MessagePutCallback instance. For parameter descriptions, see class properties.

---
### MessageStatusCallback
A callback class for MessageEngine status changes.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| id | int | Hash code. |
| onPermissionChanged | [OnPermissionChanged](#void-onpermissionchangedbool-granted) | Custom function type, called when a Nearby permission is assigned or revoked. |

#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| MessageStatusCallback({OnPermissionChanged onPermissionChanged}) | MessageStatusCallback constructor. |

#### Constructors
##### MessageStatusCallback({OnPermissionChanged onPermissionChanged})
Constructs a MessageStatusCallback instance. For parameter descriptions, see class properties.

---
### NearbyMessageHandler
Represents the callback for events such as signal change, distance change, message reception, and failure to receive a message.
#### Properties
|Name         | Type        | Description |
|-------------|-------------|-------------|
| id | int | Hash code. |
| onBleSignalChanged | [OnBleSignalChanged](#void-onblesignalchangedmessage-message-blesignal-signal) | Custom function type, called when the first BLE broadcast message associated with [Message](#message) or the BLE signal associated with [Message](#message) changes. This callback currently supports only BLE beacon messages. It does not support [getPending]((#futurevoid-getpendingnearbymessagehandler-handler-messagegetoption-option)) during subscription. |
| onDistanceChanged | [OnDistanceChanged](#void-ondistancechangedmessage-message-distance-distance) | Custom function type, called when the estimated distance to a message changes. This callback currently supports only BLE beacon messages. It does not support [getPending](#futurevoid-getpendingnearbymessagehandler-handler-messagegetoption-option) during subscription. |
| onFound | [OnFound](#void-onfoundmessage-message) | Custom function type, called when a message is detected for the first time or a message is no longer detectable (onLost). |
| onLost | [OnLost](#void-onLostmessage-message) | Custom function type, called when a message is no longer detectable. This callback currently suits BLE beacon messages the best. For other messages, it may not respond in a timely manner. The method is called back only once unless a message is no longer detectable. |

#### Constructor Summary
| Constructor | Description |
|-------------|-------------|
| NearbyMessageHandler({OnBleSignalChanged onBleSignalChanged, OnDistanceChanged onDistanceChanged, OnFound onFound, OnLost onLost}) | NearbyMessageHandler constructor. |

#### Constructors
##### NearbyMessageHandler({OnBleSignalChanged onBleSignalChanged, OnDistanceChanged onDistanceChanged, OnFound onFound, OnLost onLost})
Constructs a NearbyMessageHandler instance. For parameter descriptions, see class properties.

---
### void OnTimeout()
Custom function type defined for messaging timeout events.

---
### void OnPermissionChanged(bool granted)
Custom function type defined for Message engine permission changes.
#### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| granted | bool | Indicates whether a permission is granted. |

---
### void OnBleSignalChanged(Message message, BleSignal signal)
Custom function type defined for message handler OnBleSignalChanged events.
#### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| message | Message | Message. |
| signal | BleSignal | New BLE signal. |

---
### void OnDistanceChanged(Message message, Distance distance)
Custom function type defined for message handler OnDistanceChanged events.
#### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| message | Message | Message. |
| distance | Distance | Updated estimated distance. |

---
### void OnFound(Message message)
Custom function type defined for message handler OnFound events.
#### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| message | Message | Message. |

---
### void OnLost(Message message)
Custom function type defined for message handler OnLost events.
#### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| message | Message | Message. |

### NearbyPermissionHandler
Contains the methods for the permissions required by the Nearby Service.

#### Method Summary
| Method      | Return Type | Description |
|-------------|-------------|-------------|
| [requestPermission](#futurebool-requestpermissionlistnearbypermission-permissions)  | Future\<void\> | Requests the specified permissions. |
| [hasLocationPermission](#futurebool-haslocationpermission)  | Future\<bool\> | Checks whether the application has location permission. |
| [hasExternalStoragePermission](#futurebool-hasExternalStoragePermission)  | Future\<bool\> | Checks whether the application has external storage read/write permission. |

#### Methods
##### Future\<bool> requestPermission(List<NearbyPermission> permissions)
Requests the specified permissions.
###### Parameters
|Parameter    | Type        | Description |
|-------------|-------------|-------------|
| permissions | List\<[NearbyPermission](#nearbypermission)> | List of permissions. |
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<bool> | Whether the **all the permissions** are granted. Will return **false** if one is rejected. |
###### Call Example
```dart
await NearbyPermissionHandler.requestPermission(
        [NearbyPermission.location, NearbyPermission.externalStorage]);
```
##### Future\<bool> hasLocationPermission()
Checks whether the application has location permission.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<bool> | Whether the application has location permission. |

##### Future\<bool> hasExternalStoragePermission()
Checks whether the application has external storage read/write permission.
###### Return Type
| Type        | Description |
|-------------|-------------|
| Future\<bool> | Whether the application has external storage read/write permission. |

---

### NearbyPermission
Enumerated object that represents the permissions that are required and used by the plugin.

#### Enum Values
|Values     | Description |
|-----------|-------------|
| location | ACCESS_COARSE_LOCATION & ACCESS_FINE_LOCATION |
| externalStorage | READ_EXTERNAL_STORAGE & WRITE_EXTERNAL_STORAGE |


You can read more about the Nearby Service and its APIs from [Huawei Developers](https://developer.huawei.com/consumer/en/doc/overview/HMS-Core-Plugin)

---
## 4. Configuration and Description

### Preparing for Release

Before building a release version of your app you may need to customize the **proguard-rules.pro** obfuscation configuration file to prevent the HMS Core SDK from being obfuscated. Add the configurations below to exclude the HMS Core SDK from obfuscation. For more information on this topic refer to [this Android developer guide](https://developer.android.com/studio/build/shrink-code).

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
 
## Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn io.flutter.embedding.**
-keep class com.huawei.hms.flutter.** { *; }
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

<img src="https://github.com/HMS-Core/hms-flutter-plugin/raw/master/flutter-hms-nearby/example/.docs/screenshot1.jpg" width = 40% height = 40% style="margin:1.5em"><img src="https://github.com/HMS-Core/hms-flutter-plugin/raw/master/flutter-hms-nearby/example/.docs/screenshot2.jpg" width = 40% height = 40% style="margin:1.5em">

## 6. Questions or Issues
If you have questions about how to use HMS samples, try the following options:
- [Stack Overflow](https://stackoverflow.com/questions/tagged/huawei-mobile-services) is the best place for any programming questions. Be sure to tag your question with 
**huawei-mobile-services**.
- [Github](https://github.com/HMS-Core/hms-flutter-plugin) is the official repository for these plugins, You can open an issue or submit your ideas.
- [Huawei Developer Forum](https://forums.developer.huawei.com/forumPortal/en/home?fid=0101187876626530001) HMS Core Module is great for general questions, or seeking recommendations and opinions.
- [Huawei Developer Docs](https://developer.huawei.com/consumer/en/doc/overview/HMS-Core-Plugin) is place to official documentation for all HMS Core Kits, you can find detailed documentations in there.

If you run into a bug in our samples, please submit an issue to the [GitHub repository](https://github.com/HMS-Core/hms-flutter-plugin).

## 7. Licensing and Terms

Huawei Nearby Service Flutter Plugin is licensed under [Apache 2.0 license](LICENSE)