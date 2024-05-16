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

class HMSBeaconEngine {
  final MethodChannel _methodChannel;
  final EventChannel _eventChannel;

  HMSBeaconEngine._(this._methodChannel, this._eventChannel);

  static final HMSBeaconEngine _instance = HMSBeaconEngine._(
    const MethodChannel(_beaconMethodChannel),
    const EventChannel(_beaconEventChannel),
  );

  static HMSBeaconEngine get instance => _instance;

  /// Registers a beacon scanning task.
  Future<void> registerScanTask(BeaconPicker beaconPicker) async {
    await _methodChannel.invokeMethod('registerScanTask', beaconPicker.toMap());
  }

  /// Unregisters a beacon scanning task.
  Future<void> unRegisterScanTask() async {
    await _methodChannel.invokeMethod('unRegisterScanTask');
  }

  /// Obtains the list of filtering conditions for beacons.
  Future<List<RawBeaconCondition>> getRawBeaconConditions(
      {int? beaconType}) async {
    var response = await _methodChannel.invokeMethod(
      'getRawBeaconConditions',
      {'beaconType': beaconType},
    );
    return List<RawBeaconCondition>.from(
      response.map(
        (dynamic x) => RawBeaconCondition.fromMap(Map<String, dynamic>.from(x)),
      ),
    ).toList();
  }

  /// Obtains the list of filtering conditions for beacon message attachments.
  Future<List<BeaconMsgCondition>> getBeaconMsgConditions() async {
    var response = await _methodChannel.invokeMethod('getBeaconMsgConditions');
    return List<BeaconMsgCondition>.from(
      response.map(
        (dynamic x) => BeaconMsgCondition.fromMap(Map<String, dynamic>.from(x)),
      ),
    ).toList();
  }

  Stream<Beacon>? get getBeaconBroadcastStream => _eventChannel
      .receiveBroadcastStream()
      .map((event) => Beacon.fromJson(event));
}

enum RegionCode {
  CN,
  DE,
  RU,
  SG,
}
