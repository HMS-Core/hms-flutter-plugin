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

import 'dart:convert';

class ScanInfo {
  int averageAttenuation;
  int minimumAttenuation;
  int secondsSinceLastScan;

  ScanInfo({
    int averageAttenuation,
    int minimumAttenuation,
    int secondsSinceLastScan,
  })  : averageAttenuation = averageAttenuation ?? 0,
        minimumAttenuation = minimumAttenuation ?? 0,
        secondsSinceLastScan = secondsSinceLastScan ?? 0;

  factory ScanInfo.fromJson(String str) => ScanInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ScanInfo.fromMap(Map<String, dynamic> json) => ScanInfo(
        averageAttenuation: json["mAverageAttenuation"] == null
            ? null
            : json["mAverageAttenuation"],
        minimumAttenuation: json["mMinimumAttenuation"] == null
            ? null
            : json["mMinimumAttenuation"],
        secondsSinceLastScan: json["mSecondsSinceLastScan"] == null
            ? null
            : json["mSecondsSinceLastScan"],
      );

  Map<String, dynamic> toMap() => {
        "mAverageAttenuation":
            averageAttenuation == null ? null : averageAttenuation,
        "mMinimumAttenuation":
            minimumAttenuation == null ? null : minimumAttenuation,
        "mSecondsSinceLastScan":
            secondsSinceLastScan == null ? null : secondsSinceLastScan,
      };

  @override
  String toString() =>
      'ScanInfo(averageAttenuation: $averageAttenuation, minimumAttenuation: $minimumAttenuation, secondsSinceLastScan: $secondsSinceLastScan)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ScanInfo &&
        o.averageAttenuation == averageAttenuation &&
        o.minimumAttenuation == minimumAttenuation &&
        o.secondsSinceLastScan == secondsSinceLastScan;
  }

  @override
  int get hashCode =>
      averageAttenuation.hashCode ^
      minimumAttenuation.hashCode ^
      secondsSinceLastScan.hashCode;
}
