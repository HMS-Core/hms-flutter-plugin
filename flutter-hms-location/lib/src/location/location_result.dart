/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

part of '../../huawei_location.dart';

class LocationResult {
  /// Available locations, which are sorted from oldest to newest.
  List<Location?>? locations;

  /// List of available locations sorted from oldest to newest, including
  /// the detailed address.
  List<HWLocation?>? hwLocations;

  /// Available location of the last request.
  Location? lastLocation;

  /// Available location of the last request, including the detailed address.
  HWLocation? lastHWLocation;

  LocationResult({
    this.locations,
    this.hwLocations,
    this.lastLocation,
    this.lastHWLocation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'locations': locations?.map((Location? x) => x?.toMap()).toList(),
      'hwLocations': hwLocations?.map((HWLocation? x) => x?.toMap()).toList(),
      'lastLocation': lastLocation?.toMap(),
      'lastHWLocation': lastHWLocation?.toMap(),
    };
  }

  factory LocationResult.fromMap(Map<dynamic, dynamic> map) {
    return LocationResult(
      locations: map['locations'] == null
          ? null
          : List<Location>.from(
              map['locations'].map((dynamic x) => Location.fromMap(x)),
            ),
      hwLocations: map['hwLocations'] == null
          ? null
          : List<HWLocation>.from(
              map['hwLocations'].map((dynamic x) => HWLocation.fromMap(x)),
            ),
      lastLocation: map['lastLocation'] == null
          ? null
          : Location.fromMap(map['lastLocation']),
      lastHWLocation: map['lastHWLocation'] == null
          ? null
          : HWLocation.fromMap(map['lastHWLocation']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationResult.fromJson(String source) =>
      LocationResult.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LocationResult('
        'locations: $locations, '
        'hwLocations: $hwLocations, '
        'lastLocation: $lastLocation, '
        'lastHWLocation: $lastHWLocation)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is LocationResult &&
        listEquals(other.locations, locations) &&
        listEquals(other.hwLocations, hwLocations) &&
        other.lastLocation == lastLocation &&
        other.lastHWLocation == lastHWLocation;
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
        locations,
        hwLocations,
        lastLocation,
        lastHWLocation,
      ],
    );
  }
}
