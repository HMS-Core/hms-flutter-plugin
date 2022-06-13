/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'coordinate.dart';
import 'hwlocation_type.dart';
import 'location_type.dart';

class TextSearchRequest {
  String? language;
  String query;
  Coordinate? location;
  int? radius;
  int? pageSize;
  LocationType? poiType;
  HwLocationType? hwPoiType;
  int? pageIndex;
  String? countryCode;
  bool? children;
  List<String>? countries;

  TextSearchRequest({
    this.language,
    required this.query,
    this.location,
    this.radius,
    this.pageSize,
    this.poiType,
    this.hwPoiType,
    this.pageIndex,
    this.countryCode,
    this.children,
    this.countries,
  });

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
      'children': children,
      'countries': countries?.map((t) => t.toString()).toList(),
    };
  }

  factory TextSearchRequest.fromMap(Map<String, dynamic> map) {
    return TextSearchRequest(
      language: map['language'] == null ? null : map['language'],
      query: map['query'] == null
          ? throw ("A query must be provided.")
          : map['query'],
      location:
          map['location'] == null ? null : Coordinate.fromMap(map['location']),
      radius: map['radius'] == null ? null : map['radius'],
      pageSize: map['pageSize'] == null ? null : map['pageSize'],
      poiType: map['poiType'] == null
          ? null
          : LocationType.fromString(map['poiType']),
      hwPoiType: map['hwPoiType'] == null
          ? null
          : HwLocationType.fromString(map['hwPoiType']),
      pageIndex: map['pageIndex'] == null ? null : map['pageIndex'],
      countryCode: map['countryCode'] == null ? null : map['countryCode'],
      children: map['children'] == null ? null : map['children'],
      countries: map['countries'] == null
          ? null
          : List<String>.from(map['countries']?.map((x) => x?.toString)),
    );
  }

  String toJson() => json.encode(toMap());

  factory TextSearchRequest.fromJson(String source) =>
      TextSearchRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TextSearchRequest(language: $language, query: $query, location: '
        '$location, radius: $radius, pageSize: $pageSize, poiType: $poiType, '
        'hwPoiType: $hwPoiType, pageIndex: $pageIndex, countryCode: $countryCode, countries: $countries)';
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
        o.children == children &&
        listEquals(o.countries, countries);
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
        children.hashCode ^
        countries.hashCode;
  }
}
