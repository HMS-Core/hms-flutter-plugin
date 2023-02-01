## 3.7.0+3

- Added maxMapSize for you to set the maximum memory occupied by the map data, so as to reduce the memory usage of your app.
- Added the function of switching between the front and rear cameras for face tracking. 
- Added the feature of throwing ARUnavailableServiceApkTooOldException when your app calls APIs of AR Engine whose version is later than that installed on the device.
- Added multiFace recognition mode. Note that when lighting estimate is enabled, multi-face tracking will be unsupported. Disable lighting estimate before you use multi-face tracking.
- Added the lightMode param to set the lighting mode.
- Added the following constant for lightMode;
    - NONE, which indicates not to enable the lighting estimate capabilities.
    - AMBIENT_INTENSITY, which indicates to enable the ambient lighting intensity estimate capability.
    - ENVIRONMENT_LIGHTING, which indicates to enable the ambient lighting estimate capability.
    - ENVIRONMENT_TEXTURE, which indicates to enable the lighting environment texture estimate capability.
    - ALL, which indicates to enable all lighting estimate capabilities.
- Added the methods for obtaining the intensity, direction, and color of the main light source, the shadow type and strength, and the spherical coefficient of the global ambient lighting to the ARLightEstimate class.
- Added the semantic identification type for doors, windows, and beds. For details, see SemanticPlaneLabel.
- Added the ARAugmentedImage class for image tracking.
- Added the ARAugmentedImageConfig class.
- Added the ARSceneWorldBodyConfig class.
- Added the ARSceneMeshConfig class.
- Added the ARCameraConfig class.
- Added the ARCameraIntrinsics class.
- Added the ARTarget class. 
- Added the HealthParameter enum.
- Added the LightMode enum.
- Added the PowerMode enum.
- Added the FocusMode enum.
- Added the UpdateMode enum.
- Added the PlaneFindingMode enum.
- Added the TargetLabel and TargetShapeType enums.
- Added the handleCameraIntrinsics callback function for the camera offline intrinsic parameters.
- Added the handleCameraConfigData callback function to query the properties of a camera.
- Added the handleResult callback function for detection result of FaceHealthScene.
- Added the handleMessageData callback function to get some information about the scene. For example FPS etc.

- **[Breaking Changes]**
  - Migrated to **null-safety**.
  - With this release, `requestCameraPermission` has been removed. You are expected to handle required permissions on your own. You can learn more about the required permissions from our [official documentations](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides/dev-process-0000001059264478?ha_source=hms1).
  - Modified the internal structure of the plugin. Please use import `package:huawei_ar/huawei_ar.dart` not to get any errors.

## 2.13.0+5

- Updated HMSLogger.

## 2.13.0+4

- Initial release.
