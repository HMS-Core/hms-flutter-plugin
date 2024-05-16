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

part of huawei_site;

class Coordinate {
  double? lat;
  double? lng;

  Coordinate({
    this.lat,
    this.lng,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lng': lng,
    };
  }

  factory Coordinate.fromMap(Map<dynamic, dynamic> map) {
    return Coordinate(
      lat: map['lat']?.toDouble(),
      lng: map['lng']?.toDouble(),
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory Coordinate.fromJson(String source) {
    return Coordinate.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return '$Coordinate('
        'lat: $lat, '
        'lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Coordinate && other.lat == lat && other.lng == lng;
  }

  @override
  int get hashCode {
    return lat.hashCode ^ lng.hashCode;
  }
}
