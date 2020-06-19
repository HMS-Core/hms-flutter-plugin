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

class LocationAvailability {
  int cellStatus;
  int wifiStatus;
  int elapsedRealtimeNs;
  int locationStatus;

  LocationAvailability({
    this.cellStatus,
    this.wifiStatus,
    this.elapsedRealtimeNs,
    this.locationStatus,
  });

  bool get isLocationAvailable => locationStatus < 1000;

  Map<String, dynamic> toMap() {
    return {
      'cellStatus': cellStatus,
      'wifiStatus': wifiStatus,
      'elapsedRealtimeNs': elapsedRealtimeNs,
      'locationStatus': locationStatus,
    };
  }

  factory LocationAvailability.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    return LocationAvailability(
      cellStatus: map['cellStatus'],
      wifiStatus: map['wifiStatus'],
      elapsedRealtimeNs: map['elapsedRealtimeNs'],
      locationStatus: map['locationStatus'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationAvailability.fromJson(String source) =>
      LocationAvailability.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LocationAvailability(cellStatus: $cellStatus, wifiStatus: $wifiStatus, elapsedRealtimeNs: $elapsedRealtimeNs, locationStatus: $locationStatus)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LocationAvailability &&
        o.cellStatus == cellStatus &&
        o.wifiStatus == wifiStatus &&
        o.elapsedRealtimeNs == elapsedRealtimeNs &&
        o.locationStatus == locationStatus;
  }

  @override
  int get hashCode {
    return hashList([
      cellStatus,
      wifiStatus,
      elapsedRealtimeNs,
      locationStatus,
    ]);
  }
}
