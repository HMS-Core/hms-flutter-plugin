# Huawei Location Kit Flutter Plugin

## Table of Contents
* [Introduction](#introduction)
* [Installation Guide](#installation-guide)
* [API Reference](#api-reference)
* [Configuration Description](#configuration-description)
* [Licensing and Terms](#licensing-and-terms)

## Introduction

This plugin enables communication between Huawei Location SDK and Flutter platform. Huawei Location Kit combines the GPS, Wi-Fi, and base station locations to help you quickly obtain precise user locations, build up global positioning capabilities, and reach a wide range of users around the globe.Currently, it provides the four main capabilities: fused location, location semantics, activity identification, and geofence. You can call relevant capabilities as needed.

Huawei Location Kit provides the following core capabilities:
- **Fused location**: Provides a set of simple and easy-to-use APIs for you to quickly obtain the device location based on the GPS, Wi-Fi, and base station location data.
- **Activity identification**: Identifies user motion status through the acceleration sensor, cellular network information, and magnetometer, helping you adjust your app based on user behavior.
- **Geofence**: Allows you to set an interested area through an API so that your app can receive a notification when a specified action (such as leaving, entering, or lingering in the area) occurs.

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
                    minifyEnabled true
                    shrinkResources true
                    proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
                }
            }
        }
        ```

- On your Flutter project directory find and open your **pubspec.yaml** file and add library to dependencies. For more details please refer the [Using packages](https://flutter.dev/docs/development/packages-and-plugins/using-packages#dependencies-on-unpublished-packages) document.

    ```yaml
    dependencies:
        huawei_location:
            # Replace {library path} with actual library path of Huawei Location Kit Flutter Plugin.
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

### Fused Location Provider Client

#### Methods

| Return Type                      | Method                                                                                         | Description                                                                                                                                                                                                                                                                                                                                                                    |
|----------------------------------|------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Future\<LocationSettingsStates\> | checkLocationSettings(LocationSettingsRequest locationSettingsRequest)                         | This API is used to check location settings of the device.                                                                                                                                                                                                                                                                                                                     |
| Future\<Location\>               | getLastLocation()                                                                              | This API is used to obtain the last requested available location.  This API does not proactively request the location. Instead, it uses the location cached for the last request.                                                                                                                                                                                              |
| Future\<HWLocation\>             | getLastLocationWithAddress(LocationRequest locationRequest)                                    | This API is used to obtain the available location of the last request, including the detailed address information.                                                                                                                                                                                                                                                             |
| Future\<LocationAvailability\>   | getLocationAvailability()                                                                      | This API is used to check whether the location data is available.                                                                                                                                                                                                                                                                                                              |
| Future\<void\>                   | setMockMode(bool mockMode)                                                                     | This API is used to specify whether the location provider uses the location mock mode. If yes, the GPS or network location is not used and the location set through setMockLocation (Location) is directly returned.                                                                                                                                                           |
| Future\<void\>                   | setMockLocation(Location location)                                                             | This API is used to set the specific mock location. You must call the setMockMode(boolean) method and set the flag to true before calling this method.                                                                                                                                                                                                                         |
| Future\<int\>                    | requestLocationUpdates(LocationRequest locationRequest)                                        | This API is used to continuously request location updates.                                                                                                                                                                                                                                                                                                                     |
| Future\<int\>                    | requestLocationUpdatesCb(LocationRequest locationRequest, LocationCallback locationCallback)   | This API is used to request location updates using the callback.                                                                                                                                                                                                                                                                                                               |
| Future\<int\>                    | requestLocationUpdatesExCb(LocationRequest locationRequest, LocationCallback locationCallback) | This API is an extended location information service API. It supports high-precision location and is compatible with common location APIs. If the device does not support high-precision location or the app does not request the high-precision location permission, this API returns common location information similar to that returned by the requestLocationUpdates API. |
| Future\<void\>                   | removeLocationUpdates(int requestCode)                                                         | This API is used to remove location updates from the specified **requestCode**.                                                                                                                                                                                                                                                                                                |
| Future\<void\>                   | removeLocationUpdatesCb(int callbackId)                                                        | This API is used to remove location updates of the specified **callbackId**.                                                                                                                                                                                                                                                                                                   |
| Stream\<Location\>               | onLocationData                                                                                 | This API is used to listen location updates that comes from requestLocationUpdates API method.                                                                                                                                                                                                                                                                                 |

#### Data Types

##### Location

| Properties                   | Type   | Description                                                                                                             |
|------------------------------|--------|-------------------------------------------------------------------------------------------------------------------------|
| provider                     | String | Location provider, such as network location, GPS, Wi-Fi, and Bluetooth.                                                 |
| latitude                     | double | Latitude of a location. If no latitude is available, 0.0 is returned.                                                   |
| longitude                    | double | Longitude of a location. If no longitude is available, 0.0 is returned.                                                 |
| altitude                     | double | Altitude of a location. If no altitude is available, 0.0 is returned.                                                   |
| speed                        | double | Speed of a device at the current location, in meters per second. If no speed is available, 0.0 is returned.             |
| bearing                      | double | Bearing of a device at the current location, in degrees. If no bearing is available, 0.0 is returned.                   |
| horizontalAccuracyMeters     | double | Horizontal error of a location, in meters. If no horizontal error is available, 0.0 is returned.                        |
| verticalAccuracyMeters       | double | Vertical error of a location, in meters. If no vertical error is available, 0.0 is returned.                            |
| speedAccuracyMetersPerSecond | double | Speed error of a device at the current location, in meters per second. If no speed error is available, 0.0 is returned. |
| bearingAccuracyDegrees       | double | Bearing error of the current location, in degrees. If no bearing error is available, 0.0 is returned.                   |
| time                         | int    | Current timestamp, in milliseconds.                                                                                     |
| elapsedRealtimeNanos         | int    | Time elapsed since the system was started, in nanoseconds                                                               |

##### HWLocation

| Properties                   | Type                   | Description                                                                                                             |
|------------------------------|------------------------|-------------------------------------------------------------------------------------------------------------------------|
| provider                     | String                 | Location provider, such as network location, GPS, Wi-Fi, and Bluetooth.                                                 |
| latitude                     | double                 | Latitude of a location. If no latitude is available, 0.0 is returned.                                                   |
| longitude                    | double                 | Longitude of a location. If no longitude is available, 0.0 is returned.                                                 |
| altitude                     | double                 | Altitude of a location. If no altitude is available, 0.0 is returned.                                                   |
| speed                        | double                 | Speed of a device at the current location, in meters per second. If no speed is available, 0.0 is returned.             |
| bearing                      | double                 | Bearing of a device at the current location, in degrees. If no bearing is available, 0.0 is returned.                   |
| horizontalAccuracyMeters     | double                 | Horizontal error of a location, in meters. If no horizontal error is available, 0.0 is returned.                        |
| verticalAccuracyMeters       | double                 | Vertical error of a location, in meters. If no vertical error is available, 0.0 is returned.                            |
| speedAccuracyMetersPerSecond | double                 | Speed error of a device at the current location, in meters per second. If no speed error is available, 0.0 is returned. |
| bearingAccuracyDegrees       | double                 | Bearing error of the current location, in degrees. If no bearing error is available, 0.0 is returned.                   |
| time                         | int                    | Current timestamp, in milliseconds.                                                                                     |
| elapsedRealtimeNanos         | int                    | Time elapsed since the system was started, in nanoseconds                                                               |
| countryCode                  | String                 | Country code. The value is a two-letter code complying with the ISO 3166-1 standard.                                    |
| countryName                  | String                 | Country name.                                                                                                           |
| state                        | String                 | Administrative region.                                                                                                  |
| city                         | String                 | City of the current location.                                                                                           |
| county                       | String                 | County of the current location.                                                                                         |
| street                       | String                 | Street of the current location.                                                                                         |
| featureName                  | String                 | Landmark building at the current location.                                                                              |
| postalCode                   | String                 | Postal code of the current location.                                                                                    |
| phone                        | String                 | Phone number of the landmark building (such as a store or company) at the current location.                             |
| url                          | String                 | Website of the landmark building (such as a store or company) at the current location.                                  |
| extraInfo                    | Map\<String, dynamic\> | Additional information, which is a key-value pair.                                                                      |

##### LocationRequest

| Properties           | Type   | Description                                                                                                                                                                                                  |
|----------------------|--------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| priority             | int    | Request priority. The default value is 100.                                                                                                                                                                  |
| interval             | int    | Request interval, in milliseconds. The default value is 3600000.                                                                                                                                             |
| fastestInterval      | int    | Shortest request interval, in milliseconds. The default value is 600000. If another app initiates a location request, the location is also reported to the app at the interval specified in fastestInterval. |
| expirationTime       | int    | Request expiration time, in milliseconds.                                                                                                                                                                    |
| numUpdates           | int    | Number of requested location updates.                                                                                                                                                                        |
| smallestDisplacement | double | Minimum displacement between location updates, in meters.                                                                                                                                                    |
| maxWaitTime          | int    | Maximum waiting timeIndicates whether to return the address information. The default value is false.                                                                                                         |
| needAddress          | bool   | Indicates whether to return the address information. The default value is false.                                                                                                                             |
| language             | String | Language. The value consists of two letters and complies with the ISO 639-1 international standard. By default, the value is empty.                                                                          |
| countryCode          | String | Country code. The value consists of two letters and complies with the ISO 3166-1 international standard. By default, the value is empty.                                                                     |

| Constants                        | Type | Value | Description                                                                                                                                  |
|----------------------------------|------|-------|----------------------------------------------------------------------------------------------------------------------------------------------|
| PRIORITY_HIGH_ACCURACY           | int  | 100   | Used to request the most accurate location.                                                                                                  |
| PRIORITY_BALANCED_POWER_ACCURACY | int  | 102   | Used to request the block-level location.                                                                                                    |
| PRIORITY_LOW_POWER               | int  | 104   | Used to request the city-level location.                                                                                                     |
| PRIORITY_NO_POWER                | int  | 105   | Used to request the location with the optimal accuracy without additional power consumption.                                                 |
| PRIORITY_HD_ACCURACY             | int  | 200   | Used to request the high-precision location information. Currently, this parameter is available only for the requestLocationUpdatesExCb API. |

| Methods                        | Return Type | Description                                                                           |
|--------------------------------|-------------|---------------------------------------------------------------------------------------|
| isFastestIntervalExplicitlySet | bool        | Indicates whether the fastest interval explicitly set or default value is being used. |

##### LocationResult

| Properties     | Type               | Description                                                                                           |
|----------------|--------------------|-------------------------------------------------------------------------------------------------------|
| locations      | List\<Location\>   | Available locations, which are ordered from oldest to newest.                                         |
| hwLocations    | List\<HWLocation\> | List of available locations sorted from oldest to newest, including the detailed address information. |
| lastLocation   | Location           | Available location of the last request.                                                               |
| lastHWLocation | HWLocation         | Available location of the last request, including the detailed address information.                   |

##### LocationCallback

| Properties             | Type                                                     | Description                                                |
|------------------------|----------------------------------------------------------|------------------------------------------------------------|
| onLocationAvailability | void Function(LocationAvailability locationAvailability) | Callback function to listen location availability changes. |
| onLocationResult       | void Function(LocationResult locationResult)             | Callback function to listen location updates.              |

##### LocationAvailability

| Properties        | Type | Description                                                                                               |
|-------------------|------|-----------------------------------------------------------------------------------------------------------|
| cellStatus        | int  | Availability status code of cell location. Currently not provided. Value is always **0**.                 |
| wifiStatus        | int  | Availability status code of wifi location. Currently not provided. Value is always **0**.                 |
| elapsedRealtimeNs | int  | Time elapsed since the system was started, in nanoseconds. Currently not provided. Value is always **0**. |
| locationStatus    | int  | Location status code. If the value of smaller than 1000, then device location is available.               |

| Methods             | Return Type | Description                                    |
|---------------------|-------------|------------------------------------------------|
| isLocationAvailable | bool        | Indicates if the location is available or not. |

##### LocationSettingsRequest

| Properties | Type                    | Description                                                                                                  |
|------------|-------------------------|--------------------------------------------------------------------------------------------------------------|
| requests   | List\<LocationRequest\> | Collection of LocationRequest object.                                                                        |
| alwaysShow | bool                    | Indicates whether BLE scanning needs to be enabled. The options are true (yes) and false (no).               |
| needBle    | bool                    | Indicates whether a location is required for the app to continue. The options are true (yes) and false (no). |

##### LocationSettingsStates

| Properties             | Type | Description                                                                            |
|------------------------|------|----------------------------------------------------------------------------------------|
| blePresent             | bool | Indicates whether the BLE exists on the device.                                        |
| bleUsable              | bool | Indicates whether the BLE is enabled and can be used by the app.                       |
| gpsPresent             | bool | Indicates whether the GPS provider exists on the device.                               |
| gpsUsable              | bool | Indicates whether the GPS provider is enabled and can be used by the app.              |
| locationPresent        | bool | Indicates whether the location provider exists on the device.                          |
| locationUsable         | bool | Indicates whether the location provider is enabled and can be used by the app.         |
| networkLocationPresent | bool | Indicates whether the network location provider exists on the device.                  |
| networkLocationUsable  | bool | Indicates whether the network location provider is enabled and can be used by the app. |

### Activity Identification and Conversion

#### Methods

| Return Type                              | Method                                                                              | Description                                                                                                                                                                                      |
|------------------------------------------|-------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Future\<int\>                            | createActivityIdentificationUpdates(int detectionIntervalMillis)                    | This API is used to register for activity identification updates.                                                                                                                                |
| Future\<int\>                            | createActivityConversionUpdates(List\<ActivityConversionInfo\> activityConversions) | This API is used to activity conversions (entering and exit), for example, detecting user status change from walking to bicycling.The Conversion API supports the following activity parameters. |
| Future\<void\>                           | deleteActivityIdentificationUpdates(int requestCode)                                | This API is used to remove all activity identification updates from the specified  **requestCode**.                                                                                              |
| Future\<void\>                           | deleteActivityConversionUpdates(int requestCode)                                    | This API is used to remove all activity conversion updates from the specified  **requestCode**.                                                                                                  |
| Stream\<ActivityIdentificationResponse\> | onActivityIdentification                                                            | This API is used to listen activity identification updates that comes from createActivityIdentificationUpdates API method.                                                                       |
| Stream\<ActivityConversionResponse\>     | onActivityConversion                                                                | This API is used to listen activity conversion updates that comes from createActivityConversionUpdates API method.                                                                               |

#### Data Types

##### ActivityIdentificationData

| Properties             | Type | Description                                                                                                                                             |
|------------------------|------|---------------------------------------------------------------------------------------------------------------------------------------------------------|
| identificationActivity | int  | Type of the detected activity.                                                                                                                          |
| possibility            | int  | The confidence for the user to execute the activity. The confidence ranges from 0 to 100. A larger value indicates more reliable activity authenticity. |

| Constants | Type | Value | Description                                                     |
|-----------|------|-------|-----------------------------------------------------------------|
| VEHICLE   | int  | 100   | The device is in a vehicle, such as a car.                      |
| BIKE      | int  | 101   | The device is on a bicycle.                                     |
| FOOT      | int  | 102   | The device user is walking or running.                          |
| STILL     | int  | 103   | The device is still.                                            |
| OTHERS    | int  | 104   | The current activity cannot be detected.                        |
| TILTING   | int  | 105   | The device has an obvious tilt change.                          |
| WALKING   | int  | 107   | The user of the device is walking,it is a sub-activity of FOOT. |
| RUNNING   | int  | 108   | The user of the device is running,it is a sub-activity of FOOT. |

| Methods                      | Return Type | Description                                                    |
|------------------------------|-------------|----------------------------------------------------------------|
| static isValidType(int type) | bool        | Checks that given activity type is one of the valid constants. |

##### Activity Identification Service

| Properties                  | Type                               | Description                                                                                                     |
|-----------------------------|------------------------------------|-----------------------------------------------------------------------------------------------------------------|
| time                        | int                                | Time of this identification, which is in milliseconds since January 1, 1970.                                    |
| elapsedTimeFromReboot       | int                                | Elapsed real time (in milliseconds) of this identification since boot.                                          |
| activityIdentificationDatas | List\<ActivityIdentificationData\> | List of activitiy identification list. The activity identifications are sorted by most probable activity first. |

| Methods                                  | Return Type                | Description                                                                       |
|------------------------------------------|----------------------------|-----------------------------------------------------------------------------------|
| mostActivityIdentification               | ActivityIdentificationData | This API is used to obtain the most probable activity identification of the user. |
| getActivityPossibility(int activityType) | int                        | This API is used to obtain the confidence of an activity type.                    |

##### ActivityConversionData

| Properties            | Type | Description                                                                                                                                            |
|-----------------------|------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
| activityType          | int  | Activity type of the conversion. The value is one of the activity types defined in ActivityIdentificationData.                                         |
| conversionType        | int  | Activity conversion information. The options are ActivityConversionInfo.ENTER_ACTIVITY_CONVERSION and ActivityConversionInfo.EXIT_ACTIVITY_CONVERSION. |
| elapsedTimeFromReboot | int  | Elapsed real time (in milliseconds) of this conversion since boot.                                                                                     |

##### ActivityConversionInfo

| Properties     | Type | Description                                                                                                                                             |
|----------------|------|---------------------------------------------------------------------------------------------------------------------------------------------------------|
| activityType   | int  | Activity type of the conversion. The value is one of the activity types defined in ActivityIdentificationData.                                          |
| conversionType | int  | Activity conversion information. The options are  ActivityConversionInfo.ENTER_ACTIVITY_CONVERSION and ActivityConversionInfo.EXIT_ACTIVITY_CONVERSION. |

| Constants                 | Type | Value | Description                       |
|---------------------------|------|-------|-----------------------------------|
| ENTER_ACTIVITY_CONVERSION | int  | 0     | A user enters the given activity. |
| EXIT_ACTIVITY_CONVERSION  | int  | 1     | A user exits the given activity.  |

##### ActivityConversionResponse

| Properties              | Type                           | Description                                                                                                       |
|-------------------------|--------------------------------|-------------------------------------------------------------------------------------------------------------------|
| activityConversionDatas | List\<ActivityConversionData\> | All activity conversion events in the result. The obtained activity events are sorted by time in ascending order. |

### Geofence Service

#### Methods

| Return Type            | Method                                                | Description                                                                                                                            |
|------------------------|-------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|
| Future\<int\>          | createGeofenceList(GeofenceRequest geofenceRequest)   | This API is used to add geofences. When a geofence is triggered, a notification can be listened through **onGeofenceData** API method. |
| Future\<void\>         | deleteGeofenceList(int requestCode)                   | This API is used to remove geofences associated with a **requestCode**.                                                                |
| Future\<void\>         | deleteGeofenceListWithIds(List\<String\> geofenceIds) | This API is used to remove geofences by their unique IDs.                                                                              |
| Stream\<GeofenceData\> | onGeofenceData                                        | This API is used to listen geofence updates that comes from createGeofenceList API method.                                             |

#### Data Types

##### Geofence

| Properties           | Type   | Description                                                                                                                                                                                |
|----------------------|--------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| uniqueId             | String | Unique ID. If the unique ID already exists, the new geofence will overwrite the old one.                                                                                                   |
| conversions          | int    | Geofence conversions. The bitwise-OR operation is supported.                                                                                                                               |
| validDuration        | int    | Geofence timeout interval, in milliseconds. The geofence will be automatically deleted after this amount of time.                                                                          |
| latitude             | double | Latitude. The value range is [-90,90].                                                                                                                                                     |
| longitude            | double | Longitude. The value range is [-180,180].                                                                                                                                                  |
| radius               | double | Radius, in meters.                                                                                                                                                                         |
| notificationInterval | int    | Notification response capability. The default value is **0**. Setting it to a larger value can reduce power consumption accordingly. However, reporting of geofence events may be delayed. |
| dwellDelayTime       | int    | Lingering duration for converting a geofence event, in milliseconds. A geofence event is converted when a user lingers in a geofence for this amount of time.                              |

| Constants                 | Type | Value | Description                                         |
|---------------------------|------|-------|-----------------------------------------------------|
| ENTER_GEOFENCE_CONVERSION | int  | 1     | A user enters the geofence.                         |
| EXIT_GEOFENCE_CONVERSION  | int  | 2     | A user exits the geofence.                          |
| DWELL_GEOFENCE_CONVERSION | int  | 4     | A user lingers in the geofence.                     |
| GEOFENCE_NEVER_EXPIRE     | int  | -1    | No timeout interval is configured for the geofence. |

##### GeofenceData

| Properties               | Type           | Description                                |
|--------------------------|----------------|--------------------------------------------|
| errorCode                | int            | Error code.                                |
| conversion               | int            | Geofence convert type.                     |
| convertingGeofenceIdList | List\<String\> | List of converted geofence unique IDs.     |
| convertingLocation       | Location       | The location when a geofence is converted. |

##### GeofenceRequest

| Properties      | Type             | Description                                                                                                                                                                     |
|-----------------|------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| geofenceList    | List\<Geofence\> | List of geofences to be monitored.                                                                                                                                              |
| initConversions | int              | Initial  conversion type. This parameter is invalid if it is set to 0. The default value is GeofenceRequest.ENTER_INIT_CONVERSION &#124; GeofenceRequest.DWELL_INIT_CONVERSION. |
| coordinateType  | int              | Coordinate type of geofences. Defaults to GeofenceRequest.COORDINATE_TYPE_WGS_84.                                                                                               |

| Constants              | Type | Value | Description                                                                                                                                                                   |
|------------------------|------|-------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ENTER_INIT_CONVERSION  | int  | 1     | ENTER_INIT_CONVERSION is converted immediately when a request is initiated to add the geofence where a user device has already entered.                                       |
| EXIT_INIT_CONVERSION   | int  | 2     | EXIT_INIT_CONVERSION is converted immediately when a request is initiated to add the geofence where a user device has already exit.                                           |
| DWELL_INIT_CONVERSION  | int  | 4     | DWELL_INIT_CONVERSION is converted immediately when a request is initiated to add the geofence where a user device has already entered and stayed for the specified duration. |
| COORDINATE_TYPE_WGS_84 | int  | 1     | WGS_84 coordinate system.                                                                                                                                                     |
| COORDINATE_TYPE_GCJ_02 | int  | 0     | GCJ-02 coordinate system.                                                                                                                                                     |

### PermissionHandler

#### Methods

| Return Type    | Method                                 | Description                                                                                                             |
|----------------|----------------------------------------|-------------------------------------------------------------------------------------------------------------------------|
| Future\<bool\> | hasLocationPermission()                | This API is used to check location permission is available or not.                                                      |
| Future\<bool\> | hasBackgroundLocationPermission()      | This API is used to check background location permission is available or not.                                           |
| Future\<bool\> | hasActivityRecognitionPermission()     | This API is used to check activity permission is available or not.                                                      |
| Future\<bool\> | requestLocationPermission()            | This API is used to request location permission. Returns true if permission is granted, else returns false.             |
| Future\<bool\> | requestBackgroundLocationPermission()  | This API is used to request background location permission. Returns true if permission is granted, else returns false.  |
| Future\<bool\> | requestActivityRecognitionPermission() | This API is used to request activity recognition permission. Returns true if permission is granted, else returns false. |

## Configuration Description

No.

## Licensing and Terms

Huawei Location Kit Flutter Plugin uses the Apache 2.0 license.
