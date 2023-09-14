## 3.11.0+300

- Updated targetSdkVersion to 31, to make sure that your app can run properly on Android 12.

## 3.7.0+300

- Added `setUserRegion` and `getCountryCode` methods to MLImageApplication.

- **Breaking Changes:**

  - With this release, `MLImagePermissions` has been removed. You are expected to handle required permissions on your own. You can learn more about the required permissions from our [official documentations](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides/assigning-permissions-0000001052789343?ha_source=hms1).
  - Modified the internal structure of the plugin. Please use import **package:huawei_ml_image/huawei_ml_image.dart** not to get any errors.

## 3.2.0+301

- Deleted the capability of prompting users to install HMS Core (APK).

## 3.2.0+300

- Initial release.
