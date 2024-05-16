/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_site;

class TimeOfWeek {
  static const int _DAY_MIN = 0;
  static const int _DAY_MAX = 6;
  static const int _TIME_MIN = 0;
  static const int _TIME_MAX = 2359;

  int? _day;
  String? _time;

  TimeOfWeek({
    int? day,
    String? time,
  })  : _day = day,
        _time = time;

  int get day => _day!;

  set day(int day) {
    if (day < _DAY_MIN || day > _DAY_MAX) {
      throw const FormatException('TimeOfWeek day param exceeded the range');
    }
    _day = day;
  }

  String get time => _time!;

  set time(String time) {
    final int intValue = int.parse(time);

    if (intValue < _TIME_MIN || intValue > _TIME_MAX) {
      throw const FormatException('TimeOfWeek time param exceeded the range');
    }
    _time = time;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': _day,
      'time': _time,
    };
  }

  factory TimeOfWeek.fromMap(Map<dynamic, dynamic> map) {
    return TimeOfWeek(
      day: map['day'],
      time: map['time'],
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory TimeOfWeek.fromJson(String source) {
    return TimeOfWeek.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return '$TimeOfWeek('
        'day: $_day, '
        'time: $_time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimeOfWeek && other._day == _day && other._time == _time;
  }

  @override
  int get hashCode {
    return _day.hashCode ^ _time.hashCode;
  }
}
