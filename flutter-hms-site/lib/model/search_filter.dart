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
import 'coordinate_bounds.dart';
import 'location_type.dart';

class SearchFilter {
  CoordinateBounds bounds;
  String countryCode;
  String language;
  Coordinate location;
  List<LocationType> poiType;
  String politicalView;
  String query;
  int radius;
  bool children;
  bool strictBounds;

  SearchFilter({
    this.bounds,
    this.countryCode,
    this.language,
    this.location,
    this.poiType,
    @deprecated String politicalView,
    this.query,
    this.radius,
    this.children,
    this.strictBounds,
  }) : politicalView = null;

  Map<String, dynamic> toMap() {
    return {
      'bounds': bounds?.toMap(),
      'countryCode': countryCode,
      'language': language,
      'location': location?.toMap(),
      'poiType': poiType?.map((t) => t?.toString())?.toList(),
      'politicalView': null,
      'query': query,
      'radius': radius,
      'children': children,
      'strictBounds': strictBounds,
    };
  }

  factory SearchFilter.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SearchFilter(
      bounds: map["bounds"] == null
          ? null
          : CoordinateBounds.fromMap(map["bounds"]),
      countryCode: map["countryCode"] == null ? null : map["countryCode"],
      language: map["language"] == null ? null : map["language"],
      location:
          map["location"] == null ? null : Coordinate.fromMap(map['location']),
      poiType: map["poiType"] == null
          ? null
          : List<LocationType>.from(
              map['poiType'].map((x) => LocationType.fromString(x))),
      query: map["query"] == null ? null : map["query"],
      radius: map["radius"] == null ? null : map["radius"],
      children: map["children"] == null ? null : map["children"],
      strictBounds: map["strictBounds"] == null ? null : map["strictBounds"],
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchFilter.fromJson(String source) =>
      SearchFilter.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SearchFilter(bounds: $bounds, countryCode: $countryCode, language: $language, location: $location, poiType: $poiType, politicalView: $politicalView, query: $query, radius: $radius, children: $children, strictBounds: $strictBounds) ';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SearchFilter &&
        o.bounds == bounds &&
        o.countryCode == countryCode &&
        o.language == language &&
        o.location == location &&
        listEquals(o.poiType, poiType) &&
        o.query == query &&
        o.radius == radius &&
        o.children == children &&
        o.strictBounds == strictBounds;
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
