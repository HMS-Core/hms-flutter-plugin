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

import 'dart:convert';
import 'dart:ui';

class ActivityConversionData {
  /// Activity type of the conversion.
  ///
  /// The value is one of the activity types defined in
  /// [ActivityIdentificationData].
  int? activityType;

  /// Activity conversion information.
  ///
  /// The options are [ActivityConversionInfo.ENTER_ACTIVITY_CONVERSION] and
  /// [ActivityConversionInfo.EXIT_ACTIVITY_CONVERSION].
  int? conversionType;

  /// Time elapsed since system boot, in milliseconds.
  int? elapsedTimeFromReboot;

  ActivityConversionData({
    this.activityType,
    this.conversionType,
    this.elapsedTimeFromReboot,
  });

  Map<String, dynamic> toMap() {
    return {
      'activityType': activityType,
      'conversionType': conversionType,
      'elapsedTimeFromReboot': elapsedTimeFromReboot,
    };
  }

  factory ActivityConversionData.fromMap(Map<dynamic, dynamic> map) {
    return ActivityConversionData(
      activityType: map['activityType'],
      conversionType: map['conversionType'],
      elapsedTimeFromReboot: map['elapsedTimeFromReboot'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ActivityConversionData.fromJson(String source) =>
      ActivityConversionData.fromMap(json.decode(source));

  @override
  String toString() =>
      'ActivityConversionData(activityType: $activityType, conversionType: $conversionType, elapsedTimeFromReboot: $elapsedTimeFromReboot)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ActivityConversionData &&
        o.activityType == activityType &&
        o.conversionType == conversionType &&
        o.elapsedTimeFromReboot == elapsedTimeFromReboot;
  }

  @override
  int get hashCode {
    return hashList([
      activityType,
      conversionType,
      elapsedTimeFromReboot,
    ]);
  }
}
