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

import 'site.dart';

class TextSearchResponse {
  int? totalCount;
  List<Site?>? sites;

  TextSearchResponse({
    this.totalCount,
    this.sites,
  });

  Map<String, dynamic> toMap() {
    return {
      'totalCount': totalCount,
      'sites': sites?.map((x) => x?.toMap()).toList(),
    };
  }

  factory TextSearchResponse.fromMap(Map<String, dynamic> map) {
    return TextSearchResponse(
      totalCount: map["totalCount"] == null ? null : map["totalCount"],
      sites: map["sites"] == null
          ? null
          : List<Site>.from(map["sites"].map((x) => Site.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory TextSearchResponse.fromJson(String source) =>
      TextSearchResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'TextSearchResponse(totalCount: $totalCount, sites: $sites)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TextSearchResponse &&
        o.totalCount == totalCount &&
        listEquals(o.sites, sites);
  }

  @override
  int get hashCode => totalCount.hashCode ^ sites.hashCode;
}
