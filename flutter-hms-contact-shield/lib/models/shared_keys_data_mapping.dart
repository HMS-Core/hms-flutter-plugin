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
import 'dart:core';

import 'package:flutter/foundation.dart';

import '../constants/contagiousness.dart';

class SharedKeysDataMapping {
  static const int _DAYS_SINCE_CREATION_TO_CONTAGIOUSNESS_MAX_SIZE = 29;
  static const int _MAX_DAYS_SINCE_CREATION = 14;

  List<int> _daysSinceCreationToContagiousness;
  int _defaultContagiousness = 0;
  int _defaultReportType = 0;

  SharedKeysDataMapping();

  Map<int, int> getDaysSinceCreationToContagiousness() {
    if (_daysSinceCreationToContagiousness == null ||
        _daysSinceCreationToContagiousness.length == 0) {
      return null;
    } else {
      Map<int, int> map = <int, int>{};
      for (int i = 0; i < _daysSinceCreationToContagiousness.length; i++) {
        map.putIfAbsent(i, () => _daysSinceCreationToContagiousness[i]);
      }
      return map;
    }
  }

  int getDefaultContagiousness() {
    return _defaultContagiousness;
  }

  int getDefaultReportType() {
    return _defaultReportType;
  }

  void setDaysSinceCreationToContagiousness(
      Map<int, int> daysSinceCreationToContagiousness) {
    if (!(daysSinceCreationToContagiousness != null)) {
      throw ArgumentError("daysSinceCreationToContagiousness must not be null");
    }
    if (!(daysSinceCreationToContagiousness.length <=
        _DAYS_SINCE_CREATION_TO_CONTAGIOUSNESS_MAX_SIZE)) {
      throw ArgumentError(
          "the size of daysSinceCreationToContagiousness is large than $_DAYS_SINCE_CREATION_TO_CONTAGIOUSNESS_MAX_SIZE");
    }

    List<int> result =
        List<int>.filled(_DAYS_SINCE_CREATION_TO_CONTAGIOUSNESS_MAX_SIZE, 0);

    daysSinceCreationToContagiousness.forEach((key, value) {
      if (!(key.abs() <= _MAX_DAYS_SINCE_CREATION)) {
        throw ArgumentError("Invalid day since creation $key");
      }
      if (!(value <= Contagiousness.HIGH && value >= Contagiousness.NONE)) {
        throw ArgumentError("Invalid value of contagiousness $key");
      }
      result[key + _MAX_DAYS_SINCE_CREATION] = value;
    });
    _daysSinceCreationToContagiousness = result;
  }

  void setDefaultReportType(int reportType) {
    if (!(reportType >= 0 && reportType <= 5)) {
      throw ArgumentError("reportType is $reportType, must >=0 and <=5");
    }
    _defaultReportType = reportType;
  }

  void setDefaultContagiousness(int defaultContagiousness) {
    if (!(defaultContagiousness >= Contagiousness.NONE &&
        defaultContagiousness <= Contagiousness.HIGH)) {
      throw ArgumentError("defaultContagiousness must be >=0 and <=2");
    }
    _defaultContagiousness = defaultContagiousness;
  }

  factory SharedKeysDataMapping.fromJson(String str) =>
      SharedKeysDataMapping.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SharedKeysDataMapping.fromMap(Map<String, dynamic> json) {
    if (json == null) return null;

    final SharedKeysDataMapping sharedKeysDataMapping = SharedKeysDataMapping();
    sharedKeysDataMapping._daysSinceCreationToContagiousness =
        json["daysSinceCreationToContagiousness"] == null
            ? null
            : List<int>.from(
                json["daysSinceCreationToContagiousness"].map((x) => x));
    sharedKeysDataMapping._defaultContagiousness =
        json["defaultContagiousness"] == null
            ? null
            : json["defaultContagiousness"];
    sharedKeysDataMapping._defaultReportType =
        json["defaultReportType"] == null ? null : json["defaultReportType"];

    return sharedKeysDataMapping;
  }

  Map<String, dynamic> toMap() => {
        "daysSinceCreationToContagiousness":
            _daysSinceCreationToContagiousness == null
                ? null
                : List<dynamic>.from(
                    _daysSinceCreationToContagiousness.map((x) => x)),
        "defaultContagiousness":
            _defaultContagiousness == null ? null : _defaultContagiousness,
        "defaultReportType":
            _defaultReportType == null ? null : _defaultReportType,
      };

  @override
  String toString() {
    return 'SharedKeysDataMapping'
        '('
        'daysSinceCreationToContagiousness: $_daysSinceCreationToContagiousness, '
        'defaultContagiousness: $_defaultContagiousness, '
        'defaultReportType: $_defaultReportType'
        ')';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SharedKeysDataMapping &&
        listEquals(o._daysSinceCreationToContagiousness,
            _daysSinceCreationToContagiousness) &&
        o._defaultContagiousness == _defaultContagiousness &&
        o._defaultReportType == _defaultReportType;
  }

  @override
  int get hashCode {
    return _daysSinceCreationToContagiousness.hashCode ^
        _defaultContagiousness.hashCode ^
        _defaultReportType.hashCode;
  }
}
