/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_map;

class LatLngBounds {
  final LatLng southwest;
  final LatLng northeast;

  const LatLngBounds({
    required this.southwest,
    required this.northeast,
  });

  static LatLngBounds fromList(dynamic json) {
    return LatLngBounds(
      southwest: LatLng.fromJson(json[0]),
      northeast: LatLng.fromJson(json[1]),
    );
  }

  bool contains(LatLng point) {
    return _containsLatitude(point.lat) && _containsLongitude(point.lng);
  }

  bool _containsLatitude(double lat) {
    return (southwest.lat <= lat) && (lat <= northeast.lat);
  }

  bool _containsLongitude(double lng) {
    if (southwest.lng <= northeast.lng) {
      return southwest.lng <= lng && lng <= northeast.lng;
    } else {
      return southwest.lng <= lng || lng <= northeast.lng;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    return other is LatLngBounds &&
        southwest == other.southwest &&
        northeast == other.northeast;
  }

  @override
  int get hashCode => Object.hash(southwest, northeast);
}
