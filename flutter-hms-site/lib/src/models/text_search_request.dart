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
    return <String, dynamic>{
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
      'countries': countries?.map((String t) => t.toString()).toList(),
    };
  }

  factory TextSearchRequest.fromMap(Map<dynamic, dynamic> map) {
    return TextSearchRequest(
      language: map['language'],
      query: map['query'] ?? (throw ('A query must be provided.')),
      location:
          map['location'] != null ? Coordinate.fromMap(map['location']) : null,
      radius: map['radius'],
      pageSize: map['pageSize'],
      poiType: map['poiType'] != null
          ? LocationType.fromString(map['poiType'])
          : null,
      hwPoiType: map['hwPoiType'] != null
          ? HwLocationType.fromString(map['hwPoiType'])
          : null,
      pageIndex: map['pageIndex'],
      countryCode: map['countryCode'],
      children: map['children'],
      countries: map['countries'] != null
          ? List<String>.from(map['countries']?.map((dynamic x) => x?.toString))
          : null,
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory TextSearchRequest.fromJson(String source) {
    return TextSearchRequest.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return '$TextSearchRequest('
        'language: $language, '
        'query: $query, '
        'location: $location, '
        'radius: $radius, '
        'pageSize: $pageSize, '
        'poiType: $poiType, '
        'hwPoiType: $hwPoiType, '
        'pageIndex: $pageIndex, '
        'countryCode: $countryCode, '
        'countries: $countries)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TextSearchRequest &&
        other.language == language &&
        other.query == query &&
        other.location == location &&
        other.radius == radius &&
        other.pageSize == pageSize &&
        other.poiType == poiType &&
        other.hwPoiType == hwPoiType &&
        other.pageIndex == pageIndex &&
        other.countryCode == countryCode &&
        other.children == children &&
        listEquals(other.countries, countries);
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
