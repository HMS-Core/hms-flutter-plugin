/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

class MetadataLocation {
  double altitude;
  double latitude;
  double longitude;

  MetadataLocation({
    this.altitude,
    this.latitude,
    this.longitude,
  });

  MetadataLocation clone({
    double altitude,
    double latitude,
    double longitude,
  }) {
    return MetadataLocation(
      altitude: altitude ?? this.altitude,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'altitude': altitude,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory MetadataLocation.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MetadataLocation(
      altitude: map['altitude'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MetadataLocation.fromJson(String source) =>
      MetadataLocation.fromMap(json.decode(source));

  @override
  String toString() =>
      'MetadataLocation(altitude: $altitude, latitude: $latitude, longitude: $longitude)';
}
