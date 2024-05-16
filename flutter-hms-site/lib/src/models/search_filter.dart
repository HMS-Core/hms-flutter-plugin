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

class SearchFilter {
  CoordinateBounds? bounds;
  String? countryCode;
  String? language;
  Coordinate? location;
  List<LocationType>? poiType;
  String? query;
  int? radius;
  bool? children;
  bool? strictBounds;

  SearchFilter({
    this.bounds,
    this.countryCode,
    this.language,
    this.location,
    this.poiType,
    this.query,
    this.radius,
    this.children,
    this.strictBounds,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bounds': bounds?.toMap(),
      'countryCode': countryCode,
      'language': language,
      'location': location?.toMap(),
      'poiType': poiType?.map((LocationType t) => t.toString()).toList(),
      'query': query,
      'radius': radius,
      'children': children,
      'strictBounds': strictBounds,
    };
  }

  factory SearchFilter.fromMap(Map<dynamic, dynamic> map) {
    return SearchFilter(
      bounds: map['bounds'] != null
          ? CoordinateBounds.fromMap(map['bounds'])
          : null,
      countryCode: map['countryCode'],
      language: map['language'],
      location:
          map['location'] != null ? Coordinate.fromMap(map['location']) : null,
      poiType: map['poiType'] != null
          ? List<LocationType>.from(
              map['poiType'].map((dynamic x) => LocationType.fromString(x)))
          : null,
      query: map['query'],
      radius: map['radius'],
      children: map['children'],
      strictBounds: map['strictBounds'],
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory SearchFilter.fromJson(String source) {
    return SearchFilter.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return '$SearchFilter('
        'bounds: $bounds, '
        'countryCode: $countryCode, '
        'language: $language, '
        'location: $location, '
        'poiType: $poiType, '
        'query: $query, '
        'radius: $radius, '
        'children: $children, '
        'strictBounds: $strictBounds) ';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchFilter &&
        other.bounds == bounds &&
        other.countryCode == countryCode &&
        other.language == language &&
        other.location == location &&
        listEquals(other.poiType, poiType) &&
        other.query == query &&
        other.radius == radius &&
        other.children == children &&
        other.strictBounds == strictBounds;
  }

  @override
  int get hashCode {
    return bounds.hashCode ^
        countryCode.hashCode ^
        language.hashCode ^
        location.hashCode ^
        poiType.hashCode ^
        query.hashCode ^
        radius.hashCode ^
        children.hashCode ^
        strictBounds.hashCode;
  }
}
