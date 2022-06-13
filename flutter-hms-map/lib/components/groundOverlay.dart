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

import 'package:flutter/material.dart';

import 'package:huawei_map/components/components.dart';

@immutable
class GroundOverlay {
  final GroundOverlayId groundOverlayId;
  final double bearing;
  final bool clickable;
  final double width;
  final double height;
  final BitmapDescriptor imageDescriptor;
  final LatLng? position;
  final LatLngBounds? bounds;
  final Offset anchor;
  final double transparency;
  final bool visible;
  final double zIndex;

  final VoidCallback? onClick;

  GroundOverlay({
    required this.groundOverlayId,
    required this.width,
    required this.height,
    required this.imageDescriptor,
    this.position,
    this.bearing = 0.0,
    this.clickable = false,
    this.bounds,
    this.anchor = const Offset(0.5, 1.0),
    this.transparency = 0.0,
    this.visible = true,
    this.zIndex = 0.0,
    this.onClick,
  });

  GroundOverlay updateCopy({
    double? bearing,
    bool? clickable,
    double? width,
    double? height,
    BitmapDescriptor? imageDescriptor,
    LatLng? position,
    LatLngBounds? bounds,
    Offset? anchor,
    double? transparency,
    bool? visible,
    double? zIndex,
    VoidCallback? onClick,
  }) {
    return GroundOverlay(
      groundOverlayId: groundOverlayId,
      bearing: bearing ?? this.bearing,
      clickable: clickable ?? this.clickable,
      width: width ?? this.width,
      height: height ?? this.height,
      imageDescriptor: imageDescriptor ?? this.imageDescriptor,
      position: position ?? this.position,
      bounds: bounds ?? this.bounds,
      anchor: anchor ?? this.anchor,
      transparency: transparency ?? this.transparency,
      visible: visible ?? this.visible,
      zIndex: zIndex ?? this.zIndex,
      onClick: onClick ?? this.onClick,
    );
  }

  GroundOverlay clone() => updateCopy();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is GroundOverlay &&
        this.groundOverlayId == other.groundOverlayId &&
        this.bearing == other.bearing &&
        this.clickable == other.clickable &&
        this.width == other.width &&
        this.height == other.height &&
        this.imageDescriptor == other.imageDescriptor &&
        this.position == other.position &&
        this.bounds == other.bounds &&
        this.anchor == other.anchor &&
        this.transparency == other.transparency &&
        this.visible == other.visible &&
        this.zIndex == other.zIndex;
  }

  @override
  int get hashCode => groundOverlayId.hashCode;
}
