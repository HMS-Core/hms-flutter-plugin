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
    return <String, dynamic>{
      'query': query,
      'location': location?.toMap(),
      'radius': radius,
      'bounds': bounds?.toMap(),
      'poiTypes': poiTypes?.map((LocationType t) => t.toString()).toList(),
      'countryCode': countryCode,
      'language': language,
      'children': children,
      'strictBounds': strictBounds,
      'countries': countries?.map((String t) => t.toString()).toList(),
    };
  }

  factory QuerySuggestionRequest.fromMap(Map<dynamic, dynamic> map) {
    return QuerySuggestionRequest(
      query: map['query'] ?? (throw ('A query must be provided.')),
      location:
          map['location'] != null ? Coordinate.fromMap(map['location']) : null,
      radius: map['radius'],
      bounds: map['bounds'] == null
          ? null
          : CoordinateBounds.fromMap(map['bounds']),
      poiTypes: map['poiTypes'] != null
          ? List<LocationType>.from(
              map['poiTypes']?.map((dynamic x) => LocationType.fromString(x)),
            )
          : null,
      countryCode: map['countryCode'],
      language: map['language'],
      children: map['children'],
      strictBounds: map['strictBounds'],
      countries: map['countries'] != null
          ? List<String>.from(map['countries']?.map((dynamic x) => x?.toString))
          : null,
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory QuerySuggestionRequest.fromJson(String source) {
    return QuerySuggestionRequest.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return '$QuerySuggestionRequest('
        'query: $query, '
        'location: $location, '
        'radius: $radius, '
        'bounds: $bounds, '
        'poiTypes: $poiTypes, '
        'countryCode: $countryCode, '
        'language: $language, '
        'children: $children, '
        'strictBounds: $strictBounds, '
        'countries: $countries)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuerySuggestionRequest &&
        other.query == query &&
        other.location == location &&
        other.radius == radius &&
        other.bounds == bounds &&
        listEquals(other.poiTypes, poiTypes) &&
        other.countryCode == countryCode &&
        other.language == language &&
        other.children == children &&
        other.strictBounds == strictBounds &&
        listEquals(other.countries, countries);
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
