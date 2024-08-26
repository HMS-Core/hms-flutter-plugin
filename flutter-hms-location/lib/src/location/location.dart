/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

part of '../../huawei_location.dart';

class Location {
  /// Location provider, such as network location, GNSS, Wi-Fi, and Bluetooth.
  String? provider;

  /// Latitude of a location.
  ///
  /// If no latitude is available, `0.0` is returned.
  double? latitude;

  /// Longitude of a location.
  ///
  /// If no longitude is available, `0.0` is returned.
  double? longitude;

  /// Altitude of a location.
  ///
  /// If no altitude is available, `0.0` is returned.
  double? altitude;

  /// Speed of a device at the current location, in meters per second.
  ///
  /// If no speed is available, `0.0` is returned.
  double? speed;

  /// Bearing of a device at the current location, in degrees.
  ///
  /// If no bearing is available, `0.0` is returned.
  double? bearing;

  /// Horizontal accuracy of a location, in meters.
  ///
  /// If no horizontal accuracy is available, `0.0` is returned.
  double? horizontalAccuracyMeters;

  /// Vertical accuracy of a location, in meters.
  ///
  /// If no vertical accuracy is available, `0.0` is returned.
  double? verticalAccuracyMeters;

  /// Speed accuracy of a device at the current location, in meters per second.
  ///
  /// If no speed accuracy is available, `0.0` is returned.
  double? speedAccuracyMetersPerSecond;

  /// Bearing accuracy at the current location, in degrees.
  ///
  /// If no bearing accuracy is available, `0.0` is returned.
  double? bearingAccuracyDegrees;

  /// Timestamp, in milliseconds.
  int? time;

  /// Time elapsed since system boot, in nanoseconds.
  int? elapsedRealtimeNanos;

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
    return <String, dynamic>{
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

  factory Location.fromMap(Map<dynamic, dynamic>? map) {
    return Location(
      provider: map?['provider'],
      latitude: map?['latitude'],
      longitude: map?['longitude'],
      altitude: map?['altitude'],
      speed: map?['speed'],
      bearing: map?['bearing'],
      horizontalAccuracyMeters: map?['horizontalAccuracyMeters'],
      verticalAccuracyMeters: map?['verticalAccuracyMeters'],
      speedAccuracyMetersPerSecond: map?['speedAccuracyMetersPerSecond'],
      bearingAccuracyDegrees: map?['bearingAccuracyDegrees'],
      time: map?['time'],
      elapsedRealtimeNanos: map?['elapsedRealtimeNanos'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Location('
        'provider: $provider, '
        'latitude: $latitude, '
        'longitude: $longitude, '
        'altitude: $altitude, '
        'speed: $speed, '
        'bearing: $bearing, '
        'horizontalAccuracyMeters: $horizontalAccuracyMeters, '
        'verticalAccuracyMeters: $verticalAccuracyMeters, '
        'speedAccuracyMetersPerSecond: $speedAccuracyMetersPerSecond, '
        'bearingAccuracyDegrees: $bearingAccuracyDegrees, '
        'time: $time, '
        'elapsedRealtimeNanos: $elapsedRealtimeNanos)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Location &&
        other.provider == provider &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.altitude == altitude &&
        other.speed == speed &&
        other.bearing == bearing &&
        other.horizontalAccuracyMeters == horizontalAccuracyMeters &&
        other.verticalAccuracyMeters == verticalAccuracyMeters &&
        other.speedAccuracyMetersPerSecond == speedAccuracyMetersPerSecond &&
        other.bearingAccuracyDegrees == bearingAccuracyDegrees &&
        other.time == time &&
        other.elapsedRealtimeNanos == elapsedRealtimeNanos;
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
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
      ],
    );
  }
}
