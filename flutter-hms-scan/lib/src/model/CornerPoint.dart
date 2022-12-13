/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_scan;

class CornerPoint {
  CornerPoint({
    this.x,
    this.y,
  });

  int? x;
  int? y;

  factory CornerPoint.fromJson(String str) {
    return CornerPoint.fromMap(json.decode(str));
  }

  factory CornerPoint.fromMap(Map<String, dynamic> json) {
    return CornerPoint(
      x: json['x']?.round(),
      y: json['y']?.round(),
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'x': x,
      'y': y,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is CornerPoint && other.x == x && other.y == y;
  }

  @override
  int get hashCode {
    return hashValues(
      x,
      y,
    );
  }
}
