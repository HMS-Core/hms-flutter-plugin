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

class AddressDetail {
  String? countryCode;
  String? country;
  String? adminArea;
  String? subAdminArea;
  String? locality;
  String? subLocality;
  String? thoroughfare;
  String? postalCode;
  String? streetNumber;
  String? tertiaryAdminArea;

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

  factory AddressDetail.fromMap(Map<dynamic, dynamic> map) {
    return AddressDetail(
      adminArea: map['adminArea'],
      country: map['country'],
      countryCode: map['countryCode'],
      locality: map['locality'],
      subAdminArea: map['subAdminArea'],
      subLocality: map['subLocality'],
      thoroughfare: map['thoroughfare'],
      postalCode: map['postalCode'],
      streetNumber: map['streetNumber'],
      tertiaryAdminArea: map['tertiaryAdminArea'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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

  String toJson() {
    return json.encode(toMap());
  }

  factory AddressDetail.fromJson(String source) {
    return AddressDetail.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return '$AddressDetail('
        'countryCode: $countryCode, '
        'country: $country, '
        'adminArea: $adminArea, '
        'subAdminArea: $subAdminArea, '
        'locality: $locality, '
        'subLocality: $subLocality, '
        'thoroughfare: $thoroughfare, '
        'postalCode: $postalCode, '
        'streetNumber: $streetNumber, '
        'tertiaryAdminArea: $tertiaryAdminArea)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressDetail &&
        other.countryCode == countryCode &&
        other.country == country &&
        other.adminArea == adminArea &&
        other.subAdminArea == subAdminArea &&
        other.locality == locality &&
        other.subLocality == subLocality &&
        other.thoroughfare == thoroughfare &&
        other.postalCode == postalCode &&
        other.streetNumber == streetNumber &&
        other.tertiaryAdminArea == tertiaryAdminArea;
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
