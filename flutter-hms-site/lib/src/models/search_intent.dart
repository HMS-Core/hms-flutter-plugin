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

class SearchIntent {
  String? hint;
  SearchFilter? searchFilter;
  String apiKey;

  SearchIntent(
    this.apiKey, {
    this.hint,
    this.searchFilter,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hint': hint,
      'searchFilter': searchFilter?.toMap(),
      'apiKey': apiKey,
    };
  }

  factory SearchIntent.fromMap(Map<dynamic, dynamic> map) {
    return SearchIntent(
      map['apiKey'],
      hint: map['hint'],
      searchFilter: map['searchFilter'] != null
          ? SearchFilter.fromMap(map['searchFilter'])
          : null,
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory SearchIntent.fromJson(String source) {
    return SearchIntent.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return '$SearchIntent('
        'hint: $hint, '
        'searchFilter: $searchFilter, '
        'apiKey: ***)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchIntent &&
        other.hint == hint &&
        other.searchFilter == searchFilter &&
        other.apiKey == apiKey;
  }

  @override
  int get hashCode {
    return hint.hashCode ^ searchFilter.hashCode ^ apiKey.hashCode;
  }
}
