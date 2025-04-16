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

/// Provides various constructors for creating [CameraUpdate] objects that modify the camera of a map.
class CameraUpdate {
  final dynamic _json;

  CameraUpdate._(this._json);

  /// Creates a [CameraUpdate] object pointed to a specific coordinate (latitude and longitude).
  static CameraUpdate newLatLng(LatLng latLng) {
    return CameraUpdate._(<dynamic>[_Param.newLatLng, latLngToJson(latLng)]);
  }

  /// Creates a [CameraUpdate] object that zooms the camera in.
  static CameraUpdate zoomIn() {
    return CameraUpdate._(<dynamic>[_Param.zoomIn]);
  }

  /// Creates a [CameraUpdate] object that zooms the camera out.
  static CameraUpdate zoomOut() {
    return CameraUpdate._(<dynamic>[_Param.zoomOut]);
  }

  /// Creates a [CameraUpdate] object that sets the camera zoom level.
  static CameraUpdate zoomTo(double zoom) {
    return CameraUpdate._(<dynamic>[_Param.zoomTo, zoom]);
  }

  /// Creates a [CameraUpdate] object that modifies the camera zoom level by the specified amount.
  static CameraUpdate zoomBy(double amount, [Offset? focus]) {
    return focus == null
        ? CameraUpdate._(<dynamic>[_Param.zoomBy, amount])
        : CameraUpdate._(<dynamic>[
            _Param.zoomBy,
            amount,
            <double>[focus.dx, focus.dy],
          ]);
  }

  /// Creates a [CameraUpdate] object pointed to specific bounds and padding.
  static CameraUpdate newLatLngBounds(LatLngBounds bounds, double padding) {
    return CameraUpdate._(<dynamic>[
      _Param.newLatLngBounds,
      latLngBoundsToJson(bounds),
      padding,
    ]);
  }

  /// Creates a [CameraUpdate] object pointed to a specific coordinate (latitude and longitude) and zoom level.
  static CameraUpdate newLatLngZoom(LatLng latLng, double zoom) {
    return CameraUpdate._(
      <dynamic>[_Param.newLatLngZoom, latLngToJson(latLng), zoom],
    );
  }

  /// Creates a [CameraUpdate] object using the CameraPosition object.
  static CameraUpdate newCameraPosition(CameraPosition cameraPosition) {
    return CameraUpdate._(
      <dynamic>[_Param.newCameraPosition, cameraPosition.toMap()],
    );
  }

  /// Creates a [CameraUpdate] object that moves the camera by the specified distance on the screen.
  static CameraUpdate scrollBy(double dx, double dy) {
    return CameraUpdate._(<dynamic>[_Param.scrollBy, dx, dy]);
  }

  dynamic toJson() => _json;
}
