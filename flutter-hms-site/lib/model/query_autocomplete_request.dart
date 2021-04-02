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
  Coordinate location;
  int radius;
  String language;
  String politicalView;
  bool children;

  QueryAutocompleteRequest({
    this.query,
    this.location,
    this.radius,
    this.language,
    @deprecated String politicalView,
    bool children,
  }) : politicalView = null;

  Map<String, dynamic> toMap() {
    return {
      'query': query,
      'location': location?.toMap(),
      'radius': radius,
      'language': language,
      'politicalView': null,
      'children': children,
    };
  }

  factory QueryAutocompleteRequest.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return QueryAutocompleteRequest(
      query: map['query'],
      location: Coordinate.fromMap(map['location']),
      radius: map['radius'],
      language: map['language'],
      children: map['children'],
    );
  }

  String toJson() => json.encode(toMap());

  factory QueryAutocompleteRequest.fromJson(String source) =>
      QueryAutocompleteRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'QueryAutocompleteRequest(query: $query, location: $location, radius: $radius, language: $language, politicalView: $politicalView, children: $children)';
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
