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

class HMSDiscoveryEngine {
  final MethodChannel _channel;
  final EventChannel _channelConnect;
  final EventChannel _channelScan;

  /// Streams for ConnectCallback events
  Stream<dynamic>? _connectBroadcastStream;
  Stream<ConnectOnEstablishResponse>? _connectOnEstablish;
  Stream<ConnectOnResultResponse>? _connectOnResult;
  Stream<String>? _connectOnDisconnected;

  /// Streams for ScanEndpointCallback events
  Stream<dynamic>? _scanBroadcastStream;
  Stream<ScanOnFoundResponse>? _scanOnFound;
  Stream<String>? _scanOnLost;

  HMSDiscoveryEngine._(
    this._channel,
    this._channelConnect,
    this._channelScan,
  );

  static final HMSDiscoveryEngine _instance = HMSDiscoveryEngine._(
    const MethodChannel(_discoveryMethodChannel),
    const EventChannel(_discoveryConnectEventChannel),
    const EventChannel(_discoveryScanEventChannel),
  );

  static HMSDiscoveryEngine get instance => _instance;

  Future<void> acceptConnect(String endpointId) {
    return _channel.invokeMethod(
      'acceptConnect',
      <String, dynamic>{
        'endpointId': endpointId,
      },
    );
  }

  Future<void> disconnect(String endpointId) {
    return _channel.invokeMethod(
      'disconnect',
      <String, dynamic>{
        'endpointId': endpointId,
      },
    );
  }

  Future<void> rejectConnect(String endpointId) {
    return _channel.invokeMethod(
      'rejectConnect',
      <String, dynamic>{
        'endpointId': endpointId,
      },
    );
  }

  Future<void> requestConnectEx({
    required String name,
    required String endpointId,
    required ConnectOption channelPolicy,
  }) {
    return _channel.invokeMethod(
      'requestConnectEx',
      <String, dynamic>{
        'name': name,
        'endpointId': endpointId,
        'ConnectOption': channelPolicy.toMap()
      },
    );
  }

  Future<void> startBroadcasting({
    required String name,
    required String serviceId,
    required BroadcastOption broadcastOption,
  }) {
    return _channel.invokeMethod(
      'startBroadcasting',
      <String, dynamic>{
        'name': name,
        'serviceId': serviceId,
        'broadcastOption': broadcastOption.toMap(),
      },
    );
  }

  Future<void> startScan({
    required String serviceId,
    required ScanOption scanOption,
  }) {
    return _channel.invokeMethod(
      'startScan',
      <String, dynamic>{
        'serviceId': serviceId,
        'scanOption': scanOption.toMap(),
      },
    );
  }

  Future<void> stopBroadcasting() {
    return _channel.invokeMethod(
      'stopBroadcasting',
    );
  }

  Future<void> disconnectAll() {
    return _channel.invokeMethod(
      'disconnectAll',
    );
  }

  Future<void> stopScan() {
    return _channel.invokeMethod(
      'stopScan',
    );
  }

  Stream<dynamic>? get _getConnectBroadcastStream {
    _connectBroadcastStream ??= _channelConnect.receiveBroadcastStream();
    return _connectBroadcastStream;
  }

  Stream<ConnectOnEstablishResponse>? get connectOnEstablish {
    _connectOnEstablish ??= _getConnectBroadcastStream!
        .where((eventMap) => eventMap['event'] == 'onEstablish')
        .map((dynamic eventMap) {
      return ConnectOnEstablishResponse.fromMap(eventMap);
    });
    return _connectOnEstablish;
  }

  Stream<ConnectOnResultResponse>? get connectOnResult {
    _connectOnResult ??= _getConnectBroadcastStream!
        .where((eventMap) => eventMap['event'] == 'onResult')
        .map((dynamic eventMap) {
      return ConnectOnResultResponse.fromMap(eventMap);
    });
    return _connectOnResult;
  }

  Stream<String>? get connectOnDisconnected {
    _connectOnDisconnected ??= _getConnectBroadcastStream!
        .where((eventMap) => eventMap['event'] == 'onDisconnected')
        .map((dynamic eventMap) {
      return eventMap['endpointId'].toString();
    });
    return _connectOnDisconnected;
  }

  Stream<dynamic>? get _getScanBroadcastStream {
    _scanBroadcastStream ??= _channelScan.receiveBroadcastStream();
    return _scanBroadcastStream;
  }

  Stream<ScanOnFoundResponse>? get scanOnFound {
    _scanOnFound ??= _getScanBroadcastStream!
        .where((eventMap) => eventMap['event'] == 'onFound')
        .map((dynamic eventMap) {
      return ScanOnFoundResponse.fromMap(eventMap);
    });
    return _scanOnFound;
  }

  Stream<String>? get scanOnLost {
    _scanOnLost ??= _getScanBroadcastStream!
        .where((eventMap) => eventMap['event'] == 'onLost')
        .map((dynamic eventMap) {
      return eventMap['endpointId'].toString();
    });
    return _scanOnLost;
  }
}
