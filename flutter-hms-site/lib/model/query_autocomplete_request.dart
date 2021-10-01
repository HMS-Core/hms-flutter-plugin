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

import 'coordinate.dart';

class QueryAutocompleteRequest {
  String query;
  Coordinate? location;
  int? radius;
  String? language;
  bool children;

  QueryAutocompleteRequest({
    required this.query,
    this.location,
    this.radius,
    this.language,
    bool? children,
  }) : children = children ?? false;

  Map<String, dynamic> toMap() {
    return {
      'query': query,
      'location': location?.toMap(),
      'radius': radius,
      'language': language,
      'children': children,
    };
  }

  factory QueryAutocompleteRequest.fromMap(Map<String, dynamic> map) {
    return QueryAutocompleteRequest(
      query: map['query'] == null
          ? throw ("A query must be provided.")
          : map['query'],
      location:
          map['location'] == null ? null : Coordinate.fromMap(map['location']),
      radius: map['radius'] == null ? null : map['radius'],
      language: map['language'] == null ? null : map['language'],
      children: map['children'] == null ? null : map['children'],
    );
  }

  String toJson() => json.encode(toMap());

  factory QueryAutocompleteRequest.fromJson(String source) =>
      QueryAutocompleteRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'QueryAutocompleteRequest(query: $query, location: $location, radius: $radius, language: $language, children: $children)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is QueryAutocompleteRequest &&
        o.query == query &&
        o.location == location &&
        o.radius == radius &&
        o.language == language &&
        o.children == children;
  }

  @override
  int get hashCode {
    return query.hashCode ^
        location.hashCode ^
        radius.hashCode ^
        language.hashCode ^
        children.hashCode;
  }
}
