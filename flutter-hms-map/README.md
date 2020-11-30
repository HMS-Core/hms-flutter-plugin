# ![logo](https://github.com/HMS-Core/hms-flutter-plugin/raw/master/flutter-hms-map/.docs/logo.png) Huawei MAP Kit Flutter Plugin

---

## Contents

  - [1. Introduction](#1-introduction)
  - [2. Installation Guide](#2-installation-guide)
    - [Creating Project in App Gallery Connect](#creating-project-in-app-gallery-connect)
    - [Configuring the Signing Certificate Fingerprint](#configuring-the-signing-certificate-fingerprint)
    - [Integrating Flutter Map Plugin](#integrating-flutter-map-plugin)
  - [3. API Reference](#3-api-reference)
    - [HuaweiMap](#huaweimap)
    - [HuaweiMapUtils](#huaweimaputils)
    - [HuaweiMapController](#huaweimapcontroller)
    - [Data Types](#data-types)
  - [4. Configuration and Description](#4-configuration-and-description)
    - [Preparing for Release](#preparing-for-release)
  - [5. Sample Project](#5-sample-project)
  - [6. Questions or Issues](#6-questions-or-issues)
  - [7. Licensing and Terms](#7-licensing-and-terms)

---

## 1. Introduction

Huawei Map Kit, provides standard maps as well as UI elements such as markers, shapes, and layers for you to customize maps that better meet service scenarios. Enables users to interact with a map in your app through gestures and buttons in different scenarios.

Huawei Map Kit provides the following core capabilities:
- **Huawei Map**: Core map component with tons of features.
- **My Location**: Your location on the map.
- **Markers**: Adding markers on the map with tons of modifications with their [InfoWindow](#infowindow) component.
- **Polylines**: Adding polylines on the map with tons of modifications.
- **Polygons**: Adding polygons on the map with tons of modifications.
- **Circles**: Adding circles on the map with tons of modifications.
- **Ground Overlays**: Adding ground overlays on the map with tons of modifications. 
- **Tile Overlays**: Adding tile overlays on the map with tons of modifications. 

This plugin enables communication between HUAWEI MAP Kit SDK and Flutter platform. It exposes all functionality provided by HUAWEI MAP Kit SDK.

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

- To use HUAWEI Map, you need to enable the Map service first. For details, please refer to [Enabling Services](https://developer.huawei.com/consumer/en/doc/distribution/app/agc-enable_service#h1-1574822945685).

### Configuring the Signing Certificate Fingerprint

**Step 1:** Go to **Project Setting** > **General information**. In the **App information** field, click the icon next to SHA-256 certificate fingerprint, and enter the obtained **SHA256 certificate fingerprint**.

**Step 2:** After completing the configuration, click check mark.

### Integrating Flutter Map Plugin

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

- For Obfuscation Scripts, please refer to [Configuring Obfuscation Scripts](https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides/android-sdk-config-obfuscation-scripts-0000001050158643).

**Step 10:** On your Flutter project directory find and open your **pubspec.yaml** file and add library to dependencies.

- To download the package from [pub.dev](https://pub.dev/publishers/developer.huawei.com/packages).

  ```yaml
  dependencies:
    huawei_map: { library version }
  ```

  **or**

  If you downloaded the package from the HUAWEI Developer website, specify the **library path** on your local device.

  ```yaml
  dependencies:
    huawei_map:
      # Replace {library path} with actual library path of Huawei Map Plugin for Flutter.
      path: { library path }
  ```

  - Replace {library path} with the actual library path of Flutter Map Plugin. The following are examples:
    - Relative path example: `path: ../huawei_map`
    - Absolute path example: `path: D:\Projects\Libraries\huawei_map`

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

### HuaweiMap

A *Stateful Widget* which displays a map with data obtained from the Huawei Map service.

#### Public Properties

| Name                     | Type                                            | Description                                                  |
| ------------------------ | ----------------------------------------------- | ------------------------------------------------------------ |
| key                      | Key                                             | Key.                                                         |
| initialCameraPosition    | [*CameraPosition*](#cameraposition)             | Specifies the initial camera position for a map.             |
| compassEnabled           | bool                                            | Sets whether to enable the compass for a map.                |
| mapToolbarEnabled        | bool                                            | Sets whether to enable toolbar for a map.                    |
| cameraTargetBounds       | [*CameraTargetBounds*](#cameratargetbounds)     | Sets a [LatLngBounds](#latlngbounds) object to constrain the camera target so that the camera target does not move outside the bounds when a user scrolls the map. |
| mapType                  | [*MapType*](#enum-maptype)                      | Sets the map type.                                           |
| minMaxZoomPreference     | [*MinMaxZoomPreference*](#minmaxzoompreference) | Sets the preferred minimum and maximum zoom level of the camera. |
| rotateGesturesEnabled    | bool                                            | Specifies whether to enable rotate gestures for a map.       |
| scrollGesturesEnabled    | bool                                            | Sets whether to enable scroll gestures for a map.            |
| zoomControlsEnabled      | bool                                            | Specifies whether to enable the zoom function for the camera. |
| zoomGesturesEnabled      | bool                                            | Sets whether to enable zoom gestures for a map.              |
| tiltGesturesEnabled      | bool                                            | Sets whether to enable tilt gestures for a map.              |
| padding                  | *EdgeInsets*                                    | Sets padding on a map.                                       |
| markers                  | Set\<[*Marker*](#marker)>                       | Adds markers to a map. The marker icon is displayed at the specified position on the map. |
| polygons                 | Set\<[*Polygon*](#polygon)>                     | Adds polygons to a map.                                      |
| polylines                | Set\<[*Polyline*](#polyline)>                   | Adds polylines to a map.                                     |
| circles                  | Set\<[*Circle*](#circle)>                       | Adds circles to a map. The longitude and latitude of the center and the radius are specified for the circle to indicate the surrounding area of a location. |
| groundOverlays           | Set\<[*GroundOverlay*](#groundoverlay)>         | Adds images to a map.                                        |
| tileOverlays             | Set\<[*TileOverlay*](#tileoverlay)>             | Adds tile overlays to a map.                                 |
| myLocationEnabled        | bool                                            | Sets whether to enable the my-location layer. If the my-location layer is enabled and the location is available, the layer constantly draws the user's current location and bearing and displays the UI controls for the user to interact with their location. To use the my-location layer function, you must apply for the **ACCESS_COARSE_LOCATION** or **ACCESS_FINE_LOCATION** permissions. |
| myLocationButtonEnabled  | bool                                            | Sets whether to enable the my-location icon for a map.       |
| trafficEnabled           | bool                                            | Sets whether to enable the traffic status layer.             |
| buildingsEnabled         | bool                                            | Sets whether to enable the 3D building layer.                |
| markersClusteringEnabled | bool                                            | Sets whether a marker can be clustered.                      |
| onMapCreated             | *MapCreatedCallback*                            | Function to be called when a map is created.                 |
| onCameraMoveStarted      | *VoidCallback*                                  | Function to be called when a camera move started.            |
| onCameraMove             | *CameraPositionCallback*                        | Function to be called when a camera moved.                   |
| onCameraIdle             | *VoidCallback*                                  | Function to be called when a camera is idle.                 |
| onClick                  | *ArgumentCallback*\<[*LatLng*](#latlng)>        | Function to be called when map is clicked.                   |
| onLongPress              | *ArgumentCallback*\<[*LatLng*](#latlng)>        | Function to be called when a map is long clicked.            |
| gestureRecognizers       | Set\<Factory\<*OneSequenceGestureRecognizers*>> | Gesture recognizers.                                         |

#### Public Constructor Summary

| Constructor                                                  | Description          |
| ------------------------------------------------------------ | -------------------- |
| HuaweiMap({Key key, CameraPosition initialCameraPosition, MapType mapType, Set\<Factory\<OneSequenceGestureRecognizers>> gestureRecognizers, bool compassEnabled, bool mapToolbarEnabled, CameraTargetBounds cameraTargetBounds, MinMaxZoomPreference minMaxZoomPreference, bool rotateGesturesEnabled, bool scrollGesturesEnabled, bool zoomControlsEnabled, bool zoomGesturesEnabled, bool tiltGesturesEnabled, bool myLocationEnabled, bool myLocationButtonEnabled, EdgeInsets padding, bool trafficEnabled, bool markersClusteringEnabled, bool buildingsEnabled, Set\<Marker> markers, Set\<Polygon> polygons, Set\<Polyline> polylines, Set\<Circle> circles, Set\<GroundOverlay> groundOverlays, Set\<TileOverlay> tileOverlays, MapCreatedCallback onMapCreated, VoidCallback onCameraMoveStarted, CameraPositionCallback onCameraMove, VoidCallback onCameraIdle, ArgumentCallback\<LatLng> onClick, ArgumentCallback\<LatLng> onLongPress}) | Default constructor. |

#### Public Constructors

##### HuaweiMap({Key key, CameraPosition initialCameraPosition, MapType mapType, Set\<Factory\<OneSequenceGestureRecognizers>> gestureRecognizers, bool compassEnabled, bool mapToolbarEnabled, CameraTargetBounds cameraTargetBounds, MinMaxZoomPreference minMaxZoomPreference, bool rotateGesturesEnabled, bool scrollGesturesEnabled, bool zoomControlsEnabled, bool zoomGesturesEnabled, bool tiltGesturesEnabled, bool myLocationEnabled, bool myLocationButtonEnabled, EdgeInsets padding, bool trafficEnabled, bool markersClusteringEnabled, bool buildingsEnabled, Set\<Marker> markers, Set\<Polygon> polygons, Set\<Polyline> polylines, Set\<Circle> circles, Set\<GroundOverlay> groundOverlays, Set\<TileOverlay> tileOverlays, MapCreatedCallback onMapCreated, VoidCallback onCameraMoveStarted, CameraPositionCallback onCameraMove, VoidCallback onCameraIdle, ArgumentCallback\<LatLng> onClick, ArgumentCallback\<LatLng> onLongPress})

Constructor for *HuaweiMap* widget.

| Parameter                | Type                                            | Description                                                  |
| ------------------------ | ----------------------------------------------- | ------------------------------------------------------------ |
| key                      | Key                                             | Key.                                                         |
| initialCameraPosition    | [*CameraPosition*](#cameraposition)             | Specifies the initial camera position for a map.             |
| compassEnabled           | bool                                            | Sets whether to enable the compass for a map.                |
| mapToolbarEnabled        | bool                                            | Sets whether to enable toolbar for a map.                    |
| cameraTargetBounds       | [*CameraTargetBounds*](#cameratargetbounds)     | Sets a [LatLngBounds](#latlngbounds) object to constrain the camera target so that the camera target does not move outside the bounds when a user scrolls the map. |
| mapType                  | [*MapType*](#enum-maptype)                           | Sets the map type.                                           |
| minMaxZoomPreference     | [*MinMaxZoomPreference*](#minmaxzoompreference) | Sets the preferred minimum and maximum zoom level of the camera. |
| rotateGesturesEnabled    | bool                                            | Specifies whether to enable rotate gestures for a map.       |
| scrollGesturesEnabled    | bool                                            | Sets whether to enable scroll gestures for a map.            |
| zoomControlsEnabled      | bool                                            | Specifies whether to enable the zoom function for the camera. |
| zoomGesturesEnabled      | bool                                            | Sets whether to enable zoom gestures for a map.              |
| tiltGesturesEnabled      | bool                                            | Sets whether to enable tilt gestures for a map.              |
| padding                  | *EdgeInsets*                                    | Sets padding on a map.                                       |
| markers                  | Set\<[*Marker*](#marker)>                       | Adds markers to a map. The marker icon is displayed at the specified position on the map. |
| polygons                 | Set\<[*Polygon*](#polygon)>                     | Adds polygons to a map.                                      |
| polylines                | Set\<[*Polyline*](#polyline)>                   | Adds polylines to a map.                                     |
| circles                  | Set\<[*Circle*](#circle)>                       | Adds circles to a map. The longitude and latitude of the center and the radius are specified for the circle to indicate the surrounding area of a location. |
| groundOverlays           | Set\<[*GroundOverlay*](#groundoverlay)>         | Adds images to a map.                                        |
| tileOverlays             | Set\<[*TileOverlay*](#tileoverlay)>             | Adds tile overlays to a map.                                 |
| myLocationEnabled        | bool                                            | Sets whether to enable the my-location layer. If the my-location layer is enabled and the location is available, the layer constantly draws the user's current location and bearing and displays the UI controls for the user to interact with their location. To use the my-location layer function, you must apply for the **ACCESS_COARSE_LOCATION** or **ACCESS_FINE_LOCATION** permission unless you have set a custom location source. |
| myLocationButtonEnabled  | bool                                            | Sets whether to enable the my-location icon for a map.       |
| trafficEnabled           | bool                                            | Sets whether to enable the traffic status layer.             |
| buildingsEnabled         | bool                                            | Sets whether to enable the 3D building layer.                |
| markersClusteringEnabled | bool                                            | Sets whether a marker can be clustered.                      |
| onMapCreated             | *MapCreatedCallback*                            | Function to be called when a map is created.                 |
| onCameraMoveStarted      | *VoidCallback*                                  | Function to be called when a camera move started.            |
| onCameraMove             | *CameraPositionCallback*                        | Function to be called when a camera moved.                   |
| onCameraIdle             | *VoidCallback*                                  | Function to be called when a camera is idle.                 |
| onClick                  | *ArgumentCallback*\<[*LatLng*](#latlng)>        | Function to be called when map is clicked.                   |
| onLongPress              | *ArgumentCallback*\<[*LatLng*](#latlng)>        | Function to be called when a map is long clicked.            |
| gestureRecognizers       | Set\<Factory\<*OneSequenceGestureRecognizers*>> | Gesture recognizers.                                         |

### HuaweiMapUtils

Entry class for Huawei Map Utilities. 

#### Public Method Summary

| Method                                                       | Return Type     | Description                                                  |
| ------------------------------------------------------------ | --------------- | ------------------------------------------------------------ |
| [disableLogger()](#futurevoid-disablelogger-async)           | Future\<void>   | Disables HMS Logger.                                         |
| [enableLogger()](#futurevoid-enablelogger-async)             | Future\<void>   | Enables HMS Logger.                                          |
| [distanceCalculator(LatLng start, LatLng end)](#futuredouble-distancecalculatorlatlng-start-latlng-end-async) | Future\<double> | Method used to calculate the distance between two coordinate points. |

#### Public Methods

##### Future\<void> disableLogger() *async*

This method disables the HMSLogger capability which is used for sending usage analytics of Map SDK's methods to improve the service quality. Asynchronous. 

###### Return Type

| Type          | Description                                          |
| ------------- | ---------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example

```dart
//Call disableLogger API.
await HuaweiMapUtils.disableLogger();
```

##### Future\<void> enableLogger() *async*

This method enables the HMSLogger capability which is used for sending usage analytics of Map SDK's methods to improve the service quality. Asynchronous.

###### Return Type

| Type         | Description                                         |
| ------------- | --------------------------------------------------- |
| Future\<void> | Future result of an execution that return no value. |

###### Call Example

```dart
//Call enableLogger API.
await HuaweiMapUtils.enableLogger();
```

##### Future\<double> distanceCalculator(LatLng start, LatLng end) *async*

Method used to calculate the distance between two coordinate points. Asynchronous.

###### Parameters

| Name  | Description             |
| ----- | ----------------------- |
| start | Start coordinate point. |
| end   | End coordinate point.   |

###### Return Type

| Type            | Description                                                  |
| --------------- | ------------------------------------------------------------ |
| Future\<double> | Distance between the specified two coordinate points, in meters. |

###### Call Example

```dart
//Call distanceCalculator API. 
double result = await HuaweiMapUtils.distanceCalculator(
	start: LatLng(41.048641, 28.977033),
    end: LatLng(41.063984, 29.033135),
);
```

### HuaweiMapController

Map controller for Huawei Map. 

#### Public Method Summary

| Method                                                       | Return Type                                      | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------ | ------------------------------------------------------------ |
| [clearTileCache(TileOverlay tileOverlay)](#futurevoid-cleartilecachetileoverlay-tileoverlay-async) | Future\<void>                                    | Clears the cache of a tile overlay.                          |
| [startAnimationOnMarker(Marker marker)](#futurevoid-startanimationonmarkermarker-marker-async) | Future\<void>                                    | Starts the animation of a marker.                            |
| [animateCamera(CameraUpdate cameraUpdate)](#futurevoid-animatecameracameraupdate-cameraupdate-async) | Future\<void>                                    | Updates the camera position in animation mode.               |
| [moveCamera(CameraUpdate cameraUpdate)](#futurevoid-movecameracameraupdate-cameraupdate-async) | Future\<void>                                    | Updates the camera position. The movement is instantaneous.  |
| [setMapStyle(String mapStyle)](#futurevoid-setmapstylestring-mapstyle-async) | Future\<void>                                    | Sets the map style.                                          |
| [getVisibleRegion()](#futurelatlngbounds-getvisibleregion-async) | Future\<[*LatLngBounds*](#latlngbounds)>         | Obtains the visible region after conversion between the screen coordinates and longitude/latitude coordinates. |
| [getScreenCoordinate(LatLng latLng)](#futurescreencoordinate-getscreencoordinatelatlng-latlng-async) | Future\<[*ScreenCoordinate*](#screencoordinate)> | Obtains a location on the screen corresponding to the specified longitude/latitude coordinates. The location on the screen is specified in screen pixels (instead of display pixels) relative to the top left corner of the map (instead of the top left corner of the screen). |
| [getLatLng(ScreenCoordinate screenCoordinate)](#futurelatlng-getlatlngscreencoordinate-screencoordinate-async) | Future\<[*LatLng*](#latlng)>                     | Obtains the longitude and latitude of a location on the screen. The location on the screen is specified in screen pixels (instead of display pixels) relative to the top left corner of the map (instead of the top left corner of the screen). |
| [showMarkerInfoWindow(MarkerId markerId)](#futurevoid-showmarkerinfowindowmarkerid-markerid-async) | Future\<void>                                    | Displays the information window for a marker.                |
| [hideMarkerInfoWindow(MarkerId markerId)](#futurevoid-hidemarkerinfowindowmarkerid-markerid-async) | Future\<void>                                    | Hides the information window that is displayed for a marker. This method is invalid for invisible markers. |
| [isMarkerInfoWindowShown(MarkerId markerId)](#futurebool-ismarkerinfowindowshownmarkerid-markerid-async) | Future\<bool>                                    | Checks whether an information window is currently displayed for a marker. This method will not consider whether the information window is actually visible on the screen. |
| [isMarkerClusterable(MarkerId markerId)](#futurebool-ismarkerclusterablemarkerid-markerid-async) | Future\<bool>                                    | Checks whether a marker can be clustered.                    |
| [getZoomLevel()](#futuredouble-getzoomlevel-async)           | Future\<double>                                  | Obtains zoom level of a map.                                 |
| [takeSnapshot()](#futureuint8list-takesnapshot-async)        | Future\<*Uint8List*>                             | Takes a snapshot of a map.                                   |

#### Public Methods

##### Future\<void> clearTileCache(TileOverlay tileOverlay) *async*

Clears the cache of a tile overlay. Asynchronous.

###### Parameter

| Name        | Description                          |
| ----------- | ------------------------------------ |
| tileOverlay | [Tile overlay](#tileoverlay) object. |

###### Return Type

| Type          | Description                                          |
| ------------- | ---------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example:

```dart
//Define HuaweiMapController and TileOverlay.
HuaweiMapController mapController;
TileOverlay tileOverlay;

//Call clearTileCache API.
await mapController.clearTileCache(tileOverlay);
```

##### Future\<void> startAnimationOnMarker(Marker marker) *async*

Starts the animation of a marker. Asynchronous.

###### Parameter

| Name   | Description               |
| ------ | ------------------------- |
| marker | [Marker](#marker) object. |

###### Return Type

| Type          | Description                                          |
| ------------- | ---------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example:

```dart
//Define HuaweiMapController and a Marker with an Animation.
HuaweiMapController mapController;
Marker marker;

//Call startAnimationOnMarker API.
await mapController.startAnimationOnMarker(marker);
```

##### Future\<void> animateCamera(CameraUpdate cameraUpdate) *async*

Updates the camera position in animation mode. Asynchronous.

###### Parameter

| Name         | Description             |
| ------------ | ----------------------- |
| cameraUpdate | Camera position change. |

###### Return Type

| Type          | Description                                          |
| ------------- | ---------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example:

```dart
//Define HuaweiMapController and a CameraUpdate object.
HuaweiMapController mapController;
CameraUpdate cameraUpdate;

//Call animateCamera API.
await mapController.animateCamera(cameraUpdate);
```

##### Future\<void> moveCamera(CameraUpdate cameraUpdate) *async*

Updates the camera position. The movement is instantaneous. Asynchronous.

###### Parameter

| Name         | Description             |
| ------------ | ----------------------- |
| cameraUpdate | Camera position change. |

###### Return Type

| Type          | Description                                          |
| ------------- | ---------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example:

```dart
//Define HuaweiMapController and a CameraUpdate object.
HuaweiMapController mapController;
CameraUpdate cameraUpdate;

//Call moveCamera API.
await mapController.moveCamera(cameraUpdate);
```

##### Future\<void> setMapStyle(String mapStyle) *async*

Sets the map style. Asynchronous.

###### Parameter

| Name     | Description                 |
| -------- | --------------------------- |
| mapStyle | Map style as a JSON String. |

###### Return Type

| Type          | Description                                          |
| ------------- | ---------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example:

```dart
//Define HuaweiMapController.
HuaweiMapController mapController;

//Call setMapStyle API.
await mapController.setMapStyle("YOUR_MAP_STYLE_AS_JSON");
```

##### Future\<LatLngBounds> getVisibleRegion() *async*

Obtains the visible region after conversion between the screen coordinates and longitude/latitude coordinates. Asynchronous.

###### Return Type

| Type                                     | Description                                             |
| ---------------------------------------- | ------------------------------------------------------- |
| Future\<[*LatLngBounds*](#latlngbounds)> | Smallest bounding box that includes the visible region. |

###### Call Example:

```dart
//Define HuaweiMapController.
HuaweiMapController mapController;

//Call getVisibleRegion API.
LatLngBounds bounds = await mapController.getVisibleRegion();
```

##### Future\<ScreenCoordinate> getScreenCoordinate(LatLng latLng) *async*

Obtains a location on the screen corresponding to the specified longitude/latitude coordinates. The location on the screen is specified in screen pixels (instead of display pixels) relative to the top left corner of the map (instead of the top left corner of the screen). Asynchronous.

###### Parameter

| Name   | Description                                      |
| ------ | ------------------------------------------------ |
| latLng | Longitude and latitude of a location on the map. |

###### Return Type

| Type                                             | Description                                         |
| ------------------------------------------------ | --------------------------------------------------- |
| Future\<[*ScreenCoordinate*](#screencoordinate)> | Coordinates of a location on the screen, in pixels. |

###### Call Example:

```dart
//Define HuaweiMapController and a LatLng object.
HuaweiMapController mapController;
LatLng latLng;

//Call getScreenCoordinate API.
ScreenCoordinate coordinate = await mapController.getScreenCoordinate(latLng);
```

##### Future\<LatLng> getLatLng(ScreenCoordinate screenCoordinate) *async*

Obtains the longitude and latitude of a location on the screen. The location on the screen is specified in screen pixels (instead of display pixels) relative to the top left corner of the map (instead of the top left corner of the screen). Asynchronous.

###### Parameter

| Name             | Description                                         |
| ---------------- | --------------------------------------------------- |
| screenCoordinate | Coordinates of a location on the screen, in pixels. |

###### Return Type

| Type                         | Description                                                  |
| ---------------------------- | ------------------------------------------------------------ |
| Future\<[*LatLng*](#latlng)> | [*LatLng*](#latlng) object that contains the corresponding longitude and latitude. |

###### Call Example:

```dart
//Define HuaweiMapController and a ScreenCoordinate object.
HuaweiMapController mapController;
ScreenCoordinate screenCoordinate;

//Call getLatLng API.
LatLng latLng = await mapController.getLatLng(screenCoordinate);
```

##### Future\<void> showMarkerInfoWindow(MarkerId markerId) *async*

Displays the information window for a marker. Asynchronous.

###### Parameter

| Name     | Description |
| -------- | ----------- |
| markerId | Marker id.  |

###### Return Type

| Type          | Description                                          |
| ------------- | ---------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example:

```dart
//Define HuaweiMapController and a Marker object with InfoWindow.
HuaweiMapController mapController;
Marker marker;

//Call showMarkerInfoWindow API.
await mapController.showMarkerInfoWindow(marker.markerId);
```

##### Future\<void> hideMarkerInfoWindow(MarkerId markerId) *async*

Hides the information window that is displayed for a marker. This method is invalid for invisible markers. Asynchronous.

###### Parameter

| Name     | Description |
| -------- | ----------- |
| markerId | Marker id.  |

###### Return Type

| Type          | Description                                          |
| ------------- | ---------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example:

```dart
//Define HuaweiMapController and a Marker object with InfoWindow.
HuaweiMapController mapController;
Marker marker;

//Call hideMarkerInfoWindow API.
await mapController.hideMarkerInfoWindow(marker.markerId);
```

##### Future\<bool> isMarkerInfoWindowShown(MarkerId markerId) *async*

Checks whether an information window is currently displayed for a marker. This method will not consider whether the information window is actually visible on the screen. Asynchronous.

###### Parameter

| Name     | Description |
| -------- | ----------- |
| markerId | Marker id.  |

###### Return Type

| Type          | Description                                                  |
| ------------- | ------------------------------------------------------------ |
| Future\<bool> | **true** if an information window is currently displayed; **false** otherwise. |

###### Call Example:

```dart
//Define HuaweiMapController and a Marker object with InfoWindow.
HuaweiMapController mapController;
Marker marker;

//Call isMarkerInfoWindowShown API.
bool status = await mapController.isMarkerInfoWindowShown(marker.markerId);
```

##### Future\<bool> isMarkerClusterable(MarkerId markerId) *async*

Checks whether a marker can be clustered. Asynchronous.

###### Parameter

| Name     | Description |
| -------- | ----------- |
| markerId | Marker id.  |

###### Return Type

| Type          | Description                                                  |
| ------------- | ------------------------------------------------------------ |
| Future\<bool> | **true** if the marker can be clustered; **false** otherwise. |

###### Call Example:

```dart
//Define HuaweiMapController and a Marker object with clusterable feature.
HuaweiMapController mapController;
Marker marker;

//Call isMarkerClusterable API.
bool isClusterable = await mapController.isMarkerClusterable(marker.markerId);
```

##### Future\<double> getZoomLevel() *async*

Obtains zoom level of a map. Asynchronous.

###### Return Type

| Type            | Description |
| --------------- | ----------- |
| Future\<double> | Zoom level. |

###### Call Example:

```dart
//Define HuaweiMapController.
HuaweiMapController mapController;

//Call getZoomLevel API.
double zoomLevel = await mapController.getZoomLevel();
```

##### Future\<Uint8List> takeSnapshot() *async*

Takes a snapshot of a map. Asynchronous.

###### Return Type

| Type                 | Description                   |
| -------------------- | ----------------------------- |
| Future\<*Uint8List*> | *Uint8List* data of an image. |

###### Call Example:

```dart
//Define HuaweiMapController.
HuaweiMapController mapController;

//Call takeSnapshot API.
Uint8List imageData = await mapController.takeSnapshot();
```

### Data Types

#### Data Types Summary

| Class                                                        | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [*BitmapDescriptor*](#bitmapdescriptor)                      | Defines a Bitmap image. A Bitmap image can be used as a marker icon or for a ground overlay. |
| [*CameraPosition*](#cameraposition)                          | A class that encapsulates all camera attributes.             |
| [*CameraTargetBounds*](#cameratargetbounds)                  | A class that encapsulates bound attribute.                   |
| [*CameraUpdate*](#cameraupdate)                              | Provides various constructors for creating [*CameraUpdate*](#cameraupdate) objects that modify the camera of a map. |
| [*Cap*](#cap)                                                | Defines a cap that is applied at the start or end vertex of a polyline. |
| [*InfoWindow*](#infowindow)                                  | Defines an information window that shows up when a Marker is tapped. |
| [*JointType*](#jointtype)                                    | Defines the joint type for a polyline.                       |
| [*LatLng*](#latlng)                                          | Represents the longitude and latitude, in degrees.           |
| [*LatLngBounds*](#latlngbounds)                              | Represents a longitude/latitude aligned rectangle.           |
| [*MinMaxZoomPreference*](#minmaxzoompreference)              | A class that encapsulates minimum and maximum zoom attributes. |
| [*PatternItem*](#patternitem)                                | An immutable class that describes the stroke pattern of a polyline. |
| [*ScreenCoordinate*](#screencoordinate)                      | A class that encapsulates x and y attributes.                |
| [*Circle*](#circle)                                          | Defines a circle on a map.                                   |
| [*CircleId*](#circleid)                                      | Represents the immutable circle id class.                    |
| [*Marker*](#marker)                                          | Defines an icon placed at a specified position on a map.     |
| [*MarkerId*](#markerid)                                      | Represents the immutable marker id class.                    |
| [*Polygon*](#polygon)                                        | Defines a polygon on a map.                                  |
| [*PolygonId*](#polygonid)                                    | Represents the immutable polygon id class.                   |
| [*Polyline*](#polyline)                                      | Defines a polyline on a map.                                 |
| [*PolylineId*](#polylineid)                                  | Represents the immutable polyline id class.                  |
| [*GroundOverlay*](#groundoverlay)                            | Class that defines an image on the map.                      |
| [*GroundOverlayId*](#groundoverlayid)                        | Represents the immutable ground overlay id class.            |
| [*TileOverlay*](#tileoverlay)                                | Represents a tile overlay. A tile overlay is a set of images to be displayed on a map. It can be transparent and enable you to add new functions to an existing map. |
| [*TileOverlayId*](#tileoverlayid)                            | Represents the immutable tile overlay id class.              |
| [*Tile*](#tile)                                              | Provides tile images for [*TileOverlay*](#tileoverlay).      |
| [UrlTile](#urltile)                                          | Provides tile images for [*TileOverlay*](#tileoverlay) from URL. |
| [RepetitiveTile](#repetitivetile)                            | Provides repetitive tile images for [*TileOverlay*](#tileoverlay). |
| [*HmsMarkerAnimation*](#hmsmarkeranimation)                  | An abstract class for supporting marker animation.           |
| [*HmsMarkerAlphaAnimation*](#hmsmarkeralphaanimation)        | An animation class that controls the transparency.           |
| [*HmsMarkerRotateAnimation*](#hmsmarkerrotateanimation)      | A class that controls the animation rotation.                |
| [*HmsMarkerScaleAnimation*](#hmsmarkerscaleanimation)        | A class for controlling the animation scale.                 |
| [*HmsMarkerTranslateAnimation*](#hmsmarkertranslateanimation) | A class that controls the animation movement.                |
| [*MapType*](#enum-maptype)                                   | Map types.                                                   |

#### BitmapDescriptor

Defines a *Bitmap* image. A *Bitmap* image can be used as a [*Marker*](#marker) icon or for a [*GroundOverlay*](#groundoverlay).

##### Public Constants

| Constant      | Type                 | Value | Description     |
| ------------- | -------------------- | ----- | --------------- |
| hueRed        | double               | 0.0   | Red.            |
| hueOrange     | double               | 30.0  | Orange.         |
| hueYellow     | double               | 60.0  | Yellow.         |
| hueGreen      | double               | 120.0 | Green.          |
| hueCyan       | double               | 180.0 | Cyan.           |
| hueAzure      | double               | 210.0 | Azure.          |
| hueBlue       | double               | 240.0 | Blue.           |
| hueViolet     | double               | 270.0 | Violet.         |
| hueMagenta    | double               | 300.0 | Magenta.        |
| hueRose       | double               | 330.0 | Rose.           |
| defaultMarker | **BitmapDescriptor** | -     | Default marker. |

##### Public Constructor Summary

| Constructor                                                  | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| BitmapDescriptor.defaultMarkerWithHue(double hue)            | Creates a **BitmapDescriptor** objects for default marker icons in different colors using different hue values. This class provides 10 hue values. You can call this method by passing a hue value. |
| BitmapDescriptor.fromBytes(Uint8List byteData)               | Creates a **BitmapDescriptor** object from a Uint8List.      |
| BitmapDescriptor.fromAsset(String assetName, String package) | Creates a **BitmapDescriptor** object from an asset.         |
| BitmapDescriptor.fromAssetImage(ImageConfiguration configuration, String assetName, AssetBundle bundle, String package, bool mipmaps) | Creates a **BitmapDescriptor** object from an image asset.   |

##### Public Constructors

###### BitmapDescriptor.defaultMarkerWithHue(double hue)

Creates a **BitmapDescriptor** objects for default marker icons in different colors using different hue values. This class provides 10 hue values. You can call this method by passing a hue value.

**Parameters**

| Name | Description |
| ---- | ----------- |
| hue  | Hue value.  |

###### BitmapDescriptor.fromBytes(Uint8List byteData)

Creates a **BitmapDescriptor** object from a *Uint8List*. 

**Parameter**

| Name     | Description             |
| -------- | ----------------------- |
| byteData | *Uint8List* image data. |

###### BitmapDescriptor.fromAsset(String assetName, String package)

Creates a **BitmapDescriptor** object from an asset. 

**Parameter**

| Name      | Description   |
| --------- | ------------- |
| assetName | Asset name.   |
| package   | Package name. |

###### BitmapDescriptor.fromAssetImage(ImageConfiguration configuration, String assetName, AssetBundle bundle, String package, bool mipmaps)

Creates a **BitmapDescriptor** object from an image asset.

**Parameter**

| Name          | Description                  |
| ------------- | ---------------------------- |
| configuration | *ImageConfiguration* object. |
| assetName     | Asset name.                  |
| bundle        | *AssetBundle* object.        |
| package       | Package name.                |
| mipmaps       | Defines mipmap.              |

#### CameraPosition

A class that encapsulates all camera attributes.

##### Public Properties

| Name    | Type                | Description                                                  |
| ------- | ------------------- | ------------------------------------------------------------ |
| bearing | double              | Direction that the camera is pointing in.                    |
| target  | [*LatLng*](#latlng) | Longitude and latitude of the location that the camera is pointing at. |
| tilt    | double              | Angle of the camera from the nadir (directly facing the Earth's surface). |
| zoom    | double              | Zoom level near the center of the screen.                    |

##### Public Constructor Summary

| Constructor                                                  | Description                                     |
| ------------------------------------------------------------ | ----------------------------------------------- |
| CameraPosition({double bearing, LatLng target, double tilt, double zoom}) | Default constructor.                            |
| CameraPosition.fromMap({dynamic json})                       | Creates a **CameraPosition** object from a Map. |

##### Public Constructors

###### CameraPosition({double bearing, LatLng target, double tilt, double zoom})

Constructor for **CameraPosition** object.

| Parameter | Type                | Description                                                  |
| --------- | ------------------- | ------------------------------------------------------------ |
| bearing   | double              | Direction that the camera is pointing in.                    |
| target    | [*LatLng*](#latlng) | Longitude and latitude of the location that the camera is pointing at. |
| tilt      | double              | Angle of the camera from the nadir (directly facing the Earth's surface). |
| zoom      | double              | Zoom level near the center of the screen.                    |

###### CameraPosition.fromMap({dynamic json})

Creates a **CameraPosition** object from a Map. 

| Parameter | Type    | Description      |
| --------- | ------- | ---------------- |
| json      | dynamic | Map as a source. |

#### CameraTargetBounds

A class that encapsulates bound attribute.

#####  Public Properties

| Name   | Type                            | Description                                                  |
| ------ | ------------------------------- | ------------------------------------------------------------ |
| bounds | [*LatLngBounds*](#latlngbounds) | Defines a rectangular area using a pair of longitude and latitude. |

##### Public Constants

| Constant  | Type                   | Description              |
| --------- | ---------------------- | ------------------------ |
| unbounded | **CameraTargetBounds** | Unbounded camera bounds. |

##### Public Constructor Summary

| Constructor                               | Description          |
| ----------------------------------------- | -------------------- |
| CameraTargetBounds({LatLngBounds bounds}) | Default constructor. |

##### Public Constructors

###### CameraTargetBounds({LatLngBounds bounds})

Constructor for **CameraTargetBounds** object.

| Parameter | Type                            | Description                                                  |
| --------- | ------------------------------- | ------------------------------------------------------------ |
| bounds    | [*LatLngBounds*](#latlngbounds) | Defines a rectangular area using a pair of longitude and latitude. |

#### CameraUpdate

Provides various constructors for creating **CameraUpdate** objects that modify the camera of a map.

##### Public Constructor Summary

| Constructor                                                  | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [CameraUpdate.newLatLng(LatLng latLng)](#cameraupdatenewlatlnglatlng-latlng) | Creates a **CameraUpdate** object pointed to a specific coordinate (latitude and longitude). |
| [CameraUpdate.zoomIn()](#cameraupdatezoomin)                 | Creates a **CameraUpdate** object that zooms the camera in.  |
| [CameraUpdate.zoomOut()](#cameraupdatezoomout)               | Creates a **CameraUpdate** object that zooms the camera out. |
| [CameraUpdate.zoomTo(double zoom)](#cameraupdatezoomtodouble-zoom) | Creates a **CameraUpdate** object that sets the camera zoom level. |
| [CameraUpdate.zoomBy({double amount, Offset focus})](#cameraupdatezoombydouble-amount-offset-focus) | Creates a **CameraUpdate** object that modifies the camera zoom level by the specified amount. |
| [CameraUpdate.newLatLngBounds({LatLngBounds bounds, double padding})](#cameraupdatenewlatlngboundslatlngbounds-bounds-double-padding) | Creates a **CameraUpdate** object pointed to specific bounds and padding. |
| [CameraUpdate.newLatLngZoom({LatLng latLng, double zoom})](#cameraupdatenewlatlngzoomlatlng-latlng-double-zoom) | Creates a **CameraUpdate** object pointed to a specific coordinate (latitude and longitude) and zoom level. |
| [CameraUpdate.newCameraPosition({CameraPosition cameraPosition})](#cameraupdatenewcamerapositioncameraposition-cameraposition) | Creates a **CameraUpdate** object using the [CameraPosition](#cameraposition) object. |
| [CameraUpdate.scrollBy({double dx, double dy})](#cameraupdatescrollbydouble-dx-double-dy) | Creates a **CameraUpdate** object that moves the camera by the specified distance on the screen. |

##### Public Constructors

###### CameraUpdate.newLatLng(LatLng latLng)

Creates a **CameraUpdate** object pointed to a specific coordinate (latitude and longitude).

**Parameters**

| Name   | Description                     |
| ------ | ------------------------------- |
| latLng | Desired longitude and latitude. |

###### CameraUpdate.zoomIn()

Creates a **CameraUpdate** object that zooms the camera in.

###### CameraUpdate.zoomOut()

Creates a **CameraUpdate** object that zooms the camera out.

###### CameraUpdate.zoomTo(double zoom)

Creates a **CameraUpdate** object that sets the camera zoom level.

**Parameters**

| Name | Description                                                  |
| ---- | ------------------------------------------------------------ |
| zoom | Zoom level of the map camera. The value range is [3, 20]. If the passed value exceeds the maximum, the maximum value will be used as the value. |

###### CameraUpdate.zoomBy({double amount, Offset focus})

Creates a **CameraUpdate** object that modifies the camera zoom level by the specified amount.

Incrementally moves the map camera based on the map center's coordinates on the screen and the zoom level. The distance to the earth surface is shortened if **amount** has a positive value and prolonged if **amount** has a negative value. In the method, **focus** is the center point for zooming in or out.

**Parameters**

| Name   | Description                                 |
| ------ | ------------------------------------------- |
| amount | Incremental value to change the zoom level. |
| focus  | Map center's coordinates on the screen.     |

###### CameraUpdate.newLatLngBounds({LatLngBounds bounds, double padding})

Creates a **CameraUpdate** object pointed to specific bounds and padding.

Centers a region on the screen by setting the longitude and latitude bounds and the padding between the region edges and the longitude/latitude bounding box edges

**Parameters**

| Name    | Description                                                  |
| ------- | ------------------------------------------------------------ |
| bounds  | Longitude and latitude bounds to be displayed.               |
| padding | Space between the region edges and bounding box edges, in pixels. |

###### CameraUpdate.newLatLngZoom({LatLng latLng, double zoom})

Creates a **CameraUpdate** object pointed to a specific coordinate (latitude and longitude) and zoom level.

**Parameters**

| Name   | Description                                                  |
| ------ | ------------------------------------------------------------ |
| latLng | Longitude and latitude of the center of a map's view.        |
| zoom   | Zoom level of the map camera. The value range is [3, 20]. If the passed value exceeds the maximum, the maximum value will be used as the value. |

###### CameraUpdate.newCameraPosition({CameraPosition cameraPosition})

Creates a **CameraUpdate** object using the [CameraPosition](#cameraposition) object.

**Parameters**

| Name           | Description                  |
| -------------- | ---------------------------- |
| cameraPosition | Camera position information. |

###### CameraUpdate.scrollBy({double dx, double dy})

Creates a **CameraUpdate** object that moves the camera by the specified distance on the screen.

**Parameters**

| Name | Description                                                  |
| ---- | ------------------------------------------------------------ |
| dx   | Number of pixels moved horizontally. A positive value indicates to move the center to the right, while a negative value indicates to move the center to the left. |
| dy   | Number of pixels moved vertically. A positive value indicates to move the center up, while a negative value indicates to move the center down. |

 #### Cap

Defines a cap that is applied at the start or end vertex of a polyline.

##### Public Constants

| Constant  | Type    | Description                                                  |
| --------- | ------- | ------------------------------------------------------------ |
| squareCap | **Cap** | Sets the start or end vertex of a polyline to the square type. |
| buttCap   | **Cap** | Defines a cap that is squared off exactly at the start or end vertex of a polyline. |
| roundCap  | **Cap** | Represents a semicircle with a radius equal to a half of the stroke width. The semicircle will be centered at the start or end vertex of a polyline. |

##### Public Constructor Summary

| Constructor                                                  | Description                              |
| ------------------------------------------------------------ | ---------------------------------------- |
| Cap.customCapFromBitmap({BitmapDescriptor bitmapDescriptor, double refWidth}) | Customizes the cap style for a polyline. |

##### Public Constructors

###### Cap.customCapFromBitmap({BitmapDescriptor bitmapDescriptor, double refWidth})

Customizes the cap style for a [*Polyline*](#polyline).

| Parameter        | Type                                    | Description                                                  |
| ---------------- | --------------------------------------- | ------------------------------------------------------------ |
| bitmapDescriptor | [*BitmapDescriptor*](#bitmapdescriptor) | Definition of a Bitmap to be overlaid at the start or end vertex of a polyline. |
| refWidth         | double                                  | Reference stroke width, in pixels.                           |

#### InfoWindow

Defines an information window that shows up when a [*Marker*](#marker) is tapped.

##### Public Properties

| Name    | Type           | Description                                                  |
| ------- | -------------- | ------------------------------------------------------------ |
| title   | String         | Title of a [*Marker*](#marker). By default, the title is empty. |
| snippet | String         | Snippet of a [*Marker*](#marker).                            |
| anchor  | *Offset*       | Offset of an information window.                             |
| onClick | *VoidCallback* | Function to be executed when an information window is tapped. |

##### Public Constants

| Constant | Type           | Description               |
| -------- | -------------- | ------------------------- |
| noText   | **InfoWindow** | Empty information window. |

##### Public Constructor Summary

| Constructor                                                  | Description          |
| ------------------------------------------------------------ | -------------------- |
| InfoWindow({String title, String snippet, Offset anchor, VoidCallback onClick}) | Default constructor. |

##### Public Constructors

###### InfoWindow({String title, String snippet, Offset anchor, VoidCallback onClick})

Default constructor for **InfoWindow** object.

| Parameter | Type           | Description                                                  |
| --------- | -------------- | ------------------------------------------------------------ |
| title     | String         | Title of a [*Marker*](#marker). By default, the title is empty. |
| snippet   | String         | Snippet of a [*Marker*](#marker).                            |
| anchor    | *Offset*       | Offset of an information window.                             |
| onClick   | *VoidCallback* | Function to be executed when an information window is tapped. |

##### Public Method Summary

| Method                                                       | Return Type    | Description                                                  |
| ------------------------------------------------------------ | -------------- | ------------------------------------------------------------ |
| InfoWindow.updateCopy({String title, String snippet, Offset anchor, VoidCallback onClick}) | **InfoWindow** | Copies an existing **InfoWindow** object and updates the specified attributes. |

##### Public Methods

###### InfoWindow.updateCopy({String title, String snippet, Offset anchor, VoidCallback onClick})

Copies an existing **InfoWindow** object and updates the specified attributes.

**Parameters**

| Name    | Description                                                  |
| ------- | ------------------------------------------------------------ |
| title   | Title of a [*Marker*](#marker). By default, the title is empty. |
| snippet | Snippet of a [*Marker*](#marker).                            |
| anchor  | Offset of an information window.                             |
| onClick | Function to be executed when an information window is tapped. |

**Return Type**

| Type           | Description            |
| -------------- | ---------------------- |
| **InfoWindow** | **InfoWindow** object. |

**Call Example**

```dart
//Define an InfoWindow.
InfoWindow infoWindow;

//Call updateCopy method.
infoWindow = infoWindow.updateCopy(title: "XXX");
```

#### JointType

Defines the joint type for a [*Polyline*](#polyline).

##### Public Properties

| Name | Type | Description                                                  |
| ---- | ---- | ------------------------------------------------------------ |
| type | int  | Type of the joint. The options include **0**, **1**, and **2**. |

##### Public Constants

| Constant | Type          | Value | Description   |
| -------- | ------------- | ----- | ------------- |
| mitered  | **JointType** | 0     | Default type. |
| bevel    | **JointType** | 1     | Flat bevel.   |
| round    | **JointType** | 2     | Round.        |

#### LatLng

Defines the longitude and latitude, in degrees.

##### Public Properties

| Name | Type   | Description                                                  |
| ---- | ------ | ------------------------------------------------------------ |
| lat  | double | Longitude. The value ranges from **–180** to **180** (excluded). |
| lng  | double | Latitude. The value ranges from **–90** to **90**.           |

##### Public Constructor Summary

| Constructor                      | Description                         |
| -------------------------------- | ----------------------------------- |
| LatLng({double lat, double lng}) | Default constructor.                |
| LatLng.fromJson(dynamic json)    | Creates **LatLng** object from Map. |

##### Public Constructors

###### LatLng({double lat, double lng})

Constructor for **LatLng** object.

| Parameter | Type   | Description                                                  |
| --------- | ------ | ------------------------------------------------------------ |
| lat       | double | Longitude. The value ranges from **–180** to **180** (excluded). |
| lng       | double | Latitude. The value ranges from **–90** to **90**.           |

###### LatLng.fromJson(dynamic json)

Creates **LatLng** object from Map.

| Parameter | Type    | Description      |
| --------- | ------- | ---------------- |
| json      | dynamic | Map as a source. |

#### LatLngBounds

Defines a rectangular area using a pair of longitude and latitude.

##### Public Properties

| Name      | Type                | Description                                       |
| --------- | ------------------- | ------------------------------------------------- |
| southwest | [*LatLng*](#latlng) | Coordinates of the southwest corner of the bound. |
| northeast | [*LatLng*](#latlng) | Coordinates of the northeast corner of the bound. |

##### Public Constructor Summary

| Constructor                                        | Description                               |
| -------------------------------------------------- | ----------------------------------------- |
| LatLngBounds({LatLng southwest, LatLng northeast}) | Default constructor.                      |
| LatLngBounds.fromList(dynamic json)                | Creates **LatLngBounds** object from Map. |

##### Public Constructors

###### LatLngBounds({LatLng southwest, LatLng northeast})

Constructor for **LatLngBounds** object.

| Parameter | Type                | Description                                       |
| --------- | ------------------- | ------------------------------------------------- |
| southwest | [*LatLng*](#latlng) | Coordinates of the southwest corner of the bound. |
| northeast | [*LatLng*](#latlng) | Coordinates of the northeast corner of the bound. |

###### LatLngBounds.fromList(dynamic json)

 Creates **LatLngBounds** object from Map.

| Parameter | Type    | Description      |
| --------- | ------- | ---------------- |
| json      | dynamic | Map as a source. |

##### Public Method Summary

| Method                              | Return Type | Description                                                  |
| ----------------------------------- | ----------- | ------------------------------------------------------------ |
| LatLngBounds.contains(LatLng point) | bool        | Checks whether a **LatLngBounds** object contains a specified location. |

##### Public Methods

###### LatLngBounds.contains(LatLng point)

Checks whether a **LatLngBounds** object contains a specified location.

**Parameters**

| Name  | Description            |
| ----- | ---------------------- |
| point | Location to be tested. |

**Return Type**

| Type | Description                                                  |
| ---- | ------------------------------------------------------------ |
| bool | **true** if the specified location is contained; **false** otherwise. |

**Call Example**

```dart
//Define a LatLngBounds and LatLng.
LatLngBounds latLngBounds;
LatLng latLng;

//Call contains method with LatLng.
bool status = latLngBounds.contains(latLng);
```

 #### MinMaxZoomPreference

A class that encapsulates attributes for setting the minimum and maximum zoom levels.

##### Public Properties

| Name    | Type   | Description         |
| ------- | ------ | ------------------- |
| minZoom | double | Minimum zoom level. |
| maxZoom | double | Maximum zoom level. |

##### Public Constants

| Constant  | Type                     | Description                |
| --------- | ------------------------ | -------------------------- |
| unbounded | **MinMaxZoomPreference** | Unbounded zoom preference. |

##### Public Constructor Summary

| Constructor                                            | Description          |
| ------------------------------------------------------ | -------------------- |
| MinMaxZoomPreference({double minZoom, double maxZoom}) | Default constructor. |

##### Public Constructors

###### MinMaxZoomPreference({double minZoom, double maxZoom})

Constructor for **MinMaxZoomPreference** object.

| Parameter | Type   | Description         |
| --------- | ------ | ------------------- |
| minZoom   | double | Minimum zoom level. |
| maxZoom   | double | Maximum zoom level. |

 #### PatternItem

An immutable class that describes the stroke pattern of a [*Polyline*](#polyline).

##### Public Constants

| Constant | Type            | Description |
| -------- | --------------- | ----------- |
| dot      | **PatternItem** | Dot type.   |

##### Public Constructor Summary

| Constructor                     | Description                                                  |
| ------------------------------- | ------------------------------------------------------------ |
| PatternItem.dash(double length) | Obtains a dash-type **PatternItem** object with a specified length. |
| PatternItem.gap(double length)  | Obtains a gap-type **PatternItem** object with a specified length. |

##### Public Constructors

###### PatternItem.dash(double length)

Obtains a dash-type **PatternItem** object with a specified length.

| Parameter | Type   | Description  |
| --------- | ------ | ------------ |
| length    | double | Dash length. |

###### PatternItem.gap(double length)

Obtains a gap-type **PatternItem** object with a specified length.

| Parameter | Type   | Description |
| --------- | ------ | ----------- |
| length    | double | Gap length. |

#### ScreenCoordinate

A class that encapsulates x and y attributes.

##### Public Properties

| Name | Type | Description |
| ---- | ---- | ----------- |
| x    | int  | X value.    |
| y    | int  | Y value.    |

##### Public Constructor Summary

| Constructor                      | Description          |
| -------------------------------- | -------------------- |
| ScreenCoordinate({int x, int y}) | Default constructor. |

##### Public Constructors

###### ScreenCoordinate({int x, int y})

Constructor for **ScreenCoordinate** object.

| Parameter | Type | Description |
| --------- | ---- | ----------- |
| x         | int  | X value.    |
| y         | int  | Y value.    |

#### Circle

Defines a circle on a map.

##### Public Properties

| Name        | Type                    | Description                                                  |
| ----------- | ----------------------- | ------------------------------------------------------------ |
| circleId    | [*CircleId*](#circleid) | Unique circle ID.                                            |
| clickable   | bool                    | Indicates whether a circle is tappable.                      |
| fillColor   | *Color*                 | Fill color.                                                  |
| center      | [*LatLng*](#latlng)     | Longitude and latitude of the center of a circle.            |
| radius      | double                  | Radius of a circle.                                          |
| strokeColor | *Color*                 | Stroke color.                                                |
| strokeWidth | int                     | Stroke width of a circle's outline.                          |
| visible     | bool                    | Visibility of a circle.                                      |
| zIndex      | int                     | Z-index of a circle, which indicates the overlapping order of the circle. |
| onClick     | *VoidCallback*          | Function to be executed when a circle is tapped.             |

##### Public Constructor Summary

| Constructor                                                  | Description          |
| ------------------------------------------------------------ | -------------------- |
| Circle({CircleId circleId, bool clickable, Color fillColor, LatLng center, double radius, Color strokeColor, int strokeWidth, bool visible, int zIndex, VoidCallback onClick}) | Default constructor. |

##### Public Constructors

###### Circle({CircleId circleId, bool clickable, Color fillColor, LatLng center, double radius, Color strokeColor, int strokeWidth, bool visible, int zIndex, VoidCallback onClick})

Constructor for **Circle** object.

| Parameter   | Type                    | Description                                                  |
| ----------- | ----------------------- | ------------------------------------------------------------ |
| circleId    | [*CircleId*](#circleid) | Unique circle ID.                                            |
| clickable   | bool                    | Indicates whether a circle is tappable.                      |
| fillColor   | *Color*                 | Fill color.                                                  |
| center      | [*LatLng*](#latlng)     | Longitude and latitude of the center of a circle.            |
| radius      | double                  | Radius of a circle.                                          |
| strokeColor | *Color*                 | Stroke color.                                                |
| strokeWidth | int                     | Stroke width of a circle's outline.                          |
| visible     | bool                    | Visibility of a circle.                                      |
| zIndex      | int                     | Z-index of a circle, which indicates the overlapping order of the circle. |
| onClick     | *VoidCallback*          | Function to be executed when a circle is tapped.             |

##### Public Method Summary

| Method                                                       | Return Type | Description                                                  |
| ------------------------------------------------------------ | ----------- | ------------------------------------------------------------ |
| Circle.updateCopy({bool clickable, Color fillColor, LatLng center, double radius, Color strokeColor, int strokeWidth, bool visible, int zIndex, VoidCallback onClick}) | **Circle**  | Copies an existing **Circle** object and updates the specified attributes. |
| Circle.clone()                                               | **Circle**  | Clones the Circle.                                           |

##### Public Methods

###### Circle.updateCopy({bool clickable, Color fillColor, LatLng center, double radius, Color strokeColor, int strokeWidth, bool visible, int zIndex, VoidCallback onClick})

Copies an existing **Circle** object and updates the specified attributes.

**Parameters**

| Name        | Description                                                  |
| ----------- | ------------------------------------------------------------ |
| clickable   | Indicates whether a circle is tappable.                      |
| fillColor   | Fill color.                                                  |
| center      | Longitude and latitude of the center of a circle.            |
| radius      | Radius of a circle.                                          |
| strokeColor | Stroke color.                                                |
| strokeWidth | Stroke width of a circle's outline.                          |
| visible     | Visibility of a circle.                                      |
| zIndex      | Z-index of a circle, which indicates the overlapping order of the circle. |
| onClick     | Function to be executed when a circle is tapped.             |

**Return Type**

| Type       | Description        |
| ---------- | ------------------ |
| **Circle** | **Circle** object. |

**Call Example**

```dart
//Define a Circle.
Circle circle;

//Call updateCopy method.
circle = circle.updateCopy(radius: 4000);
```

###### Circle.clone()

Clones the **Circle**.

**Return Type**

| Type       | Description        |
| ---------- | ------------------ |
| **Circle** | **Circle** object. |

**Call Example**

```dart
//Define a Circle.
Circle circle;
Circle circle2;

//Call clone method.
circle2 = circle.clone();
```

#### CircleId

Represents the immutable circle ID.

##### Public Properties

| Name | Type   | Description       |
| ---- | ------ | ----------------- |
| id   | String | Unique circle ID. |

##### Public Constructor Summary

| Constructor           | Description          |
| --------------------- | -------------------- |
| CircleId({String id}) | Default constructor. |

##### Public Constructors

###### CircleId({String id})

Constructor for **CircleId** object.

| Parameter | Type   | Description       |
| --------- | ------ | ----------------- |
| id        | String | Unique circle ID. |

#### Marker

Defines an icon placed at a specified position on a map.

##### Public Properties

| Name         | Type                                    | Description                                                  |
| ------------ | --------------------------------------- | ------------------------------------------------------------ |
| markerId     | [*MarkerId*](#markerid)                 | Unique marker ID.                                            |
| position     | [*LatLng*](#latlng)                     | Position of a marker.                                        |
| infoWindow   | [*InfoWindow*](#infowindow)             | Information window of a marker.                              |
| anchor       | *Offset*                                | Anchor point of a marker.                                    |
| draggable    | bool                                    | Indicates whether a marker can be dragged. The options are **true** (yes) and **false** (no). |
| flat         | bool                                    | Indicates whether to flatly attach a marker to the map. If the marker is flatly attached to the map, it will stay on the map when the camera rotates or tilts. The marker will remain the same size when the camera zooms in or out. If the marker faces the camera, it will always be drawn facing the camera and rotates or tilts with the camera. |
| icon         | [*BitmapDescriptor*](#bitmapdescriptor) | Marker icon to render.                                       |
| rotation     | double                                  | Rotation angle of a marker, in degrees.                      |
| alpha        | double                                  | Opacity. The value ranges from **0** (completely transparent) to **1** (completely opaque). |
| visible      | bool                                    | Indicates whether a marker is visible. The options are **true** (yes) and **false** (no). |
| zIndex       | double                                  | Z-index of a marker. The z-index indicates the overlapping order of a marker. A marker with a larger z-index overlaps that with a smaller z-index. Markers with the same z-index overlap each other in a random order. By default, the z-index is **0**. |
| clickable    | bool                                    | Indicates whether a marker can be tapped. The options are **true** (yes) and **false** (no). |
| clusterable  | bool                                    | Indicates whether a marker is clusterable or not.            |
| onClick      | *VoidCallback*                          | Callback method executed when a marker is tapped.            |
| onDragEnd    | ValueChanged\<[*LatLng*](#latlng)>      | Callback method executed when marker dragging is finished.   |
| animationSet | List\<dynamic>                          | Animations.                                                  |

##### Public Constructor Summary

| Constructor                                                  | Description          |
| ------------------------------------------------------------ | -------------------- |
| Marker({MarkerId markerId, LatLng position, InfoWindow infoWindow, Offset anchor, bool draggable, bool flat, BitmapDescriptor icon, double rotation, double alpha, bool visible, double zIndex, bool clickable, bool clusterable, VoidCallback onClick, ValueChanged\<LatLng> onDragEnd, List\<dynamic> animationSet}) | Default constructor. |

##### Public Constructors

###### Marker({MarkerId markerId, LatLng position, InfoWindow infoWindow, Offset anchor, bool draggable, bool flat, BitmapDescriptor icon, double rotation, double alpha, bool visible, double zIndex, bool clickable, bool clusterable, VoidCallback onClick, ValueChanged\<LatLng> onDragEnd, List\<dynamic> animationSet})

Constructor for **Marker** object. 

| Parameter    | Type                                    | Description                                                  |
| ------------ | --------------------------------------- | ------------------------------------------------------------ |
| markerId     | [*MarkerId*](#markerid)                 | Unique marker ID.                                            |
| position     | [*LatLng*](#latlng)                     | Position of a marker.                                        |
| infoWindow   | [*InfoWindow*](#infowindow)             | Information window of a marker.                              |
| anchor       | *Offset*                                | Anchor point of a marker.                                    |
| draggable    | bool                                    | Indicates whether a marker can be dragged. The options are **true** (yes) and **false** (no). |
| flat         | bool                                    | Indicates whether to flatly attach a marker to the map. If the marker is flatly attached to the map, it will stay on the map when the camera rotates or tilts. The marker will remain the same size when the camera zooms in or out. If the marker faces the camera, it will always be drawn facing the camera and rotates or tilts with the camera. |
| icon         | [*BitmapDescriptor*](#bitmapdescriptor) | Marker icon to render.                                       |
| rotation     | double                                  | Rotation angle of a marker, in degrees.                      |
| alpha        | double                                  | Opacity. The value ranges from **0** (completely transparent) to **1** (completely opaque). |
| visible      | bool                                    | Indicates whether a marker is visible. The options are **true** (yes) and **false** (no). |
| zIndex       | double                                  | Z-index of a marker. The z-index indicates the overlapping order of a marker. A marker with a larger z-index overlaps that with a smaller z-index. Markers with the same z-index overlap each other in a random order. By default, the z-index is **0**. |
| clickable    | bool                                    | Indicates whether a marker can be tapped. The options are **true** (yes) and **false** (no). |
| clusterable  | bool                                    | Indicates whether a marker is clusterable or not.            |
| onClick      | *VoidCallback*                          | Callback method executed when a marker is tapped.            |
| onDragEnd    | ValueChanged\<[*LatLng*](#latlng)>      | Callback method executed when marker dragging is finished.   |
| animationSet | List\<dynamic>                          | Animations.                                                  |

##### Public Method Summary

| Method                                                       | Return Type | Description                                                  |
| ------------------------------------------------------------ | ----------- | ------------------------------------------------------------ |
| Marker.updateCopy({LatLng position, InfoWindow infoWindow, Offset anchor, bool draggable, bool flat, BitmapDescriptor icon, double rotation, double alpha, bool visible, double zIndex, bool clickable, bool clusterable, VoidCallback onClick, ValueChanged\<LatLng> onDragEnd, List\<dynamic> animationSet}) | **Marker**  | Copies an existing **Marker** object and updates the specified attributes. |
| Marker.clone()                                               | **Marker**  | Clones the **Marker**.                                       |

##### Public Methods

###### Marker.updateCopy({LatLng position, InfoWindow infoWindow, Offset anchor, bool draggable, bool flat, BitmapDescriptor icon, double rotation, double alpha, bool visible, double zIndex, bool clickable, bool clusterable, VoidCallback onClick, ValueChanged\<LatLng> onDragEnd, List\<dynamic> animationSet})

Copies an existing **Marker** object and updates the specified attributes.

**Parameters**

| Name         | Description                                                  |
| ------------ | ------------------------------------------------------------ |
| position     | Position of a marker.                                        |
| infoWindow   | Information window of a marker.                              |
| anchor       | Anchor point of a marker.                                    |
| draggable    | Indicates whether a marker can be dragged. The options are **true** (yes) and **false** (no). |
| flat         | Indicates whether to flatly attach a marker to the map. If the marker is flatly attached to the map, it will stay on the map when the camera rotates or tilts. The marker will remain the same size when the camera zooms in or out. If the marker faces the camera, it will always be drawn facing the camera and rotates or tilts with the camera. |
| icon         | Marker icon to render.                                       |
| rotation     | Rotation angle of a marker, in degrees.                      |
| alpha        | Opacity. The value ranges from **0** (completely transparent) to **1** (completely opaque). |
| visible      | Indicates whether a marker is visible. The options are **true** (yes) and **false** (no). |
| zIndex       | Z-index of a marker. The z-index indicates the overlapping order of a marker. A marker with a larger z-index overlaps that with a smaller z-index. Markers with the same z-index overlap each other in a random order. By default, the z-index is **0**. |
| clickable    | Indicates whether a marker can be tapped. The options are **true** (yes) and **false** (no). |
| clusterable  | Indicates whether a marker is clusterable or not.            |
| onClick      | Callback method executed when a marker is tapped.            |
| onDragEnd    | Callback method executed when marker dragging is finished.   |
| animationSet | Animations.                                                  |

**Return Type**

| Type       | Description        |
| ---------- | ------------------ |
| **Marker** | **Marker** object. |

**Call Example**

```dart
//Define a Marker.
Marker marker;

//Call updateCopy method.
marker = marker.updateCopy(draggable: true);
```

###### Marker.clone()

Clones the **Marker**.

**Return Type**

| Type       | Description        |
| ---------- | ------------------ |
| **Marker** | **Marker** object. |

**Call Example**

```dart
//Define a Marker.
Marker marker;
Marker marker2;

//Call clone method.
marker2 = marker.clone();
```

#### MarkerId

Defines an immutable marker ID.

##### Public Properties

| Name | Type   | Description       |
| ---- | ------ | ----------------- |
| id   | String | Unique marker ID. |

##### Public Constructor Summary

| Constructor           | Description          |
| --------------------- | -------------------- |
| MarkerId({String id}) | Default constructor. |

##### Public Constructors

###### MarkerId({String id})

Constructor for **MarkerId** object.

| Parameter | Type   | Description       |
| --------- | ------ | ----------------- |
| id        | String | Unique marker ID. |

#### Polygon

Defines a polygon on a map.

##### Public Properties

| Name        | Type                       | Description                                                  |
| ----------- | -------------------------- | ------------------------------------------------------------ |
| polygonId   | [*PolygonId*](#polygonid)  | Unique polygon ID.                                           |
| clickable   | bool                       | Indicates whether a polygon is tappable.                     |
| fillColor   | *Color*                    | Fill color.                                                  |
| geodesic    | bool                       | Indicates whether to draw each segment of a polygon as a geodesic. The options are **true** (yes) and **false** (no). |
| points      | List\<[*LatLng*](#latlng)> | Vertex coordinate set.                                       |
| visible     | bool                       | Visibility of a polygon.                                     |
| strokeColor | *Color*                    | Stroke color.                                                |
| strokeWidth | int                        | Stroke width of a polygon's outline.                         |
| zIndex      | int                        | Z-index of a polygon, which indicates the overlapping order of the polygon. |
| onClick     | *VoidCallback*             | Function to be executed when a polygon is tapped.            |

##### Public Constructor Summary

| Constructor                                                  | Description          |
| ------------------------------------------------------------ | -------------------- |
| Polygon({PolygonId polygonId, bool clickable, Color fillColor, bool geodesic, List\<LatLng> points, bool visible, Color strokeColor, int strokeWidth, int zIndex, VoidCallback onClick}) | Default constructor. |

##### Public Constructors

###### Polygon({PolygonId polygonId, bool clickable, Color fillColor, bool geodesic, List\<LatLng> points, bool visible, Color strokeColor, int strokeWidth, int zIndex, VoidCallback onClick})

Constructor for **Polygon** object.

| Parameter   | Type                       | Description                                                  |
| ----------- | -------------------------- | ------------------------------------------------------------ |
| polygonId   | [*PolygonId*](#polygonid)  | Unique polygon ID.                                           |
| clickable   | bool                       | Indicates whether a polygon is tappable.                     |
| fillColor   | *Color*                    | Fill color.                                                  |
| geodesic    | bool                       | Indicates whether to draw each segment of a polygon as a geodesic. The options are **true** (yes) and **false** (no). |
| points      | List\<[*LatLng*](#latlng)> | Vertex coordinate set.                                       |
| visible     | bool                       | Visibility of a polygon.                                     |
| strokeColor | *Color*                    | Stroke color.                                                |
| strokeWidth | int                        | Stroke width of a polygon's outline.                         |
| zIndex      | int                        | Z-index of a polygon, which indicates the overlapping order of the polygon. |
| onClick     | *VoidCallback*             | Function to be executed when a polygon is tapped.            |

##### Public Method Summary

| Method                                                       | Return Type | Description                                                  |
| ------------------------------------------------------------ | ----------- | ------------------------------------------------------------ |
| Polygon.updateCopy({bool clickable, Color fillColor, bool geodesic, List\<LatLng> points, bool visible, Color strokeColor, int strokeWidth, int zIndex, VoidCallback onClick}) | **Polygon** | Copies an existing **Polygon** object and updates the specified attributes. |
| Polygon.clone()                                              | **Polygon** | Clones the **Polygon**.                                      |

##### Public Methods

###### Polygon.updateCopy({bool clickable, Color fillColor, bool geodesic, List\<LatLng> points, bool visible, Color strokeColor, int strokeWidth, int zIndex, VoidCallback onClick})

Copies an existing **Polygon** object and updates the specified attributes.

**Parameters**

| Name        | Description                                                  |
| ----------- | ------------------------------------------------------------ |
| clickable   | Indicates whether a polygon is tappable.                     |
| fillColor   | Fill color.                                                  |
| geodesic    | Indicates whether to draw each segment of a polygon as a geodesic. The options are **true** (yes) and **false** (no). |
| points      | Vertex coordinate set.                                       |
| visible     | Visibility of a polygon.                                     |
| strokeColor | Stroke color.                                                |
| strokeWidth | Stroke width of a polygon's outline.                         |
| zIndex      | Z-index of a polygon, which indicates the overlapping order of the polygon. |
| onClick     | Function to be executed when a polygon is tapped.            |

**Return Type**

| Type        | Description         |
| ----------- | ------------------- |
| **Polygon** | **Polygon** object. |

```dart
//Define a Polygon.
Polygon polygon;

//Call updateCopy method.
polygon = polygon.updateCopy(clickable: true);
```

###### Polygon.clone()

Clones the **Polygon**. 

**Return Type**

| Type        | Description         |
| ----------- | ------------------- |
| **Polygon** | **Polygon** object. |

**Call Example**

```dart 
//Define a Polygon.
Polygon polygon;
Polygon polygon2;

//Call clone method.
polygon2 = polygon.clone();
```

#### PolygonId

Defines an immutable polygon ID.

##### Public Properties

| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| id   | String | Unique polygon ID. |

##### Public Constructor Summary

| Constructor            | Description          |
| ---------------------- | -------------------- |
| PolygonId({String id}) | Default constructor. |

##### Public Constructors

###### PolygonId({String id})

Constructor for **PolygonId** object.

| Parameter | Type   | Description        |
| --------- | ------ | ------------------ |
| id        | String | Unique polygon ID. |

#### Polyline

Defines a polyline on a map.

##### Public Properties

| Name       | Type                                 | Description                                                  |
| ---------- | ------------------------------------ | ------------------------------------------------------------ |
| polylineId | [*PolylineId*](#polylineid)          | Unique polyline ID.                                          |
| clickable  | bool                                 | Indicates whether a polyline is tappable.                    |
| color      | *Color*                              | Stroke color.                                                |
| geodesic   | bool                                 | Indicates whether to draw each segment of a polyline as a geodesic. The options are **true** (yes) and **false** (no). |
| jointType  | [*JointType*](#jointtype)            | [*JointType*](#jointtype) of all vertices of a polyline, except the start and end vertices. |
| patterns   | List\<[*PatternItem*](#patternitem)> | Stroke pattern of a polyline. The default value is **null**, indicating that the stroke pattern is solid. |
| points     | List\<[*LatLng*](#latlng)>           | Vertices of a polyline. Line segments are drawn between consecutive points. A polyline is not closed by default. To form a closed polyline, the start and end vertices must be the same. |
| startCap   | [*Cap*](#cap)                        | Start vertex of a polyline.                                  |
| endCap     | [*Cap*](#cap)                        | End vertex of a polyline.                                    |
| visible    | bool                                 | Visibility of a polyline.                                    |
| width      | int                                  | Stroke width of a polyline.                                  |
| zIndex     | int                                  | Z-index of a polyline, which indicates the overlapping order of the polyline. |
| onClick    | *VoidCallback*                       | Function to be executed when a polyline is tapped.           |

##### Public Constructor Summary

| Constructor                                                  | Description          |
| ------------------------------------------------------------ | -------------------- |
| Polyline({PolylineId polylineId, bool clickable, Color color, bool geodesic, JointType jointType, List\<PatternItem> patterns, List\<LatLng> points, Cap startCap, Cap endCap, bool visible, int width, int zIndex, VoidCallback onClick}) | Default constructor. |

##### Public Constructors

###### Polyline({PolylineId polylineId, bool clickable, Color color, bool geodesic, JointType jointType, List\<PatternItem> patterns, List\<LatLng> points, Cap startCap, Cap endCap, bool visible, int width, int zIndex, VoidCallback onClick})

Constructor for **Polyline** object.

| Parameter  | Type                                 | Description                                                  |
| ---------- | ------------------------------------ | ------------------------------------------------------------ |
| polylineId | [*PolylineId*](#polylineid)          | Unique polyline ID.                                          |
| clickable  | bool                                 | Indicates whether a polyline is tappable.                    |
| color      | *Color*                              | Stroke color.                                                |
| geodesic   | bool                                 | Indicates whether to draw each segment of a polyline as a geodesic. The options are **true** (yes) and **false** (no). |
| jointType  | [*JointType*](#jointtype)            | [*JointType*](#jointtype) of all vertices of a polyline, except the start and end vertices. |
| patterns   | List\<[*PatternItem*](#patternitem)> | Stroke pattern of a polyline. The default value is **null**, indicating that the stroke pattern is solid. |
| points     | List\<[*LatLng*](#latlng)>           | Vertices of a polyline. Line segments are drawn between consecutive points. A polyline is not closed by default. To form a closed polyline, the start and end vertices must be the same. |
| startCap   | [*Cap*](#cap)                        | Start vertex of a polyline.                                  |
| endCap     | [*Cap*](#cap)                        | End vertex of a polyline.                                    |
| visible    | bool                                 | Visibility of a polyline.                                    |
| width      | int                                  | Stroke width of a polyline.                                  |
| zIndex     | int                                  | Z-index of a polyline, which indicates the overlapping order of the polyline. |
| onClick    | *VoidCallback*                       | Function to be executed when a polyline is tapped.           |

##### Public Method Summary

| Method                                                       | Return Type  | Description                                                  |
| ------------------------------------------------------------ | ------------ | ------------------------------------------------------------ |
| Polyline.updateCopy({bool clickable, Color color, bool geodesic, JointType jointType, List\<PatternItem> patterns, List\<LatLng> points, Cap startCap, Cap endCap, bool visible, int width, int zIndex, VoidCallback onClick}) | **Polyline** | Copies an existing **Polyline** object and updates the specified attributes. |
| Polyline.clone()                                             | **Polyline** | Clones the **Polyline**.                                     |

##### Public Methods

###### Polyline.updateCopy({bool clickable, Color color, bool geodesic, JointType jointType, List\<PatternItem> patterns, List\<LatLng> points, Cap startCap, Cap endCap, bool visible, int width, int zIndex, VoidCallback onClick})

Copies an existing **Polyline** object and updates the specified attributes.

**Parameters**

| Name      | Description                                                  |
| --------- | ------------------------------------------------------------ |
| clickable | Indicates whether a polyline is tappable.                    |
| color     | Stroke color.                                                |
| geodesic  | Indicates whether to draw each segment of a polyline as a geodesic. The options are **true** (yes) and **false** (no). |
| jointType | [*JointType*](#jointtype) of all vertices of a polyline, except the start and end vertices. |
| patterns  | Stroke pattern of a polyline. The default value is **null**, indicating that the stroke pattern is solid. |
| points    | Vertices of a polyline. Line segments are drawn between consecutive points. A polyline is not closed by default. To form a closed polyline, the start and end vertices must be the same. |
| startCap  | Start vertex of a polyline.                                  |
| endCap    | End vertex of a polyline.                                    |
| visible   | Visibility of a polyline.                                    |
| width     | Stroke width of a polyline.                                  |
| zIndex    | Z-index of a polyline, which indicates the overlapping order of the polyline. |
| onClick   | Function to be executed when a polyline is tapped.           |

**Return Type**

| Type         | Description         |
| ------------ | ------------------- |
| **Polyline** | **Poyline** object. |

**Call Example**

```dart
//Define a Polyline.
Polyline polyline;

//Call updateCopy method.
polyline = polyline.updateCopy(clickable: true);
```

###### Polyline.clone()

Clones the **Polyline**.

**Return Type**

| Type         | Description          |
| ------------ | -------------------- |
| **Polyline** | **Polyline** object. |

**Call Example**

```dart
//Define a Polyline.
Polyline polyline;
Polyline polyline2;

//Call clone method.
polyline2 = polyline.clone();
```

#### PolylineId

Defines an immutable polyline ID.

##### Public Properties

| Name | Type   | Description         |
| ---- | ------ | ------------------- |
| id   | String | Unique polyline ID. |

##### Public Constructor Summary

| Constructor             | Description         |
| ----------------------- | ------------------- |
| PolylineId({String id}) | Default constructor |

##### Public Constructors

###### PolylineId({String id})

Constructor for **PolylineId** object.

| Parameter | Type   | Description         |
| --------- | ------ | ------------------- |
| id        | String | Unique polyline ID. |

#### GroundOverlay

Class that defines an image on the map.

##### Public Properties

| Name            | Type                                    | Description                                                  |
| --------------- | --------------------------------------- | ------------------------------------------------------------ |
| groundOverlayId | [*GroundOverlayId*](#groundoverlayid)   | Unique Ground Overlay ID.                                    |
| bearing         | double                                  | Sets the bearing of a ground overlay, in degrees clockwise from north. |
| clickable       | bool                                    | Sets whether a ground overlay is tappable.                   |
| width           | double                                  | Width of a ground overlay, in meters.                        |
| height          | double                                  | Height of a ground overlay, in meters.                       |
| imageDescriptor | [*BitmapDescriptor*](#bitmapdescriptor) | Sets the image for a ground overlay.                         |
| position        | [*LatLng*](#latlng)                     | Sets the position of a ground overlay.                       |
| bounds          | [*LatLngBounds*](#latlngbounds)         | Sets bounds of a ground overlay.                             |
| anchor          | *Offset*                                | Sets anchor of a ground overlay.                             |
| transparency    | double                                  | Sets the transparency of a ground overlay.                   |
| visible         | bool                                    | Sets whether a ground overlay is visible. If the ground overlay is invisible, it will not be drawn but all other states will be preserved. |
| zIndex          | double                                  | Sets the z-index of a ground overlay. The z-index indicates the overlapping order of a ground overlay. A ground overlay with a larger z-index overlaps that with a smaller z-index. Ground overlays with the same z-index overlap each other in a random order. |
| onClick         | *VoidCallback*                          | Function to be executed when a ground overlay is tapped.     |

##### Public Constructor Summary

| Constructor                                                  | Description          |
| ------------------------------------------------------------ | -------------------- |
| GroundOverlay({GroundOverlayId groundOverlayId, double bearing, bool clickable, double width, double height, BitmapDescriptor imageDescriptor, LatLng position, LatLngBounds bounds, Offset anchor, double transparency, bool visible, double zIndex}) | Default constructor. |

##### Public Constructors

###### GroundOverlay({GroundOverlayId groundOverlayId, double bearing, bool clickable, double width, double height, BitmapDescriptor imageDescriptor, LatLng position, LatLngBounds bounds, Offset anchor, double transparency, bool visible, double zIndex})

Constructor for **GroundOverlay** object. 

| Parameter       | Type                                    | Description                                                  |
| --------------- | --------------------------------------- | ------------------------------------------------------------ |
| groundOverlayId | [*GroundOverlayId*](#groundoverlayid)   | Unique Ground Overlay ID.                                    |
| bearing         | double                                  | Sets the bearing of a ground overlay, in degrees clockwise from north. |
| clickable       | bool                                    | Sets whether a ground overlay is tappable.                   |
| width           | double                                  | Width of a ground overlay, in meters.                        |
| height          | double                                  | Height of a ground overlay, in meters.                       |
| imageDescriptor | [*BitmapDescriptor*](#bitmapdescriptor) | Sets the image for a ground overlay.                         |
| position        | [*LatLng*](#latlng)                     | Sets the position of a ground overlay.                       |
| bounds          | [*LatLngBounds*](#latlngbounds)         | Sets bounds of a ground overlay.                             |
| anchor          | *Offset*                                | Sets anchor of a ground overlay.                             |
| transparency    | double                                  | Sets the transparency of a ground overlay.                   |
| visible         | bool                                    | Sets whether a ground overlay is visible. If the ground overlay is invisible, it will not be drawn but all other states will be preserved. |
| zIndex          | double                                  | Sets the z-index of a ground overlay. The z-index indicates the overlapping order of a ground overlay. A ground overlay with a larger z-index overlaps that with a smaller z-index. Ground overlays with the same z-index overlap each other in a random order. |
| onClick         | *VoidCallback*                          | Function to be executed when a ground overlay is tapped.     |

##### Public Method Summary

| Method                                                       | Return Type       | Description                                                  |
| ------------------------------------------------------------ | ----------------- | ------------------------------------------------------------ |
| GroundOverlay.updateCopy({double bearing, bool clickable, double width, double height, BitmapDescriptor imageDescriptor, LatLng position, LatLngBounds bounds, Offset anchor, double transparency, bool visible, double zIndex}) | **GroundOverlay** | Copies an existing **GroundOverlay** object and updates the specified attributes. |
| GroundOverlay.clone()                                        | **GroundOverlay** | Clones the **GroundOverlay**.                                |

##### Public Methods

###### GroundOverlay.updateCopy({double bearing, bool clickable, double width, double height, BitmapDescriptor imageDescriptor, LatLng position, LatLngBounds bounds, Offset anchor, double transparency, bool visible, double zIndex})

Copies an existing **GroundOverlay** object and updates the specified attributes.

**Parameters**

| Name            | Description                                                  |
| --------------- | ------------------------------------------------------------ |
| bearing         | Sets the bearing of a ground overlay, in degrees clockwise from north. |
| clickable       | Sets whether a ground overlay is tappable.                   |
| width           | Width of a ground overlay, in meters.                        |
| height          | Height of a ground overlay, in meters.                       |
| imageDescriptor | Sets the image for a ground overlay.                         |
| position        | Sets the position of a ground overlay.                       |
| bounds          | Sets bounds of a ground overlay.                             |
| anchor          | Sets anchor of a ground overlay.                             |
| transparency    | Sets the transparency of a ground overlay.                   |
| visible         | Sets whether a ground overlay is visible. If the ground overlay is invisible, it will not be drawn but all other states will be preserved. |
| zIndex          | Sets the z-index of a ground overlay. The z-index indicates the overlapping order of a ground overlay. A ground overlay with a larger z-index overlaps that with a smaller z-index. Ground overlays with the same z-index overlap each other in a random order. |
| onClick         | Function to be executed when a ground overlay is tapped.     |

**Return Type**

| Type              | Description               |
| ----------------- | ------------------------- |
| **GroundOverlay** | **GroundOverlay** object. |

**Call Example**

```dart
//Define a GroundOverlay.
GroundOverlay groundOverlay;

//Call updateCopy method.
groundOverlay = groundOverlay.updateCopy(clickable: true);
```

###### GroundOverlay.clone()

Clones the **GroundOverlay**.

**Return Type**

| Type              | Description               |
| ----------------- | ------------------------- |
| **GroundOverlay** | **GroundOverlay** object. |

**Call Example**

```dart
//Define a GroundOverlay.
GroundOverlay groundOverlay;
GroundOverlay groundOverlay2;

//Call clone method.
groundOverlay2 = groundOverlay.clone();
```

#### GroundOverlayId

Defines an immutable ground overlay ID.

##### Public Properties

| Name | Type   | Description               |
| ---- | ------ | ------------------------- |
| id   | String | Unique ground overlay ID. |

##### Public Constructor Summary

| Constructor                  | Description         |
| ---------------------------- | ------------------- |
| GroundOverlayId({String id}) | Default constructor |

##### Public Constructors

###### GroundOverlayId({String id})

Constructor for **GroundOverlayId** object.

| Parameter | Type   | Description               |
| --------- | ------ | ------------------------- |
| id        | String | Unique ground overlay ID. |

#### TileOverlay

A tile overlay is a set of images to be displayed on a map. It can be transparent and enable you to add new functions to an existing map.

##### Public Properties

| Name          | Type                              | Description                                                  |
| ------------- | --------------------------------- | ------------------------------------------------------------ |
| tileOverlayId | [*TileOverlayId*](#tileoverlayid) | Unique Tile Overlay ID.                                      |
| fadeIn        | bool                              | Sets whether a tile overlay fades in.                        |
| transparency  | double                            | Sets the transparency of a tile overlay.                     |
| visible       | bool                              | Sets whether a tile overlay is visible. If the tile overlay is invisible, it will not be drawn but all other states will be preserved. By default, a tile overlay is visible. |
| zIndex        | double                            | Sets the z-index of a tile overlay. The z-index indicates the overlapping order of a tile overlay. A tile overlay with a larger z-index overlaps that with a smaller z-index. Tile overlays with the same z-index overlap each other in any order. |
| tileProvider  | dynamic                           | Sets the provider of a tile overlay.                         |
| type          | String                            | Type of providers.                                           |

##### Public Constructor Summary

| Constructor                                                  | Description          |
| ------------------------------------------------------------ | -------------------- |
| TileOverlay({TileOverlayId tileOverlayId, String type, dynamic tileProvider, bool fadeIn, double transparency, bool visible, double zIndex}) | Default constructor. |

##### Public Constructors

###### TileOverlay({TileOverlayId tileOverlayId, String type, dynamic tileProvider, bool fadeIn, double transparency, bool visible, double zIndex})

Constructor for **TileOverlay** object.

| Parameter     | Type                              | Description                                                  |
| ------------- | --------------------------------- | ------------------------------------------------------------ |
| tileOverlayId | [*TileOverlayId*](#tileoverlayid) | Unique Tile Overlay ID.                                      |
| fadeIn        | bool                              | Sets whether a tile overlay fades in.                        |
| transparency  | double                            | Sets the transparency of a tile overlay.                     |
| visible       | bool                              | Sets whether a tile overlay is visible. If the tile overlay is invisible, it will not be drawn but all other states will be preserved. By default, a tile overlay is visible. |
| zIndex        | double                            | Sets the z-index of a tile overlay. The z-index indicates the overlapping order of a tile overlay. A tile overlay with a larger z-index overlaps that with a smaller z-index. Tile overlays with the same z-index overlap each other in any order. |
| tileProvider  | dynamic                           | Sets the provider of a tile overlay.                         |
| type          | String                            | Type of providers.                                           |

##### Public Method Summary

| Method                                                       | Return Type     | Description                                                  |
| ------------------------------------------------------------ | --------------- | ------------------------------------------------------------ |
| TileOverlay.updateCopy({bool fadeIn, double transparency, bool visible, double zIndex, dynamic tileProvider, String type}) | **TileOverlay** | Copies an existing **TileOverlay** object and updates the specified attributes. |
| TileOverlay.clone()                                          | **TileOverlay** | Clones the **TileOverlay**.                                  |

##### Public Methods

###### TileOverlay.updateCopy({bool fadeIn, double transparency, bool visible, double zIndex, dynamic tileProvider, String type})

Copies an existing **TileOverlay** object and updates the specified attributes.

**Parameters**

| Name         | Description                                                  |
| ------------ | ------------------------------------------------------------ |
| fadeIn       | Sets whether a tile overlay fades in.                        |
| transparency | Sets the transparency of a tile overlay.                     |
| visible      | Sets whether a tile overlay is visible. If the tile overlay is invisible, it will not be drawn but all other states will be preserved. By default, a tile overlay is visible. |
| zIndex       | Sets the z-index of a tile overlay. The z-index indicates the overlapping order of a tile overlay. A tile overlay with a larger z-index overlaps that with a smaller z-index. Tile overlays with the same z-index overlap each other in any order. |
| tileProvider | Sets the provider of a tile overlay.                         |
| type         | Type of providers.                                           |

**Return Type**

| Type            | Description             |
| --------------- | ----------------------- |
| **TileOverlay** | **TileOverlay** object. |

**Call Example**

```dart
//Define a TileOverlay.
TileOverlay tileOverlay;

//Call updateCopy method.
tileOverlay = tileOverlay.updateCopy(visible: true);
```

###### TileOverlay.clone()

Clones the **TileOverlay**.

**Return Type**

| Type            | Description     |
| --------------- | --------------- |
| **TileOverlay** | **TileOverlay** |

**Call Example**

```dart
//Define a TileOverlay.
TileOverlay tileOverlay;
TileOverlay tileOverlay2;

//Call clone method.
tileOverlay2 = tileOverlay.clone();
```

 #### TileOverlayId

##### Public Properties

| Name | Type   | Description             |
| ---- | ------ | ----------------------- |
| id   | String | Unique tile overlay ID. |

##### Public Constructor Summary

| Constructor                | Description          |
| -------------------------- | -------------------- |
| TileOverlayId({String id}) | Default constructor. |

##### Public Constructors

###### TileOverlayId({String id})

Constructor for **TileOverlayId** object.

| Parameter | Type   | Description             |
| --------- | ------ | ----------------------- |
| id        | String | Unique tile overlay ID. |

#### Tile

Provides tile images for [*TileOverlay*](#tileoverlay).

##### Public Properties

| Name      | Type        | Description             |
| --------- | ----------- | ----------------------- |
| x         | int         | X value.                |
| y         | int         | Y value.                |
| zoom      | int         | Zoom level.             |
| imageData | *Uint8List* | *Uint8List* image data. |

##### Public Constructor Summary

| Constructor                                         | Description          |
| --------------------------------------------------- | -------------------- |
| Tile({int x, int y, int zoom, Uint8List imageData}) | Default constructor. |

##### Public Constructors

###### Tile({int x, int y, int zoom, Uint8List imageData})

Constructor for **Tile** object.

| Parameter | Type        | Description             |
| --------- | ----------- | ----------------------- |
| x         | int         | X value.                |
| y         | int         | Y value                 |
| zoom      | int         | Zoom level.             |
| imageData | *Uint8List* | *Uint8List* image data. |

#### UrlTile

Provides tile images for [*TileOverlay*](#tileoverlay) from URL.

##### Public Properties

| Name | Type   | Description                                                  |
| ---- | ------ | ------------------------------------------------------------ |
| uri  | String | URL of the image to be used at the specified tile coordinates. |

##### Public Constructor Summary

| Constructor           | Description          |
| --------------------- | -------------------- |
| UrlTile({String uri}) | Default constructor. |

##### Public Constructors

###### UrlTile({String uri})

Constructor for **UrlTile** object.

| Parameter | Type   | Description                                               |
| --------- | ------ | --------------------------------------------------------- |
| uri       | String | URL of the image to be used at specific tile coordinates. |

#### RepetitiveTile

Provides repetitive tile images for [*TileOverlay*](#tileoverlay).

##### Public Properties

| Name      | Type        | Description                |
| --------- | ----------- | -------------------------- |
| imageData | *Uint8List* | *Uint8List* image data.    |
| zoom      | List\<int>  | Zoom levels of repetition. |

##### Public Constructor Summary

| Constructor                                            | Description          |
| ------------------------------------------------------ | -------------------- |
| RepetitiveTile({Uint8List imageData, List\<int> zoom}) | Default constructor. |

##### Public Constructors

###### RepetitiveTile({Uint8List imageData, List\<int> zoom})

Constructor for **RepetitiveTile** object.

| Parameter | Type        | Descirption                |
| --------- | ----------- | -------------------------- |
| imageData | *Uint8List* | *Uint8List* image data.    |
| zoom      | List\<int>  | Zoom levels of repetition. |

#### HmsMarkerAnimation

An abstract class for supporting marker animation.

##### Public Properties

| Name         | Type   | Description                                                  |
| ------------ | ------ | ------------------------------------------------------------ |
| animationId  | String | Unique animation ID.                                         |
| type         | String | Animation type.                                              |
| duration     | int    | Sets the animation duration.                                 |
| fillMode     | int    | Sets the status after the animation ends.                    |
| repeatCount  | int    | Sets the number of times that an animation is replayed.      |
| repeatMode   | int    | Sets the animation replay mode. By default, the animation is replayed from the start. |
| interpolator | int    | Sets an animation interpolator.                              |

##### Public Constants

| Constant              | Type | Value | Description                                                  |
| --------------------- | ---- | ----- | ------------------------------------------------------------ |
| FORWARDS              | int  | 0     | *(Fill Mode)* The last frame is displayed after the animation ends. |
| BACKWARDS             | int  | 1     | *(Fill Mode)* The first frame is displayed after the animation ends. |
| INFINITE              | int  | -1    | *(Repeat Mode*) The animation is replayed infinitely.        |
| RESTART               | int  | 1     | *(Repeat Mode)* The animation is replayed from the start after it ends. |
| REVERSE               | int  | 2     | *(Repeat Mode)* The animation is replayed from the end in reverse order after it ends. |
| LINEAR                | int  | 0     | *(Interpolator)* Linear interpolator.                        |
| ACCELERATE            | int  | 1     | *(Interpolator)* Accelerate interpolator.                    |
| ANTICIPATE            | int  | 2     | *(Interpolator)* Anticipate interpolator.                    |
| BOUNCE                | int  | 3     | *(Interpolator)* Bounce interpolator.                        |
| DECELERATE            | int  | 4     | *(Interpolator)* Decelerate interpolator.                    |
| OVERSHOOT             | int  | 5     | *(Interpolator)* Overshoot interpolator.                     |
| ACCELERATE_DECELERATE | int  | 6     | *(Interpolator)* Accelerate decelerate interpolator.         |
| FAST_OUT_LINEAR_IN    | int  | 7     | *(Interpolator)* Fast out linear in interpolator.            |
| FAST_OUT_SLOW_IN      | int  | 8     | *(Interpolator)* Fast out slow in interpolator.              |
| LINEAR_OUT_SLOW_IN    | int  | 9     | *(Interpolator)* Linear out slow in interpolator.            |

##### Public Constructor Summary

| Constructor                                                  | Description          |
| ------------------------------------------------------------ | -------------------- |
| HmsMarkerAnimation({String animationId, String type, int duration, int fillMode, int repeatCount, int repeatMode, int interpolator}) | Default constructor. |

##### Public Constructors

###### HmsMarkerAnimation({String animationId, String type, int duration, int fillMode, int repeatCount, int repeatMode, int interpolator})

Constructor for **HmsMarkerAnimation** object.

| Parameter    | Type   | Description                                                  |
| ------------ | ------ | ------------------------------------------------------------ |
| animationId  | String | Unique animation ID.                                         |
| type         | String | Animation type.                                              |
| duration     | int    | Sets the animation duration.                                 |
| fillMode     | int    | Sets the status after the animation ends.                    |
| repeatCount  | int    | Sets the number of times that an animation is replayed.      |
| repeatMode   | int    | Sets the animation replay mode. By default, the animation is replayed from the start. |
| interpolator | int    | Sets an animation interpolator.                              |

#### HmsMarkerAlphaAnimation

An animation class that controls the transparency. The transparency value range is [0,1]. The value **1** indicates opaque.

##### Public Properties

| Name             | Type     | Description                                                  |
| ---------------- | -------- | ------------------------------------------------------------ |
| animationId      | String   | Unique animation ID.                                         |
| fromAlpha        | double   | Initial transparency.                                        |
| toAlpha          | double   | Target transparency.                                         |
| duration         | int      | Sets the animation duration.                                 |
| fillMode         | int      | Sets the status after the animation ends.                    |
| repeatCount      | int      | Sets the number of times that an animation is replayed.      |
| repeatMode       | int      | Sets the animation replay mode. By default, the animation is replayed from the start. |
| interpolator     | int      | Sets an animation interpolator.                              |
| onAnimationStart | Function | Function to be executed when an animation starts.             |
| onAnimationEnd   | Function | Function to be executed when an animation ends.               |

##### Public Constructor Summary

| Constructor                                                  | Description          |
| ------------------------------------------------------------ | -------------------- |
| HmsMarkerAlphaAnimation({String animationId, double fromAlpha, double toAlpha, int duration, int fillMode, int repeatCount, int repeatMode, int interpolator, Function onAnimationStart, Function onAnimationEnd}) | Default constructor. |

##### Public Constructors

###### HmsMarkerAlphaAnimation({String animationId, double fromAlpha, double toAlpha, int duration, int fillMode, int repeatCount, int repeatMode, int interpolator, Function onAnimationStart, Function onAnimationEnd})

Constructor for **HmsMarkerAlphaAnimation** object.

| Parameter        | Type     | Description                                                  |
| ---------------- | -------- | ------------------------------------------------------------ |
| animationId      | String   | Unique animation ID.                                         |
| fromAlpha        | double   | Initial transparency.                                        |
| toAlpha          | double   | Target transparency.                                         |
| duration         | int      | Sets the animation duration.                                 |
| fillMode         | int      | Sets the status after the animation ends.                    |
| repeatCount      | int      | Sets the number of times that an animation is replayed.      |
| repeatMode       | int      | Sets the animation replay mode. By default, the animation is replayed from the start. |
| interpolator     | int      | Sets an animation interpolator.                              |
| onAnimationStart | Function | Function to be executed when an animation starts.             |
| onAnimationEnd   | Function | Function to be executed when an animation ends.               |

#### HmsMarkerRotateAnimation

A class that controls the animation rotation.

##### Public Properties

| Name             | Type     | Description                                                  |
| ---------------- | -------- | ------------------------------------------------------------ |
| animationId      | String   | Unique animation ID.                                         |
| fromDegree       | double   | Initial angle.                                               |
| toDegree         | double   | Target angle.                                                |
| duration         | int      | Sets the animation duration.                                 |
| fillMode         | int      | Sets the status after the animation ends.                    |
| repeatCount      | int      | Sets the number of times that an animation is replayed.      |
| repeatMode       | int      | Sets the animation replay mode. By default, the animation is replayed from the start. |
| interpolator     | int      | Sets an animation interpolator.                              |
| onAnimationStart | Function | Function to be executed when an animation starts.             |
| onAnimationEnd   | Function | Function to be executed when an animation ends.               |

##### Public Constructor Summary

| Constructor                                                  | Description          |
| ------------------------------------------------------------ | -------------------- |
| HmsMarkerRotateAnimation({String animationId, double fromDegree, double toDegree, int duration, int fillMode, int repeatCount, int repeatMode, int interpolator, Function onAnimationStart, Function onAnimationEnd}) | Default constructor. |

##### Public Constructors

###### HmsMarkerRotateAnimation({String animationId, double fromDegree, double toDegree, int duration, int fillMode, int repeatCount, int repeatMode, int interpolator, Function onAnimationStart, Function onAnimationEnd})

Constructor for **HmsMarkerRotateAnimation** object. 

| Parameter        | Type     | Description                                                  |
| ---------------- | -------- | ------------------------------------------------------------ |
| animationId      | String   | Unique animation ID.                                         |
| fromDegree       | double   | Initial angle.                                               |
| toDegree         | double   | Target angle.                                                |
| duration         | int      | Sets the animation duration.                                 |
| fillMode         | int      | Sets the status after the animation ends.                    |
| repeatCount      | int      | Sets the number of times that an animation is replayed.      |
| repeatMode       | int      | Sets the animation replay mode. By default, the animation is replayed from the start. |
| interpolator     | int      | Sets an animation interpolator.                              |
| onAnimationStart | Function | Function to be executed when an animation starts.             |
| onAnimationEnd   | Function | Function to be executed when an animation ends.               |

#### HmsMarkerScaleAnimation

A class for controlling the animation scale.

##### Public Properties

| Name             | Type     | Description                                                  |
| ---------------- | -------- | ------------------------------------------------------------ |
| animationId      | String   | Unique animation ID.                                         |
| fromX            | double   | Indicates the horizontal scale ratio when the animation starts. |
| toX              | double   | Indicates the horizontal scale ratio when the animation ends. |
| fromY            | double   | Indicates the vertical scale ratio when the animation starts. |
| toY              | double   | Indicates the vertical scale ratio when the animation ends.  |
| duration         | int      | Sets the animation duration.                                 |
| fillMode         | int      | Sets the status after the animation ends.                    |
| repeatCount      | int      | Sets the number of times that an animation is replayed.      |
| repeatMode       | int      | Sets the animation replay mode. By default, the animation is replayed from the start. |
| interpolator     | int      | Sets an animation interpolator.                              |
| onAnimationStart | Function | Function to be executed when an animation starts.             |
| onAnimationEnd   | Function | Function to be executed when an animation ends.               |

##### Public Constructor Summary

| Constructor                                                  | Description          |
| ------------------------------------------------------------ | -------------------- |
| HmsMarkerScaleAnimation({String animationId, double fromX, double toX, double fromY, double toY, int duration, int fillMode, int repeatCount, int repeatMode, int interpolator, Function onAnimationStart, Function onAnimationEnd}) | Default constructor. |

##### Public Constructors

###### HmsMarkerScaleAnimation({String animationId, double fromX, double toX, double fromY, double toY, int duration, int fillMode, int repeatCount, int repeatMode, int interpolator, Function onAnimationStart, Function onAnimationEnd})

Constructor for **HmMarkerScaleAnimation** object.

| Parameter        | Type     | Description                                                  |
| ---------------- | -------- | ------------------------------------------------------------ |
| animationId      | String   | Unique animation ID.                                         |
| fromX            | double   | Indicates the horizontal scale ratio when the animation starts. |
| toX              | double   | Indicates the horizontal scale ratio when the animation ends. |
| fromY            | double   | Indicates the vertical scale ratio when the animation starts. |
| toY              | double   | Indicates the vertical scale ratio when the animation ends.  |
| duration         | int      | Sets the animation duration.                                 |
| fillMode         | int      | Sets the status after the animation ends.                    |
| repeatCount      | int      | Sets the number of times that an animation is replayed.      |
| repeatMode       | int      | Sets the animation replay mode. By default, the animation is replayed from the start. |
| interpolator     | int      | Sets an animation interpolator.                              |
| onAnimationStart | Function | Function to be executed when an animation starts.             |
| onAnimationEnd   | Function | Function to be executed when an animation ends.               |

#### HmsMarkerTranslateAnimation

A class that controls the animation movement.

##### Public Properties

| Name             | Type                | Description                                                  |
| ---------------- | ------------------- | ------------------------------------------------------------ |
| animationId      | String              | Unique animation ID.                                         |
| target           | [*LatLng*](#latlng) | Target movement position.                                    |
| duration         | int                 | Sets the animation duration.                                 |
| fillMode         | int                 | Sets the status after the animation ends.                    |
| repeatCount      | int                 | Sets the number of times that an animation is replayed.      |
| repeatMode       | int                 | Sets the animation replay mode. By default, the animation is replayed from the start. |
| interpolator     | int                 | Sets an animation interpolator.                              |
| onAnimationStart | Function            | Function to be executed when an animation starts.             |
| onAnimationEnd   | Function            | Function to be executed when an animation ends.               |

##### Public Constructor Summary

| Constructor                                                  | Description          |
| ------------------------------------------------------------ | -------------------- |
| HmsMarkerTranslateAnimation({String animationId, LatLng target, int duration, int fillMode, int repeatCount, int repeatMode, int interpolator, Function onAnimationStart, Function onAnimationEnd}) | Default constructor. |

##### Public Constructors

###### HmsMarkerTranslateAnimation({String animationId, LatLng target, int duration, int fillMode, int repeatCount, int repeatMode, int interpolator, Function onAnimationStart, Function onAnimationEnd})

Constructor for **HmsMarkerTranslateAnimation** object.

| Parameter        | Type                | Description                                                  |
| ---------------- | ------------------- | ------------------------------------------------------------ |
| animationId      | String              | Unique animation ID.                                         |
| target           | [*LatLng*](#latlng) | Target movement position.                                    |
| duration         | int                 | Sets the animation duration.                                 |
| fillMode         | int                 | Sets the status after the animation ends.                    |
| repeatCount      | int                 | Sets the number of times that an animation is replayed.      |
| repeatMode       | int                 | Sets the animation replay mode. By default, the animation is replayed from the start. |
| interpolator     | int                 | Sets an animation interpolator.                              |
| onAnimationStart | Function            | Function to be executed when an animation starts.             |
| onAnimationEnd   | Function            | Function to be executed when an animation ends.               |

#### enum MapType

Map types.

| Value  | Description            |
| ------ | ---------------------- |
| none   | Empty map.             |
| normal | Basic Huawei Map type. |

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

<img src="https://github.com/HMS-Core/hms-flutter-plugin/raw/master/flutter-hms-map/.docs/mainPage.jpg" width = 40% height = 40% style="margin:1.5em">

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

Huawei MAP Kit Flutter Plugin is licensed under [Apache 2.0 license](LICENSE)
