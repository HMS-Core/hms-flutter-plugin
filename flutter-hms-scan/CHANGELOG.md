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
