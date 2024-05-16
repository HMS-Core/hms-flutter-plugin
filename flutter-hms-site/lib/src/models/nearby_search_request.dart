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

class NearbySearchRequest {
  int? pageSize;
  int? pageIndex;
  String? query;
  Coordinate location;
  int? radius;
  LocationType? poiType;
  String? language;
  HwLocationType? hwPoiType;
  bool? strictBounds;

  NearbySearchRequest({
    this.pageSize,
    this.pageIndex,
    this.query,
    required this.location,
    this.radius,
    this.poiType,
    this.language,
    this.hwPoiType,
    this.strictBounds,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pageSize': pageSize,
      'pageIndex': pageIndex,
      'query': query,
      'location': location.toMap(),
      'radius': radius,
      'poiType': poiType?.toString(),
      'language': language,
      'hwPoiType': hwPoiType?.toString(),
      'strictBounds': strictBounds,
    };
  }

  factory NearbySearchRequest.fromMap(Map<dynamic, dynamic> map) {
    return NearbySearchRequest(
      pageSize: map['pageSize'],
      pageIndex: map['pageIndex'],
      query: map['query'],
      location: map['location'] != null
          ? Coordinate.fromMap(map['location'])
          : throw ('A location object must be provided.'),
      radius: map['radius'],
      poiType: map['poiType'] != null
          ? LocationType.fromString(map['poiType'])
          : null,
      language: map['language'],
      hwPoiType: map['hwPoiType'] != null
          ? HwLocationType.fromString(map['hwPoiType'])
          : null,
      strictBounds: map['strictBounds'],
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory NearbySearchRequest.fromJson(String source) {
    return NearbySearchRequest.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return '$NearbySearchRequest('
        'pageSize: $pageSize, '
        'pageIndex: $pageIndex, '
        'query: $query, location: $location, '
        'radius: $radius, '
        'poiType: $poiType, '
        'language: $language, '
        'hwPoiType: $hwPoiType, '
        'strictBounds: $strictBounds)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NearbySearchRequest &&
        other.pageSize == pageSize &&
        other.pageIndex == pageIndex &&
        other.query == query &&
        other.location == location &&
        other.radius == radius &&
        other.poiType == poiType &&
        other.language == language &&
        other.hwPoiType == hwPoiType &&
        other.strictBounds == strictBounds;
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
