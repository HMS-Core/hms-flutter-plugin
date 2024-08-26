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

class Geofence {
  /// A user enters the geofence.
  static const int ENTER_GEOFENCE_CONVERSION = 1;

  /// A user exits the geofence.
  static const int EXIT_GEOFENCE_CONVERSION = 2;

  /// A user stays in the geofence.
  static const int DWELL_GEOFENCE_CONVERSION = 4;

  /// No timeout interval is configured for the geofence.
  static const int GEOFENCE_NEVER_EXPIRE = -1;

  /// Unique ID of a geofence.
  ///
  /// If the unique ID exists, the new geofence will overwrite the old one.
  String uniqueId;

  /// Geofence conversions.
  ///
  /// The **bitwise-OR** operation is supported.
  int? conversions;

  /// Geofence timeout interval, in milliseconds.
  ///
  /// The geofence will be automatically deleted after this amount of time.
  int? validDuration;

  /// Latitude.
  ///
  /// The value range is between `-90` and `90`.
  double latitude;

  /// Longitude.
  ///
  /// The value range is between `-180` and `180`.
  double longitude;

  /// Geofence radius, in meters.
  double radius;

  /// Interval for sending geofence notifications.
  ///
  /// The default value is `0`. Setting it to a larger value can reduce power
  /// consumption accordingly. However, reporting of geofence events
  /// may be delayed.
  int? notificationInterval;

  /// Stay duration for reporting a geofence event, in milliseconds.
  ///
  /// A geofence event will be reported when a user stays in a geofence for
  /// this amount of time.
  int? dwellDelayTime;

  Geofence({
    required this.uniqueId,
    required this.latitude,
    required this.longitude,
    required this.radius,
    this.conversions,
    this.validDuration,
    this.notificationInterval = 0,
    this.dwellDelayTime = 0,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
    return 'Geofence('
        'uniqueId: $uniqueId, '
        'conversions: $conversions, '
        'validDuration: $validDuration, '
        'latitude: $latitude, '
        'longitude: $longitude, '
        'radius: $radius, '
        'notificationInterval: $notificationInterval, '
        'dwellDelayTime: $dwellDelayTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Geofence &&
        other.uniqueId == uniqueId &&
        other.conversions == conversions &&
        other.validDuration == validDuration &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.radius == radius &&
        other.notificationInterval == notificationInterval &&
        other.dwellDelayTime == dwellDelayTime;
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
        uniqueId,
        conversions,
        validDuration,
        latitude,
        longitude,
        radius,
        notificationInterval,
        dwellDelayTime,
      ],
    );
  }
}
