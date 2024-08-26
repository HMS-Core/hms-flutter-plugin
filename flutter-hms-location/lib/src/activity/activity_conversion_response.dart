/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

part of '../../huawei_location.dart';

class ActivityConversionResponse {
  /// All activity conversion events in the result.
  ///
  /// The obtained activity events are sorted by time in ascending order.
  List<ActivityConversionData?>? activityConversionDatas;

  ActivityConversionResponse({
    this.activityConversionDatas,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'activityConversionDatas': activityConversionDatas
          ?.map((ActivityConversionData? x) => x?.toMap())
          .toList(),
    };
  }

  factory ActivityConversionResponse.fromMap(Map<dynamic, dynamic> map) {
    return ActivityConversionResponse(
      activityConversionDatas: map['activityConversionDatas'] == null
          ? null
          : List<ActivityConversionData>.from(
              map['activityConversionDatas']?.map(
                (dynamic x) => ActivityConversionData.fromMap(x),
              ),
            ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ActivityConversionResponse.fromJson(String source) =>
      ActivityConversionResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ActivityConversionResponse('
        'activityConversionDatas: $activityConversionDatas)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is ActivityConversionResponse &&
        listEquals(other.activityConversionDatas, activityConversionDatas);
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
        activityConversionDatas,
      ],
    );
  }
}
