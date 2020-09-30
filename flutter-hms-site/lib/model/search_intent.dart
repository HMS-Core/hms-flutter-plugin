/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'dart:convert';

import 'search_filter.dart';

class SearchIntent {
  String hint;
  SearchFilter filter;

  SearchIntent({
    this.hint,
    this.filter,
  });

  Map<String, dynamic> toMap() {
    return {
      'hint': hint,
      'filter': filter?.toMap(),
    };
  }

  factory SearchIntent.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SearchIntent(
      hint: map["hint"] == null ? null : map["hint"],
      filter:
          map["filter"] == null ? null : SearchFilter.fromMap(map["filter"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchIntent.fromJson(String source) =>
      SearchIntent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SearchIntent(hint: $hint, filter: $filter)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SearchIntent && o.hint == hint && o.filter == filter;
  }

  @override
  int get hashCode {
    return hint.hashCode ^ filter.hashCode;
  }
}
