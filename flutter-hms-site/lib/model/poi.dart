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

import 'package:flutter/foundation.dart';

import 'children_node.dart';
import 'opening_hours.dart';

class Poi {
  String internationalPhone;
  OpeningHours openingHours;
  String phone;
  List<String> photoUrls;
  List<String> poiTypes;
  List<String> hwPoiTypes;
  double rating;
  String websiteUrl;
  int priceLevel;
  String businessStatus;
  List<ChildrenNode> childrenNodes;

  Poi({
    this.internationalPhone,
    this.openingHours,
    this.phone,
    this.photoUrls,
    this.poiTypes,
    this.hwPoiTypes,
    double rating,
    this.websiteUrl,
    int priceLevel,
    this.businessStatus,
    this.childrenNodes,
  })  : rating = rating ?? 0,
        priceLevel = priceLevel ?? -1;

  Map<String, dynamic> toMap() {
    return {
      'internationalPhone': internationalPhone,
      'openingHours': openingHours?.toMap(),
      'phone': phone,
      'photoUrls': photoUrls,
      'poiTypes': poiTypes,
      'hwPoiTypes': hwPoiTypes,
      'rating': rating,
      'websiteUrl': websiteUrl,
      'priceLevel': priceLevel,
      'businessStatus': businessStatus,
      'childrenNodes': childrenNodes,
    };
  }

  factory Poi.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Poi(
      internationalPhone:
          map["internationalPhone"] == null ? null : map["internationalPhone"],
      openingHours: map["openingHours"] == null
          ? null
          : OpeningHours.fromMap(map["openingHours"]),
      phone: map["phone"] == null ? null : map["phone"],
      photoUrls: map["photoUrls"] == null
          ? null
          : List<String>.from(map["photoUrls"].map((x) => x)),
      poiTypes: map["poiTypes"] == null
          ? null
          : List<String>.from(map["poiTypes"].map((x) => x)),
      hwPoiTypes: map["hwPoiTypes"] == null
          ? null
          : List<String>.from(map["hwPoiTypes"].map((x) => x)),
      rating: map["rating"] == null ? null : map["rating"].toDouble(),
      websiteUrl: map["websiteUrl"] == null ? null : map["websiteUrl"],
      priceLevel: map["priceLevel"] == null ? null : map["priceLevel"],
      businessStatus:
          map["businessStatus"] == null ? null : map["businessStatus"],
      childrenNodes: map["childrenNodes"] == null
          ? null
          : List<ChildrenNode>.from(
              map["childrenNodes"].map((x) => ChildrenNode.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Poi.fromJson(String source) => Poi.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Poi(internationalPhone: $internationalPhone, openingHours: '
        '$openingHours, phone: $phone, photoUrls: $photoUrls, poiTypes: '
        '$poiTypes, hwPoiTypes: $hwPoiTypes, rating: $rating, websiteUrl: $websiteUrl, priceLevel: $priceLevel, businessStatus: $businessStatus, childrenNodes: $childrenNodes)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Poi &&
        o.internationalPhone == internationalPhone &&
        o.openingHours == openingHours &&
        o.phone == phone &&
        listEquals(o.photoUrls, photoUrls) &&
        listEquals(o.poiTypes, poiTypes) &&
        listEquals(o.hwPoiTypes, hwPoiTypes) &&
        o.rating == rating &&
        o.websiteUrl == websiteUrl &&
        o.priceLevel == priceLevel &&
        o.businessStatus == businessStatus &&
        listEquals(o.childrenNodes, childrenNodes);
  }

  @override
  int get hashCode {
    return internationalPhone.hashCode ^
        openingHours.hashCode ^
        phone.hashCode ^
        photoUrls.hashCode ^
        poiTypes.hashCode ^
        hwPoiTypes.hashCode ^
        rating.hashCode ^
        websiteUrl.hashCode ^
        priceLevel.hashCode ^
        businessStatus.hashCode ^
        childrenNodes.hashCode;
  }
}
