/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'dart:convert';
import 'dart:ui';

class ActivityIdentificationData {
  static const int VEHICLE = 100;
  static const int BIKE = 101;
  static const int FOOT = 102;
  static const int STILL = 103;
  static const int OTHERS = 104;
  static const int TILTING = 105;
  static const int WALKING = 107;
  static const int RUNNING = 108;

  static const List<int> _validTypes = <int>[
    VEHICLE,
    BIKE,
    FOOT,
    STILL,
    OTHERS,
    TILTING,
    WALKING,
    RUNNING
  ];

  int identificationActivity;
  int possibility;

  ActivityIdentificationData({
    this.identificationActivity,
    this.possibility,
  });

  static bool isValidType(int type) {
    return _validTypes.contains(type) ? true : false;
  }

  Map<String, dynamic> toMap() {
    return {
      'identificationActivity': identificationActivity,
      'possibility': possibility,
    };
  }

  factory ActivityIdentificationData.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    return ActivityIdentificationData(
      identificationActivity: map['identificationActivity'],
      possibility: map['possibility'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ActivityIdentificationData.fromJson(String source) =>
      ActivityIdentificationData.fromMap(json.decode(source));

  @override
  String toString() =>
      'ActivityIdentificationData(identificationActivity: $identificationActivity, possibility: $possibility)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ActivityIdentificationData &&
        o.identificationActivity == identificationActivity &&
        o.possibility == possibility;
  }

  @override
  int get hashCode {
    return hashList([
      identificationActivity,
      possibility,
    ]);
  }
}
