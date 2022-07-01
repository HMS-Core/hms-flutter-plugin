/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:huawei_map/constants/param.dart';

class Location {
  double? latitude;
  double? longitude;
  double? altitude;
  double? speed;
  double? bearing;
  double? accuracy;
  double? verticalAccuracyMeters;
  double? bearingAccuracyDegrees;
  double? speedAccuracyMetersPerSecond;
  int? time;
  bool? fromMockProvider;

  Location({
    this.latitude,
    this.longitude,
    this.altitude,
    this.speed,
    this.bearing,
    this.accuracy,
    this.verticalAccuracyMeters,
    this.bearingAccuracyDegrees,
    this.speedAccuracyMetersPerSecond,
    this.time,
    this.fromMockProvider,
  });

  Map<String, dynamic> toMap() => {
        Param.latitude: latitude,
        Param.longitude: longitude,
        Param.altitude: altitude,
        Param.speed: speed,
        Param.bearing: bearing,
        Param.accuracy: accuracy,
        Param.verticalAccuracyMeters: verticalAccuracyMeters,
        Param.bearingAccuracyDegrees: bearingAccuracyDegrees,
        Param.speedAccuracyMetersPerSecond: speedAccuracyMetersPerSecond,
        Param.time: time,
        Param.fromMockProvider: fromMockProvider,
      };

  static Location fromMap(Map<dynamic, dynamic> map) {
    return Location(
      latitude: map[Param.latitude]?.toDouble(),
      longitude: map[Param.longitude]?.toDouble(),
      altitude: map[Param.altitude]?.toDouble(),
      speed: map[Param.speed]?.toDouble(),
      bearing: map[Param.bearing]?.toDouble(),
      accuracy: map[Param.accuracy]?.toDouble(),
      verticalAccuracyMeters: map[Param.verticalAccuracyMeters]?.toDouble(),
      bearingAccuracyDegrees: map[Param.bearingAccuracyDegrees]?.toDouble(),
      speedAccuracyMetersPerSecond:
          map[Param.speedAccuracyMetersPerSecond]?.toDouble(),
      time: map[Param.time],
      fromMockProvider: map[Param.fromMockProvider],
    );
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is Location &&
        this.latitude == other.latitude &&
        this.longitude == other.longitude &&
        this.altitude == other.altitude &&
        this.speed == other.speed &&
        this.bearing == other.bearing &&
        this.accuracy == other.accuracy &&
        this.verticalAccuracyMeters == other.verticalAccuracyMeters &&
        this.bearingAccuracyDegrees == other.bearingAccuracyDegrees &&
        this.speedAccuracyMetersPerSecond ==
            other.speedAccuracyMetersPerSecond &&
        this.time == other.time &&
        this.fromMockProvider == other.fromMockProvider;
  }

  @override
  int get hashCode => Object.hash(
      latitude,
      longitude,
      altitude,
      speed,
      bearing,
      accuracy,
      verticalAccuracyMeters,
      bearingAccuracyDegrees,
      speedAccuracyMetersPerSecond,
      time,
      fromMockProvider);
}
