/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_safetydetect;

/// The entity class of the WifiDetect API.
class WifiDetectResponse {
  final int _wifiDetectStatus;

  WifiDetectResponse._(this._wifiDetectStatus);

  factory WifiDetectResponse.fromInt(int status) {
    return WifiDetectResponse._(status);
  }

  /// Obtains the security check result of a Wi-Fi network.
  /// This helps your app protect the payment and privacy security of your users,
  /// preventing economic loss and privacy breach.
  int get getWifiDetectStatus => _wifiDetectStatus;

  /// Obtains the WifiDetectType of the wifiDetectStatus.
  WifiDetectType get getWifiDetectType {
    try {
      return WifiDetectType.values[_wifiDetectStatus];
    } catch (_) {
      throw ('Unsupported wifi detect status');
    }
  }
}

/// Security status type of the current Wi-Fi.
enum WifiDetectType {
  /// No Wi-Fi is connected.
  no_wifi,

  /// The Wi-Fi is secure.
  secure_wifi,

  /// The Wi-Fi is insecure.
  insecure_wifi,
}
