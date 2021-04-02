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

import 'coordinate.dart';
import 'hwlocation_type.dart';
import 'location_type.dart';

class TextSearchRequest {
  String language;
  String query;
  Coordinate location;
  int radius;
  int pageSize;
  LocationType poiType;
  HwLocationType hwPoiType;
  int pageIndex;
  String countryCode;
  String politicalView;
  bool children;

  TextSearchRequest({
    this.language,
    this.query,
    this.location,
    this.radius,
    this.pageSize,
    this.poiType,
    this.hwPoiType,
    this.pageIndex,
    this.countryCode,
    @deprecated String politicalView,
    this.children,
  }) : politicalView = null;

  Map<String, dynamic> toMap() {
    return {
      'language': language,
      'query': query,
      'location': location?.toMap(),
      'radius': radius,
      'pageSize': pageSize,
      'poiType': poiType?.toString(),
      'hwPoiType': hwPoiType?.toString(),
      'pageIndex': pageIndex,
      'countryCode': countryCode,
      'politicalView': null,
      'children': children,
    };
  }

  factory TextSearchRequest.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TextSearchRequest(
      language: map['language'],
      query: map['query'],
      location: Coordinate.fromMap(map['location']),
      radius: map['radius'],
      pageSize: map['pageSize'],
      poiType: LocationType.fromString(map['poiType']),
      hwPoiType: HwLocationType.fromString(map['hwPoiType']),
      pageIndex: map['pageIndex'],
      countryCode: map['countryCode'],
      children: map['children'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TextSearchRequest.fromJson(String source) =>
      TextSearchRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TextSearchRequest(language: $language, query: $query, location: '
        '$location, radius: $radius, pageSize: $pageSize, poiType: $poiType, '
        'hwPoiType: $hwPoiType, pageIndex: $pageIndex, countryCode: $countryCode, politicalView: $politicalView)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TextSearchRequest &&
        o.language == language &&
        o.query == query &&
        o.location == location &&
        o.radius == radius &&
        o.pageSize == pageSize &&
        o.poiType == poiType &&
        o.hwPoiType == hwPoiType &&
        o.pageIndex == pageIndex &&
        o.countryCode == countryCode &&
        o.children == children;
  }

  @override
  int get hashCode {
    return language.hashCode ^
        query.hashCode ^
        location.hashCode ^
        radius.hashCode ^
        pageSize.hashCode ^
        poiType.hashCode ^
        hwPoiType.hashCode ^
        pageIndex.hashCode ^
        countryCode.hashCode ^
        children.hashCode;
  }
}
