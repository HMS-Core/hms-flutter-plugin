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

part of huawei_map;

class CameraPosition {
  final double bearing;
  final LatLng target;
  final double tilt;
  final double zoom;

  const CameraPosition({
    this.bearing = 0.0,
    required this.target,
    this.tilt = 0.0,
    this.zoom = 0.0,
  });

  dynamic toMap() {
    return <String, dynamic>{
      _Param.bearing: bearing,
      _Param.target: latLngToJson(target),
      _Param.tilt: tilt,
      _Param.zoom: zoom,
    };
  }

  static CameraPosition fromMap(dynamic json) {
    return CameraPosition(
      bearing: json[_Param.bearing],
      target: LatLng.fromJson(json[_Param.target]),
      tilt: json[_Param.tilt],
      zoom: json[_Param.zoom],
    );
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    return other is CameraPosition &&
        bearing == other.bearing &&
        target == other.target &&
        tilt == other.tilt &&
        zoom == other.zoom;
  }

  @override
  int get hashCode => Object.hash(bearing, target, tilt, zoom);
}
