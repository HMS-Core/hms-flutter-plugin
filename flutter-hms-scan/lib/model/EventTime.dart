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

import 'dart:convert' show json;
import 'dart:ui' show hashValues;

class EventTime {
  EventTime({
    this.day,
    this.hours,
    this.isUTCTime,
    this.minutes,
    this.month,
    this.originalValue,
    this.seconds,
    this.year,
  });

  int day;
  int hours;
  bool isUTCTime;
  int minutes;
  int month;
  String originalValue;
  int seconds;
  int year;

  factory EventTime.fromJson(String str) => EventTime.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EventTime.fromMap(Map<String, dynamic> json) => EventTime(
        day: json["day"] == null ? null : json["day"].round(),
        hours: json["hours"] == null ? null : json["hours"].round(),
        isUTCTime: json["isUTCTime"] == null ? null : json["isUTCTime"],
        minutes: json["minutes"] == null ? null : json["minutes"].round(),
        month: json["month"] == null ? null : json["month"].round(),
        originalValue:
            json["originalValue"] == null ? null : json["originalValue"],
        seconds: json["seconds"] == null ? null : json["seconds"].round(),
        year: json["year"] == null ? null : json["year"].round(),
      );

  Map<String, dynamic> toMap() => {
        "day": day == null ? null : day,
        "hours": hours == null ? null : hours,
        "isUTCTime": isUTCTime == null ? null : isUTCTime,
        "minutes": minutes == null ? null : minutes,
        "month": month == null ? null : month,
        "originalValue": originalValue == null ? null : originalValue,
        "seconds": seconds == null ? null : seconds,
        "year": year == null ? null : year,
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final EventTime check = o;
    return o is EventTime &&
        check.day == day &&
        check.hours == hours &&
        check.isUTCTime == isUTCTime &&
        check.minutes == minutes &&
        check.month == month &&
        check.originalValue == originalValue &&
        check.seconds == seconds &&
        check.year == year;
  }

  @override
  int get hashCode => hashValues(
        day,
        hours,
        isUTCTime,
        minutes,
        month,
        originalValue,
        seconds,
        year,
      );
}
