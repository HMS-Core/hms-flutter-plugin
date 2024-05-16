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

class ChildrenNode {
  String? siteId;
  String? name;
  String? formatAddress;
  Coordinate? location;
  List<String>? hwPoiTypes;
  String? domeAndInt;
  String? depAndArr;

  ChildrenNode({
    this.siteId,
    this.name,
    this.formatAddress,
    this.location,
    this.hwPoiTypes,
    this.domeAndInt,
    this.depAndArr,
  });

  factory ChildrenNode.fromMap(Map<dynamic, dynamic> map) {
    return ChildrenNode(
      siteId: map['siteId'],
      name: map['name'],
      formatAddress: map['formatAddress'],
      location: map['location'] != null
          ? Coordinate.fromMap(
              map['location'],
            )
          : null,
      hwPoiTypes: List<String>.from(
        map['hwPoiTypes']?.map(
          (dynamic x) => x?.toString,
        ),
      ),
      domeAndInt: map['domeAndInt'],
      depAndArr: map['depAndArr'],
    );
  }

  void resetChildrenInfo() {
    name = null;
    formatAddress = null;
    location = null;
    hwPoiTypes = null;
    domeAndInt = null;
    depAndArr = null;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'siteId': siteId,
      'name': name,
      'formatAddress': formatAddress,
      'location': location?.toMap(),
      'hwPoiTypes': hwPoiTypes?.map((String t) => t.toString()).toList(),
      'domeAndInt': domeAndInt,
      'depAndArr': depAndArr,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory ChildrenNode.fromJson(String source) {
    return ChildrenNode.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return '$ChildrenNode('
        'siteId: $siteId, '
        'name: $name, '
        'formatAddress: $formatAddress, '
        'location: $location, '
        'hwPoiTypes: $hwPoiTypes, '
        'domeAndInt: $domeAndInt, '
        'depAndArr: $depAndArr)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChildrenNode &&
        other.siteId == siteId &&
        other.name == name &&
        other.formatAddress == formatAddress &&
        other.location == location &&
        listEquals(other.hwPoiTypes, hwPoiTypes) &&
        other.domeAndInt == domeAndInt &&
        other.depAndArr == depAndArr;
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
