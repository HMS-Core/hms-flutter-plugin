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
import 'package:huawei_awareness/constants/param.dart';

class LocationResponse {
  double latitude;
  double longitude;
  double altitude;
  double speed;
  double bearing;
  double accuracy;
  double verticalAccuracyMeters;
  double bearingAccuracyDegrees;
  double speedAccuracyMetersPerSecond;
  int time;
  bool fromMockProvider;

  LocationResponse({
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

  factory LocationResponse.fromJson(String str) =>
      LocationResponse.fromMap(json.decode(str));

  factory LocationResponse.fromMap(Map<dynamic, dynamic> jsonMap) =>
      LocationResponse(
        latitude: jsonMap[Param.latitude] == null
            ? null
            : jsonMap[Param.latitude].toDouble(),
        longitude: jsonMap[Param.longitude] == null
            ? null
            : jsonMap[Param.longitude].toDouble(),
        altitude: jsonMap[Param.altitude] == null
            ? null
            : jsonMap[Param.altitude].toDouble(),
        speed: jsonMap[Param.speed] == null
            ? null
            : jsonMap[Param.speed].toDouble(),
        bearing: jsonMap[Param.bearing] == null
            ? null
            : jsonMap[Param.bearing].toDouble(),
        accuracy: jsonMap[Param.accuracy] == null
            ? null
            : jsonMap[Param.accuracy].toDouble(),
        verticalAccuracyMeters: jsonMap[Param.verticalAccuracyMeters] == null
            ? null
            : jsonMap[Param.verticalAccuracyMeters].toDouble(),
        bearingAccuracyDegrees: jsonMap[Param.bearingAccuracyDegrees] == null
            ? null
            : jsonMap[Param.bearingAccuracyDegrees].toDouble(),
        speedAccuracyMetersPerSecond:
            jsonMap[Param.speedAccuracyMetersPerSecond] == null
                ? null
                : jsonMap[Param.speedAccuracyMetersPerSecond].toDouble(),
        time: jsonMap[Param.time] == null ? null : jsonMap[Param.time],
        fromMockProvider: jsonMap[Param.fromMockProvider] == null
            ? null
            : jsonMap[Param.fromMockProvider],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      Param.latitude: latitude == null ? null : latitude,
      Param.longitude: longitude == null ? null : longitude,
      Param.altitude: altitude == null ? null : altitude,
      Param.speed: speed == null ? null : speed,
      Param.bearing: bearing == null ? null : bearing,
      Param.accuracy: accuracy == null ? null : accuracy,
      Param.verticalAccuracyMeters:
          verticalAccuracyMeters == null ? null : verticalAccuracyMeters,
      Param.bearingAccuracyDegrees:
          bearingAccuracyDegrees == null ? null : bearingAccuracyDegrees,
      Param.speedAccuracyMetersPerSecond: speedAccuracyMetersPerSecond == null
          ? null
          : speedAccuracyMetersPerSecond,
      Param.time: time == null ? null : time,
      Param.fromMockProvider:
          fromMockProvider == null ? null : fromMockProvider,
    };
  }
}
