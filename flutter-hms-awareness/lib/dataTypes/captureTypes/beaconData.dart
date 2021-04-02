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

import 'dart:convert' show json;
import 'package:huawei_awareness/constants/param.dart';

class BeaconData {
  String beaconId;
  String namespace;
  String type;
  List<int> content;

  BeaconData({
    this.beaconId,
    this.namespace,
    this.type,
    this.content,
  });

  factory BeaconData.fromJson(String str) =>
      BeaconData.fromMap(json.decode(str));

  factory BeaconData.fromMap(Map<String, dynamic> json) => BeaconData(
        beaconId: json[Param.beaconId] == null ? null : json[Param.beaconId],
        namespace: json[Param.beaconNamespace] == null
            ? null
            : json[Param.beaconNamespace],
        type: json[Param.beaconType] == null ? null : json[Param.beaconType],
        content: json[Param.beaconContent] == null
            ? null
            : List<int>.from(json[Param.beaconContent].map((x) => x)),
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        Param.beaconId: beaconId == null ? null : beaconId,
        Param.beaconNamespace: namespace == null ? null : namespace,
        Param.beaconType: type == null ? null : type,
        Param.beaconContent:
            content == null ? null : List<dynamic>.from(content.map((x) => x)),
      };
}
