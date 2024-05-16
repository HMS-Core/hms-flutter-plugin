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

class CoordinateBounds {
  Coordinate? northeast;
  Coordinate? southwest;

  CoordinateBounds({
    this.northeast,
    this.southwest,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'northeast': northeast?.toMap(),
      'southwest': southwest?.toMap(),
    };
  }

  factory CoordinateBounds.fromMap(Map<dynamic, dynamic> map) {
    return CoordinateBounds(
      northeast: map['northeast'] != null
          ? Coordinate.fromMap(map['northeast'])
          : null,
      southwest: map['southwest'] != null
          ? Coordinate.fromMap(map['southwest'])
          : null,
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory CoordinateBounds.fromJson(String source) {
    return CoordinateBounds.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return '$Coordinate('
        'northeast: $northeast, '
        'southwest: $southwest)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CoordinateBounds &&
        other.northeast == northeast &&
        other.southwest == southwest;
  }

  @override
  int get hashCode {
    return northeast.hashCode ^ southwest.hashCode;
  }
}
