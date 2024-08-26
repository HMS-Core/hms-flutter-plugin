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

part of '../../huawei_map.dart';

/// An object that contains attributes about a tapped POI.
class PointOfInterest {
  /// Position of a POI.
  final LatLng? latLng;

  /// Name of a POI.
  final String? name;

  /// ID of a POI.
  final String? placeId;

  /// Creates a [PointOfInterest] object.
  const PointOfInterest({
    this.latLng,
    this.name,
    this.placeId,
  });

  /// Creates a [PointOfInterest] object from a map.
  static PointOfInterest fromMap(Map<String, dynamic> map) {
    return PointOfInterest(
      latLng: map[_Param.latLng] == null
          ? null
          : LatLng.fromJson(map[_Param.latLng]),
      name: map[_Param.name],
      placeId: map[_Param.placeId],
    );
  }

  dynamic toMap() {
    return <String, dynamic>{
      _Param.latLng: latLng == null ? null : latLngToJson(latLng!),
      _Param.name: name,
      _Param.placeId: placeId,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    return other is PointOfInterest &&
        latLng == other.latLng &&
        name == other.name &&
        placeId == other.placeId;
  }

  @override
  int get hashCode => Object.hash(latLng, name, placeId);
}
