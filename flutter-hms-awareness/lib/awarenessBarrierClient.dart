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

import 'package:flutter/foundation.dart' show required;
import 'package:flutter/services.dart' show MethodChannel, EventChannel;
import 'package:huawei_awareness/hmsAwarenessLibrary.dart'
    show
        AwarenessBarrier,
        BarrierQueryRequest,
        BarrierQueryResponse,
        BarrierDeleteRequest,
        BarrierStatus;
import 'constants/channel.dart';
import 'constants/method.dart';
import 'constants/param.dart';

class AwarenessBarrierClient {
  static const MethodChannel _barrierChannel =
      const MethodChannel(Channel.AwarenessBarrierChannel);

  static const EventChannel _barrierListenerChannel =
      const EventChannel(Channel.AwarenessBarrierEventChannel);

  static Future<BarrierQueryResponse> queryBarriers(
      BarrierQueryRequest request) async {
    return BarrierQueryResponse.fromJson(await _barrierChannel.invokeMethod(
      Method.QueryBarriers,
      request.toMap(),
    ));
  }

  static Future<bool> deleteBarrier(BarrierDeleteRequest request) async {
    return await _barrierChannel.invokeMethod(
      Method.DeleteBarrier,
      request.toMap(),
    );
  }

  static Future<void> enableUpdateWindow(bool status) async {
    return _barrierChannel.invokeMethod(Method.EnableUpdateWindow, {
      Param.status: status,
    });
  }

  static Future<bool> updateBarriers(
      {@required AwarenessBarrier barrier, bool autoRemove}) async {
    return _barrierChannel.invokeMethod(Method.UpdateBarrier, {
      Param.request: barrier.toMap(),
      Param.autoRemove: autoRemove,
    });
  }

  static Stream<BarrierStatus> get onBarrierStatusStream =>
      _barrierListenerChannel
          .receiveBroadcastStream()
          .map((event) => BarrierStatus.fromJson(event));
}
