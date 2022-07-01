/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:huawei_map/constants/param.dart';
import 'package:huawei_map/utils/toJson.dart';
import 'package:huawei_map/components/components.dart';

class PointOfInterest {
  final LatLng? latLng;
  final String? name;
  final String? placeId;

  PointOfInterest({
    this.latLng,
    this.name,
    this.placeId,
  });

  dynamic toMap() => <String, dynamic>{
        Param.lat_lng: latLng == null ? null : latLngToJson(latLng!),
        Param.name: name,
        Param.placeId: placeId,
      };

  static PointOfInterest fromMap(Map<String, dynamic> map) {
    return PointOfInterest(
      latLng: map[Param.lat_lng] == null
          ? null
          : LatLng.fromJson(map[Param.lat_lng]),
      name: map[Param.name],
      placeId: map[Param.placeId],
    );
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is PointOfInterest &&
        this.latLng == other.latLng &&
        this.name == other.name &&
        this.placeId == other.placeId;
  }

  @override
  int get hashCode => Object.hash(latLng, name, placeId);
}
