## 3.12.0+301

- Dart improvements.

## 3.12.0+300

- Added the Customized Scanning Action section for the Interactive Biometric Verification service, and added error code USER_ DEFINED_ACTIONS_INVALID and method setActionArray(int[]actionArray, int num, boolean isRandomable).

## 3.7.0+300

- Added `setUserRegion` and `getCountryCode` methods to MLBodyApplication.
- Added `MLInteractiveLivenessCapture` API which is interactive biometric verification service implements liveness detection in an interactive way.

- **Breaking Changes:**

  - With this release, `MLBodyPermissions` has been removed. You are expected to handle required permissions on your own. You can learn more about the required permissions from our [official documentations](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides/assigning-permissions-0000001052789343?ha_source=hms1).
  - Modified the internal structure of the plugin. Please use import **package:huawei_ml_body/huawei_ml_body.dart** not to get any errors.

  **Updated API List**

  - MLSkeleton:
    - Type of `joints` changed to `List<MLJoint>` from `List<MLJoint?>`.
  - MLJoint:
    - Type of `type` changed to `int` from `int?`.
    - Type of `pointX` changed to `double` from `dynamic`.
    - Type of `pointY` changed to `double` from `dynamic`.
    - Type of `score` changed to `double` from `dynamic`.
  - MLHandKeyPoints:
    - Type of `handKeyPoints` changed to `List<MLHandKeyPoint>` from `List<MLHandKeyPoint?>`.
  - MLHandKeyPoint:
    - Type of `pointX` changed to `double` from `dynamic`.
    - Type of `pointY` changed to `double` from `dynamic`.
    - Type of `score` changed to `double` from `dynamic`.
  - MLFace:
    - Type of `faceShapeList` changed to `List<MLFaceShape>` from `List<MLFaceShape?>`.
    - Type of `keyPoints` changed to `List<MLFaceKeyPoint>` from `List<MLFaceKeyPoint?>`.
    - Type of `allPoints` changed to `List<BodyPosition>` from `List<BodyPosition?>`.
    - Type of `rotationAngleX` changed to `double` from `dynamic`.
    - Type of `rotationAngleY` changed to `double` from `dynamic`.
    - Type of `rotationAngleZ` changed to `double` from `dynamic`.
    - Type of `opennessOfLeftEye` changed to `double` from `dynamic`.
    - Type of `opennessOfRightEye` changed to `double` from `dynamic`.
    - Type of `possibilityOfSmiling` changed to `double` from `dynamic`.
    - Type of `tracingIdentity` changed to `int` from `int?`.
    - Type of `width` changed to `double` from `dynamic`.
    - Type of `height` changed to `double` from `dynamic`.
  - MLFaceEmotion:
    - Type of `angryProbability` changed to `double` from `dynamic`.
    - Type of `disgustProbability` changed to `double` from `dynamic`.
    - Type of `surpriseProbability` changed to `double` from `dynamic`.
    - Type of `sadProbability` changed to `double` from `dynamic`.
    - Type of `neutralProbability` changed to `double` from `dynamic`.
    - Type of `smilingProbability` changed to `double` from `dynamic`.
    - Type of `fearProbability` changed to `double` from `dynamic`.
  - MLFaceShape:
    - Type of `points` changed to `List<BodyPosition>` from `List<BodyPosition?>`.
  - MLFaceFeature:
    - Type of `age` changed to `int` from `int?`.
    - Type of `moustacheProbability` changed to `double` from `dynamic`.
    - Type of `hatProbability` changed to `double` from `dynamic`.
    - Type of `sexProbability` changed to `double` from `dynamic`.
    - Type of `sunGlassProbability` changed to `double` from `dynamic`.
    - Type of `leftEyeOpenProbability` changed to `double` from `dynamic`.
    - Type of `rightEyeOpenProbability` changed to `double` from `dynamic`.
  - ML3DFace
    - Type of `allVertexes` changed to `List<BodyPosition>` from `List<BodyPosition?>`.
    - Type of `eulerX` changed to `double` from `dynamic`.
    - Type of `eulerY` changed to `double` from `dynamic`.
    - Type of `eulerZ` changed to `double` from `dynamic`.
  - BodyPosition
    - Type of `x` changed to `double?` from `dynamic`.
    - Type of `y` changed to `double?` from `dynamic`.
    - Type of `z` changed to `double?` from `dynamic`.

## 3.2.0+301

- Deleted the capability of prompting users to install HMS Core (APK).

## 3.2.0+300

- Initial release.
