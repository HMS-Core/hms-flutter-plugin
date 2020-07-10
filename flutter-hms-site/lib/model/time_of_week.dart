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

class TimeOfWeek {
  int week;
  String time;

  TimeOfWeek({
    this.week,
    this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'week': week,
      'time': time,
    };
  }

  factory TimeOfWeek.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TimeOfWeek(
      week: map["week"] == null ? null : map["week"],
      time: map["time"] == null ? null : map["time"],
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeOfWeek.fromJson(String source) =>
      TimeOfWeek.fromMap(json.decode(source));

  @override
  String toString() => 'TimeOfWeek(week: $week, time: $time)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TimeOfWeek && o.week == week && o.time == time;
  }

  @override
  int get hashCode => week.hashCode ^ time.hashCode;
}
