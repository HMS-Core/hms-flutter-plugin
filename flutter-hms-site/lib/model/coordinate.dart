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

import 'package:flutter/foundation.dart';

class Coordinate {
  double lat;
  double lng;

  Coordinate({
    @required this.lat,
    @required this.lng,
  });

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  factory Coordinate.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Coordinate(
      lat: map["lat"] == null ? null : map["lat"].toDouble(),
      lng: map["lng"] == null ? null : map["lng"].toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Coordinate.fromJson(String source) =>
      Coordinate.fromMap(json.decode(source));

  @override
  String toString() => 'Coordinate(lat: $lat, lng: $lng)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Coordinate && o.lat == lat && o.lng == lng;
  }

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode;
}
