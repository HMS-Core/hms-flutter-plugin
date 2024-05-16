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
    return <String, dynamic>{
      'query': query,
      'location': location?.toMap(),
      'radius': radius,
      'language': language,
      'children': children,
    };
  }

  factory QueryAutocompleteRequest.fromMap(Map<dynamic, dynamic> map) {
    return QueryAutocompleteRequest(
      query: map['query'] ?? (throw ('A query must be provided.')),
      location:
          map['location'] != null ? Coordinate.fromMap(map['location']) : null,
      radius: map['radius'],
      language: map['language'],
      children: map['children'],
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory QueryAutocompleteRequest.fromJson(String source) {
    return QueryAutocompleteRequest.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return '$QueryAutocompleteRequest('
        'query: $query, '
        'location: $location, '
        'radius: $radius, '
        'language: $language, '
        'children: $children)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QueryAutocompleteRequest &&
        other.query == query &&
        other.location == location &&
        other.radius == radius &&
        other.language == language &&
        other.children == children;
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
