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
import 'dart:ui';

class Location {
  String provider;
  double latitude;
  double longitude;
  double altitude;
  double speed;
  double bearing;
  double horizontalAccuracyMeters;
  double verticalAccuracyMeters;
  double speedAccuracyMetersPerSecond;
  double bearingAccuracyDegrees;
  int time;
  int elapsedRealtimeNanos;

  Location({
    this.provider = 'HMS Mock Location',
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.altitude = 0.0,
    this.speed = 0.0,
    this.bearing = 0.0,
    this.horizontalAccuracyMeters = 0.0,
    this.verticalAccuracyMeters = 0.0,
    this.speedAccuracyMetersPerSecond = 0.0,
    this.bearingAccuracyDegrees = 0.0,
    this.time = 0,
    this.elapsedRealtimeNanos = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'provider': provider,
      'latitude': latitude,
      'longitude': longitude,
      'altitude': altitude,
      'speed': speed,
      'bearing': bearing,
      'horizontalAccuracyMeters': horizontalAccuracyMeters,
      'verticalAccuracyMeters': verticalAccuracyMeters,
      'speedAccuracyMetersPerSecond': speedAccuracyMetersPerSecond,
      'bearingAccuracyDegrees': bearingAccuracyDegrees,
      'time': time,
      'elapsedRealtimeNanos': elapsedRealtimeNanos,
    };
  }

  factory Location.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    return Location(
      provider: map["provider"] == null ? null : map["provider"],
      latitude: map["latitude"] == null ? null : map["latitude"],
      longitude: map["longitude"] == null ? null : map["longitude"],
      altitude: map["altitude"] == null ? null : map["altitude"],
      speed: map["speed"] == null ? null : map["speed"],
      bearing: map["bearing"] == null ? null : map["bearing"],
      horizontalAccuracyMeters: map["horizontalAccuracyMeters"] == null
          ? null
          : map["horizontalAccuracyMeters"],
      verticalAccuracyMeters: map["verticalAccuracyMeters"] == null
          ? null
          : map["verticalAccuracyMeters"],
      speedAccuracyMetersPerSecond: map["speedAccuracyMetersPerSecond"] == null
          ? null
          : map["speedAccuracyMetersPerSecond"],
      bearingAccuracyDegrees: map["bearingAccuracyDegrees"] == null
          ? null
          : map["bearingAccuracyDegrees"],
      time: map["time"] == null ? null : map["time"],
      elapsedRealtimeNanos: map["elapsedRealtimeNanos"] == null
          ? null
          : map["elapsedRealtimeNanos"],
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Location(provider: $provider, latitude: $latitude, longitude: $longitude, altitude: $altitude, speed: $speed, bearing: $bearing, horizontalAccuracyMeters: $horizontalAccuracyMeters, verticalAccuracyMeters: $verticalAccuracyMeters, speedAccuracyMetersPerSecond: $speedAccuracyMetersPerSecond, bearingAccuracyDegrees: $bearingAccuracyDegrees, time: $time, elapsedRealtimeNanos: $elapsedRealtimeNanos)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Location &&
        o.provider == provider &&
        o.latitude == latitude &&
        o.longitude == longitude &&
        o.altitude == altitude &&
        o.speed == speed &&
        o.bearing == bearing &&
        o.horizontalAccuracyMeters == horizontalAccuracyMeters &&
        o.verticalAccuracyMeters == verticalAccuracyMeters &&
        o.speedAccuracyMetersPerSecond == speedAccuracyMetersPerSecond &&
        o.bearingAccuracyDegrees == bearingAccuracyDegrees &&
        o.time == time &&
        o.elapsedRealtimeNanos == elapsedRealtimeNanos;
  }

  @override
  int get hashCode {
    return hashList([
      provider,
      latitude,
      longitude,
      altitude,
      speed,
      bearing,
      horizontalAccuracyMeters,
      verticalAccuracyMeters,
      speedAccuracyMetersPerSecond,
      bearingAccuracyDegrees,
      time,
      elapsedRealtimeNanos,
    ]);
  }
}
