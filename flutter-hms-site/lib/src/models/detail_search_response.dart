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

class DetailSearchResponse {
  Site? site;

  DetailSearchResponse({
    this.site,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'site': site?.toMap(),
    };
  }

  factory DetailSearchResponse.fromMap(Map<dynamic, dynamic> map) {
    return DetailSearchResponse(
      site: map['site'] != null
          ? Site.fromMap(
              map['site'],
            )
          : null,
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory DetailSearchResponse.fromJson(String source) {
    return DetailSearchResponse.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return '$DetailSearchResponse('
        'site: $site)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DetailSearchResponse && other.site == site;
  }

  @override
  int get hashCode {
    return site.hashCode;
  }
}
