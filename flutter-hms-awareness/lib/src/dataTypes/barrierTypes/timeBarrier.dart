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

part of huawei_awareness;

class TimeBarrier extends AwarenessBarrier {
  static const int fridayCode = 6;
  static const int mondayCode = 2;
  static const int saturdayCode = 7;
  static const int sundayCode = 1;
  static const int thursdayCode = 5;
  static const int tuesdayCode = 3;
  static const int wednesdayCode = 4;

  static const int sunriseCode = 0;
  static const int sunsetCode = 1;

  static const int categoryAfternoon = 2;
  static const int categoryEvening = 3;
  static const int categoryHoliday = 5;
  static const int categoryMorning = 1;
  static const int categoryNight = 4;
  static const int categoryWeekday = 6;
  static const int categoryWeekend = 7;
  static const int categoryNotHoliday = 8;

  String barrierLabel;

  //inSunriseOrSunsetPeriod
  int? timeInstant;
  int? startTimeOffset;
  int? stopTimeOffset;

  //duringPeriodOfDay
  int? startTimeOfDay;
  int? stopTimeOfDay;

  //duringTimePeriod
  int? startTimeStamp;
  int? stopTimeStamp;

  //duringPeriodOfWeek
  int? dayOfWeek;
  int? startTimeOfSpecifiedDay;
  int? stopTimeOfSpecifiedDay;

  //inTimeCategory
  int? inTimeCategory;

  //for duringPeriodOfDay and duringPeriodOfWeek
  String? timeZoneId;

  TimeBarrier.inSunriseOrSunsetPeriod({
    required this.barrierLabel,
    required this.timeInstant,
    required this.startTimeOffset,
    required this.stopTimeOffset,
  }) : super(
          barrierEventType: _Param.timeBarrierReceiverAction,
          barrierType: _Param.timeInSunriseOrSunsetPeriodBarrier,
          barrierLabel: barrierLabel,
        ) {
    startTimeOfDay = null;
    stopTimeOfDay = null;
    startTimeStamp = null;
    stopTimeStamp = null;
    dayOfWeek = null;
    startTimeOfSpecifiedDay = null;
    stopTimeOfSpecifiedDay = null;
    inTimeCategory = null;
    timeZoneId = null;
  }

  TimeBarrier.duringPeriodOfDay({
    required this.barrierLabel,
    required this.startTimeOfDay,
    required this.stopTimeOfDay,
    this.timeZoneId,
  }) : super(
          barrierEventType: _Param.timeBarrierReceiverAction,
          barrierType: _Param.timeDuringPeriodOfDayBarrier,
          barrierLabel: barrierLabel,
        ) {
    timeInstant = null;
    startTimeOffset = null;
    stopTimeOffset = null;
    startTimeStamp = null;
    stopTimeStamp = null;
    dayOfWeek = null;
    startTimeOfSpecifiedDay = null;
    stopTimeOfSpecifiedDay = null;
    inTimeCategory = null;
  }

  TimeBarrier.duringTimePeriod({
    required this.barrierLabel,
    required this.startTimeStamp,
    required this.stopTimeStamp,
  }) : super(
          barrierEventType: _Param.timeBarrierReceiverAction,
          barrierType: _Param.timeDuringTimePeriodBarrier,
          barrierLabel: barrierLabel,
        ) {
    timeInstant = null;
    startTimeOffset = null;
    stopTimeOffset = null;
    startTimeOfDay = null;
    stopTimeOfDay = null;
    dayOfWeek = null;
    startTimeOfSpecifiedDay = null;
    stopTimeOfSpecifiedDay = null;
    inTimeCategory = null;
    timeZoneId = null;
  }

  TimeBarrier.duringPeriodOfWeek({
    required this.barrierLabel,
    required this.dayOfWeek,
    required this.startTimeOfSpecifiedDay,
    required this.stopTimeOfSpecifiedDay,
    this.timeZoneId,
  }) : super(
          barrierEventType: _Param.timeBarrierReceiverAction,
          barrierType: _Param.timeDuringPeriodOfWeekBarrier,
          barrierLabel: barrierLabel,
        ) {
    timeInstant = null;
    startTimeOffset = null;
    stopTimeOffset = null;
    startTimeOfDay = null;
    stopTimeOfDay = null;
    startTimeStamp = null;
    stopTimeStamp = null;
    inTimeCategory = null;
  }

  TimeBarrier.inTimeCategory({
    required this.barrierLabel,
    required this.inTimeCategory,
  }) : super(
          barrierEventType: _Param.timeBarrierReceiverAction,
          barrierType: _Param.timeInTimeCategoryBarrier,
          barrierLabel: barrierLabel,
        ) {
    timeInstant = null;
    startTimeOffset = null;
    stopTimeOffset = null;
    startTimeOfDay = null;
    stopTimeOfDay = null;
    startTimeStamp = null;
    stopTimeStamp = null;
    dayOfWeek = null;
    startTimeOfSpecifiedDay = null;
    stopTimeOfSpecifiedDay = null;
    timeZoneId = null;
  }

  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        _Param.barrierEventType: barrierEventType,
        _Param.barrierType: barrierType,
        _Param.barrierLabel: barrierLabel,
        _Param.timeInstant: timeInstant,
        _Param.startTimeOffset: startTimeOffset,
        _Param.stopTimeOffset: stopTimeOffset,
        _Param.startTimeOfDay: startTimeOfDay,
        _Param.stopTimeOfDay: stopTimeOfDay,
        _Param.startTimeStamp: startTimeStamp,
        _Param.stopTimeStamp: stopTimeStamp,
        _Param.dayOfWeek: dayOfWeek,
        _Param.startTimeOfSpecifiedDay: startTimeOfSpecifiedDay,
        _Param.stopTimeOfSpecifiedDay: stopTimeOfSpecifiedDay,
        _Param.inTimeCategory: inTimeCategory,
        _Param.timeZone: timeZoneId,
      };
}
