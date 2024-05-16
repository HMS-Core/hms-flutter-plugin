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

class LocationResponse {
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
        latitude: jsonMap[_Param.latitude].toDouble(),
        longitude: jsonMap[_Param.longitude].toDouble(),
        altitude: jsonMap[_Param.altitude].toDouble(),
        speed: jsonMap[_Param.speed].toDouble(),
        bearing: jsonMap[_Param.bearing].toDouble(),
        accuracy: jsonMap[_Param.accuracy].toDouble(),
        verticalAccuracyMeters:
            jsonMap[_Param.verticalAccuracyMeters].toDouble(),
        bearingAccuracyDegrees:
            jsonMap[_Param.bearingAccuracyDegrees].toDouble(),
        speedAccuracyMetersPerSecond:
            jsonMap[_Param.speedAccuracyMetersPerSecond].toDouble(),
        time: jsonMap[_Param.time],
        fromMockProvider: jsonMap[_Param.fromMockProvider],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      _Param.latitude: latitude,
      _Param.longitude: longitude,
      _Param.altitude: altitude,
      _Param.speed: speed,
      _Param.bearing: bearing,
      _Param.accuracy: accuracy,
      _Param.verticalAccuracyMeters: verticalAccuracyMeters,
      _Param.bearingAccuracyDegrees: bearingAccuracyDegrees,
      _Param.speedAccuracyMetersPerSecond: speedAccuracyMetersPerSecond,
      _Param.time: time,
      _Param.fromMockProvider: fromMockProvider,
    };
  }
}
