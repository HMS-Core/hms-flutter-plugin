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

class Poi {
  String? internationalPhone;
  OpeningHours? openingHours;
  String? phone;
  List<String>? photoUrls;
  List<String>? poiTypes;
  List<String>? hwPoiTypes;
  double rating;
  String? websiteUrl;
  int priceLevel;
  String? businessStatus;
  List<ChildrenNode>? childrenNodes;
  String? icon;

  Poi({
    this.internationalPhone,
    this.openingHours,
    this.phone,
    this.photoUrls,
    this.poiTypes,
    this.hwPoiTypes,
    double? rating,
    this.websiteUrl,
    int? priceLevel,
    this.businessStatus,
    this.childrenNodes,
    this.icon,
  })  : rating = rating ?? 0,
        priceLevel = priceLevel ?? -1;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
      'icon': icon,
    };
  }

  factory Poi.fromMap(Map<dynamic, dynamic> map) {
    return Poi(
      internationalPhone: map['internationalPhone'],
      openingHours: map['openingHours'] != null
          ? OpeningHours.fromMap(map['openingHours'])
          : null,
      phone: map['phone'],
      photoUrls: map['photoUrls'] != null
          ? List<String>.from(map['photoUrls'].map((dynamic x) => x))
          : null,
      poiTypes: map['poiTypes'] != null
          ? List<String>.from(map['poiTypes'].map((dynamic x) => x))
          : null,
      hwPoiTypes: map['hwPoiTypes'] != null
          ? List<String>.from(map['hwPoiTypes'].map((dynamic x) => x))
          : null,
      rating: map['rating']?.toDouble(),
      websiteUrl: map['websiteUrl'],
      priceLevel: map['priceLevel'],
      businessStatus: map['businessStatus'],
      childrenNodes: map['childrenNodes'] != null
          ? List<ChildrenNode>.from(
              map['childrenNodes'].map(
                (dynamic x) => ChildrenNode.fromMap(x),
              ),
            )
          : null,
      icon: map['icon'],
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory Poi.fromJson(String source) {
    return Poi.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return '$Poi('
        'internationalPhone: $internationalPhone, '
        'openingHours: $openingHours, '
        'phone: $phone, '
        'photoUrls: $photoUrls, '
        'poiTypes: $poiTypes, '
        'hwPoiTypes: $hwPoiTypes, '
        'rating: $rating, '
        'websiteUrl: $websiteUrl, '
        'priceLevel: $priceLevel, '
        'businessStatus: $businessStatus, '
        'childrenNodes: $childrenNodes, '
        'icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Poi &&
        other.internationalPhone == internationalPhone &&
        other.openingHours == openingHours &&
        other.phone == phone &&
        listEquals(other.photoUrls, photoUrls) &&
        listEquals(other.poiTypes, poiTypes) &&
        listEquals(other.hwPoiTypes, hwPoiTypes) &&
        other.rating == rating &&
        other.websiteUrl == websiteUrl &&
        other.priceLevel == priceLevel &&
        other.businessStatus == businessStatus &&
        listEquals(other.childrenNodes, childrenNodes) &&
        other.icon == icon;
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
        childrenNodes.hashCode ^
        icon.hashCode;
  }
}
