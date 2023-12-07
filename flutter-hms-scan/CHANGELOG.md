## 2.12.0+301

- Added `decode(DecodeRequest request)` method to HmsScanUtils.
- Added `photoMode`, `parseResult`, `multiMode` variables to DecodeRequest model.
- Supported the multi-functional code by adding `MULTI_FUNCTIONAL_SCAN_TYPE` to HmsScanTypes.
- Added `SCAN_NO_DETECTED` error type.

## 2.10.0+301

- Updated Scan SDK to the latest version 2.10.0.301.
- Added relevant instructions in Adding Permissions.
- Updated the development procedure and code of Default View.
- Added RESULT_CODE (indicating the scanning result) to ScanUtil.
- Added setErrorCheck(boolean var1) for listening to errors to HmsScanAnalyzerOptions.Creator.
- Added supplementary information about the personal information collected by the SDK.

## 2.8.0+300

- Scan Kit SDK is updated to the newest version.
- **Breaking Change:** With this release, `PermissionMethodCallHandler` has been removed. You are expected to handle required permissions on your own. You can learn more about the required permissions from our [official documentations](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides/dev-process-0000001057213093?ha_source=hms1)
- Modified the internal structure of the plugin. Please use import 'package:huawei_scan/huawei_scan.dart' not to get any errors.

## 2.1.0+300

- Nullsafety migration.
- Scan Kit SDK is updated to the newest version.

## 1.3.0+300

- Scan Kit SDK is updated to the newest version.
- [**Breaking Change**] HmsCustomizedView.startCustomizedView doesn't return ScanResponse anymore. All ScanResponse objects can be listenable from customizedCameraListener callback on CustomizedViewRequest.
- qrLogo parameter added to BuildBitmapRequest for creating QR codes with a logo.
- Updated HMSLogger.

## 1.2.2

- Initial release.
