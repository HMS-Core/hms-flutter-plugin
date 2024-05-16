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

class Site {
  String? siteId;
  String? name;
  String? formatAddress;
  AddressDetail? address;
  Coordinate? location;
  CoordinateBounds? viewport;
  double? distance;
  Poi? poi;
  AutoCompletePrediction? prediction;
  int utcOffset;

  Site({
    this.siteId,
    this.name,
    this.formatAddress,
    this.address,
    this.location,
    this.viewport,
    this.distance,
    this.poi,
    this.prediction,
    int? utcOffset,
  }) : utcOffset = utcOffset ?? 0;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'siteId': siteId,
      'name': name,
      'formatAddress': formatAddress,
      'address': address?.toMap(),
      'location': location?.toMap(),
      'viewport': viewport?.toMap(),
      'distance': distance,
      'poi': poi?.toMap(),
      'prediction': prediction?.toMap(),
      'utcOffset': utcOffset,
    };
  }

  factory Site.fromMap(Map<dynamic, dynamic> map) {
    return Site(
      address:
          map['address'] == null ? null : AddressDetail.fromMap(map['address']),
      distance: map['distance']?.toDouble(),
      formatAddress: map['formatAddress'],
      location:
          map['location'] != null ? Coordinate.fromMap(map['location']) : null,
      name: map['name'],
      poi: map['poi'] != null ? Poi.fromMap(map['poi']) : null,
      siteId: map['siteId'],
      viewport: map['viewport'] != null
          ? CoordinateBounds.fromMap(map['viewport'])
          : null,
      prediction: map['prediction'] != null
          ? AutoCompletePrediction.fromMap(map['prediction'])
          : null,
      utcOffset: map['utcOffset'],
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory Site.fromJson(String source) {
    return Site.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return '$Site('
        'siteId: $siteId, '
        'name: $name, '
        'formatAddress: $formatAddress, '
        'address: $address, '
        'location: $location, '
        'viewport: $viewport, '
        'distance: $distance, '
        'poi: $poi, '
        'prediction: $prediction, '
        'utcOffset: $utcOffset)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Site &&
        other.siteId == siteId &&
        other.name == name &&
        other.formatAddress == formatAddress &&
        other.address == address &&
        other.location == location &&
        other.viewport == viewport &&
        other.distance == distance &&
        other.poi == poi &&
        other.prediction == prediction &&
        other.utcOffset == utcOffset;
  }

  @override
  int get hashCode {
    return siteId.hashCode ^
        name.hashCode ^
        formatAddress.hashCode ^
        address.hashCode ^
        location.hashCode ^
        viewport.hashCode ^
        distance.hashCode ^
        poi.hashCode ^
        prediction.hashCode ^
        utcOffset.hashCode;
  }
}
