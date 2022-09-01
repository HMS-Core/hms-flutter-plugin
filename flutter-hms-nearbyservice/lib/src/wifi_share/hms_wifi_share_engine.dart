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

part of huawei_nearbyservice;

class HMSWifiShareEngine {
  final MethodChannel _methodChannel;
  final EventChannel _eventChannel;

  HMSWifiShareEngine._(
    this._methodChannel,
    this._eventChannel,
  );

  /// Streams for DataCallback events
  Stream<dynamic>? _wifiBroadcastStream;
  Stream<WifiOnFoundResponse>? _wifiOnFound;
  Stream<String>? _wifiOnLost;
  Stream<WifiOnFetchAuthCodeResponse>? _wifiOnFetchAuthCode;
  Stream<WifiShareResultResponse>? _wifiOnShareResult;

  static final HMSWifiShareEngine _instance = HMSWifiShareEngine._(
    const MethodChannel(_wifiMethodChannel),
    const EventChannel(_wifiEventChannel),
  );

  static HMSWifiShareEngine get instance => _instance;

  Future<void> startWifiShare(WifiSharePolicy policy) {
    return _methodChannel.invokeMethod(
      'startWifiShare',
      <String, dynamic>{
        'policy': policy.toMap(),
      },
    );
  }

  Future<void> stopWifiShare() {
    return _methodChannel.invokeMethod(
      'stopWifiShare',
    );
  }

  Future<void> shareWifiConfig(String endpointId) {
    return _methodChannel.invokeMethod(
      'shareWifiConfig',
      <String, dynamic>{
        'endpointId': endpointId,
      },
    );
  }

  Stream<dynamic>? get _getWifiBroadcastStream {
    _wifiBroadcastStream ??= _eventChannel.receiveBroadcastStream();
    return _wifiBroadcastStream;
  }

  Stream<WifiOnFoundResponse>? get wifiOnFound {
    _wifiOnFound ??= _getWifiBroadcastStream!
        .where((eventMap) => eventMap['event'] == 'onFound')
        .map((dynamic eventMap) {
      return WifiOnFoundResponse.fromMap(eventMap);
    });
    return _wifiOnFound;
  }

  Stream<String>? get wifiOnLost {
    _wifiOnLost ??= _getWifiBroadcastStream!
        .where((eventMap) => eventMap['event'] == 'onLost')
        .map((dynamic eventMap) {
      return eventMap['endpointId'].toString();
    });
    return _wifiOnLost;
  }

  Stream<WifiOnFetchAuthCodeResponse>? get wifiOnFetchAuthCode {
    _wifiOnFetchAuthCode ??= _getWifiBroadcastStream!
        .where((eventMap) => eventMap['event'] == 'onFetchAuthCode')
        .map((dynamic eventMap) {
      return WifiOnFetchAuthCodeResponse.fromMap(eventMap);
    });
    return _wifiOnFetchAuthCode;
  }

  Stream<WifiShareResultResponse>? get wifiOnShareResult {
    _wifiOnShareResult ??= _getWifiBroadcastStream!
        .where((eventMap) => eventMap['event'] == 'onWifiShareResult')
        .map((dynamic eventMap) {
      return WifiShareResultResponse.fromMap(eventMap);
    });
    return _wifiOnShareResult;
  }
}
