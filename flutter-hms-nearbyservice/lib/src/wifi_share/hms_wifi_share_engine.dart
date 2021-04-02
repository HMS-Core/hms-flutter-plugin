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

import 'package:flutter/services.dart';
import 'package:huawei_nearbyservice/src/utils/channels.dart';
import 'package:huawei_nearbyservice/src/wifi_share/callback/response.dart';
import 'package:huawei_nearbyservice/src/wifi_share/wifi_share_policy.dart';

class HMSWifiShareEngine {
  final MethodChannel _methodChannel;
  final EventChannel _eventChannel;

  HMSWifiShareEngine._(this._methodChannel, this._eventChannel);

  /// Streams for DataCallback events
  Stream<dynamic> _wifiBroadcastStream;
  Stream<WifiOnFoundResponse> _wifiOnFound;
  Stream<String> _wifiOnLost;
  Stream<WifiOnFetchAuthCodeResponse> _wifiOnFetchAuthCode;
  Stream<WifiShareResultResponse> _wifiOnShareResult;

  static final HMSWifiShareEngine _instance = HMSWifiShareEngine._(
      const MethodChannel(WIFI_METHOD_CHANNEL),
      const EventChannel(WIFI_EVENT_CHANNEL));

  static HMSWifiShareEngine get instance => _instance;

  Future<void> startWifiShare(WifiSharePolicy policy) {
    return _methodChannel.invokeMethod("startWifiShare", <String, dynamic>{
      'policy': policy?.toMap(),
    });
  }

  Future<void> stopWifiShare() {
    return _methodChannel.invokeMethod("stopWifiShare");
  }

  Future<void> shareWifiConfig(String endpointId) {
    return _methodChannel.invokeMethod("shareWifiConfig", <String, dynamic>{
      "endpointId": endpointId,
    });
  }

  Stream<dynamic> get _getWifiBroadcastStream {
    if (_wifiBroadcastStream == null) {
      _wifiBroadcastStream = _eventChannel.receiveBroadcastStream();
    }

    return _wifiBroadcastStream;
  }

  Stream<WifiOnFoundResponse> get wifiOnFound {
    if (_wifiOnFound == null) {
      _wifiOnFound = _getWifiBroadcastStream.map((eventMap) {
        if (eventMap['event'] == 'onFound') {
          return WifiOnFoundResponse.fromMap(eventMap);
        } else {
          return null;
        }
      }).where((event) => event != null);
    }
    return _wifiOnFound;
  }

  Stream<String> get wifiOnLost {
    if (_wifiOnLost == null) {
      _wifiOnLost = _getWifiBroadcastStream.map((eventMap) {
        if (eventMap['event'] == 'onLost') {
          return eventMap['endpointId'].toString();
        } else {
          return null;
        }
      }).where((event) => event != null);
    }
    return _wifiOnLost;
  }

  Stream<WifiOnFetchAuthCodeResponse> get wifiOnFetchAuthCode {
    if (_wifiOnFetchAuthCode == null) {
      _wifiOnFetchAuthCode = _getWifiBroadcastStream.map((eventMap) {
        if (eventMap['event'] == 'onFetchAuthCode') {
          return WifiOnFetchAuthCodeResponse.fromMap(eventMap);
        } else {
          return null;
        }
      }).where((event) => event != null);
    }
    return _wifiOnFetchAuthCode;
  }

  Stream<WifiShareResultResponse> get wifiOnShareResult {
    if (_wifiOnShareResult == null) {
      _wifiOnShareResult = _getWifiBroadcastStream.map((eventMap) {
        if (eventMap['event'] == 'onWifiShareResult') {
          return WifiShareResultResponse.fromMap(eventMap);
        } else {
          return null;
        }
      }).where((event) => event != null);
    }
    return _wifiOnShareResult;
  }
}
