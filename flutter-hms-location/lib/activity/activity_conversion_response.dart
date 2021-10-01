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
import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'activity_conversion_data.dart';

class ActivityConversionResponse {
  /// All activity conversion events in the result.
  ///
  /// The obtained activity events are sorted by time in ascending order.
  List<ActivityConversionData?>? activityConversionDatas;

  ActivityConversionResponse({
    this.activityConversionDatas,
  });

  Map<String, dynamic> toMap() {
    return {
      'activityConversionDatas':
          activityConversionDatas?.map((x) => x?.toMap()).toList(),
    };
  }

  factory ActivityConversionResponse.fromMap(Map<dynamic, dynamic> map) {
    return ActivityConversionResponse(
      activityConversionDatas: map['activityConversionDatas'] == null
          ? null
          : List<ActivityConversionData>.from(map['activityConversionDatas']
              ?.map((x) => ActivityConversionData.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ActivityConversionResponse.fromJson(String source) =>
      ActivityConversionResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'ActivityConversionResponse(activityConversionDatas: $activityConversionDatas)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ActivityConversionResponse &&
        listEquals(o.activityConversionDatas, activityConversionDatas);
  }

  @override
  int get hashCode {
    return hashList([
      activityConversionDatas,
    ]);
  }
}
