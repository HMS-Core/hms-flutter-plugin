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
    return <String, dynamic>{
      'siteId': siteId,
      'language': language,
      'children': children,
    };
  }

  factory DetailSearchRequest.fromMap(Map<dynamic, dynamic> map) {
    final String? siteId = map['siteId'];
    if (siteId == null) {
      throw ('A siteId must be provided.');
    }
    return DetailSearchRequest(
      siteId: siteId,
      language: map['language'],
      children: map['children'],
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory DetailSearchRequest.fromJson(String source) {
    return DetailSearchRequest.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return '$DetailSearchRequest('
        'siteId: $siteId, '
        'language: $language, '
        'children: $children)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DetailSearchRequest &&
        other.siteId == siteId &&
        other.language == language &&
        other.children == children;
  }

  @override
  int get hashCode {
    return siteId.hashCode ^ language.hashCode ^ children.hashCode;
  }
}
