## 6.1.0+300
* Added the requestConnectEx(String name, String endpointId, ConnectOption) method to the HMSDiscoveryEngine class.
* Added the getChannelPolicy() method to the ConnectResult class.
* Added the ConnectOption and ChannelPolicy classes.
* Added the STATUS_WIFI_NOT_SUPPORT_SHARE, STATUS_WIFI_MUST_BE_ENABLED, and STATUS_ANDROID_HMS_RESTRICTED error codes.
* Modified the ConnectResult(Status) build method in the ConnectResult class to ConnectResult(Status, ChannelPolicy).
* Deprecated the requestConnect(String name, String endpointId) method in the HMSDiscoveryEngine class.
* Migrated to null-safety.

## 5.0.4+303
* Updated HMSLogger.

## 5.0.4+302
* Initial release.
