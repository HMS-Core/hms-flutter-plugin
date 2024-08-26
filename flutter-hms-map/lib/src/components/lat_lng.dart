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

/// Defines the [longitude] and [latitude], in degrees.
class LatLng {
  /// Latitude.
  ///
  /// The value ranges from –90 to 90.
  final double lat;

  /// Longitude.
  ///
  /// The value ranges from –180 to 180 (excluded).
  final double lng;

  /// Creates a [LatLng] object.
  const LatLng(double latitude, double longitude)
      : lat = (latitude < -90.0 ? -90.0 : (90.0 < latitude ? 90.0 : latitude)),
        lng = (longitude + 180.0) % 360.0 - 180.0;

  /// Creates a [LatLng] object from a map.
  static LatLng fromJson(dynamic json) {
    return LatLng(json[0], json[1]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    return other is LatLng && lat == other.lat && lng == other.lng;
  }

  @override
  int get hashCode => Object.hash(lat, lng);
}
