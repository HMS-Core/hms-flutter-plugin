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

import 'package:flutter/foundation.dart';

import 'scan_info.dart';

class ContactWindow {
  int dateMillis;
  int reportType;
  List<ScanInfo> scanInfos;
  int contagiousness;
  int calibrationConfidence;

  ContactWindow({
    final int dateMillis,
    final reportType,
    final List<ScanInfo> scanInfos,
    final contagiousness,
    final calibrationConfidence,
  })  : dateMillis = 0,
        reportType = 0,
        scanInfos = scanInfos ?? <ScanInfo>[],
        contagiousness = 0,
        calibrationConfidence = 0;

  factory ContactWindow.fromJson(String str) =>
      ContactWindow.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContactWindow.fromMap(Map<String, dynamic> json) => ContactWindow(
        dateMillis: json["mDateMillis"] == null ? null : json["mDateMillis"],
        reportType: json["mReportType"] == null ? null : json["mReportType"],
        scanInfos: json["mScanInfos"] == null
            ? null
            : List<ScanInfo>.from(
                json["mScanInfos"].map((x) => ScanInfo.fromMap(x))),
        contagiousness:
            json["mContagiousness"] == null ? null : json["mContagiousness"],
        calibrationConfidence: json["mCalibrationConfidence"] == null
            ? null
            : json["mCalibrationConfidence"],
      );

  Map<String, dynamic> toMap() => {
        "mDateMillis": dateMillis == null ? null : dateMillis,
        "mReportType": reportType == null ? null : reportType,
        "mScanInfos": scanInfos == null
            ? null
            : List<dynamic>.from(scanInfos.map((x) => x.toMap())),
        "mContagiousness": contagiousness == null ? null : contagiousness,
        "mCalibrationConfidence":
            calibrationConfidence == null ? null : calibrationConfidence,
      };

  @override
  String toString() =>
      'ContactWindow(dateMillis: $dateMillis, reportType: $reportType, scanInfos: $scanInfos, contagiousness: $contagiousness, calibrationConfidence: $calibrationConfidence)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ContactWindow &&
        o.dateMillis == dateMillis &&
        o.reportType == reportType &&
        listEquals(o.scanInfos, scanInfos) &&
        o.contagiousness == contagiousness &&
        o.calibrationConfidence == calibrationConfidence;
  }

  @override
  int get hashCode =>
      dateMillis.hashCode ^
      reportType.hashCode ^
      scanInfos.hashCode ^
      contagiousness.hashCode ^
      calibrationConfidence.hashCode;
}
