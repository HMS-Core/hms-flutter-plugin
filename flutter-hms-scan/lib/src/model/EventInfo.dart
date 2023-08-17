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

  String? abstractInfo;
  EventTime? beginTime;
  EventTime? closeTime;
  String? condition;
  String? placeInfo;
  String? sponsor;
  String? theme;

  factory EventInfo.fromJson(String str) {
    return EventInfo.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory EventInfo.fromMap(Map<String, dynamic> json) {
    return EventInfo(
      abstractInfo: json['abstractInfo'],
      beginTime: json['beginTime'] == null
          ? null
          : EventTime.fromMap(json['beginTime']),
      closeTime: json['closeTime'] == null
          ? null
          : EventTime.fromMap(json['closeTime']),
      condition: json['condition'],
      placeInfo: json['placeInfo'],
      sponsor: json['sponsor'],
      theme: json['theme'],
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'abstractInfo': abstractInfo,
        'beginTime': beginTime == null ? null : beginTime!.toMap(),
        'closeTime': closeTime == null ? null : closeTime!.toMap(),
        'condition': condition,
        'placeInfo': placeInfo,
        'sponsor': sponsor,
        'theme': theme,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is EventInfo &&
        other.abstractInfo == abstractInfo &&
        other.beginTime == beginTime &&
        other.closeTime == closeTime &&
        other.condition == condition &&
        other.placeInfo == placeInfo &&
        other.sponsor == sponsor &&
        other.theme == theme;
  }

  @override
  int get hashCode {
    return Object.hash(
      abstractInfo,
      beginTime,
      closeTime,
      condition,
      placeInfo,
      sponsor,
      theme,
    );
  }
}
