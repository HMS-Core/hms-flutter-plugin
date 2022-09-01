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

class ContactWindow {
  int dateMillis;
  int reportType;
  List<ScanInfo> scanInfos;
  int contagiousness;
  int calibrationConfidence;

  ContactWindow({
    this.dateMillis = 0,
    this.reportType = 0,
    List<ScanInfo>? scanInfos,
    this.contagiousness = 0,
    this.calibrationConfidence = 0,
  }) : scanInfos = scanInfos ?? <ScanInfo>[];

  factory ContactWindow.fromJson(String str) {
    return ContactWindow.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory ContactWindow.fromMap(Map<String, dynamic> json) {
    return ContactWindow(
      dateMillis: json['mDateMillis'],
      reportType: json['mReportType'],
      scanInfos: json['mScanInfos'] == null
          ? null
          : List<ScanInfo>.from(
              json['mScanInfos'].map((dynamic x) => ScanInfo.fromMap(x)),
            ),
      contagiousness: json['mContagiousness'],
      calibrationConfidence: json['mCalibrationConfidence'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mDateMillis': dateMillis,
      'mReportType': reportType,
      'mScanInfos': scanInfos.map((ScanInfo x) => x.toMap()).toList(),
      'mContagiousness': contagiousness,
      'mCalibrationConfidence': calibrationConfidence,
    };
  }

  @override
  String toString() {
    return '$ContactWindow('
        'dateMillis: $dateMillis, '
        'reportType: $reportType, '
        'scanInfos: $scanInfos, '
        'contagiousness: $contagiousness, '
        'calibrationConfidence: $calibrationConfidence)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is ContactWindow &&
        other.dateMillis == dateMillis &&
        other.reportType == reportType &&
        listEquals(other.scanInfos, scanInfos) &&
        other.contagiousness == contagiousness &&
        other.calibrationConfidence == calibrationConfidence;
  }

  @override
  int get hashCode {
    return dateMillis.hashCode ^
        reportType.hashCode ^
        scanInfos.hashCode ^
        contagiousness.hashCode ^
        calibrationConfidence.hashCode;
  }
}
