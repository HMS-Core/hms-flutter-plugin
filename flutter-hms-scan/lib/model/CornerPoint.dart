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

class CornerPoint {
  CornerPoint({
    this.x,
    this.y,
  });

  int x;
  int y;

  factory CornerPoint.fromJson(String str) =>
      CornerPoint.fromMap(json.decode(str));

  factory CornerPoint.fromMap(Map<String, dynamic> json) => CornerPoint(
        x: json["x"] == null ? null : json["x"].round(),
        y: json["y"] == null ? null : json["y"].round(),
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "x": x == null ? null : x,
        "y": y == null ? null : y,
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final CornerPoint check = o;
    return o is CornerPoint && check.x == x && check.y == y;
  }

  @override
  int get hashCode => hashValues(
        x,
        y,
      );
}
