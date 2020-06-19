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
import 'dart:core';
import 'dart:ui';

class Geofence {
  static const int ENTER_GEOFENCE_CONVERSION = 1;
  static const int EXIT_GEOFENCE_CONVERSION = 2;
  static const int DWELL_GEOFENCE_CONVERSION = 4;
  static const int GEOFENCE_NEVER_EXPIRE = -1;

  String uniqueId;
  int conversions;
  int validDuration;
  double latitude;
  double longitude;
  double radius;
  int notificationInterval;
  int dwellDelayTime;

  Geofence({
    this.uniqueId,
    this.conversions,
    this.validDuration,
    this.latitude,
    this.longitude,
    this.radius,
    this.notificationInterval = 0,
    this.dwellDelayTime = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'uniqueId': uniqueId,
      'conversions': conversions,
      'validDuration': validDuration,
      'latitude': latitude,
      'longitude': longitude,
      'radius': radius,
      'notificationInterval': notificationInterval,
      'dwellDelayTime': dwellDelayTime,
    };
  }

  factory Geofence.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    return Geofence(
      uniqueId: map['uniqueId'],
      conversions: map['conversions'],
      validDuration: map['validDuration'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      radius: map['radius'],
      notificationInterval: map['notificationInterval'],
      dwellDelayTime: map['dwellDelayTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Geofence.fromJson(String source) =>
      Geofence.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Geofence(uniqueId: $uniqueId, conversions: $conversions, validDuration: $validDuration, latitude: $latitude, longitude: $longitude, radius: $radius, notificationInterval: $notificationInterval, dwellDelayTime: $dwellDelayTime)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Geofence &&
        o.uniqueId == uniqueId &&
        o.conversions == conversions &&
        o.validDuration == validDuration &&
        o.latitude == latitude &&
        o.longitude == longitude &&
        o.radius == radius &&
        o.notificationInterval == notificationInterval &&
        o.dwellDelayTime == dwellDelayTime;
  }

  @override
  int get hashCode {
    return hashList([
      uniqueId,
      conversions,
      validDuration,
      latitude,
      longitude,
      radius,
      notificationInterval,
      dwellDelayTime,
    ]);
  }
}
