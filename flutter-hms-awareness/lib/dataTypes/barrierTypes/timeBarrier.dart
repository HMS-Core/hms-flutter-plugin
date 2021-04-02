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
import 'package:flutter/foundation.dart' show required;
import 'package:huawei_awareness/hmsAwarenessLibrary.dart'
    show AwarenessBarrier;
import 'package:huawei_awareness/constants/param.dart';

class TimeBarrier extends AwarenessBarrier {
  static const int FridayCode = 6;
  static const int MondayCode = 2;
  static const int SaturdayCode = 7;
  static const int SundayCode = 1;
  static const int ThursdayCode = 5;
  static const int TuesdayCode = 3;
  static const int WednesdayCode = 4;

  static const int SunriseCode = 0;
  static const int SunsetCode = 1;

  static const int CategoryAfternoon = 2;
  static const int CategoryEvening = 3;
  static const int CategoryHoliday = 5;
  static const int CategoryMorning = 1;
  static const int CategoryNight = 4;
  static const int CategoryWeekday = 6;
  static const int CategoryWeekend = 7;
  static const int CategoryNotHoliday = 8;

  String barrierLabel;

  //inSunriseOrSunsetPeriod
  int timeInstant;
  int startTimeOffset;
  int stopTimeOffset;

  //duringPeriodOfDay
  int startTimeOfDay;
  int stopTimeOfDay;

  //duringTimePeriod
  int startTimeStamp;
  int stopTimeStamp;

  //duringPeriodOfWeek
  int dayOfWeek;
  int startTimeOfSpecifiedDay;
  int stopTimeOfSpecifiedDay;

  //inTimeCategory
  int inTimeCategory;

  //for duringPeriodOfDay and duringPeriodOfWeek
  String timeZoneId;

  TimeBarrier.inSunriseOrSunsetPeriod({
    @required this.barrierLabel,
    @required this.timeInstant,
    @required this.startTimeOffset,
    @required this.stopTimeOffset,
  }) : super(
          barrierEventType: Param.timeBarrierReceiverAction,
          barrierType: Param.timeInSunriseOrSunsetPeriodBarrier,
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
    @required this.barrierLabel,
    @required this.startTimeOfDay,
    @required this.stopTimeOfDay,
    this.timeZoneId,
  }) : super(
          barrierEventType: Param.timeBarrierReceiverAction,
          barrierType: Param.timeDuringPeriodOfDayBarrier,
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
    @required this.barrierLabel,
    @required this.startTimeStamp,
    @required this.stopTimeStamp,
  }) : super(
          barrierEventType: Param.timeBarrierReceiverAction,
          barrierType: Param.timeDuringTimePeriodBarrier,
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
    @required this.barrierLabel,
    @required this.dayOfWeek,
    @required this.startTimeOfSpecifiedDay,
    @required this.stopTimeOfSpecifiedDay,
    this.timeZoneId,
  }) : super(
          barrierEventType: Param.timeBarrierReceiverAction,
          barrierType: Param.timeDuringPeriodOfWeekBarrier,
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
    @required this.barrierLabel,
    @required this.inTimeCategory,
  }) : super(
          barrierEventType: Param.timeBarrierReceiverAction,
          barrierType: Param.timeInTimeCategoryBarrier,
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
  Map<String, dynamic> toMap() => {
        Param.barrierEventType:
            barrierEventType == null ? null : barrierEventType,
        Param.barrierType: barrierType == null ? null : barrierType,
        Param.barrierLabel: barrierLabel == null ? null : barrierLabel,
        Param.timeInstant: timeInstant == null ? null : timeInstant,
        Param.startTimeOffset: startTimeOffset == null ? null : startTimeOffset,
        Param.stopTimeOffset: stopTimeOffset == null ? null : stopTimeOffset,
        Param.startTimeOfDay: startTimeOfDay == null ? null : startTimeOfDay,
        Param.stopTimeOfDay: stopTimeOfDay == null ? null : stopTimeOfDay,
        Param.startTimeStamp: startTimeStamp == null ? null : startTimeStamp,
        Param.stopTimeStamp: stopTimeStamp == null ? null : stopTimeStamp,
        Param.dayOfWeek: dayOfWeek == null ? null : dayOfWeek,
        Param.startTimeOfSpecifiedDay:
            startTimeOfSpecifiedDay == null ? null : startTimeOfSpecifiedDay,
        Param.stopTimeOfSpecifiedDay:
            stopTimeOfSpecifiedDay == null ? null : stopTimeOfSpecifiedDay,
        Param.inTimeCategory: inTimeCategory == null ? null : inTimeCategory,
        Param.timeZone: timeZoneId == null ? null : timeZoneId,
      };
}
