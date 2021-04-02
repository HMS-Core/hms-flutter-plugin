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

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';

class HWLocation {
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
  String countryCode;
  String countryName;
  String state;
  String city;
  String county;
  String street;
  String featureName;
  String postalCode;
  String phone;
  String url;
  Map<String, dynamic> extraInfo;

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
    };
  }

  factory HWLocation.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    return HWLocation(
        provider: map["provider"] == null ? null : map["provider"],
        latitude: map["latitude"] == null ? null : map["latitude"],
        longitude: map["longitude"] == null ? null : map["longitude"],
        altitude: map["altitude"] == null ? null : map["altitude"],
        speed: map["speed"] == null ? null : map["speed"],
        bearing: map["bearing"] == null ? null : map["bearing"],
        horizontalAccuracyMeters: map["horizontalAccuracyMeters"],
        verticalAccuracyMeters: map["verticalAccuracyMeters"] == null
            ? null
            : map["verticalAccuracyMeters"],
        speedAccuracyMetersPerSecond:
            map["speedAccuracyMetersPerSecond"] == null
                ? null
                : map["speedAccuracyMetersPerSecond"],
        bearingAccuracyDegrees: map["bearingAccuracyDegrees"] == null
            ? null
            : map["bearingAccuracyDegrees"],
        time: map["time"] == null ? null : map["time"],
        elapsedRealtimeNanos: map["elapsedRealtimeNanos"] == null
            ? null
            : map["elapsedRealtimeNanos"],
        countryCode: map["countryCode"] == null ? null : map["countryCode"],
        countryName: map["countryName"] == null ? null : map["countryName"],
        state: map["state"] == null ? null : map["state"],
        city: map["city"] == null ? null : map["city"],
        county: map["county"] == null ? null : map["county"],
        street: map["street"] == null ? null : map["street"],
        featureName: map["featureName"] == null ? null : map["featureName"],
        postalCode: map["postalCode"] == null ? null : map["postalCode"],
        phone: map["phone"] == null ? null : map["phone"],
        url: map["url"] == null ? null : map["url"],
        extraInfo:
            map["extraInfo"] == null ? null : Map.from(map["extraInfo"]));
  }

  String toJson() => json.encode(toMap());

  factory HWLocation.fromJson(String source) =>
      HWLocation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HWLocation(provider: $provider, latitude: $latitude, longitude: $longitude, altitude: $altitude, speed: $speed, bearing: $bearing, horizontalAccuracyMeters: $horizontalAccuracyMeters, verticalAccuracyMeters: $verticalAccuracyMeters, speedAccuracyMetersPerSecond: $speedAccuracyMetersPerSecond, bearingAccuracyDegrees: $bearingAccuracyDegrees, time: $time, elapsedRealtimeNanos: $elapsedRealtimeNanos, countryCode: $countryCode, countryName: $countryName, state: $state, city: $city, county: $county, street: $street, featureName: $featureName, postalCode: $postalCode, phone: $phone, url: $url, extraInfo: $extraInfo)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is HWLocation &&
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
        o.elapsedRealtimeNanos == elapsedRealtimeNanos &&
        o.countryCode == countryCode &&
        o.countryName == countryName &&
        o.state == state &&
        o.city == city &&
        o.county == county &&
        o.street == street &&
        o.featureName == featureName &&
        o.postalCode == postalCode &&
        o.phone == phone &&
        o.url == url &&
        mapEquals(o.extraInfo, extraInfo);
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
    ]);
  }
}
