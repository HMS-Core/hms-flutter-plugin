/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:flutter/foundation.dart';

@immutable
class StatusCode {
  static const int STATUS_SUCCESS = 0;
  static const int STATUS_FAILURE = -1;
  static const int STATUS_APP_QUOTA_LIMITED = 8100;
  static const int STATUS_DISK_FULL = 8101;
  static const int STATUS_BLUETOOTH_OPERATION_ERROR = 8102;
  static const int STATUS_MISSING_PERMISSION_LOCATION = 8103;
  static const int STATUS_SIGNATURE_VERIFY_FAILED = 8104;
  static const int STATUS_UNAUTHORIZED = 8105;
  static const int STATUS_API_DISORDER = 8001;
  static const int STATUS_MISSING_PERMISSION_BLUETOOTH = 8016;
  static const int STATUS_MISSING_SETTING_LOCATION_ON = 8020;
  static const int STATUS_INTERNAL_ERROR = 8060;
  static const int STATUS_MISSING_PERMISSION_INTERNET = 8064;

  static String getStatusCode(int statusCode) {
    switch (statusCode) {
      case 0:
        return 'STATUS_SUCCESS';
      case -1:
        return 'STATUS_FAILURE';
      case 8100:
        return 'STATUS_APP_QUOTA_LIMITED';
      case 8101:
        return 'STATUS_DISK_FULL';
      case 8102:
        return 'STATUS_BLUETOOTH_OPERATION_ERROR';
      case 8103:
        return 'STATUS_MISSING_PERMISSION_LOCATION';
      case 8104:
        return 'STATUS_SIGNATURE_VERIFY_FAILED';
      case 8105:
        return 'STATUS_UNAUTHORIZED';
      case 8001:
        return 'STATUS_API_DISORDER';
      case 8016:
        return 'STATUS_MISSING_PERMISSION_BLUETOOTH';
      case 8020:
        return 'STATUS_MISSING_SETTING_LOCATION_ON';
      case 8060:
        return 'STATUS_INTERNAL_ERROR';
      case 8064:
        return 'STATUS_MISSING_PERMISSION_INTERNET';
      default:
        return 'Unknown Status Code: $statusCode';
    }
  }
}
