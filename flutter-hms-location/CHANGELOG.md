## 6.4.0+300

- **Breaking Change:** With this release, `PermissionHandler` has been removed. You are expected to handle required permissions on your own. You can learn more about the required permissions from our [official documentations](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides/dev-process-0000001089376648?ha_source=hms1)
- Opened the background location service for non-Huawei Android phones, and added the enableBackgroundLocation and disableBackgroundLocation methods to the FusedLocationProviderClient class.
- Supported fused location on non-Huawei phones.
- Added the setLogConfig and getLogConfig methods to the FusedLocationProviderClient class for log recording function.
- Added the GeocoderService class with getFromLocation and getFromLocationName methods.
- Modified the internal structure of the plugin. Please use import 'package:huawei_location/huawei_location.dart' not to get any errors.
## 6.0.0+303

- Deleted the capability of prompting users to install HMS Core (APK).

## 6.0.0+302

- Added the High-precision Location capability.
  ***
  **NOTE**
  Currently, the high-precision location capability of Location Kit is available only in Shenzhen, Guangzhou, Suzhou, Hangzhou, and Chongqing in the Chinese mainland.
  ***
- Supported fused location on non-Huawei phones.
- Canceled support of the geofence function on non-Huawei phones.

## 5.1.0+303

- [Breaking Change] Added Null Safety support.

## 5.1.0+301

- Added the following properties to the **LocationSettingsStates** class: hmsLocationPresent, hmsLocationUsable, gnssPresent, gnssUsable.
- Deprecated the following properties in the **LocationSettingsStates** class: gpsPresent, gpsUsable.
- Removed the following property in the **NavigationRequest** class: extras.

## 5.0.0+301

- Added the getNavigationContextState function.
- Added the enableLogger and disableLogger methods.

## 4.0.4+1/4.0.4+300

- Fix minor issues.

## 4.0.4

- Initial release.
