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

class BeaconResponse {
  List<BeaconData>? beacons;

  BeaconResponse({
    this.beacons,
  });

  factory BeaconResponse.fromJson(String str) =>
      BeaconResponse.fromMap(json.decode(str));

  factory BeaconResponse.fromMap(Map<String, dynamic> jsonMap) =>
      BeaconResponse(
        beacons: List<BeaconData>.from(
          jsonMap[_Param.beacons].map(
            (dynamic x) => BeaconData.fromMap(x),
          ),
        ),
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        _Param.beacons: beacons == null
            ? null
            : List<dynamic>.from(
                beacons!.map(
                  (BeaconData x) => x.toMap(),
                ),
              ),
      };
}
