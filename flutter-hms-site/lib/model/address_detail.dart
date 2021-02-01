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

class AddressDetail {
  String countryCode;
  String country;
  String adminArea;
  String subAdminArea;
  String locality;
  String subLocality;
  String thoroughfare;
  String postalCode;
  String streetNumber;
  String tertiaryAdminArea;

  AddressDetail({
    this.countryCode,
    this.country,
    this.adminArea,
    this.subAdminArea,
    this.locality,
    this.subLocality,
    this.thoroughfare,
    this.postalCode,
    this.streetNumber,
    this.tertiaryAdminArea,
  });

  Map<String, dynamic> toMap() {
    return {
      'countryCode': countryCode,
      'country': country,
      'adminArea': adminArea,
      'subAdminArea': subAdminArea,
      'locality': locality,
      'subLocality': subLocality,
      'thoroughfare': thoroughfare,
      'postalCode': postalCode,
      'streetNumber': streetNumber,
      'tertiaryAdminArea': tertiaryAdminArea,
    };
  }

  factory AddressDetail.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AddressDetail(
      adminArea: map["adminArea"] == null ? null : map["adminArea"],
      country: map["country"] == null ? null : map["country"],
      countryCode: map["countryCode"] == null ? null : map["countryCode"],
      locality: map["locality"] == null ? null : map["locality"],
      subAdminArea: map["subAdminArea"] == null ? null : map["subAdminArea"],
      subLocality: map["subLocality"] == null ? null : map["subLocality"],
      thoroughfare: map["thoroughfare"] == null ? null : map["thoroughfare"],
      postalCode: map["postalCode"] == null ? null : map["postalCode"],
      streetNumber: map["streetNumber"] == null ? null : map["streetNumber"],
      tertiaryAdminArea:
          map["tertiaryAdminArea"] == null ? null : map["tertiaryAdminArea"],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressDetail.fromJson(String source) =>
      AddressDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddressDetail(countryCode: $countryCode, country: $country, adminArea: $adminArea, subAdminArea: $subAdminArea, locality: $locality, subLocality: $subLocality, thoroughfare: $thoroughfare, postalCode: $postalCode, streetNumber: $streetNumber, tertiaryAdminArea: $tertiaryAdminArea)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AddressDetail &&
        o.countryCode == countryCode &&
        o.country == country &&
        o.adminArea == adminArea &&
        o.subAdminArea == subAdminArea &&
        o.locality == locality &&
        o.subLocality == subLocality &&
        o.thoroughfare == thoroughfare &&
        o.postalCode == postalCode &&
        o.streetNumber == streetNumber &&
        o.tertiaryAdminArea == tertiaryAdminArea;
  }

  @override
  int get hashCode {
    return countryCode.hashCode ^
        country.hashCode ^
        adminArea.hashCode ^
        subAdminArea.hashCode ^
        locality.hashCode ^
        subLocality.hashCode ^
        thoroughfare.hashCode ^
        postalCode.hashCode ^
        streetNumber.hashCode ^
        tertiaryAdminArea.hashCode;
  }
}
