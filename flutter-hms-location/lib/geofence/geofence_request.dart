/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'geofence.dart';

class GeofenceRequest {
  static const int ENTER_INIT_CONVERSION = 1;
  static const int EXIT_INIT_CONVERSION = 2;
  static const int DWELL_INIT_CONVERSION = 4;
  static const int COORDINATE_TYPE_WGS_84 = 1;
  static const int COORDINATE_TYPE_GCJ_02 = 0;

  List<Geofence> geofenceList;
  int initConversions;
  int coordinateType;

  GeofenceRequest({
    this.geofenceList,
    this.initConversions = ENTER_INIT_CONVERSION | DWELL_INIT_CONVERSION,
    this.coordinateType = COORDINATE_TYPE_WGS_84,
  }) {
    if (this.geofenceList == null) {
      this.geofenceList = <Geofence>[];
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'geofenceList': geofenceList?.map((x) => x?.toMap())?.toList(),
      'initConversions': initConversions,
      'coordinateType': coordinateType,
    };
  }

  factory GeofenceRequest.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    return GeofenceRequest(
      geofenceList: List<Geofence>.from(
          map['geofenceList']?.map((x) => Geofence.fromMap(x))),
      initConversions: map['initConversions'],
      coordinateType: map['coordinateType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GeofenceRequest.fromJson(String source) =>
      GeofenceRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'GeofenceRequest(geofenceList: $geofenceList, initConversions: $initConversions, coordinateType: $coordinateType)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is GeofenceRequest &&
        listEquals(o.geofenceList, geofenceList) &&
        o.initConversions == initConversions &&
        o.coordinateType == coordinateType;
  }

  @override
  int get hashCode {
    return hashList([
      geofenceList,
      initConversions,
      coordinateType,
    ]);
  }
}
