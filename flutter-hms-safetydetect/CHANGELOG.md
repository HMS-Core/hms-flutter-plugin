## 6.4.0+302

- **Breaking Changes**
  - Use `SafetyDetect.statusCodes` instead of `SafetyDetectStatusCodes`.
  - Modified the internal structure of the plugin. Please use import **package:huawei_safetydetect/huawei_safetydetect.dart** not to get any errors.

## 6.4.0+301

- Updated the framework version.
- Optimized user experience and solved several known issues.

## 6.1.0+302

- Nullsafety migration.
- Added the result code USER_DETECT_PERMISSION, indicating no permission to show a popup for fake user detection on some non-Huawei phones.
- Added signature verification algorithm support to the SysIntegrity API. Supported algorithms are RS256 and PS256.
- Updated to newest sdk version.

## 5.0.3+301

- Updated HMSLogger.

## 5.0.3+300

- Initial release.
