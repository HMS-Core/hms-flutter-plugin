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

import 'dart:ui' show Offset;

import 'package:huawei_map/constants/param.dart';
import 'package:huawei_map/components/components.dart';
import 'package:huawei_map/utils/toJson.dart';

class CameraUpdate {
  final dynamic _json;

  CameraUpdate._(this._json);

  static CameraUpdate newLatLng(LatLng latLng) {
    return CameraUpdate._(<dynamic>[Param.newLatLng, latLngToJson(latLng)]);
  }

  static CameraUpdate zoomIn() {
    return CameraUpdate._(<dynamic>[Param.zoomIn]);
  }

  static CameraUpdate zoomOut() {
    return CameraUpdate._(<dynamic>[Param.zoomOut]);
  }

  static CameraUpdate zoomTo(double zoom) {
    return CameraUpdate._(<dynamic>[Param.zoomTo, zoom]);
  }

  static CameraUpdate zoomBy(double amount, [Offset? focus]) {
    return focus == null
        ? CameraUpdate._(<dynamic>[Param.zoomBy, amount])
        : CameraUpdate._(<dynamic>[
            Param.zoomBy,
            amount,
            <double>[focus.dx, focus.dy],
          ]);
  }

  static CameraUpdate newLatLngBounds(LatLngBounds bounds, double padding) {
    return CameraUpdate._(<dynamic>[
      Param.newLatLngBounds,
      latLngBoundsToJson(bounds),
      padding,
    ]);
  }

  static CameraUpdate newLatLngZoom(LatLng latLng, double zoom) {
    return CameraUpdate._(
      <dynamic>[Param.newLatLngZoom, latLngToJson(latLng), zoom],
    );
  }

  static CameraUpdate newCameraPosition(CameraPosition cameraPosition) {
    return CameraUpdate._(
      <dynamic>[Param.newCameraPosition, cameraPosition.toMap()],
    );
  }

  static CameraUpdate scrollBy(double dx, double dy) {
    return CameraUpdate._(
      <dynamic>[Param.scrollBy, dx, dy],
    );
  }

  dynamic toJson() => _json;
}
