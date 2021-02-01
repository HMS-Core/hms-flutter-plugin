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

import 'address_detail.dart';
import 'auto_complete_prediction.dart';
import 'coordinate.dart';
import 'coordinate_bounds.dart';
import 'poi.dart';

class Site {
  String siteId;
  String name;
  String formatAddress;
  AddressDetail address;
  Coordinate location;
  CoordinateBounds viewport;
  double distance;
  Poi poi;
  AutoCompletePrediction prediction;
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
    int utcOffset,
  }) : utcOffset = utcOffset ?? 0;

  Map<String, dynamic> toMap() {
    return {
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

  factory Site.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Site(
      address:
          map["address"] == null ? null : AddressDetail.fromMap(map["address"]),
      distance: map["distance"] == null ? null : map["distance"].toDouble(),
      formatAddress: map["formatAddress"] == null ? null : map["formatAddress"],
      location:
          map["location"] == null ? null : Coordinate.fromMap(map["location"]),
      name: map["name"] == null ? null : map["name"],
      poi: map["poi"] == null ? null : Poi.fromMap(map["poi"]),
      siteId: map["siteId"] == null ? null : map["siteId"],
      viewport: map["viewport"] == null
          ? null
          : CoordinateBounds.fromMap(map["viewport"]),
      prediction: map["prediction"] == null
          ? null
          : AutoCompletePrediction.fromMap(map["prediction"]),
      utcOffset: map["utcOffset"] == null ? null : map["utcOffset"],
    );
  }

  String toJson() => json.encode(toMap());

  factory Site.fromJson(String source) => Site.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Site(siteId: $siteId, name: $name, formatAddress: $formatAddress, address: $address, location: $location, viewport: $viewport, distance: $distance, poi: $poi, prediction: $prediction, utcOffset: $utcOffset)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Site &&
        o.siteId == siteId &&
        o.name == name &&
        o.formatAddress == formatAddress &&
        o.address == address &&
        o.location == location &&
        o.viewport == viewport &&
        o.distance == distance &&
        o.poi == poi &&
        o.prediction == prediction &&
        o.utcOffset == utcOffset;
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
