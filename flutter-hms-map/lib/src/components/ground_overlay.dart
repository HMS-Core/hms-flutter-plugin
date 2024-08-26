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

/// Defines an image on the map.
@immutable
class GroundOverlay {
  /// Unique Ground Overlay ID.
  final GroundOverlayId groundOverlayId;

  /// Bearing of a ground overlay, in degrees clockwise from north.
  final double bearing;

  /// Indicates whether a ground overlay is tappable.
  final bool clickable;

  /// Width of a ground overlay, in meters.
  final double width;

  /// Height of a ground overlay, in meters.
  final double height;

  /// Image of a ground overlay.
  final BitmapDescriptor imageDescriptor;

  /// Position of a ground overlay.
  final LatLng? position;

  /// Bounds of a ground overlay.
  final LatLngBounds? bounds;

  /// Anchor of a ground overlay.
  final Offset anchor;

  /// Transparency of a ground overlay.
  final double transparency;

  /// Indicates whether a ground overlay is visible.
  ///
  /// If the ground overlay is invisible, it will not be drawn but all other states will be preserved.
  final bool visible;

  /// Z-index of a ground overlay.
  ///
  /// The z-index indicates the overlapping order of a ground overlay.
  /// A ground overlay with a larger z-index overlaps that with a smaller z-index.
  /// Ground overlays with the same z-index overlap each other in a random order.
  final double zIndex;

  /// Function to be executed when a ground overlay is tapped.
  final VoidCallback? onClick;

  /// Creates a [GroundOverlay] object.
  const GroundOverlay({
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

  /// Copies a [GroundOverlay] object and updates the specified attributes.
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

  /// Clones a [GroundOverlay] object.
  GroundOverlay clone() => updateCopy();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    return other is GroundOverlay &&
        groundOverlayId == other.groundOverlayId &&
        bearing == other.bearing &&
        clickable == other.clickable &&
        width == other.width &&
        height == other.height &&
        imageDescriptor == other.imageDescriptor &&
        position == other.position &&
        bounds == other.bounds &&
        anchor == other.anchor &&
        transparency == other.transparency &&
        visible == other.visible &&
        zIndex == other.zIndex;
  }

  @override
  int get hashCode => groundOverlayId.hashCode;
}
