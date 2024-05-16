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

class BeaconData {
  String? beaconId;
  String? namespace;
  String? type;
  List<int>? content;

  BeaconData({
    this.beaconId,
    this.namespace,
    this.type,
    this.content,
  });

  factory BeaconData.fromJson(String str) =>
      BeaconData.fromMap(json.decode(str));

  factory BeaconData.fromMap(Map<String, dynamic> json) => BeaconData(
        beaconId: json[_Param.beaconId],
        namespace: json[_Param.beaconNamespace],
        type: json[_Param.beaconType],
        content: List<int>.from(
          json[_Param.beaconContent].map((dynamic x) => x),
        ),
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        _Param.beaconId: beaconId,
        _Param.beaconNamespace: namespace,
        _Param.beaconType: type,
        _Param.beaconContent: content == null
            ? null
            : List<dynamic>.from(
                content!.map((int x) => x),
              ),
      };
}
