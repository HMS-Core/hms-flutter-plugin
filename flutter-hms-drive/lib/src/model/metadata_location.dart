/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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
  double? altitude;
  double? latitude;
  double? longitude;

  MetadataLocation({
    this.altitude,
    this.latitude,
    this.longitude,
  });

  factory MetadataLocation.fromMap(Map<String, dynamic> map) {
    return MetadataLocation(
      altitude: map['altitude'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  factory MetadataLocation.fromJson(String source) =>
      MetadataLocation.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'altitude': altitude,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'MetadataLocation(altitude: $altitude, latitude: $latitude, longitude: $longitude)';
}
