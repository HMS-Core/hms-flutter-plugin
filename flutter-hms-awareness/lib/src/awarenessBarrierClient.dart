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

part of huawei_awareness;

class AwarenessBarrierClient {
  static const MethodChannel _barrierChannel =
      MethodChannel(_Channel.awarenessBarrierChannel);

  static const EventChannel _barrierListenerChannel =
      EventChannel(_Channel.awarenessBarrierEventChannel);

  static Future<BarrierQueryResponse> queryBarriers(
    BarrierQueryRequest request,
  ) async {
    return BarrierQueryResponse.fromJson(await _barrierChannel.invokeMethod(
      _Method.queryBarriers,
      request.toMap(),
    ));
  }

  static Future<bool> deleteBarrier(
    BarrierDeleteRequest request,
  ) async {
    return await _barrierChannel.invokeMethod(
      _Method.deleteBarrier,
      request.toMap(),
    );
  }

  static Future<void> enableUpdateWindow(
    bool status,
  ) async {
    return _barrierChannel.invokeMethod(
      _Method.enableUpdateWindow,
      <String, dynamic>{
        _Param.status: status,
      },
    );
  }

  static Future<bool> updateBarriers({
    required AwarenessBarrier barrier,
    bool? autoRemove,
  }) async {
    return (await _barrierChannel.invokeMethod(
      _Method.updateBarrier,
      <String, dynamic>{
        _Param.request: barrier.toMap(),
        _Param.autoRemove: autoRemove,
      },
    ))!;
  }

  static Stream<BarrierStatus> get onBarrierStatusStream =>
      _barrierListenerChannel.receiveBroadcastStream().map(
            (dynamic event) => BarrierStatus.fromJson(event),
          );
}
