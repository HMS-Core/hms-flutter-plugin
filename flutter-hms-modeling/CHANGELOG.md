## 1.8.0+300

- Updated minSdkVersion to 26.
- Added the **downloadModelWithConfig** method to the `Modeling3dReconstructEngine` class. 
- Added **Modeling3dReconstructDownloadConfig** class for setting download configurations.
- Added two new methods to the `Modeling3dReconstructQueryResult` class: the **getReconstructFailMessage** method for obtaining the task failure reason and the **getModelFormat** method for obtaining the supported model file formats.
- Added the **setTextureMode** method to set the texture map mode for the model to be downloaded to the `Modeling3dReconstructDownloadConfig.Factory` class.
- Added **TextureMode** constant to `Modeling3dReconstructConstants` class for defining the texture map mode of a 3D object reconstruction task.
- Added **Modeling3dReconstructPreviewConfig** class as the model preview configuration for a 3D object reconstruction task.
- Added result codes to **Modeling3dReconstructErrors**.
- Deleted the result code **ERR_RET_OVER_MAX_LIMIT**.
- Added the `real-time guide mode`.
  - Added **Modeling3dCaptureErrors**, **Modeling3dCaptureImageEngine**, **Modeling3dCaptureImageListener** and **Modeling3dCaptureSetting** classes.
  - Added two methods to the `Modeling3dCaptureImageEngine` class: **setCaptureConfig**, **captureImage**.
- Added the **Auto Rigging** capability.
- Added **getTaskType** (for obtaining the type of a 3D object reconstruction task) to `Modeling3dReconstructSetting`.
- Added **setTaskType** (for setting the type of a 3D object reconstruction task) to `Modeling3dReconstructSetting.Factory`.
- Added **riskControlAuditInProgress**, **riskControlFailed**, and **riskControlPassed** to **ProgressStatus** constant in `Modeling3dReconstructConstants` class.
- Added the **FaceLevel** constant to `Modeling3dReconstructConstant` class for mesh count levels.
- Added the **NeedRescan** constant to `Modeling3dReconstructConstants` class for extra scanning statuses.
- Added the following methods to `Modeling3dReconstructSetting.Factory`: **setFaceLevel**, **setNeedRescan**, and **setTaskId**.
- Added the `motion capture`.
  - Added **Modeling3dMotionCaptureConstants**, **Modeling3dMotionCaptureJoint**, **Modeling3dMotionCaptureQuaternion**, **Modeling3dMotionCaptureSkeleton** classes.
  - Added **analyseFrame**, **asyncAnalyseFrame** methods.

- **Breaking Changes:**
  - Modified the internal structure of the plugin. Please use import **package:huawei_modeling3d/huawei_modeling3d.dart** not to get any errors.
  - With this release, `PermissionHandler` has been removed. You are expected to handle required permissions on your own. You can learn more about the required permissions from our [official documentations](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides/adding-permissions-0000001209850943?ha_source=hms1).

## 1.1.0+300

- Initial release.
