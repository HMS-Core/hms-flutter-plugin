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

import 'EventTime.dart';

class EventInfo {
  EventInfo({
    this.abstractInfo,
    this.beginTime,
    this.closeTime,
    this.condition,
    this.placeInfo,
    this.sponsor,
    this.theme,
  });

  String abstractInfo;
  EventTime beginTime;
  EventTime closeTime;
  String condition;
  String placeInfo;
  String sponsor;
  String theme;

  factory EventInfo.fromJson(String str) => EventInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EventInfo.fromMap(Map<String, dynamic> json) => EventInfo(
        abstractInfo:
            json["abstractInfo"] == null ? null : json["abstractInfo"],
        beginTime: json["beginTime"] == null
            ? null
            : EventTime.fromMap(json["beginTime"]),
        closeTime: json["closeTime"] == null
            ? null
            : EventTime.fromMap(json["closeTime"]),
        condition: json["condition"] == null ? null : json["condition"],
        placeInfo: json["placeInfo"] == null ? null : json["placeInfo"],
        sponsor: json["sponsor"] == null ? null : json["sponsor"],
        theme: json["theme"] == null ? null : json["theme"],
      );

  Map<String, dynamic> toMap() => {
        "abstractInfo": abstractInfo == null ? null : abstractInfo,
        "beginTime": beginTime == null ? null : beginTime.toMap(),
        "closeTime": closeTime == null ? null : closeTime.toMap(),
        "condition": condition == null ? null : condition,
        "placeInfo": placeInfo == null ? null : placeInfo,
        "sponsor": sponsor == null ? null : sponsor,
        "theme": theme == null ? null : theme,
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final EventInfo check = o;
    return o is EventInfo &&
        check.abstractInfo == abstractInfo &&
        check.beginTime == beginTime &&
        check.closeTime == closeTime &&
        check.condition == condition &&
        check.placeInfo == placeInfo &&
        check.sponsor == sponsor &&
        check.theme == theme;
  }

  @override
  int get hashCode => hashValues(
        abstractInfo,
        beginTime,
        closeTime,
        condition,
        placeInfo,
        sponsor,
        theme,
      );
}
