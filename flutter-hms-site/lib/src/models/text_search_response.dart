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

class TextSearchResponse {
  int? totalCount;
  List<Site?>? sites;

  TextSearchResponse({
    this.totalCount,
    this.sites,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalCount': totalCount,
      'sites': sites?.map((Site? x) => x?.toMap()).toList(),
    };
  }

  factory TextSearchResponse.fromMap(Map<dynamic, dynamic> map) {
    return TextSearchResponse(
      totalCount: map['totalCount'],
      sites: map['sites'] != null
          ? List<Site>.from(map['sites'].map((dynamic x) => Site.fromMap(x)))
          : null,
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory TextSearchResponse.fromJson(String source) {
    return TextSearchResponse.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return '$TextSearchResponse('
        'totalCount: $totalCount, '
        'sites: $sites)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TextSearchResponse &&
        other.totalCount == totalCount &&
        listEquals(other.sites, sites);
  }

  @override
  int get hashCode {
    return totalCount.hashCode ^ sites.hashCode;
  }
}
