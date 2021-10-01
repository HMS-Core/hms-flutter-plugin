## 5.3.0+304
* Upgraded Push SDK and added the **getAnalyticInfo** and **getAnalyticInfoMap** methods to obtain **bi_tag** (indicates the tag of a message in a batch delivery task).
* Resolved the issue about the call of Implicit PendingIntent.
* Updated Background Messaging and added V2 plugin embedding support.
* Added custom data payload to local notifications.
* Bug fixes and improvements.
* **[Breaking Change]**
  * Library file name "huawei_push_library" has changed to "huawei_push" due to a pub requirement.

## 5.1.1+301
* Updated Push SDK to the latest version 5.1.1+301.
* Added Multi-Sender API.
* Bug fixes and improvements.
* **[Breaking Changes]**
  * Migrated the plugin to Null-Safety.
  * Folder structure updated, all library can be imported with a single line.
  * Code constant renamed as ResultCodes.
  * Push.deleteToken method's result will not be returned to the stream anymore, it can be obtained directly from the method.

## 5.0.2+304
* Updated HMSLogger.
* Changed lightSettings, vibrateConfig, titleLocalizationArgs and bodyLocalizationArgs fields of RemoteMessageNotification to type List\<dynamic> in order to support parsing for 3rd party integrations.

## 5.0.2+302/5.0.2+303
* Updated documentation comments for push.dart.
* Bug fixes and improvements.

## 5.0.2+301
* Added the registerBackgroundMessageHandler and removeBackgroundMessageHandler methods for handling data messages when application at background/killed state.
* Added the "scope" parameter to getToken and deleteToken methods.
* Change responses of onNotificationOpenedApp listener and getInitialNotification method, added "extra" and "uriPage" keys to result object.
* Bug fixes and improvements.

## 5.0.2+300
* Support for ODID and added the getOdid() method.
* Support for Uplink Message Sending with sendRemoteMessage() method.
* Support for sending Local Notifications.
* Support for obtaining the Custom Intent URI from the push notification.
* Added streams for listening HMSMessageService events.
* Update for the demo project.
* Fix minor issues.

## 4.0.4+300
* Fix minor issues. 

## 4.0.4
* Initial release.
