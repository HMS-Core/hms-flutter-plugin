## 6.12.1+310

- **Breaking Change:** Wifi Service has been removed.
- **Breaking Change:** API 33 support has been added.
- Added `registerScanTask`, `unRegisterScanTask`, `getRawBeaconConditions` and `getBeaconMsgConditions` methods.
- Added `getBeaconBroadcastStream` listener.
- Added `setAgcRegion` method with its enum class `RegionCode`.

## 6.4.0+300

- **Breaking Change:** With this release, `NearbyPermissionHandler` has been removed. You are expected to handle required permissions on your own. You can learn more about the required permissions from our [official documentations](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides/dev-process-0000001073825475?ha_source=hms1)
- Deleted the capability of prompting users to install HMS Core (APK).
- Supported the new Bluetooth permissions in Android 12.

## 6.1.0+300

- Added the requestConnectEx(String name, String endpointId, ConnectOption) method to the HMSDiscoveryEngine class.
- Added the getChannelPolicy() method to the ConnectResult class.
- Added the ConnectOption and ChannelPolicy classes.
- Added the STATUS_WIFI_NOT_SUPPORT_SHARE, STATUS_WIFI_MUST_BE_ENABLED, and STATUS_ANDROID_HMS_RESTRICTED error codes.
- Modified the ConnectResult(Status) build method in the ConnectResult class to ConnectResult(Status, ChannelPolicy).
- Deprecated the requestConnect(String name, String endpointId) method in the HMSDiscoveryEngine class.
- Migrated to null-safety.

## 5.0.4+303

- Updated HMSLogger.

## 5.0.4+302

- Initial release.
