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

import 'package:huawei_health/huawei_health.dart';
import 'package:huawei_health/src/hihealth/util/util.dart';

/// The sampling dataset class represents the container for storing sampling points.
///
/// The sampling points stored in a sampling dataset must be from the same data collector
/// (but their raw data collectors can be different). This class is usually used to
/// insert or read sampling data in batches.
class SampleSet {
  DataCollector dataCollector;
  List<SamplePoint> samplePoints;

  SampleSet(this.dataCollector, this.samplePoints);

  factory SampleSet.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return SampleSet(
        map['dataCollector'] != null
            ? DataCollector.fromMap(
                Map<String, dynamic>.from(map['dataCollector']))
            : null,
        map['samplePoints'] != null
            ? List.from(map['samplePoints']
                .map((e) => SamplePoint.fromMap(Map<String, dynamic>.from(e))))
            : null);
  }

  Map<String, dynamic> toMap() {
    return {
      "dataCollector": dataCollector?.toMap(),
      "samplePoints": List.from(samplePoints.map((e) => e.toMap()))
    }..removeWhere((k, v) => v == null);
  }

  @override
  String toString() {
    return toMap().toString();
  }

  DataType get getDataType => this.dataCollector.dataType;

  @override
  bool operator ==(Object other) {
    if (!isTypeEqual(this, other)) return false;
    SampleSet compare = other;
    List<dynamic> currentArgs = [dataCollector, samplePoints];
    List<dynamic> otherArgs = [compare.dataCollector, compare.samplePoints];
    return isEquals(this, other, currentArgs, otherArgs);
  }

  @override
  int get hashCode => hashValues(dataCollector, hashList(samplePoints));
}
