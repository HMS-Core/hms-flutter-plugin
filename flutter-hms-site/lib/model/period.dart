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

import 'time_of_week.dart';

class Period {
  TimeOfWeek open;
  TimeOfWeek close;

  Period({
    this.open,
    this.close,
  });

  Map<String, dynamic> toMap() {
    return {
      'open': open?.toMap(),
      'close': close?.toMap(),
    };
  }

  factory Period.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Period(
      open: map["open"] == null ? null : TimeOfWeek.fromMap(map["open"]),
      close: map["close"] == null ? null : TimeOfWeek.fromMap(map["close"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Period.fromJson(String source) => Period.fromMap(json.decode(source));

  @override
  String toString() => 'Period(open: $open, close: $close)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Period && o.open == open && o.close == close;
  }

  @override
  int get hashCode => open.hashCode ^ close.hashCode;
}
