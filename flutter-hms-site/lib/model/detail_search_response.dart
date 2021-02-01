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

import 'site.dart';

class DetailSearchResponse {
  Site site;

  DetailSearchResponse({
    this.site,
  });

  Map<String, dynamic> toMap() {
    return {
      'site': site?.toMap(),
    };
  }

  factory DetailSearchResponse.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DetailSearchResponse(
      site: map["site"] == null ? null : Site.fromMap(map["site"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailSearchResponse.fromJson(String source) =>
      DetailSearchResponse.fromMap(json.decode(source));

  @override
  String toString() => 'DetailSearchResponse(site: $site)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DetailSearchResponse && o.site == site;
  }

  @override
  int get hashCode => site.hashCode;
}
