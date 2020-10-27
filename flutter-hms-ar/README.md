# Huawei AR Kit Flutter Plugin

---

## Contents

  - [1. Introduction](#1-introduction)
  - [2. Installation Guide](#2-installation-guide)
  - [3. API Reference](#3-api-reference)
  - [4. Configuration and Description](#4-configuration-and-description)
  - [5. Sample Project](#5-sample-project)
  - [6. Questions or Issues](#6-questions-or-issues)
  - [7. Licensing and Terms](#7-licensing-and-terms)

---

## 1. Introduction

**HUAWEI AR Kit Plugin for Flutter** is a platform for building augmented reality (AR) applications on Android devices using the Flutter framework. It is based on the HiSilicon chipset, and integrates AR core algorithms to provide basic AR capabilities such as motion tracking, environment tracking, body tracking, and face tracking. It allows your app to bridge virtual world with the real world, for a brand new visually interactive user experience.

This plugin enables communication between the HUAWEI AR Engine SDK and the Flutter platform. It exposes all functionality provided by the HUAWEI AR Engine SDK.

### Restrictions:

#### Supported Devices

| Brand/Series       | Device Model |
| :----------------- | :----------- |
| HUAWEI P series    | P40, P40 Pro, P40 Pro+, P30, P30 Pro, P20, P20 Pro |
| HUAWEI Mate series | Mate 30, Mate 30 Pro, Mate 30 RS, Mate 30 (5G), Mate 30 Pro (5G) , Mate X, Mate Xs, Mate 20 X (5G), Mate RS, Mate 20 X, Mate 20, Mate 20 Pro, Mate 20 RS |
| HUAWEI nova series | nova 7, nova 7 Pro, nova 6, nova 6 Pro, nova 4, nova 3 |
| HONOR phones       | HONOR 30, HONOR 30 Pro, HONOR 30 Pro+, HONOR 30S, HONOR View30, HONOR View30 Pro, HONOR 20, HONOR 20 Pro, HONOR View20, HONOR 9X    |
| Tablet             | HUAWEI MediaPad M6, HUAWEI MatePad Pro |

#### Supported Locations

For details about the supported locations, please refer to [Supported Locations](https://developer.huawei.com/consumer/en/doc/HMSCore-Guides-V5/supported-regions-0000001050723728-V5).

---

## 2. Installation Guide

On your Flutter project directory, find and open your **pubspec.yaml** file and add the **huawei_ar** library to dependencies. For more details please refer to the [Using packages](https://flutter.dev/docs/development/packages-and-plugins/using-packages#dependencies-on-unpublished-packages) document.
- To download the package from [pub.dev](https://pub.dev/publishers/developer.huawei.com/packages).
  ```yaml
    dependencies:
      huawei_ar: {library version}
  ```

- Or if you downloaded the package from the HUAWEI Developer website, specify the **library path** on your local device.
  ```yaml
    dependencies:
      huawei_ar:
          # Replace {library path} with actual library path of Huawei AR Kit Plugin for Flutter.
          path: {library path}
  ```
  - Replace {library path} with the actual library path of Flutter AR Plugin. The following are examples:
    - Relative path example: `path: ../huawei_ar`
    - Absolute path example: `path: D:\Projects\Libraries\huawei_ar`


Run the following command to update package info.
```
[project_path]> flutter pub get
```

Import the library to access the methods.
```dart
import 'package:huawei_ar/ar_engine_library.dart';
```

Run the following command to start the app.
```
[project_path]> flutter run
```

---

## 3. API Reference

### AREngine
Contains methods for setting up the AR Engine.

#### Public Method Summary

| Method                      | Return Type   | Description                           |
| :-------------------------- | :------------ | :------------------------------------ |
| [isAREngineServiceApkReady()](#futurebool-isarengineserviceapkready-async) | Future\<bool> | Checks if the AR Engine Service APK is ready.|
| [navigateToAppMarketPage()](#futurevoid-navigatetoappmarketpage-async)   | Future\<void> | Navigates to the AR Engine AppGallery page for downloading the AR Engine Service APK.|
| [hasCameraPermission()](#futurebool-hascamerapermission-async)       | Future\<bool> | Checks if the camera permission is granted.|
| [requestCameraPermission()](#futurevoid-requestcamerapermission-async)   | Future\<void> | Requests the camera permission which is required to display an [AREngineScene](#arenginescene).|
| [enableLogger()](#futurevoid-enablelogger-async)              | Future\<void> | Enables HMS Plugin Method Analytics. |
| [disableLogger()](#futurevoid-disablelogger-async)             | Future\<void> | Disables HMS Plugin Method Analytics.|

#### Public Methods

##### Future\<bool> isAREngineServiceApkReady **async**
The AR Engine needs the AR Engine Service APK installed on the device before using the AR capabilities. This method checks if the service APK is already installed on the device.

###### Return Type
| Type          | Description                                         |
| :----------   | --------------------------------------------------  |
| Future\<bool> | True if the AR Engine Service APK is installed and ready, false otherwise. |

###### Call Example
```dart
_checkServiceApk() async {
  bool result = await AREngine.isArEngineServiceApkReady();
  // Navigate to the AppGallery for AR Engine Service APK Download if result is false
}
```


##### Future\<void> navigateToAppMarketPage **async**
Opens the AR Engine Service APK AppGallery Page. If the device doesn't support the AR Engine, AppGallery would display application not available message.

###### Return Type
| Type          | Description                                         |
| :-----------  | :-------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value.|

###### Call Example
```dart
_checkServiceApk() async {
  bool result = await AREngine.isArEngineServiceApkReady();
  if(!result) {
      AREngine.navigateToAppMarketPage();
  }
}
```


##### Future\<bool> hasCameraPermission **async**
Checks if the camera permission is given.

###### Return Type
| Type          | Description                                             |
| :------------ | :-----------------------------------------------------  |
| Future\<bool> | True if the camera permission is given, false otherwise.|

###### Call Example
```dart
_checkCameraPermission() async {
  bool result = await AREngine.hasCameraPermission();
 // Request for camera permission if result is false.
}
```


##### Future\<void> requestCameraPermission **async**
Requests the camera permission which is required to display the AREngineScene.

**Note:** [AREngineScene](#arenginescene) widget automatically checks for the camera permission and requests the permission if it has not given at the moment.

###### Return Type
| Type          | Description                                         |
| :-----------  | :-------------------------------------------------- |
| Future\<void> | Future result of an execution that returns no value.|

###### Call Example
```dart
_checkCameraPermission() async {
  bool result = await AREngine.hasCameraPermission();
  if(!result) {
      AREngine.requestCameraPermission();
  }
}
```


##### Future\<void> enableLogger **async**
This method enables the HMSLogger capability which is used for sending usage analytics of AR Engine SDK's methods to improve the service quality.

###### Return Type
| Type          | Description                                          |
| :----------   | :-------------------------------------------------   |
| Future\<void> | Future result of an execution that returns no value. |

###### Call Example

```dart
AREngine.enableLogger(); // Enables HMSLogger
```


##### Future\<void> disableLogger **async**
This method disables the HMSLogger capability which is used for sending usage analytics of AR Engine SDK's methods to improve the service quality.

###### Return Type
| Type          | Description                                         |
| :----------   | :-------------------------------------------------  |
| Future\<void> | Future result of an execution that returns no value.|

###### Call Example

```dart
AREngine.disableLogger(); // Disables HMSLogger
```

### AREngineScene

Flutter widget which displays an AR Engine Scene. The scene will open and display the camera of the device for AR interactions.

#### Public Properties
<details>
  <summary>Click to expand/collapse table</summary>

| Name          | Type        | Description | Required |
| :------------ | :---------- | :---------- | :------- |
| key           | Key         | Optional key for the AREngineScene widget. | No |
| height        | double      | Height of the AREngineScene widget. | No |
| width         | double      | Width of the AREngineScene widget.  | No |
| arSceneType   | [ARSceneType](#enum-arscenetype) | Determines the AR scene type. Check ARSceneType for the options. | **Yes** |
| arSceneConfig | [ARSceneBaseConfig](#arscenebaseconfig) | Configurations which are specific to defined ARSceneType. | **Yes** |
| onARSceneCreated | Function([ARSceneController](#arscenecontroller) arSceneController) | A callback function which is called on widget creation and returns an ARSceneController instance. | No |
| notSupportedText | String | Text to display when the device platform doesn't support Huawei AR Engine. | No |
| permissionTitleText   | String | Title of the text that displayed when the camera permission is needed.  | No |
| permissionBodyText    | String | Body message of the text that displayed when the camera permission is needed. | No |
| permissionButtonText  | String | Text of the button which requests the camera permission. | No |
| notSupportedTextStyle     | TextStyle | TextStyle for notSupportedText.     | No |
| permissionTitleTextStyle  | TextStyle | TextStyle for permissionTitleText.  | No |
| permissionBodyTextStyle   | TextStyle | TextStyle for permissionBodyText.   | No |
| permissionButtonTextStyle | TextStyle | TextStyle for permissionButtonText. | No |
| permissionButtonColor     | Color | Color of the permissionButton. | No |
| permissionMessageBgColor  | Color | Background color of the permission message container. | No |
</details>

#### Public Constructor Summary

| Signature | Description |
| :-------- | ----------- |
| AREngineScene(ARSceneType arSceneType, ARSceneBaseConfig arSceneConfig, {Key key, double height, double width, Function(ARSceneController arSceneController) onARSceneCreated, String notSupportedText, String permissionTitleText, String permissionBodyText, String permissionButtonText, TextStyle permissionTitleTextStyle, TextStyle permissionBodyTextStyle, TextStyle notSupportedTextStyle, TextStyle permissionButtonTextStyle, Color permissionButtonColor, Color permissionMessageBgColor}) | Creates an AREngineScene widget instance. |

#### Public Constructors

##### AREngineScene(ARSceneType arSceneType, ARSceneBaseConfig arSceneConfig, {Key key, double height, double width, Function(ARSceneController arSceneController) onARSceneCreated, String notSupportedText, String permissionTitleText, String permissionBodyText, String permissionButtonText, TextStyle permissionTitleTextStyle, TextStyle permissionBodyTextStyle, TextStyle notSupportedTextStyle, TextStyle permissionButtonTextStyle, Color permissionButtonColor, Color permissionMessageBgColor})

Constructs an AREngineScene widget with the specified parameters.
- For parameter descriptions, see [public properties](#public-properties).

###### Usage Example

```dart

import 'package:flutter/material.dart';
import 'package:huawei_ar/ar_engine_library.dart';

class ArBodyScene extends StatefulWidget {
  ArBodyScene({Key key}) : super(key: key);

  @override
  _ArBodySceneState createState() => _ArBodySceneState();
}

class _ArBodySceneState extends State<ArBodyScene> {
  ARSceneController arSceneController;

  _onARSceneCreated(ARSceneController controller) {
    arSceneController = controller;
    arSceneController.onDetectTrackable =
        (arHand) => _bodyDetectCallback(arHand);
  }

  _bodyDetectCallback(ARBody arBody) {
    print("ARBody detected: " + arBody?.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: AREngineScene(
            ARSceneType.BODY,
            ARSceneBodyConfig(
              drawLine: true,
              drawPoint: true,
              lineWidth: 10.0,
              pointSize: 20.0,
              lineColor: Colors.green,
              pointColor: Colors.amber,
            ),
            onArSceneCreated: _onARSceneCreated,
          ),
        ),
    );
  }
}
```

#### enum ARSceneType

Specifies the AREngineScene type.

| Value | Description                                      |
| :---- | :----------------------------------------------- |
| HAND  | ARHandScene option for the AREngineScene Widget.  |
| FACE  | ARFaceScene option for the AREngineScene Widget.  |
| BODY  | ARBodyScene option for the AREngineScene Widget.  |
| WORLD | ARWorldScene option for the AREngineScene Widget. |

### ARSceneBaseConfig
Abstract class for AREngineScene widget's scene configurations. The different scene configuration classes for [ARSceneTypes](#enum-arscenetype) HAND, BODY, FACE and WORLD, inherits from this base class.

#### Public Constants

| Constant     | Type  | Description          |
| :----        | :---  | :------------------- |
| defaultRed   | Color | Default red color.   |
| defaultWhite | Color | Default white color. |
| defaultBlue  | Color | Default blue color.  |
| defaultGreen | Color | Default green color. |

#### Public Method Summary

| Method                      | Return Type  | Description |
| :-------------------------- | :----------- | :---------- |
| getARSceneType              | [ARSceneType](#enum-arscenetype)  | Obtains the scene type. |
| getARSceneConfig            | String       | Obtains the json string representation of the ARSceneConfig. |

#### Public Methods

##### ARSceneType getARSceneType
Obtains the scene type of the scene configuration object.

###### Return Type
| Type                            | Description |
| :-----------------------------  | :---------- |
| [ARSceneType](#enum-arscenetype)| Scene Type. |

##### String getARSceneConfig
Obtains the json string representation of the scene configuration object.

###### Return Type
| Type   | Description                                           |
| :----- | :---------------------------------------------------- |
| String | Json string representation of an ARSceneBaseConfig object. |

### ARSceneHandConfig
Scene configurations for an AREngineScene with the type **ARSceneType.HAND**. Implements the ARSceneBaseConfig.

#### Public Properties

| Name              | Type        | Description |
| :---------------- | :---------- | :---------- |
| enableBoundingBox | bool        | If set to true or not specified, a bounding box around the hand will be drawn when a hand gesture is recognized. |
| boxColor          | Color       | Color of the bounding box.                                              |
| lineWidth         | double      | Line width of the bounding box.                                         |

#### Public Constructor Summary

| Signature | Description |
| :-------- | ----------- |
| ARSceneHandConfig({bool enableBoundingBox, Color boxColor, double lineWidth }) | Creates an ARSceneHandConfig instance. |

#### Public Constructors

##### ARSceneHandConfig({bool enableBoundingBox, Color boxColor, double lineWidth })
Constructs an ARSceneHandConfig instance with the specified parameters.
- For parameter descriptions, see [public properties](#public-properties-1).


### ARSceneFaceConfig
Scene configurations for an AREngineScene with the type **ARSceneType.FACE**. Implements the ARSceneBaseConfig.

#### Public Properties

| Name              | Type        | Description |
| :---------------- | :---------- | :---------- |
| drawFace          | bool        | If set true or not specifed, A face mask will be drawn on a detected face. |
| depthColor        | Color       | Set color of face mask points.                                                |
| pointSize         | double      | Set point size of face mask points.                                           |
| texturePath       | String      | A texture asset\'s path, that will be shown on the detected face.             |

#### Public Constructor Summary

| Signature | Description |
| :-------- | ----------- |
| ARSceneFaceConfig({bool drawFace, Color depthColor, double pointSize, String texturePath }) | Creates an ARSceneFaceConfig instance. |

#### Public Constructors

##### ARSceneFaceConfig({bool drawFace, Color depthColor, double pointSize, String texturePath })
Constructs an ARSceneFaceConfig instance with the specified parameters.
- For parameter descriptions, see [public properties](#public-properties-2).

### ARSceneBodyConfig
Scene configurations for an AREngineScene with the type **ARSceneType.BODY**. Implements the ARSceneBaseConfig.

#### Public Properties

| Name        | Type        | Description |
| :---------- | :---------- | :---------- |
| drawLine    | bool        | If set to true or not specifed, skeleton connection lines will be drawn when a person is detected.   |
| drawPoint   | bool        | If set to true or not specified, skeleton connection points will be drawn when a person is detected. |
| pointSize   | double      | Point size of the skeleton connection points.                                                            |
| lineWidth   | double      | Line width of the skeleton connection lines.                                                             |
| lineColor   | Color       | Skeleton connection line color.                                                                      |
| pointColor  | Color       | Skeleton connection point color.                                                                     |

#### Public Constructor Summary

| Signature | Description |
| :-------- | ----------- |
| ARSceneBodyConfig({bool drawLine, bool drawPoint, double pointSize, double lineWidth, Color lineColor, Color pointColor }) | Creates an ARSceneBodyConfig instance. |

#### Public Constructors

##### ARSceneBodyConfig({bool drawLine, bool drawPoint, double pointSize, double lineWidth, Color lineColor, Color pointColor })
Constructs an ARSceneBodyConfig instance with the specified parameters.
- For parameter descriptions, see [public properties](#public-properties-3).

### ARSceneWorldConfig
Scene configurations for an AREngineScene with the type **ARSceneType.WORLD**. Implements the ARSceneBaseConfig.

#### Public Properties

<details>
  <summary>Click to expand/collapse table</summary>
  
| Name         | Type    | Description                                                                           |
| :----------- | :------ | :------------------------------------------------------------------------------------ |
| objPath      | String | Virtual object file asset path. When object file path is given you can put that object in the AREngineScene. The object should be in waveform object (**.obj**) format. |
| texturePath  | String | Virtual object texture file asset path. This texture will be rendered to the given virtual object.                                                    |
| drawLabel    | bool   | If set to true a label will be drawn when the plane is detected.|
| imageOther   | String | Path of the image to be displayed when other plane type is detected. |
| imageWall    | String | Path of the image to be displayed when wall plane is detected. |
| imageFloor   | String | Path of the image to be displayed when floor plane is detected. |
| imageSeat    | String | Path of the image to be displayed when seat plane is detected.|
| imageTable   | String | Path of the image to be displayed when table plane is detected.|
| imageCeiling | String | Path of the image to be displayed when ceiling plane is detected.|
| textOther    | String | Text to be displayed when other plane is detected.|
| textWall     | String | Text to be displayed when wall plane is detected.|
| textFloor    | String | Text to be displayed when floor plane is detected.|
| textSeat     | String | Text to be displayed when seat plane is detected.|
| textTable    | String | Text to be displayed when table plane is detected.|
| textCeiling  | String | Text to be displayed when ceiling plane is detected.|
| colorOther   | Color  | Text color when other plane is detected.|
| colorWall    | Color  | Text color when wall plane is detected.|
| colorFloor   | Color  | Text color when floor plane is detected.|
| colorSeat    | Color  | Text color when seat plane is detected.|
| colorTable   | Color  | Text color when table plane is detected.|
| colorCeiling | Color  | Text color when ceiling plane is detected.|
</details>

#### Public Constructor Summary

| Signature | Description |
| :-------- | ----------- |
| ARSceneWorldConfig({String objPath, String texturePath, bool drawLabel, String imageOther, String imageWall, String imageFloor, String imageSeat, String imageTable, String imageCeiling, String textOther, String textWall, String textFloor, String textSeat,  String textTable, String textCeiling, Color colorOther, Color colorWall, Color colorFloor, Color colorSeat, Color colorTable, Color colorCeiling }) | Creates an ARSceneWorldConfig instance. |

#### Public Constructors

##### ARSceneWorldConfig({String objPath, String texturePath, bool drawLabel, String imageOther, String imageWall, String imageFloor, String imageSeat, String imageTable, String imageCeiling, String textOther, String textWall, String textFloor, String textSeat,  String textTable, String textCeiling, Color colorOther, Color colorWall, Color colorFloor, Color colorSeat, Color colorTable, Color colorCeiling })
Constructs an ARSceneWorldConfig instance with the specified parameters.
- For parameter descriptions, see [public properties](#public-properties-4).

### ARSceneController
Controller class for the [AREngineScene](#arenginescene) widget which can return ARTrackable objects based on the [ARSceneType](#enum-arscenetype).

#### Public Properties

| Name          | Type            | Description                     |
| :------------ | :------------   | :------------------------------ |
| onDetectTrackable | Function([ARTrackableBase](#artrackablebase) arTrackable) | Callback function which returns an arTrackable object depending on the current [ARSceneType](#enum-arscenetype).|

#### Public Method Summary

| Method               | Return Type  | Description                        |
| :------------------- | :----------- | :--------------------------------- |
| dispose              | void         | Disposes the current AREngineScene. |

#### Public Methods

##### void dispose
Disposes the current [AREngineScene](#arenginescene) which the controller is attached to. 

### ARTrackableBase
Abstract base class for ARTrackables which are [ARHand](#arhand), [ARFace](#arface), [ARBody](#arbody) and [ARPlane](#arplane).

#### Public Properties

| Name          | Type            | Description                     |
| :------------ | :------------   | :------------------------------ |
| anchors       | List\<[ARAnchor](#aranchor)>    | All anchor data associated to the current trackable object.|
| trackingState | [TrackingState](#enum-trackingstate) | Status of the current trackable.|

#### Public Constants

##### enum TrackingState
The tracking status of the trackable object.

| Value          | Description     |
| :------------- | :-------------- |
| UNKNOWN_STATE  | Unknown State.  |
| TRACKING       | Tracking Status.|
| PAUSED         | Paused Status.  |
| STOPPED        | Stopped Status. |

### ARAnchor
Represents an anchor at a fixed location and a specified direction in an actual environment. HUAWEI AR Engine continuously updates this value so that the location and direction remains unchanged even when the environment changes, for example, as the camera moves. Before using methods in this class, call **trackingState** to check the anchor status. The data obtained through **arPose** is valid only when the anchor status is **TrackingState.TRACKING**.
#### Public Properties

| Name          | Type          | Description                                                                       |
| :------------ | :------------ | :-------------------------------------------------------------------------------- |
| arPose | [ARPose](#arpose)        | Returns the location and the pose of the anchor point in the world coordinate system.|
| trackingState  | [TrackingState](#enum-trackingstate) | Status of the current trackable.|

#### Public Method Summary

| Name                | Return Type          | Description                                                            |
| :------------------ | :------------ | :--------------------------------------------------------------------- |
| toMap               | Map\<String, dynamic> | Returns the map representation of the current ARAnchor object. |
| toString            | String | Returns the string representation of the current ARAnchor object.|
| == (equals operator)| bool   | Compares whether two ARAnchor objects correspond to the same anchor.|
| hashCode            | int    | Returns the hash code of the current ARAnchor object.|

#### Public Methods

##### Map\<String, dynamic> toMap
Converts the current ARAnchor object to a Map.

###### Return Type
| Type                  | Description                                        |
| :-------------------- | :------------------------------------------------- |
| Map\<String, dynamic> | Map representation of the current ARAnchor object. |

##### String toString
Converts the current ARAnchor object to a string.

###### Return Type
| Type   | Description                                           |
| :----- | :---------------------------------------------------- |
| String | String representation of the current ARAnchor object. |

##### bool ==(Object other) (equals operator)
Compares whether two ARAnchor objects correspond to the same anchor.

###### Parameters
| Name  | Description                                                 |
| :---- | :---------------------------------------------------------- |
| other | Any object to compare with the current ARAnchor instance.   |

###### Return Type
| Type | Description                                                 |
| :--- | :---------------------------------------------------------- |
| bool | True if two ARAnchor objects are the same, false otherwise. |

##### int hashCode
Returns the **hashCode** of the current object. The same value is returned for objects correspond to the same real world anchor.

###### Return Type
| Type | Description                                                           |
| :--- | :-------------------------------------------------------------------- |
| int  | Hash code that is generated from the values of the ARAnchor instance. |

### ARPose
Represents the pose data, including a translation vector and a rotation vector (quaternion).

#### Public Constants

| Constant              | Type          | Description          |
| :-------------------- | :---          | :------------------- |
| IDENTITY_TRANSLATION  | List\<double> | Identity translation with values X: 0, Y: 0, Z: 0. |
| IDENTITY_ROTATION     | List\<double> | Identity rotation with values X: 0, Y: 0, Z: 0, W: 1. |
| IDENTITY              | ARPose        | Indicates the identity pose (transformed from local coordinate system to world coordinate system). The values are IDENTITY_TRANSLATION and IDENTITY_ROTATION.|

#### Public Properties
| Name        | Type          | Description                                                                       |
| :---------- | :------------ | :-------------------------------------------------------------------------------- |
| translation | List\<double> | Indicates the translation from the destination coordinate system to the local coordinate system.|
| rotation    | List\<double> | Indicates the rotation variable, which is a Hamilton quaternion.|

#### Public Method Summary

| Name                | Return Type          | Description                                                            |
| :------------------ | :------------ | :--------------------------------------------------------------------- |
| toMap               | Map\<String, dynamic> | Returns the map representation of the current ARPose object. |
| toString            | String | Returns the string representation of the current ARPose object.|

#### Public Methods

##### Map\<String, dynamic> toMap
Converts the current ARPose object to a Map.

###### Return Type
| Type | Description                                                         |
| :--- | :------------------------------------------------------------------ |
| Map\<String, dynamic> | Map representation of the current ARPose object.   |

##### String toString
Converts the current ARPose object to a string.

###### Return Type
| Type   | Description                                         |
| :---   | :-------------------------------------------------- |
| String | String representation of the current ARPose object. |


### ARHand
Contains the results of hand tracking, including the hand skeleton data and gesture recognition result. This class is derived from [ARTrackableBase](#artrackablebase).

#### Public Properties
<details>
  <summary>Click to expand/collapse table</summary>

| Name          | Type          | Description                                                                       |
| :------------ | :------------ | :-------------------------------------------------------------------------------- |
| gestureType              | int   | [Different static gestures](#gesture-type-mapping) can be identified based on whether deep flow inspection is enabled.|
| arHandType               | [ARHandType](#enum-arhandtype)      | The hand type, which can be left hand, right hand, or unknown (if left/right hand recognition is not supported).|
| gestureHandBox           | List\<double> | The rectangle that covers the hand, in the format of [x0,y0,0,x1,y1,0]. (x0,y0) indicates the upper left corner, (x1,y1) indicates the lower right corner, and x/y is based on the OpenGL NDC coordinate system.                      |
| gestureCenter            | List\<double> | Coordinates of the center point of a hand in the format of [x,y,0]. The point is the center coordinates of the bounding rectangle of the hand.|
| handSkeletonArray        | List\<double> | The coordinates of a hand skeleton point in the format of [x0,y0,z0,x1,y1,z1, ...].|
| handSkeletonConnection   | List\<int> | The connection data of a hand skeleton point, which is the index of the skeleton point type.|
| arHandSkeletonTypes      | List\<[ARHandSkeletonType](#enum-arhandskeletontype)> | The list of hand skeleton point types.|
| gestureCoordinateSystem  | [ARCoordinateSystemType](#enum-arcoordinatesystemtype)      | Coordinate type used by the current gesture posture. For example,COORDINATE_SYSTEM_TYPE_2D_IMAGE indicates the OpenGL NDC coordinate.|
| skeletonCoordinateSystem | [ARCoordinateSystemType](#enum-arcoordinatesystemtype)     | Coordinate system of the hand skeleton data: COORDINATE_SYSTEM_TYPE_2D_IMAGE indicates 2D hand tracking, and COORDINATE_SYSTEM_TYPE_3D_CAMERA indicates 3D hand tracking.|
| anchors                  | List\<[ARAnchor](#aranchor)> | ARAnchor data attached to the current trackable object.|
| trackingState            | [TrackingState](#enum-trackingstate) | Status of the current trackable.|

</details>

#### Public Constants

##### enum ARHandType
The type of hand, which can be left or right.

| Value           | Description                                       |
| :-------------  | :------------------------------------------------ |
| AR_HAND_UNKNOWN | Unknown or the hand type cannot be distinguished. |
| AR_HAND_RIGHT   | Right hand.                                       |
| AR_HAND_LEFT    | Left hand.                                        |

##### enum ARHandSkeletonType
The enum type of the hand skeleton point.

<details>
  <summary>Click to expand/collapse table</summary>
  
| Value           | Description     |
| :-------------  | :-------------- |
|HANDSKELETON_ROOT|The root point of the hand bone, that is, the wrist.|
|HANDSKELETON_PINKY_1|Pinky knuckle 1. |
|HANDSKELETON_PINKY_2|Pinky knuckle 2. |
|HANDSKELETON_PINKY_3|Pinky knuckle 3. |
|HANDSKELETON_PINKY_4|Pinky knuckle tip.|
|HANDSKELETON_RING_1|Ring finger knuckle 1.|
|HANDSKELETON_RING_2|Ring finger knuckle 2.|
|HANDSKELETON_RING_3|Ring finger knuckle 3.|
|HANDSKELETON_RING_4|Ring finger tip.|
|HANDSKELETON_MIDDLE_1|Middle finger knuckle 1.|
|HANDSKELETON_MIDDLE_2|Middle finger knuckle 2.|
|HANDSKELETON_MIDDLE_3|Middle finger knuckle 3.|  
|HANDSKELETON_MIDDLE_4|Middle finger tip.|
|HANDSKELETON_INDEX_1|Index finger knuckle 1.|
|HANDSKELETON_INDEX_2|Index finger knuckle 2.|  
|HANDSKELETON_INDEX_3|Index finger knuckle 3.|  
|HANDSKELETON_INDEX_4|Index finger tip.|
|HANDSKELETON_THUMB_1|Thumb knuckle 1.|
|HANDSKELETON_THUMB_2|Thumb knuckle 2.|  
|HANDSKELETON_THUMB_3|Thumb knuckle 3.|
|HANDSKELETON_THUMB_4|Thumb tip.|
|HANDSKELETON_LENGTH|Number of knuckles.|
</details>

#### Public Method Summary

| Name                | Return Type          | Description                                                            |
| :------------------ | :------------ | :--------------------------------------------------------------------- |
| toMap               | Map\<String, dynamic> | Returns the map representation of the current ARHand object. |
| toString            | String | Returns the string representation of the current ARHand object.|

#### Public Methods

##### Map\<String, dynamic> toMap
Converts the current ARHand object to a Map.

###### Return Type
| Type                  | Description   |
| :-------------------- | :------------ |
| Map\<String, dynamic> | Map representation of the current ARHand object. |

##### String toString
Converts the current ARHand object to a string.

###### Return Type
| Type          | Description   |
| :-----------  | :------------ |
| String        | String representation of the current ARHand object. |

##### Gesture Type Mapping
With Huawei AR Engine different hand gestures can be identified based on whether deep flow inspection is enabled.

Gesture recognition is associated with deep flow inspection as shown on the table below.

| Gesture Type     | Value | Supported Without Deep Flow | Supported With Deep Flow |
| :--------------- | :---- | :-------------------------- | :----------------------- |
| Gesture 0 (fist) | 0     | Yes                         | Yes                      |
| Gesture 1 (stick index finger)| 1 | Yes                | No                       |
| Gesture 6 (calling gesture)| 6 | Yes                   | Yes                      |
| Gesture 8 (stick thumb and index finger apart)| 8 | No | Yes                      |
| Others           | -1    | --                          | --                       |

The following figures show the gestures.
<table>
  <tr>
    <th>
    <img src="https://communityfile-drcn.op.hicloud.com/FileServer/getFile/cmtyPub/011/111/111/0000000000011111111.20200927161416.71104542619766720914827582655510:50510927095945:2800:092C935C0CD5412ACBB16B036BEB2490B5384450EF066EC7047002DF1A473811.png?needInitFileName=true?needInitFileName=true"  alt="1" width = 120px height = 100px >
    </th>
    <th>
    <img src="https://communityfile-drcn.op.hicloud.com/FileServer/getFile/cmtyPub/011/111/111/0000000000011111111.20200927161416.75764571855537394244254172347533:50510927095945:2800:219C24422EE8660D79475AA6D1E950F66CF862A742B08CE59D023B6D0CBB3B8B.png?needInitFileName=true?needInitFileName=true" alt="3" width = 120px height = 100px>
    </th>
    <th>
    <img src="https://communityfile-drcn.op.hicloud.com/FileServer/getFile/cmtyPub/011/111/111/0000000000011111111.20200927161416.97858341799355013208386158475751:50510927095945:2800:B89A9F2D5B21C2B65D1314AF18E291D90BF4533BBD25BAC022BAB08D360F264E.png?needInitFileName=true?needInitFileName=true" alt="3" width = 120px height = 100px>
    </th>
    <th>
    <img src="https://communityfile-drcn.op.hicloud.com/FileServer/getFile/cmtyPub/011/111/111/0000000000011111111.20200927161416.61750088494832650314771493499061:50510927095945:2800:D04D534FB279AB19FE28A89947DFD5BD645D88B4E8B722B861BB9E661813B436.png?needInitFileName=true?needInitFileName=true" alt="3" width = 120px height = 100px>
    </th>
  </tr>
  <tr>
    <td>Gesture 0</td>
    <td>Gesture 1</td>
    <td>Gesture 6</td>
    <td>Gesture 8</td>
  </tr>
</table>

### ARFace
Provides the face tracking results, including the face location, pose, and blend shapes. This class is derived from [ARTrackableBase](#artrackablebase).

#### Public Properties
| Name          | Type          | Description                                                                       |
| :------------ | :------------ | :-------------------------------------------------------------------------------- |
| arPose              | [ARPose](#arpose)   | The pose of a face mesh center in the camera coordinate system, which is a right-handed coordinate system. The origin is located at the nose tip, the center of a face, X+ points leftwards, Y+ points up, and Z+ points from the inside to the outside with the face as the reference.|
| faceBlendShapes            | [ARFaceBlendShapes](#arfaceblendshapes) | The facial blend shapes, which contain several expression parameters.|
| anchors                  | List\<[ARAnchor](#aranchor)> | ARAnchor data attached to the current trackable object.|
| trackingState            | [TrackingState](#enum-trackingstate)      | Status of the current trackable.|

#### Public Method Summary
| Name                | Return Type          | Description                                                            |
| :------------------ | :------------ | :--------------------------------------------------------------------- |
| toMap               | Map\<String, dynamic> | Returns the map representation of the current ARFace object. |
| toString            | String | Returns the string representation of the current ARFace object.|

#### Public Methods

##### Map\<String, dynamic> toMap
Converts the current ARFace object to a Map.

###### Return Type
| Type                  | Description   |
| :-------------------- | :------------ |
| Map\<String, dynamic> | Map representation of the current ARFace object. |

##### String toString
Converts the current ARFace object to a string.

###### Return Type
| Type          | Description   |
| :-----------  | :------------ |
| String        | String representation of the current ARFace Object. |

### ARFaceBlendShapes
Describes the facial blend shapes, which contain several expression parameters.

#### Public Properties

| Name          | Type          | Description                                                                       |
| :------------ | :------------ | :-------------------------------------------------------------------------------- |
| blendShapeDataMap | Map\<String, dynamic>   | Key indicates the string corresponding to the blend shape enumeration type, and the value indicates the blend shape expression degree, ranging from [0, 1]. |
| blendShapeData   | List\<double> | The value ranges from 0 to 1, indicating the expression degree of each blend shape. |
| blendShapeType   | List\<String> | List of blend shape types.|
| blendShapeCount  | int | Number of blend shapes. |

#### Public Method Summary

| Name                | Return Type          | Description                                                            |
| :------------------ | :------------ | :--------------------------------------------------------------------- |
| toMap               | Map\<String, dynamic> | Returns the map representation of the current ARFaceBlendShapes object. |

##### Public Methods

##### Map\<String, dynamic> toMap
Converts the current ARFaceBlendShapes object to a Map.

###### Return Type
| Type                  | Description   |
| :-------------------- | :------------ |
| Map\<String, dynamic> | Map representation of the current ARFaceBlendShapes object. |


### ARBody
The tracking result during body skeleton tracking, including body skeleton data, which is derived from [ARTrackableBase](#artrackablebase).

#### Public Constants

##### enum ARBodySkeletonType
Enum which represents the body skeleton type.

<details>
  <summary>Click to expand/collapse table</summary>

| Value | Description                                      |
| :---- | :----------------------------------------------- |
| BodySkeleton_Unknown  | Unknown skeleton type  |
| BodySkeleton_Head  |  Head.  |
| BodySkeleton_Neck  | Neck.  |
| BodySkeleton_r_Sho | Right shoulder. |
| BodySkeleton_r_Elbow | Right elbow. |
| BodySkeleton_r_Wrist | Right wrist. |
| BodySkeleton_l_Sho | Left shoulder. |
| BodySkeleton_l_Elbow | Left elbow. |
| BodySkeleton_l_Wrist | Left wrist. |
| BodySkeleton_r_Hip | Right hip joint. |
| BodySkeleton_r_Knee | Right knee. |
| BodySkeleton_r_Ankle | Right ankle. |
| BodySkeleton_l_Hip | Left hip joint. |
| BodySkeleton_l_Knee | Left knee. |
| BodySkeleton_l_Ankle | Left ankle. |
| BodySkeleton_Hip_mid | Center of hip joint. |
| BodySkeleton_r_ear | Right ear. |
| BodySkeleton_r_eye | Right eye. |
| BodySkeleton_nose | Nose.  |
| BodySkeleton_l_eye | Left eye. |
| BodySkeleton_l_ear | Left ear. |
| BodySkeleton_spine | Spine. |
| BodySkeleton_r_toe | Right toe. |
| BodySkeleton_l_toe | Left toe. |
| BodySkeleton_Length | Number of joints, instead of a joint point. |
</details>

#### Public Properties

<details>
  <summary>Click to expand/collapse table</summary>

| Name                   | Type          | Description                                                                       |
| :--------------------- | :------------ | :-------------------------------------------------------------------------------- |
| bodyAction             | int | Body action type, including [six preset static postures](#body-action-mapping). |
| bodySkeletonTypes      | List\<[ARBodySkeletonType](#enum-arbodyskeletontype)> | An array of body skeleton types, including the head, neck, left shoulder, and right shoulder.|
| skeletonPoint2D        | List\<double> | The 2D coordinates of a skeleton point measured with the screen center as the origin, in the format of [x0,y0,0,x1,y1,0]. The coordinates are normalized device coordinates (NDC) of OpenGL, and the value range of x/y is [-1,1].|
| skeletonPoint3D        | List\<double> | The 3D coordinates of a skeleton point, in the format of [x0,y0,z0,x1,y1,z1...]. |
| skeletonConfidence     | List\<double> | The confidence of each skeleton point. The number of values are the same as that of skeleton points, and each element indicates the confidence within the range [0,1]. |
| bodySkeletonConnection | List\<int> | The connection data of a skeleton point, which is the index of the skeleton point type. | 
| skeletonPointIsExist2D | List\<bool> |  True or False to indicate that whether the 2D coordinates of a skeleton point are valid. The value false indicates that the data is invalid, while true indicates that the data is valid. |
| skeletonPointIsExist3D | List\<bool> | True or False to indicate that whether the 3D coordinates of a skeleton point are valid. The value false indicates that the data is invalid, while true indicates that the data is valid. |
| coordinateSystemType   | [ARCoordinateSystemType](#enum-arcoordinatesystemtype) | The coordinate system type. |
| anchors                | List\<[ARAnchor](#aranchor)> | ARAnchor data attached to the current trackable object.|
| trackingState          | [TrackingState](#enum-trackingstate) | Status of the current trackable.|
</details>

#### Public Method Summary

| Name                | Return Type          | Description                                                            |
| :------------------ | :------------ | :--------------------------------------------------------------------- |
| toMap               | Map\<String, dynamic> | Returns the map representation of the current ARBody object. |
| toString            | String | Returns the string representation of the current ARBody object.|

##### Public Methods

##### Map\<String, dynamic> toMap
Converts the current ARBody object to a Map.

###### Return Type
| Type                  | Description   |
| :-------------------- | :------------ |
| Map\<String, dynamic> | Map representation of the current ARBody object. |

##### String toString
Converts the current ARBody object to a string.

###### Return Type
| Type          | Description   |
| :-----------  | :------------ |
| String        | String representation of the current ARBody object. |


##### Body Action Mapping
Huawei AR Engine can recognize different body actions. When a body action is recognized by the AR Engine SDK, the corresponding integer value will be returned through the **bodyAction** field. The table below shows the mapping of different body actions that can be recognized by the AR Engine.

<table>
  <tr>
    <th>
    <img src="https://communityfile-drcn.op.hicloud.com/FileServer/getFile/cmtyPub/011/111/111/0000000000011111111.20200927161415.46731735517740074658714673465960:50510927095945:2800:27044D2EF3E70E59DC0DC97D2A3614ECA2D2E3F0AFAADB70684577200DC04174.png?needInitFileName=true?needInitFileName=true"  alt="1" width = 120px height = 160px >
    </th>
    <th>
    <img src="https://communityfile-drcn.op.hicloud.com/FileServer/getFile/cmtyPub/011/111/111/0000000000011111111.20200927161415.09704615669652331159025300731120:50510927095945:2800:4F5C5115B29CA7C958BBDC21C0311FF8BC02320F0BB0596BD77CAD025B1B3200.png?needInitFileName=true?needInitFileName=true" alt="3" width = 120px height = 160px>
    </th>
    <th>
    <img src="https://communityfile-drcn.op.hicloud.com/FileServer/getFile/cmtyPub/011/111/111/0000000000011111111.20200927161415.59250497190229584349714881668510:50510927095945:2800:9801BB0863FF586597AFE746262CCDF82CDE56D04D45A3008E4B95B71D25C84D.png?needInitFileName=true?needInitFileName=true" alt="3" width = 120px height = 160px>
    </th>
  </tr>
  <tr>
    <td>Return value: 1</td>
    <td>Return value: 2</td>
    <td>Return value: 3</td>
  </tr>
    <tr>
    <th>
    <img src="https://communityfile-drcn.op.hicloud.com/FileServer/getFile/cmtyPub/011/111/111/0000000000011111111.20200927161415.04620619867542869512912002890329:50510927095945:2800:88CE747C1EC90F88B4493644688CBCFBEF926CC4702C198DC895E6D369CA818E.png?needInitFileName=true?needInitFileName=true"  alt="1" width = 120px height = 160px >
    </th>
    <th>
    <img src="https://communityfile-drcn.op.hicloud.com/FileServer/getFile/cmtyPub/011/111/111/0000000000011111111.20200927161415.80932568391815331625170557072219:50510927095945:2800:474880767C4549E7329241EC80814324083ED986EB7929483A9BDBCAA53CDB88.png?needInitFileName=true?needInitFileName=true" alt="3" width = 120px height = 160px>
    </th>
    <th>
    <img src="https://communityfile-drcn.op.hicloud.com/FileServer/getFile/cmtyPub/011/111/111/0000000000011111111.20200927161415.46087084711452457207160829601066:50510927095945:2800:6B026F621A967E3BA52DBD6B33BDD5FFB9CE2A9B6C187AAF2B6193990F4A51CF.png?needInitFileName=true?needInitFileName=true" alt="3" width = 120px height = 160px>
    </th>
  </tr>
  <tr>
    <td>Return value: 4</td>
    <td>Return value: 5</td>
    <td>Return value: 6</td>
  </tr>
</table>

### ARPlane
Represents the plane information in the real world identified by HUAWEI AR Engine. This class is derived from [ARTrackableBase](#artrackablebase).

#### Public Constants

##### enum SemanticPlaneLabel
Semantic types of the current plane.

| Value         | Description |
| :------------ | :---------- |
| PLANE_OTHER   | Others.     |
| PLANE_WALL    | Wall.       |
| PLANE_FLOOR   | Floor.      |
| PLANE_SEAT    | Seat.       |
| PLANE_TABLE   | Table.      |
| PLANE_CEILING | Ceiling.    |

##### enum PlaneType
The plane type.

| Value                      | Description                                                          |
| :------------------------- | :------------------------------------------------------------------- | 
| HORIZONTAL_UPWARD_FACING   | A horizontal plane facing up (such as the ground and desk platform). |
| HORIZONTAL_DOWNWARD_FACING | A horizontal plane facing down (such as the ceiling).                |
| VERTICAL_FACING            | A vertical plane.                                                    |
| UNKNOWN_FACING             | Unsupported type.                                                    |

#### Public Properties

<details>
  <summary>Click to expand/collapse table</summary>

| Name          | Type          | Description                                                                       |
| :------------ | :------------ | :-------------------------------------------------------------------------------- |
| centerPose    | [ARPose](#arpose) | The pose transformed from the local coordinate system of a plane to the world coordinate system.|
| extentX       | double | The length of the plane's bounding rectangle measured along the local X-axis of the coordinate system centered on the plane, such as the width of the rectangle. |
| extentZ       | double | The length of the plane's bounding rectangle measured along the local Z-axis of the coordinate system centered on the plane, such as the height of the rectangle. |
| planePolygon  | List\<double>  | The 2D vertices of the detected plane, in the format of [x1, z1, x2, z2, ...]. |
| label         | [SemanticPlaneLabel](#enum-semanticplanelabel) | The semantic type of the current plane, such as desktop or floor. |
| type          | [PlaneType](#enum-planetype) | The plane type. |
| anchors       | List\<[ARAnchor](#aranchor)> | ARAnchor data attached to the current trackable object. |
| trackingState | [TrackingState](#enum-trackingstate) | Status of the current trackable. |
</details>

#### Public Method Summary

| Name                | Return Type          | Description                                                            |
| :------------------ | :------------ | :--------------------------------------------------------------------- |
| toMap               | Map\<String, dynamic> | Returns the map representation of the current ARPlane object. |
| toString            | String | Returns the string representation of the current ARPlane object.|

##### Public Methods

##### Map\<String, dynamic> toMap
Converts the current ARPlane object to a Map.

###### Return Type
| Type                  | Description   |
| :-------------------- | :------------ |
| Map\<String, dynamic> | Map representation of the current ARPlane object. |

##### String toString
Converts the current ARPlane object to a string.

###### Return Type
| Type          | Description   |
| :-----------  | :------------ |
| String        | String representation of the current ARPlane object. |

### Global Public Constants

#### enum ARCoordinateSystemType
The coordinate system type.

| Value                            | Description                   |
| :------------------------------- | :---------------------------- |
| COORDINATE_SYSTEM_TYPE_UNKNOWN   | Unknown coordinate system.    |
| COORDINATE_SYSTEM_TYPE_3D_WORLD  | World coordinate system       |
| COORDINATE_SYSTEM_TYPE_3D_SELF   | Local coordinate system.      |
| COORDINATE_SYSTEM_TYPE_2D_IMAGE  | OpenGL NDC coordinate system. |
| COORDINATE_SYSTEM_TYPE_3D_CAMERA | Camera coordinate system.     |


---

## 4. Configuration and Description

No configuration needed.

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

Huawei AR Kit Flutter Plugin is licensed under [Apache 2.0 license](LICENSE)
