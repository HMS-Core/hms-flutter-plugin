## 6.12.0+303

- Minor optimization and bug fixes.

## 6.12.0+302

- Minor optimization and bug fixes.

## 6.12.0+301

**Breaking Changes:** 
- Starting from this version, you first need to initialize the services to use their features.
  - Added `initFusedLocationService()` method to `FusedLocationProviderClient`.
  - Added `initActivityIdentificationService()` method to `ActivityIdentificationService`.
  - Added `initGeofenceService()` method to `GeofenceService`.
  - Added `initGeocoderService(Locale locale)` method to `GeocoderService`.  
  - Removed `Locale` parameter from `getFromLocation` and `getFromLocationName` methods. 

> For more information, please visit the [API References](https://developer.huawei.com/consumer/en/doc/HMS-Plugin-References/overview-0000001057833710-V1?ha_source=hms1) document.

## 6.12.0+300

- **Breaking Change:** The minimum API Level minSdkVersion changed 21 . 
- Fix issues related to Pending Intents in Android API 33.

## 6.11.0+301

- Optimized the scenario where no GNSS location is returned.
- Added the logic of checking whether the value is empty during coordinate conversion
- Added error code 10206 for the geofence function, indicating that the geofence function is disabled.
- Added PRIORITY_HIGH_ACCURACY_AND_INDOOR (location request type) to LocationRequest, which is used to check whether location type is indoor location or fused location.
- Added the utility class LocationUtils for converting WGS84 coordinates into GCJ02 coordinates.
- Added LonLat, which is a coordinate object returned after coordinate type conversion.
- Modified getCoordinateType and setCoordinateType in HWLocation, and setCoordinateType in LocationRequest.
- Modified the following APIs in FusedLocationProviderClient to support setting of the output coordinate type:
getLastLocationWithAddress(LocationRequest request), requestLocationUpdates(LocationRequest request, LocationCallback callback, Looper looper), requestLocationUpdatesEx(LocationRequest request, LocationCallback callback, Looper looper)
- Adapted to Android 13, so that your app can use related functions normally when running on Android 13.
- Optimized callback parameters of the disableBackgroundLocation and enableBackgroundLocation(int id, Notification notification) methods in FusedLocationProviderClient.
- Optimized AndroidManifest.xml in the Location SDK to ensure that the displayed version number is consistent with the integrated version number.
- Modified the naming rule of xxx.properties in the Location SDK to solve the integration conflict issue.

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
