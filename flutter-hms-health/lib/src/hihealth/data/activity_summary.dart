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

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:huawei_health/huawei_health.dart';
import 'package:huawei_health/src/hihealth/data/pace_summary.dart';
import 'package:huawei_health/src/hihealth/util/util.dart';

class ActivitySummary {
  /// [PaceSummary] Instance.
  PaceSummary paceSummary;

  /// Statistical data points that consist from [SamplePoint]s.
  List<SamplePoint> dataSummary;

  ActivitySummary({this.paceSummary, @required this.dataSummary});

  Map<String, dynamic> toMap() {
    return {
      "paceSummary": paceSummary?.toMap(),
      "dataSummary": dataSummary != null
          ? List.from(dataSummary?.map((e) => e.toMap()))
          : null
    }..removeWhere((k, v) => v == null);
  }

  @override
  String toString() {
    return toMap().toString();
  }

  factory ActivitySummary.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return ActivitySummary(
        dataSummary: map['dataSummary'] != null
            ? List.from(map['dataSummary']
                .map((e) => SamplePoint.fromMap(Map<String, dynamic>.from(e))))
            : null,
        paceSummary: map['paceSummary'] != null
            ? PaceSummary.fromMap(Map<String, dynamic>.from(map['paceSummary']))
            : null);
  }

  @override
  bool operator ==(Object other) {
    if (!isTypeEqual(this, other)) return false;
    ActivitySummary compare = other;
    List<dynamic> currentArgs = [paceSummary, dataSummary];
    List<dynamic> otherArgs = [compare.paceSummary, compare.dataSummary];
    return isEquals(this, other, currentArgs, otherArgs);
  }

  @override
  int get hashCode => hashValues(paceSummary, hashList(dataSummary));
}
