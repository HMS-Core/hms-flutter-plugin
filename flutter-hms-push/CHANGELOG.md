## 6.12.0+302

- Fixed stability and performance issues.
  > You are advised to use this version. To use it, you only need to update the version number and do not need to modify any code for adaptation.

## 6.12.0+301

- Minor optimization.

## 6.12.0+300

- To solve stability and performance problems, it is recommended that you use it integratedly. You only need to upgrade the version number, and no other code adaptation is required. 

## 6.11.0+300

- Fixed stability and performance issues. 
  > You are advised to use this version. To use it, you only need to update the version number and do not need to modify any code for adaptation.

## 6.10.0+300

- Updated Push SDK to the latest version 6.10.0.300.
- Resolved a performance-related issue.

## 6.7.0+300

- Updated Push SDK to the latest version 6.7.0.300.
- Added the function of integrating the HMS Core Installer SDK to prompt users to download HMS Core (APK), ensuring that your app can normally use capabilities of HMS Core (APK).
- Adapted to Android 13 (targetSdkVersion=33).

## 6.5.0+300

- Updated Push SDK to the latest version 6.5.0.300.
- Added HmsConsent API.

## 6.3.0+304

- Updated Push SDK to the latest version 6.3.0.304.
- Deleted the capability of prompting users to install HMS Core (APK).

## 6.3.0+302

- Updated Push SDK to the latest version 6.3.0.302.
- Updated minSdkVersion to 19.
- Fixed some issues for adapting to Android 12 (targetSdkVersion=31).

## 6.1.0+300

- Updated Push SDK to the latest version 6.1.0.300. This SDK has preset configuration of the <queries> element so that
  your app can properly call HMS Core (APK) on Android 11.

  > Your Android Studio version must be 3.6.1 or later, and your Android Gradle plugin must be 3.5.4 or later.

- Huawei Push-FCM Proxy SDK has been seperated from the Push Kit and released as a new Flutter plugin.
- Bug fixes.

## 5.3.0+304

- Upgraded Push SDK and added the **getAnalyticInfo** and **getAnalyticInfoMap** methods to obtain **bi_tag** (indicates
  the tag of a message in a batch delivery task).
- Resolved the issue about the call of Implicit PendingIntent.
- Updated Background Messaging and added V2 plugin embedding support.
- Added custom data payload to local notifications.
- Bug fixes and improvements.
- **[Breaking Change]**
  - Library file name "huawei_push_library" has changed to "huawei_push" due to a pub requirement.

## 5.1.1+301

- Updated Push SDK to the latest version 5.1.1.301.
- Added Multi-Sender API.
- Bug fixes and improvements.
- **[Breaking Changes]**
  - Migrated the plugin to Null-Safety.
  - Folder structure updated, all library can be imported with a single line.
  - Code constant renamed as ResultCodes.
  - Push.deleteToken method's result will not be returned to the stream anymore, it can be obtained directly from the
    method.

## 5.0.2+304

- Updated HMSLogger.
- Changed lightSettings, vibrateConfig, titleLocalizationArgs and bodyLocalizationArgs fields of
  RemoteMessageNotification to type List\<dynamic> in order to support parsing for 3rd party integrations.

## 5.0.2+302/5.0.2+303

- Updated documentation comments for push.dart.
- Bug fixes and improvements.

## 5.0.2+301

- Added the registerBackgroundMessageHandler and removeBackgroundMessageHandler methods for handling data messages when
  application at background/killed state.
- Added the "scope" parameter to getToken and deleteToken methods.
- Change responses of onNotificationOpenedApp listener and getInitialNotification method, added "extra" and "uriPage"
  keys to result object.
- Bug fixes and improvements.

## 5.0.2+300

- Support for ODID and added the getOdid() method.
- Support for Uplink Message Sending with sendRemoteMessage() method.
- Support for sending Local Notifications.
- Support for obtaining the Custom Intent URI from the push notification.
- Added streams for listening HMSMessageService events.
- Update for the demo project.
- Fix minor issues.

## 4.0.4+300

- Fix minor issues.

## 4.0.4

- Initial release.
