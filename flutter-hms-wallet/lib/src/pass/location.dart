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

class Location {
  final String longitude;
  final String latitude;
  Location({
    this.longitude,
    this.latitude,
  });

  Location copyWith({
    String latitude,
    String longitude,
  }) {
    return Location(
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Location(
      longitude: map['longitude'],
      latitude: map['latitude'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source));

  @override
  String toString() => 'Location(longitude: $longitude, latitude: $latitude)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Location && o.longitude == longitude && o.latitude == latitude;
  }

  @override
  int get hashCode => longitude.hashCode ^ latitude.hashCode;
}
