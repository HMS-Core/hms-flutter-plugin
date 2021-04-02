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

class QuerySuggestionRequest {
  String query;
  Coordinate location;
  int radius;
  CoordinateBounds bounds;
  List<LocationType> poiTypes;
  String countryCode;
  String language;
  String politicalView;
  bool children;
  bool strictBounds;

  QuerySuggestionRequest({
    this.query,
    this.location,
    this.radius,
    this.bounds,
    this.poiTypes,
    this.countryCode,
    this.language,
    @deprecated String politicalView,
    this.children,
    this.strictBounds,
  }) : politicalView = null;

  Map<String, dynamic> toMap() {
    return {
      'query': query,
      'location': location?.toMap(),
      'radius': radius,
      'bounds': bounds?.toMap(),
      'poiTypes': poiTypes?.map((t) => t?.toString())?.toList(),
      'countryCode': countryCode,
      'language': language,
      'politicalView': null,
      'children': children,
      'strictBounds': strictBounds,
    };
  }

  factory QuerySuggestionRequest.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return QuerySuggestionRequest(
      query: map['query'],
      location: Coordinate.fromMap(map['location']),
      radius: map['radius'],
      bounds: CoordinateBounds.fromMap(map['bounds']),
      poiTypes: List<LocationType>.from(
          map['poiTypes']?.map((x) => LocationType.fromString(x))),
      countryCode: map['countryCode'],
      language: map['language'],
      children: map['children'],
      strictBounds: map['strictBounds'],
    );
  }

  String toJson() => json.encode(toMap());

  factory QuerySuggestionRequest.fromJson(String source) =>
      QuerySuggestionRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'QuerySuggestionRequest(query: $query, location: $location, radius: $radius, bounds: $bounds, poiTypes: $poiTypes, countryCode: $countryCode, language: $language, politicalView: $politicalView, children: $children, strictBounds: $strictBounds)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is QuerySuggestionRequest &&
        o.query == query &&
        o.location == location &&
        o.radius == radius &&
        o.bounds == bounds &&
        listEquals(o.poiTypes, poiTypes) &&
        o.countryCode == countryCode &&
        o.language == language &&
        o.children == children &&
        o.strictBounds == strictBounds;
  }

  @override
  int get hashCode {
    return query.hashCode ^
        location.hashCode ^
        radius.hashCode ^
        bounds.hashCode ^
        poiTypes.hashCode ^
        countryCode.hashCode ^
        language.hashCode ^
        children.hashCode ^
        strictBounds.hashCode;
  }
}
