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

import 'dart:convert' show json;
import 'dart:ui' show hashValues;

class LocationCoordinate {
  LocationCoordinate({this.latitude, this.longitude});

  double latitude;
  double longitude;

  factory LocationCoordinate.fromJson(String str) =>
      LocationCoordinate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LocationCoordinate.fromMap(Map<String, dynamic> json) =>
      LocationCoordinate(
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
      );

  Map<String, dynamic> toMap() => {
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final LocationCoordinate check = o;
    return o is LocationCoordinate &&
        check.latitude == latitude &&
        check.longitude == longitude;
  }

  @override
  int get hashCode => hashValues(latitude, longitude);
}
