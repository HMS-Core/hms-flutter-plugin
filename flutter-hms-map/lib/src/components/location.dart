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

part of '../../huawei_map.dart';

/// An object that contains attributes about a location.
class Location {
  /// Latitude, in degrees.
  double? latitude;

  /// Longitude, in degrees.
  double? longitude;

  /// Altitude if available, in meters above the WGS 84 reference ellipsoid.
  double? altitude;

  /// Speed if it is available, in meters/second over ground.
  double? speed;

  /// Bearing, in degrees.
  double? bearing;

  /// Estimated horizontal accuracy of this location, radial, in meters.
  double? accuracy;

  /// Estimated vertical accuracy of this location, in meters.
  double? verticalAccuracyMeters;

  /// Estimated bearing accuracy of this location, in degrees.
  double? bearingAccuracyDegrees;

  /// Estimated speed accuracy of this location, in meters per second.
  double? speedAccuracyMetersPerSecond;

  /// Time in milliseconds since January 1, 1970.
  int? time;

  /// Location provider status.
  bool? fromMockProvider;

  /// Creates a [Location] object.
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

  /// Creates a [Location] object from a map.
  static Location fromMap(Map<dynamic, dynamic> map) {
    return Location(
      latitude: map[_Param.latitude]?.toDouble(),
      longitude: map[_Param.longitude]?.toDouble(),
      altitude: map[_Param.altitude]?.toDouble(),
      speed: map[_Param.speed]?.toDouble(),
      bearing: map[_Param.bearing]?.toDouble(),
      accuracy: map[_Param.accuracy]?.toDouble(),
      verticalAccuracyMeters: map[_Param.verticalAccuracyMeters]?.toDouble(),
      bearingAccuracyDegrees: map[_Param.bearingAccuracyDegrees]?.toDouble(),
      speedAccuracyMetersPerSecond:
          map[_Param.speedAccuracyMetersPerSecond]?.toDouble(),
      time: map[_Param.time],
      fromMockProvider: map[_Param.fromMockProvider],
    );
  }

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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    return other is Location &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        altitude == other.altitude &&
        speed == other.speed &&
        bearing == other.bearing &&
        accuracy == other.accuracy &&
        verticalAccuracyMeters == other.verticalAccuracyMeters &&
        bearingAccuracyDegrees == other.bearingAccuracyDegrees &&
        speedAccuracyMetersPerSecond == other.speedAccuracyMetersPerSecond &&
        time == other.time &&
        fromMockProvider == other.fromMockProvider;
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
        fromMockProvider,
      );
}
