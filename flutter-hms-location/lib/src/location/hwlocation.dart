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

class HWLocation {
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

  /// Country code.
  ///
  /// The value is a two-letter code complying with the **ISO 3166-1 standard**.
  /// If no country code is available, `null` is returned.
  String? countryCode;

  /// Country name.
  ///
  /// If no country name is available, `null` is returned.
  String? countryName;

  /// Administrative region.
  ///
  /// If no administrative region is available, `null` is returned.
  String? state;

  /// City of the current location.
  ///
  /// If no city is available, `null` is returned.
  String? city;

  /// County of the current location.
  ///
  /// If no county is available, `null` is returned.
  String? county;

  /// Street of the current location.
  ///
  /// If no street is available, `null` is returned.
  String? street;

  /// Landmark building at the current location.
  ///
  /// If no landmark building is available, `null` is returned.
  String? featureName;

  /// Postal code of the current location.
  ///
  /// If no postal code is available, `null` is returned.
  String? postalCode;

  /// Phone number of the landmark building (such as a store or company) at
  /// the current location.
  ///
  /// If no phone number is available, `null` is returned.
  String? phone;

  /// Website of the landmark building (such as a store or company) at
  /// the current location.
  ///
  /// If no website is available, `null` is returned.
  String? url;

  /// Additional information, which is a key-value pair.
  ///
  /// If no additional information is available, `null` is returned.
  Map<String, dynamic>? extraInfo;

  /// The coordinate type of the current location.
  int? coordinateType;

  HWLocation({
    this.provider,
    this.latitude,
    this.longitude,
    this.altitude,
    this.speed,
    this.bearing,
    this.horizontalAccuracyMeters,
    this.verticalAccuracyMeters,
    this.speedAccuracyMetersPerSecond,
    this.bearingAccuracyDegrees,
    this.time,
    this.elapsedRealtimeNanos,
    this.countryCode,
    this.countryName,
    this.state,
    this.city,
    this.county,
    this.street,
    this.featureName,
    this.postalCode,
    this.phone,
    this.url,
    this.extraInfo,
    this.coordinateType,
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
      'countryCode': countryCode,
      'countryName': countryName,
      'state': state,
      'city': city,
      'county': county,
      'street': street,
      'featureName': featureName,
      'postalCode': postalCode,
      'phone': phone,
      'url': url,
      'extraInfo': extraInfo,
      'coordinateType': coordinateType,
    };
  }

  factory HWLocation.fromMap(Map<dynamic, dynamic>? map) {
    return HWLocation(
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
      countryCode: map?['countryCode'],
      countryName: map?['countryName'],
      state: map?['state'],
      city: map?['city'],
      county: map?['county'],
      street: map?['street'],
      featureName: map?['featureName'],
      postalCode: map?['postalCode'],
      phone: map?['phone'],
      url: map?['url'],
      coordinateType: map?['coordinateType'],
      extraInfo: Map<String, dynamic>.from(map?['extraInfo']),
    );
  }

  String toJson() => json.encode(toMap());

  factory HWLocation.fromJson(String source) =>
      HWLocation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HWLocation('
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
        'elapsedRealtimeNanos: $elapsedRealtimeNanos, '
        'countryCode: $countryCode, '
        'countryName: $countryName, '
        'state: $state, '
        'city: $city, '
        'county: $county, '
        'street: $street, '
        'featureName: $featureName, '
        'postalCode: $postalCode, '
        'phone: $phone, '
        'url: $url, '
        'extraInfo: $extraInfo, '
        'coordinateType: $coordinateType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is HWLocation &&
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
        other.elapsedRealtimeNanos == elapsedRealtimeNanos &&
        other.countryCode == countryCode &&
        other.countryName == countryName &&
        other.state == state &&
        other.city == city &&
        other.county == county &&
        other.street == street &&
        other.featureName == featureName &&
        other.postalCode == postalCode &&
        other.phone == phone &&
        other.url == url &&
        other.coordinateType == coordinateType &&
        mapEquals(other.extraInfo, extraInfo);
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
        countryCode,
        countryName,
        state,
        city,
        county,
        street,
        featureName,
        postalCode,
        phone,
        url,
        extraInfo,
        coordinateType,
      ],
    );
  }
}
