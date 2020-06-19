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

import 'hwlocation.dart' show HWLocation;
import 'location.dart' show Location;

class LocationResult {
  List<Location> locations;
  List<HWLocation> hwLocations;
  Location lastLocation;
  HWLocation lastHWLocation;

  LocationResult({
    this.locations,
    this.hwLocations,
    this.lastLocation,
    this.lastHWLocation,
  });

  Map<String, dynamic> toMap() {
    return {
      'locations': locations?.map((x) => x?.toMap())?.toList(),
      'hwLocations': hwLocations?.map((x) => x?.toMap())?.toList(),
      'lastLocation': lastLocation?.toMap(),
      'lastHWLocation': lastHWLocation?.toMap(),
    };
  }

  factory LocationResult.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    return LocationResult(
      locations: map["locations"] == null
          ? null
          : List<Location>.from(
              map["locations"].map((x) => Location.fromMap(x))),
      hwLocations: map["hwLocations"] == null
          ? null
          : List<HWLocation>.from(
              map["hwLocations"].map((x) => HWLocation.fromMap(x))),
      lastLocation: map["lastLocation"] == null
          ? null
          : Location.fromMap(map["lastLocation"]),
      lastHWLocation: map["lastHWLocation"] == null
          ? null
          : HWLocation.fromMap(map["lastHWLocation"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationResult.fromJson(String source) =>
      LocationResult.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LocationResult(locations: $locations, hwLocations: $hwLocations, lastLocation: $lastLocation, lastHWLocation: $lastHWLocation)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LocationResult &&
        listEquals(o.locations, locations) &&
        listEquals(o.hwLocations, hwLocations) &&
        o.lastLocation == lastLocation &&
        o.lastHWLocation == lastHWLocation;
  }

  @override
  int get hashCode {
    return hashList([
      locations,
      hwLocations,
      lastLocation,
      lastHWLocation,
    ]);
  }
}
