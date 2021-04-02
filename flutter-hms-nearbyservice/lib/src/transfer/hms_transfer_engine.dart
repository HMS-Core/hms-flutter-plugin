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
import 'package:huawei_nearbyservice/src/transfer/classes.dart';
import 'package:huawei_nearbyservice/src/utils/channels.dart';

import 'callback/response.dart';

class HMSTransferEngine {
  static final int maxSizeData = 32768;

  final MethodChannel _methodChannel;
  final EventChannel _eventChannel;

  HMSTransferEngine._(this._methodChannel, this._eventChannel);

  /// Streams for DataCallback events
  Stream<dynamic> _dataBroadcastStream;
  Stream<DataOnReceivedResponse> _dataOnReceived;
  Stream<DataOnTransferUpdateResponse> _dataOnTransferUpdate;

  static final HMSTransferEngine _instance = HMSTransferEngine._(
      const MethodChannel(TRANSFER_METHOD_CHANNEL),
      const EventChannel(TRANSFER_EVENT_CHANNEL));

  static HMSTransferEngine get instance => _instance;

  Future<void> sendData(String endpointId, TransferData data,
      {bool isUri = false}) {
    return _methodChannel.invokeMethod("sendData", <String, dynamic>{
      'endpointId': endpointId,
      'data': data?.toMap(),
      'isUri': isUri
    });
  }

  Future<void> sendMultiEndpointData(
      List<String> endpointIds, TransferData data,
      {bool isUri = false}) {
    return _methodChannel.invokeMethod(
        "sendMultiEndpointData", <String, dynamic>{
      'endpointIds': endpointIds,
      'data': data?.toMap(),
      'isUri': isUri
    });
  }

  Future<void> cancelDataTransfer(int dataId) {
    return _methodChannel.invokeMethod("cancelDataTransfer", <String, dynamic>{
      'dataId': dataId,
    });
  }

  Stream<dynamic> get _getDataBroadcastStream {
    if (_dataBroadcastStream == null) {
      _dataBroadcastStream = _eventChannel.receiveBroadcastStream();
    }

    return _dataBroadcastStream;
  }

  Stream<DataOnReceivedResponse> get dataOnReceived {
    if (_dataOnReceived == null) {
      _dataOnReceived = _getDataBroadcastStream.map((eventMap) {
        if (eventMap['event'] == 'onReceived') {
          return DataOnReceivedResponse.fromMap(eventMap);
        } else {
          return null;
        }
      }).where((event) => event != null);
    }
    return _dataOnReceived;
  }

  Stream<DataOnTransferUpdateResponse> get dataOnTransferUpdate {
    if (_dataOnTransferUpdate == null) {
      _dataOnTransferUpdate = _getDataBroadcastStream.map((eventMap) {
        if (eventMap['event'] == 'onTransferUpdate') {
          return DataOnTransferUpdateResponse.fromMap(eventMap);
        } else {
          return null;
        }
      }).where((event) => event != null);
    }
    return _dataOnTransferUpdate;
  }
}
