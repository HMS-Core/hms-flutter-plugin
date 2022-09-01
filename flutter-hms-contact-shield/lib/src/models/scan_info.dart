/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_contactshield;

class ScanInfo {
  int averageAttenuation;
  int minimumAttenuation;
  int secondsSinceLastScan;

  ScanInfo({
    this.averageAttenuation = 0,
    this.minimumAttenuation = 0,
    this.secondsSinceLastScan = 0,
  });

  factory ScanInfo.fromJson(String str) {
    return ScanInfo.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory ScanInfo.fromMap(Map<String, dynamic> json) {
    return ScanInfo(
      averageAttenuation: json['mAverageAttenuation'],
      minimumAttenuation: json['mMinimumAttenuation'],
      secondsSinceLastScan: json['mSecondsSinceLastScan'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mAverageAttenuation': averageAttenuation,
      'mMinimumAttenuation': minimumAttenuation,
      'mSecondsSinceLastScan': secondsSinceLastScan,
    };
  }

  @override
  String toString() {
    return '$ScanInfo('
        'averageAttenuation: $averageAttenuation, '
        'minimumAttenuation: $minimumAttenuation, '
        'secondsSinceLastScan: $secondsSinceLastScan)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is ScanInfo &&
        other.averageAttenuation == averageAttenuation &&
        other.minimumAttenuation == minimumAttenuation &&
        other.secondsSinceLastScan == secondsSinceLastScan;
  }

  @override
  int get hashCode {
    return averageAttenuation.hashCode ^
        minimumAttenuation.hashCode ^
        secondsSinceLastScan.hashCode;
  }
}
