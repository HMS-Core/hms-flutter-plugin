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

class BluetoothBarrier extends AwarenessBarrier {
  String barrierLabel;
  int? bluetoothStatus;
  int? deviceType;

  BluetoothBarrier.keeping({
    required this.barrierLabel,
    required this.bluetoothStatus,
    required this.deviceType,
  }) : super(
          barrierEventType: _Param.bluetoothBarrierReceiverAction,
          barrierType: _Param.bluetoothKeepBarrier,
          barrierLabel: barrierLabel,
        );

  BluetoothBarrier.connecting({
    required this.barrierLabel,
    required this.deviceType,
  }) : super(
          barrierEventType: _Param.bluetoothBarrierReceiverAction,
          barrierType: _Param.bluetoothConnectingBarrier,
          barrierLabel: barrierLabel,
        ) {
    bluetoothStatus = null;
  }

  BluetoothBarrier.disconnecting({
    required this.barrierLabel,
    required this.deviceType,
  }) : super(
          barrierEventType: _Param.bluetoothBarrierReceiverAction,
          barrierType: _Param.bluetoothDisconnectingBarrier,
          barrierLabel: barrierLabel,
        ) {
    bluetoothStatus = null;
  }

  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        _Param.barrierEventType: barrierEventType,
        _Param.barrierType: barrierType,
        _Param.barrierLabel: barrierLabel,
        _Param.bluetoothStatus: bluetoothStatus,
        _Param.deviceType: deviceType,
      };
}
