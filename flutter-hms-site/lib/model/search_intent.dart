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

import 'search_filter.dart';

class SearchIntent {
  String hint;
  SearchFilter searchFilter;
  String apiKey;

  SearchIntent(
    this.apiKey, {
    this.hint,
    this.searchFilter,
  });

  Map<String, dynamic> toMap() {
    return {
      'hint': hint,
      'searchFilter': searchFilter?.toMap(),
      'apiKey': apiKey,
    };
  }

  factory SearchIntent.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SearchIntent(
      map['apiKey'] == null ? null : map['apiKey'],
      hint: map['hint'] == null ? null : map['hint'],
      searchFilter: map['searchFilter'] == null
          ? null
          : SearchFilter.fromMap(map['searchFilter']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchIntent.fromJson(String source) =>
      SearchIntent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SearchIntent(hint: $hint, searchFilter: $searchFilter, apiKey: ***)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SearchIntent &&
        o.hint == hint &&
        o.searchFilter == searchFilter &&
        o.apiKey == apiKey;
  }

  @override
  int get hashCode {
    return hint.hashCode ^ searchFilter.hashCode ^ apiKey.hashCode;
  }
}
