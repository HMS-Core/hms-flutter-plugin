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

import 'coordinate.dart';

class CoordinateBounds {
  Coordinate northeast;
  Coordinate southwest;

  CoordinateBounds({
    @required this.northeast,
    @required this.southwest,
  });

  Map<String, dynamic> toMap() {
    return {
      'northeast': northeast?.toMap(),
      'southwest': southwest?.toMap(),
    };
  }

  factory CoordinateBounds.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CoordinateBounds(
      northeast: map["northeast"] == null
          ? null
          : Coordinate.fromMap(map["northeast"]),
      southwest: map["southwest"] == null
          ? null
          : Coordinate.fromMap(map["southwest"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory CoordinateBounds.fromJson(String source) =>
      CoordinateBounds.fromMap(json.decode(source));

  @override
  String toString() =>
      'CoordinateBounds(northeast: $northeast, southwest: $southwest)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CoordinateBounds &&
        o.northeast == northeast &&
        o.southwest == southwest;
  }

  @override
  int get hashCode => northeast.hashCode ^ southwest.hashCode;
}
