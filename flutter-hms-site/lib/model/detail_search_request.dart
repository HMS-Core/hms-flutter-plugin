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

class DetailSearchRequest {
  String siteId;
  String? language;
  bool? children;

  DetailSearchRequest({
    required this.siteId,
    this.language,
    this.children,
  });

  Map<String, dynamic> toMap() {
    return {
      'siteId': siteId,
      'language': language,
      'children': children,
    };
  }

  factory DetailSearchRequest.fromMap(Map<String, dynamic> map) {
    return DetailSearchRequest(
      siteId: map['siteId'] == null
          ? throw ("A siteId must be provided.")
          : map['siteId'],
      language: map['language'] == null ? null : map['language'],
      children: map['children'] == null ? null : map['children'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailSearchRequest.fromJson(String source) =>
      DetailSearchRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'DetailSearchRequest(siteId: $siteId, language: $language, children: $children)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DetailSearchRequest &&
        o.siteId == siteId &&
        o.language == language &&
        o.children == children;
  }

  @override
  int get hashCode => siteId.hashCode ^ language.hashCode ^ children.hashCode;
}
