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

class GeofenceRequest {
  /// Triggered immediately when a request is initiated to add the geofence
  /// where a user device has already entered.
  static const int ENTER_INIT_CONVERSION = 1;

  /// Triggered immediately when a request is initiated to add the geofence
  /// where a user device has already exited.
  static const int EXIT_INIT_CONVERSION = 2;

  /// Triggered immediately when a request is initiated to add the geofence
  /// where a user device has already entered and stayed for the specified
  /// duration.
  static const int DWELL_INIT_CONVERSION = 4;

  /// WGS_84 coordinate system.
  static const int COORDINATE_TYPE_WGS_84 = 1;

  /// GCJ-02 coordinate system.
  static const int COORDINATE_TYPE_GCJ_02 = 0;

  /// List of geofences to be monitored.
  List<Geofence?>? geofenceList;

  /// Initial conversion type.
  ///
  /// The **bitwise-OR** operation is supported. This parameter is invalid if it
  /// is set to `0`.
  int? initConversions;

  /// Geofence coordinate type.
  int? coordinateType;

  GeofenceRequest({
    this.geofenceList,
    this.initConversions = ENTER_INIT_CONVERSION | DWELL_INIT_CONVERSION,
    this.coordinateType = COORDINATE_TYPE_WGS_84,
  }) {
    geofenceList ??= <Geofence>[];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'geofenceList': geofenceList?.map((dynamic x) => x?.toMap()).toList(),
      'initConversions': initConversions,
      'coordinateType': coordinateType,
    };
  }

  factory GeofenceRequest.fromMap(Map<dynamic, dynamic> map) {
    return GeofenceRequest(
      geofenceList: List<Geofence>.from(
        map['geofenceList']?.map(
          (dynamic x) => Geofence.fromMap(x),
        ),
      ),
      initConversions: map['initConversions'],
      coordinateType: map['coordinateType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GeofenceRequest.fromJson(String source) =>
      GeofenceRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GeofenceRequest('
        'geofenceList: $geofenceList, '
        'initConversions: $initConversions, '
        'coordinateType: $coordinateType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is GeofenceRequest &&
        listEquals(other.geofenceList, geofenceList) &&
        other.initConversions == initConversions &&
        other.coordinateType == coordinateType;
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
        geofenceList,
        initConversions,
        coordinateType,
      ],
    );
  }
}
