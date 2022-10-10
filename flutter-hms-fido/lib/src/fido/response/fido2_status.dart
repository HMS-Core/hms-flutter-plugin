/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_fido;

class Fido2Status {
  /// Success.
  static const int OK = 0;

  /// Not supported by the system.
  /// Verify that relevant registration or authentication parameters are
  /// correct.
  static const int NOT_SUPPORTED_ERR = 9;

  /// Invalid status.
  /// Check the status of the roaming authenticator and use it correctly.
  static const int INVALID_STATE_ERR = 11;

  /// The device failed the system integrity check.
  /// The possible cause is that the device is unlocked or rooted.
  /// Use a device meeting the security requirements.
  static const int SECURITY_ERR = 18;

  /// The operation is canceled by the user.
  static const int ABORT_ERR = 20;

  /// The request timed out.
  static const int TIMEOUT_ERR = 23;

  /// Encoding error.
  /// Verify that relevant registration or authentication parameters are
  /// correct.
  static const int ENCODING_ERR = 27;

  /// Unknown error. Contact Huawei technical support.
  static const int UNKNOWN_ERR = 28;

  /// Constraint error.
  /// Verify that relevant registration or authentication parameters are
  /// correct.
  static const int CONSTRAINT_ERR = 29;

  /// Data error.
  /// Verify that relevant registration or authentication parameters are
  /// correct.
  static const int DATA_ERR = 30;

  /// The operation is rejected by the user.
  static const int NOT_ALLOWED_ERR = 35;

  /// An HMS Core framework error occurred.
  /// Update the HMS Core (APK) to the latest version and clear app data.
  static const int HMS_FRAMEWORK_ERR = 1003;
}
