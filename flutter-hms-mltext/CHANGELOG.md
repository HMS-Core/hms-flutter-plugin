## 3.12.0+301

- Dart improvements.

## 3.12.0+300

- Bank card recognition: Added the onBcrFailResult(MLBcrCaptureResult result) method to the CustomView.OnBcrResultCallback API.

## 3.7.0+300

- Added `setUserRegion` and `getCountryCode` methods to MLTextApplication.

- **Breaking Changes:**

  - With this release, `MLTextPermissions` has been removed. You are expected to handle required permissions on your own. You can learn more about the required permissions from our [official documentations](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides/assigning-permissions-0000001052789343?ha_source=hms1).
  - Modified the internal structure of the plugin. Please use import **package:huawei_ml_text/huawei_ml_text.dart** not to get any errors.

  **Updated API List**

  - MLTextEmbeddingAnalyzer:
    - Return type of `analyzeSentenceVector` changed to `List<double>` from `List<dynamic>`.
    - Return type of `analyseWordVector` changed to `List<double>` from `List<dynamic>`.
    - Return type of `analyseSimilarWords` changed to `List<String>` from `List<dynamic>`.
    - Return type of `analyseWordVectorBatch` changed to `Map<String, List<double>>` from `dynamic`.

## 3.2.0+301

- Deleted the capability of prompting users to install HMS Core (APK).

## 3.2.0+300

- Initial release.
