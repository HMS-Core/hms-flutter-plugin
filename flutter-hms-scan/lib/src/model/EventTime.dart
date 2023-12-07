/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_scan;

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

  int? day;
  int? hours;
  bool? isUTCTime;
  int? minutes;
  int? month;
  String? originalValue;
  int? seconds;
  int? year;

  factory EventTime.fromJson(String str) {
    return EventTime.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory EventTime.fromMap(Map<String, dynamic> json) {
    return EventTime(
      day: json['day']?.round(),
      hours: json['hours']?.round(),
      isUTCTime: json['isUTCTime'],
      minutes: json['minutes']?.round(),
      month: json['month']?.round(),
      originalValue: json['originalValue'],
      seconds: json['seconds']?.round(),
      year: json['year']?.round(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day,
      'hours': hours,
      'isUTCTime': isUTCTime,
      'minutes': minutes,
      'month': month,
      'originalValue': originalValue,
      'seconds': seconds,
      'year': year,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is EventTime &&
        other.day == day &&
        other.hours == hours &&
        other.isUTCTime == isUTCTime &&
        other.minutes == minutes &&
        other.month == month &&
        other.originalValue == originalValue &&
        other.seconds == seconds &&
        other.year == year;
  }

  @override
  int get hashCode {
    return Object.hash(
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
}
