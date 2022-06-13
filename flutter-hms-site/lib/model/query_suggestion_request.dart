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

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'coordinate.dart';
import 'coordinate_bounds.dart';
import 'location_type.dart';

class QuerySuggestionRequest {
  String query;
  Coordinate? location;
  int? radius;
  CoordinateBounds? bounds;
  List<LocationType>? poiTypes;
  String? countryCode;
  String? language;
  bool? children;
  bool? strictBounds;
  List<String>? countries;

  QuerySuggestionRequest({
    required this.query,
    this.location,
    this.radius,
    this.bounds,
    this.poiTypes,
    this.countryCode,
    this.language,
    this.children,
    this.strictBounds,
    this.countries,
  });

  Map<String, dynamic> toMap() {
    return {
      'query': query,
      'location': location?.toMap(),
      'radius': radius,
      'bounds': bounds?.toMap(),
      'poiTypes': poiTypes?.map((t) => t.toString()).toList(),
      'countryCode': countryCode,
      'language': language,
      'children': children,
      'strictBounds': strictBounds,
      'countries': countries?.map((t) => t.toString()).toList(),
    };
  }

  factory QuerySuggestionRequest.fromMap(Map<String, dynamic> map) {
    return QuerySuggestionRequest(
      query: map['query'] == null
          ? throw ("A query must be provided.")
          : map['query'],
      location:
          map['location'] == null ? null : Coordinate.fromMap(map['location']),
      radius: map['radius'] == null ? null : map['radius'],
      bounds: map['bounds'] == null
          ? null
          : CoordinateBounds.fromMap(map['bounds']),
      poiTypes: map['poiTypes'] == null
          ? null
          : List<LocationType>.from(
              map['poiTypes']?.map((x) => LocationType.fromString(x))),
      countryCode: map['countryCode'] == null ? null : map['countryCode'],
      language: map['language'] == null ? null : map['language'],
      children: map['children'] == null ? null : map['children'],
      strictBounds: map['strictBounds'] == null ? null : map['strictBounds'],
      countries: map['countries'] == null
          ? null
          : List<String>.from(map['countries']?.map((x) => x?.toString)),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuerySuggestionRequest.fromJson(String source) =>
      QuerySuggestionRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'QuerySuggestionRequest(query: $query, location: $location, radius: $radius, bounds: $bounds, poiTypes: $poiTypes, countryCode: $countryCode, language: $language, children: $children, strictBounds: $strictBounds, countries: $countries)';
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
        o.strictBounds == strictBounds &&
        listEquals(o.countries, countries);
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
        strictBounds.hashCode ^
        countries.hashCode;
  }
}
