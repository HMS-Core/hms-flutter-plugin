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

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:huawei_nearbyservice/src/discovery/callback/response.dart';
import 'package:huawei_nearbyservice/src/discovery/classes.dart';
import 'package:huawei_nearbyservice/src/utils/channels.dart';

class HMSDiscoveryEngine {
  final MethodChannel _channel;
  final EventChannel _channelConnect;
  final EventChannel _channelScan;

  /// Streams for ConnectCallback events
  Stream<dynamic> _connectBroadcastStream;
  Stream<ConnectOnEstablishResponse> _connectOnEstablish;
  Stream<ConnectOnResultResponse> _connectOnResult;
  Stream<String> _connectOnDisconnected;

  /// Streams for ScanEndpointCallback events
  Stream<dynamic> _scanBroadcastStream;
  Stream<ScanOnFoundResponse> _scanOnFound;
  Stream<String> _scanOnLost;

  HMSDiscoveryEngine._(this._channel, this._channelConnect, this._channelScan);

  static final HMSDiscoveryEngine _instance = HMSDiscoveryEngine._(
      const MethodChannel(DISCOVERY_METHOD_CHANNEL),
      const EventChannel(DISCOVERY_EVENT_CHANNEL_CONNECT),
      const EventChannel(DISCOVERY_EVENT_CHANNEL_SCAN));

  static HMSDiscoveryEngine get instance => _instance;

  Future<void> acceptConnect(String endpointId) {
    return _channel.invokeMethod(
        'acceptConnect', <String, dynamic>{'endpointId': endpointId});
  }

  Future<void> disconnect(String endpointId) {
    return _channel.invokeMethod('disconnect', <String, dynamic>{
      'endpointId': endpointId,
    });
  }

  Future<void> rejectConnect(String endpointId) {
    return _channel.invokeMethod('rejectConnect', <String, dynamic>{
      'endpointId': endpointId,
    });
  }

  Future<void> requestConnect({String name, String endpointId}) {
    return _channel.invokeMethod('requestConnect', <String, dynamic>{
      'name': name,
      'endpointId': endpointId,
    });
  }

  Future<void> startBroadcasting(
      {String name, String serviceId, BroadcastOption broadcastOption}) {
    return _channel.invokeMethod('startBroadcasting', <String, dynamic>{
      'name': name,
      'serviceId': serviceId,
      'broadcastOption': broadcastOption?.toMap()
    });
  }

  Future<void> startScan({String serviceId, ScanOption scanOption}) {
    return _channel.invokeMethod('startScan', <String, dynamic>{
      'serviceId': serviceId,
      'scanOption': scanOption?.toMap(),
    });
  }

  Future<void> stopBroadcasting() {
    return _channel.invokeMethod('stopBroadcasting');
  }

  Future<void> disconnectAll() {
    return _channel.invokeMethod('disconnectAll');
  }

  Future<void> stopScan() {
    return _channel.invokeMethod('stopScan');
  }

  Stream<dynamic> get _getConnectBroadcastStream {
    if (_connectBroadcastStream == null) {
      _connectBroadcastStream = _channelConnect.receiveBroadcastStream();
    }

    return _connectBroadcastStream;
  }

  Stream<ConnectOnEstablishResponse> get connectOnEstablish {
    if (_connectOnEstablish == null) {
      _connectOnEstablish = _getConnectBroadcastStream.map((eventMap) {
        if (eventMap['event'] == 'onEstablish') {
          return ConnectOnEstablishResponse.fromMap(eventMap);
        } else {
          return null;
        }
      }).where((event) => event != null);
    }
    return _connectOnEstablish;
  }

  Stream<ConnectOnResultResponse> get connectOnResult {
    if (_connectOnResult == null) {
      _connectOnResult = _getConnectBroadcastStream.map((eventMap) {
        if (eventMap['event'] == 'onResult') {
          return ConnectOnResultResponse.fromMap(eventMap);
        } else {
          return null;
        }
      }).where((event) => event != null);
    }
    return _connectOnResult;
  }

  Stream<String> get connectOnDisconnected {
    if (_connectOnDisconnected == null) {
      _connectOnDisconnected = _getConnectBroadcastStream.map((eventMap) {
        if (eventMap['event'] == 'onDisconnected') {
          return eventMap['endpointId'].toString();
        } else {
          return null;
        }
      }).where((event) => event != null);
    }
    return _connectOnDisconnected;
  }

  Stream<dynamic> get _getScanBroadcastStream {
    if (_scanBroadcastStream == null) {
      _scanBroadcastStream = _channelScan.receiveBroadcastStream();
    }

    return _scanBroadcastStream;
  }

  Stream<ScanOnFoundResponse> get scanOnFound {
    if (_scanOnFound == null) {
      _scanOnFound = _getScanBroadcastStream.map((eventMap) {
        if (eventMap['event'] == 'onFound') {
          return ScanOnFoundResponse.fromMap(eventMap);
        } else {
          return null;
        }
      }).where((event) => event != null);
    }
    return _scanOnFound;
  }

  Stream<String> get scanOnLost {
    if (_scanOnLost == null) {
      _scanOnLost = _getScanBroadcastStream.map((eventMap) {
        if (eventMap['event'] == 'onLost') {
          return eventMap['endpointId'].toString();
        } else {
          return null;
        }
      }).where((event) => event != null);
    }
    return _scanOnLost;
  }
}
