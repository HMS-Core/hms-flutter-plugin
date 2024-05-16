/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License")
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

part of huawei_nearbyservice;

class NearbyStatus {
  final int code;
  final String message;

  const NearbyStatus(this.code, this.message);

  static const NearbyStatus success = NearbyStatus(0, 'STATUS_SUCCESS');
  static const NearbyStatus failure = NearbyStatus(-1, 'STATUS_FAILURE');
  static const NearbyStatus unknown = NearbyStatus(-2, 'STATUS_UNKNOWN');
  static const NearbyStatus apiDisorder =
      NearbyStatus(8001, 'STATUS_API_DISORDER');
  static const NearbyStatus noNetwork = NearbyStatus(8002, 'STATUS_NO_NETWORK');
  static const NearbyStatus notConnected =
      NearbyStatus(8003, 'STATUS_NOT_CONNECTED');
  static const NearbyStatus transferIoError =
      NearbyStatus(8004, 'STATUS_TRANSFER_IO_ERROR');
  static const NearbyStatus alreadyBroadcasting =
      NearbyStatus(8005, 'STATUS_ALREADY_BROADCASTING');
  static const NearbyStatus alreadyConnected =
      NearbyStatus(8006, 'STATUS_ALREADY_CONNECTED');
  static const NearbyStatus alreadyScanning =
      NearbyStatus(8007, 'STATUS_ALREADY_SCANNING');
  static const NearbyStatus policyConflict =
      NearbyStatus(8008, 'STATUS_POLICY_CONFLICT');
  static const NearbyStatus bluetoothOperationFailed =
      NearbyStatus(8009, 'STATUS_BLUETOOTH_OPERATION_FAILED');
  static const NearbyStatus connectRejected =
      NearbyStatus(8010, 'STATUS_CONNECT_REJECTED');
  static const NearbyStatus connectIoError =
      NearbyStatus(8011, 'STATUS_CONNECT_IO_ERROR');
  static const NearbyStatus endpointUnknown =
      NearbyStatus(8012, 'STATUS_ENDPOINT_UNKNOWN');
  static const NearbyStatus apiOccupied =
      NearbyStatus(8013, 'STATUS_API_OCCUPIED');
  static const NearbyStatus missingPermissionAccessCoarseLocation =
      NearbyStatus(8014, 'STATUS_MISSING_PERMISSION_ACCESS_COARSE_LOCATION');
  static const NearbyStatus missingPermissionAccessWifiState =
      NearbyStatus(8015, 'STATUS_MISSING_PERMISSION_ACCESS_WIFI_STATE');
  static const NearbyStatus missingPermissionBluetooth =
      NearbyStatus(8016, 'STATUS_MISSING_PERMISSION_BLUETOOTH');
  static const NearbyStatus missingPermissionBluetoothAdmin =
      NearbyStatus(8017, 'STATUS_MISSING_PERMISSION_BLUETOOTH_ADMIN');
  static const NearbyStatus missingPermissionChangeWifiState =
      NearbyStatus(8018, 'STATUS_MISSING_PERMISSION_CHANGE_WIFI_STATE');
  static const NearbyStatus missingSettingLocationOn =
      NearbyStatus(8020, 'STATUS_MISSING_SETTING_LOCATION_ON');
  static const NearbyStatus airplaneModeMustBeOff =
      NearbyStatus(8021, 'STATUS_AIRPLANE_MODE_MUST_BE_OFF');
  static const NearbyStatus missingPermissionBluetoothScan =
      NearbyStatus(8023, 'STATUS_MISSING_PERMISSION_BLUETOOTH_SCAN');
  static const NearbyStatus missingPermissionBluetoothAdvertise =
      NearbyStatus(8024, 'STATUS_MISSING_PERMISSION_BLUETOOTH_ADVERTISE');
  static const NearbyStatus missingPermissionBluetoothConnect =
      NearbyStatus(8025, 'STATUS_MISSING_PERMISSION_BLUETOOTH_CONNECT');
  static const NearbyStatus messageAppUnregistered =
      NearbyStatus(8050, 'STATUS_MESSAGE_APP_UNREGISTERED');
  static const NearbyStatus messageAppQuotaLimited =
      NearbyStatus(8051, 'STATUS_MESSAGE_APP_QUOTA_LIMITED');
  static const NearbyStatus messageBleBroadcastingUnsupported =
      NearbyStatus(8052, 'STATUS_MESSAGE_BLE_BROADCASTING_UNSUPPORTED');
  static const NearbyStatus messageBleScanningUnsupported =
      NearbyStatus(8053, 'STATUS_MESSAGE_BLE_SCANNING_UNSUPPORTED');
  static const NearbyStatus bluetoothOff =
      NearbyStatus(8054, 'STATUS_BLUETOOTH_OFF');
  static const NearbyStatus messageWrongContext =
      NearbyStatus(8055, 'STATUS_MESSAGE_WRONG_CONTEXT');
  static const NearbyStatus messageNotAllow =
      NearbyStatus(8056, 'STATUS_MESSAGE_NOT_ALLOW');
  static const NearbyStatus messageMissingPermissions =
      NearbyStatus(8057, 'STATUS_MESSAGE_MISSING_PERMISSIONS');
  static const NearbyStatus messageAuthFailed =
      NearbyStatus(8058, 'STATUS_MESSAGE_AUTH_FAILED');
  static const NearbyStatus messagePendingIntentsLimited =
      NearbyStatus(8059, 'STATUS_MESSAGE_PENDING_INTENTS_LIMITED');
  static const NearbyStatus internalError =
      NearbyStatus(8060, 'STATUS_INTERNAL_ERROR');
  static const NearbyStatus findingModeError =
      NearbyStatus(8061, 'STATUS_FINDING_MODE_ERROR');
  static const NearbyStatus missingPermissionFileReadWrite =
      NearbyStatus(8063, 'STATUS_MISSING_PERMISSION_FILE_READ_WRITE');
  static const NearbyStatus missingPermissionInterrnet =
      NearbyStatus(8064, 'STATUS_MISSING_PERMISSION_INTERNET');
  static const NearbyStatus wifiMustBeEnabled =
      NearbyStatus(8069, 'STATUS_WIFI_MUST_BE_ENABLED');
  static const NearbyStatus androidHmsRestricted =
      NearbyStatus(8070, 'STATUS_ANDROID_HMS_RESTRICTED');
  static const NearbyStatus notSetCloudPolicy =
      NearbyStatus(8071, 'STATUS_NOT_SET_CLOUD_POLICY');
  static const NearbyStatus selectCloudPolicyIsAuto =
      NearbyStatus(8072, 'STATUS_SELECT_CLOUD_POLICY_IS_AUTO');
  static const NearbyStatus beaconFilterSumExceedLimit =
      NearbyStatus(8073, 'STATUS_BEACON_FILTER_SUM_EXCEED_LIMIT');
  static const NearbyStatus singleAppBeaconFilterExceedLimit =
      NearbyStatus(8074, 'STATUS_SINGLE_APP_BEACON_FILTER_EXCEED_LIMIT');
  static const NearbyStatus beaconTaskNotFound =
      NearbyStatus(8075, 'STATUS_BEACON_TASK_NOT_FOUND');
  static const NearbyStatus beaconTaskRegistered =
      NearbyStatus(8076, 'STATUS_BEACON_TASK_REGISTERED');

  static NearbyStatus getStatus(int code) {
    switch (code) {
      case 0:
        return NearbyStatus.success;
      case -1:
        return NearbyStatus.failure;
      case -2:
        return NearbyStatus.unknown;
      case 8001:
        return NearbyStatus.apiDisorder;
      case 8002:
        return NearbyStatus.noNetwork;
      case 8003:
        return NearbyStatus.notConnected;
      case 8004:
        return NearbyStatus.transferIoError;
      case 8005:
        return NearbyStatus.alreadyBroadcasting;
      case 8006:
        return NearbyStatus.alreadyConnected;
      case 8007:
        return NearbyStatus.alreadyScanning;
      case 8008:
        return NearbyStatus.policyConflict;
      case 8009:
        return NearbyStatus.bluetoothOperationFailed;
      case 8010:
        return NearbyStatus.connectRejected;
      case 8011:
        return NearbyStatus.connectIoError;
      case 8012:
        return NearbyStatus.endpointUnknown;
      case 8013:
        return NearbyStatus.apiOccupied;
      case 8014:
        return NearbyStatus.missingPermissionAccessCoarseLocation;
      case 8015:
        return NearbyStatus.missingPermissionAccessWifiState;
      case 8016:
        return NearbyStatus.missingPermissionBluetooth;
      case 8017:
        return NearbyStatus.missingPermissionBluetoothAdmin;
      case 8018:
        return NearbyStatus.missingPermissionChangeWifiState;
      case 8020:
        return NearbyStatus.missingSettingLocationOn;
      case 8021:
        return NearbyStatus.airplaneModeMustBeOff;
      case 8023:
        return NearbyStatus.missingPermissionBluetoothScan;
      case 8024:
        return NearbyStatus.missingPermissionBluetoothAdvertise;
      case 8025:
        return NearbyStatus.missingPermissionBluetoothConnect;
      case 8050:
        return NearbyStatus.messageAppUnregistered;
      case 8051:
        return NearbyStatus.messageAppQuotaLimited;
      case 8052:
        return NearbyStatus.messageBleBroadcastingUnsupported;
      case 8053:
        return NearbyStatus.messageBleScanningUnsupported;
      case 8054:
        return NearbyStatus.bluetoothOff;
      case 8055:
        return NearbyStatus.messageWrongContext;
      case 8056:
        return NearbyStatus.messageNotAllow;
      case 8057:
        return NearbyStatus.messageMissingPermissions;
      case 8058:
        return NearbyStatus.messageAuthFailed;
      case 8059:
        return NearbyStatus.messagePendingIntentsLimited;
      case 8060:
        return NearbyStatus.internalError;
      case 8061:
        return NearbyStatus.findingModeError;
      case 8063:
        return NearbyStatus.missingPermissionFileReadWrite;
      case 8064:
        return NearbyStatus.missingPermissionInterrnet;
      case 8069:
        return NearbyStatus.wifiMustBeEnabled;
      case 8070:
        return NearbyStatus.androidHmsRestricted;
      case 8071:
        return NearbyStatus.notSetCloudPolicy;
      case 8072:
        return NearbyStatus.selectCloudPolicyIsAuto;
      case 8073:
        return NearbyStatus.beaconFilterSumExceedLimit;
      case 8074:
        return NearbyStatus.singleAppBeaconFilterExceedLimit;
      case 8075:
        return NearbyStatus.beaconTaskNotFound;
      case 8076:
        return NearbyStatus.beaconTaskRegistered;
      default:
        debugPrint('Unknown status code: $code');
        return NearbyStatus.unknown;
    }
  }
}

class DataTypes {
  static const int file = 1;
  static const int bytes = 2;
  static const int stream = 3;
}

class TransferStateUpdateStatus {
  static const int success = 1;
  static const int failure = 2;
  static const int inProgress = 3;
  static const int stateCancelled = 4;
}

class MessagePermissions {
  static const int ble = 1;
  static const int bluetooth = 2;
  static const int pDefault = 0;
  static const int microphone = 3;
  static const int none = -1;
}
