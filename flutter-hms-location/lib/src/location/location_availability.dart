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

class LocationAvailability {
  /// Availability status code for cell-based location.
  int cellStatus;

  /// Availability status code for Wi-Fi-based location.
  int wifiStatus;

  /// Time elapsed since system boot, in nanoseconds.
  int elapsedRealtimeNs;

  /// Location status code.
  ///
  /// If the value is smaller than 1000, the device location is available.
  int locationStatus;

  LocationAvailability({
    required this.cellStatus,
    required this.wifiStatus,
    required this.elapsedRealtimeNs,
    required this.locationStatus,
  });

  /// Indicates if the location is available or not.
  bool get isLocationAvailable => locationStatus < 1000;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cellStatus': cellStatus,
      'wifiStatus': wifiStatus,
      'elapsedRealtimeNs': elapsedRealtimeNs,
      'locationStatus': locationStatus,
    };
  }

  factory LocationAvailability.fromMap(Map<dynamic, dynamic> map) {
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
    return 'LocationAvailability('
        'cellStatus: $cellStatus, '
        'wifiStatus: $wifiStatus, '
        'elapsedRealtimeNs: $elapsedRealtimeNs, '
        'locationStatus: $locationStatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is LocationAvailability &&
        other.cellStatus == cellStatus &&
        other.wifiStatus == wifiStatus &&
        other.elapsedRealtimeNs == elapsedRealtimeNs &&
        other.locationStatus == locationStatus;
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
        cellStatus,
        wifiStatus,
        elapsedRealtimeNs,
        locationStatus,
      ],
    );
  }
}
