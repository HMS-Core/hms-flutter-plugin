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

import '../location/location.dart';

class GeofenceData {
  int errorCode;
  int conversion;
  List<String> convertingGeofenceIdList;
  Location convertingLocation;

  GeofenceData({
    this.errorCode,
    this.conversion,
    this.convertingGeofenceIdList,
    this.convertingLocation,
  });

  Map<String, dynamic> toMap() {
    return {
      'errorCode': errorCode,
      'conversion': conversion,
      'convertingGeofenceIdList': convertingGeofenceIdList,
      'convertingLocation': convertingLocation?.toMap(),
    };
  }

  factory GeofenceData.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    return GeofenceData(
      errorCode: map['errorCode'],
      conversion: map['conversion'],
      convertingGeofenceIdList:
          List<String>.from(map['convertingGeofenceIdList']),
      convertingLocation: Location.fromMap(map['convertingLocation']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GeofenceData.fromJson(String source) =>
      GeofenceData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GeofenceData(errorCode: $errorCode, conversion: $conversion, convertingGeofenceIdList: $convertingGeofenceIdList, convertingLocation: $convertingLocation)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is GeofenceData &&
        o.errorCode == errorCode &&
        o.conversion == conversion &&
        listEquals(o.convertingGeofenceIdList, convertingGeofenceIdList) &&
        o.convertingLocation == convertingLocation;
  }

  @override
  int get hashCode {
    return hashList([
      errorCode,
      conversion,
      convertingGeofenceIdList,
      convertingLocation,
    ]);
  }
}
