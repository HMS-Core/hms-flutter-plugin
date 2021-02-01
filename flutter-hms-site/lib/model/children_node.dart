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

import 'coordinate.dart';

class ChildrenNode {
  String siteId;
  String name;
  String formatAddress;
  Coordinate location;
  List<String> hwPoiTypes;
  String domeAndInt;
  String depAndArr;

  ChildrenNode({
    this.siteId,
    this.name,
    this.formatAddress,
    this.location,
    this.hwPoiTypes,
    this.domeAndInt,
    this.depAndArr,
  });

  void resetChildrenInfo() {
    name = null;
    formatAddress = null;
    location = null;
    hwPoiTypes = null;
    domeAndInt = null;
    depAndArr = null;
  }

  Map<String, dynamic> toMap() {
    return {
      'siteId': siteId,
      'name': name,
      'formatAddress': formatAddress,
      'location': location?.toMap(),
      'hwPoiTypes': hwPoiTypes?.map((t) => t?.toString())?.toList(),
      'domeAndInt': domeAndInt,
      'depAndArr': depAndArr,
    };
  }

  factory ChildrenNode.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ChildrenNode(
      siteId: map["siteId"] == null ? null : map["siteId"],
      name: map["name"] == null ? null : map["name"],
      formatAddress: map["formatAddress"] == null ? null : map["formatAddress"],
      location:
          map["location"] == null ? null : Coordinate.fromMap(map["location"]),
      hwPoiTypes: List<String>.from(map['hwPoiTypes']?.map((x) => x?.toString)),
      domeAndInt: map["domeAndInt"] == null ? null : map["domeAndInt"],
      depAndArr: map["depAndArr"] == null ? null : map["depAndArr"],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChildrenNode.fromJson(String source) =>
      ChildrenNode.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChildrenNode(siteId: $siteId, name: $name, formatAddress: $formatAddress, location: $location, hwPoiTypes: $hwPoiTypes, domeAndInt: $domeAndInt, depAndArr: $depAndArr)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ChildrenNode &&
        o.siteId == siteId &&
        o.name == name &&
        o.formatAddress == formatAddress &&
        o.location == location &&
        listEquals(o.hwPoiTypes, hwPoiTypes) &&
        o.domeAndInt == domeAndInt &&
        o.depAndArr == depAndArr;
  }

  @override
  int get hashCode {
    return siteId.hashCode ^
        name.hashCode ^
        formatAddress.hashCode ^
        location.hashCode ^
        hwPoiTypes.hashCode ^
        domeAndInt.hashCode ^
        depAndArr.hashCode;
  }
}
