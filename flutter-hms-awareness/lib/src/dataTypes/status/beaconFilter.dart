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

class BeaconFilter {
  String? beaconNamespace;
  String? beaconType;
  Uint8List? beaconContent;
  String? beaconId;
  String? _filterType;

  BeaconFilter.matchByNameType({
    required this.beaconNamespace,
    required this.beaconType,
  }) {
    _filterType = _Param.matchByNameType;
  }
  BeaconFilter.matchByBeaconContent({
    required this.beaconNamespace,
    required this.beaconType,
    required this.beaconContent,
  }) {
    _filterType = _Param.matchByBeaconContent;
  }
  BeaconFilter.matchByBeaconId({
    required this.beaconId,
  }) {
    _filterType = _Param.matchByBeaconId;
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        _Param.filterType: _filterType,
        _Param.beaconNamespace: beaconNamespace,
        _Param.beaconType: beaconType,
        _Param.beaconContent: beaconContent,
        _Param.beaconId: beaconId,
      };
}
