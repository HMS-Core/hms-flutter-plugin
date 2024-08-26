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

class GeofenceData {
  /// Error code.
  int? errorCode;

  /// Geofence conversion type.
  int? conversion;

  /// List of unique IDs of converted geofences.
  List<String>? convertingGeofenceIdList;

  /// Location when a geofence is converted.
  Location? convertingLocation;

  GeofenceData({
    this.errorCode,
    this.conversion,
    this.convertingGeofenceIdList,
    this.convertingLocation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errorCode': errorCode,
      'conversion': conversion,
      'convertingGeofenceIdList': convertingGeofenceIdList,
      'convertingLocation': convertingLocation?.toMap(),
    };
  }

  factory GeofenceData.fromMap(Map<dynamic, dynamic> map) {
    return GeofenceData(
      errorCode: map['errorCode'],
      conversion: map['conversion'],
      convertingGeofenceIdList: map['convertingGeofenceIdList'] == null
          ? null
          : List<String>.from(map['convertingGeofenceIdList']),
      convertingLocation: Location.fromMap(map['convertingLocation']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GeofenceData.fromJson(String source) =>
      GeofenceData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GeofenceData('
        'errorCode: $errorCode, '
        'conversion: $conversion, '
        'convertingGeofenceIdList: $convertingGeofenceIdList, '
        'convertingLocation: $convertingLocation)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is GeofenceData &&
        other.errorCode == errorCode &&
        other.conversion == conversion &&
        listEquals(other.convertingGeofenceIdList, convertingGeofenceIdList) &&
        other.convertingLocation == convertingLocation;
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
        errorCode,
        conversion,
        convertingGeofenceIdList,
        convertingLocation,
      ],
    );
  }
}
