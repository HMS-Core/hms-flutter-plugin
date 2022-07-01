## 6.5.0+300

- **[Breaking Change]** Added the ```getInstance({String routePolicy})```  method. With this version ```getInstance``` method must be called from the application to initialize plugin in Android platform.
- Added events to [HAEventType](lib/src/constants/analytics_constants.dart). 
- Added parameters to [HAParamType](lib/src/constants/analytics_constants.dart).
- Added attributes to [HAUserProfileType](lib/src/constants/analytics_constants.dart).
- Added ```setChannel```, ```setPropertyCollection``` and ```setCustomReferrer``` methods to [HMSAnalytics](lib/src/hms_analytics.dart) class.
- Supported on devices running Android 12.

## 6.2.0+302

- Deleted the capability of prompting users to install HMS Core (APK).

## 6.2.0+301

- Added the setCollectAdsIdEnabled and addDefaultEventParams methods.
- Changed the value of minSdkVersion from 18 to 19

## 5.2.0+301

- Changed the value of minSdkVersion from 19 to 18 to support more mobile phones.
- Added custom data support to onEvent API.
- **[Breaking Change]** Deleted the **OccurredTime** and **InstallTime** parameters from the automatically collected events and predefined events.

## 5.1.0+301

- Updated HMSLogger.

## 5.1.0+300

- Added the setRestrictionEnabled, isRestrictionEnabled and deleteUserProfile methods.
- Added getReportPolicyThreshold. This function is specifically used by Android Platforms.
- Update for the demo project.
- Added the HAUserProfileType.
- Update HAEventType and HAParamType.

## 5.0.3+300

- Added the enableLogger and disableLogger methods.
- Support for iOS.
- Update for the demo project.

## 4.0.4

- Initial release.
