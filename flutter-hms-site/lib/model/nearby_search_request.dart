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

class NearbySearchRequest {
  int pageSize;
  int pageIndex;
  String query;
  Coordinate location;
  int radius;
  LocationType poiType;
  String language;
  String politicalView;
  HwLocationType hwPoiType;
  bool strictBounds;

  NearbySearchRequest({
    this.pageSize,
    this.pageIndex,
    this.query,
    this.location,
    this.radius,
    this.poiType,
    this.language,
    @deprecated String politicalView,
    this.hwPoiType,
    this.strictBounds,
  }) : politicalView = null;

  Map<String, dynamic> toMap() {
    return {
      'pageSize': pageSize,
      'pageIndex': pageIndex,
      'query': query,
      'location': location?.toMap(),
      'radius': radius,
      'poiType': poiType?.toString(),
      'language': language,
      'politicalView': null,
      'hwPoiType': hwPoiType?.toString(),
      'strictBounds': strictBounds,
    };
  }

  factory NearbySearchRequest.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return NearbySearchRequest(
      pageSize: map['pageSize'],
      pageIndex: map['pageIndex'],
      query: map['query'],
      location: Coordinate.fromMap(map['location']),
      radius: map['radius'],
      poiType: LocationType.fromString(map['poiType']),
      language: map['language'],
      hwPoiType: HwLocationType.fromString(map['hwPoiType']),
      strictBounds: map['strictBounds'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NearbySearchRequest.fromJson(String source) =>
      NearbySearchRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NearbySearchRequest(pageSize: $pageSize, pageIndex: $pageIndex, query: $query, location: $location, radius: $radius, poiType: $poiType, language: $language, politicalView: $politicalView, hwPoiType: $hwPoiType, strictBounds: $strictBounds)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NearbySearchRequest &&
        o.pageSize == pageSize &&
        o.pageIndex == pageIndex &&
        o.query == query &&
        o.location == location &&
        o.radius == radius &&
        o.poiType == poiType &&
        o.language == language &&
        o.hwPoiType == hwPoiType &&
        o.strictBounds == strictBounds;
  }

  @override
  int get hashCode {
    return pageSize.hashCode ^
        pageIndex.hashCode ^
        query.hashCode ^
        location.hashCode ^
        radius.hashCode ^
        poiType.hashCode ^
        language.hashCode ^
        hwPoiType.hashCode ^
        strictBounds.hashCode;
  }
}
