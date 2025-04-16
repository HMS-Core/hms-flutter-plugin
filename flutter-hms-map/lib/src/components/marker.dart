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

/// Defines an icon placed at a specified position on a map.
@immutable
class Marker {
  /// Unique marker ID.
  final MarkerId markerId;

  /// Position of a marker.
  final LatLng position;

  /// Information window of a marker.
  final InfoWindow infoWindow;

  /// Anchor point of a marker.
  final Offset anchor;

  /// Indicates whether a marker can be dragged.
  ///
  /// The options are `true` (yes) and `false` (no).
  final bool draggable;

  /// Indicates whether to flatly attach a marker to the map.
  ///
  /// If the marker is flatly attached to the map, it will stay on the map when the camera rotates or tilts.
  /// The marker will remain the same size when the camera zooms in or out.
  /// If the marker faces the camera, it will always be drawn facing the camera and rotates or tilts with the camera.
  final bool flat;

  /// Marker icon to render.
  final BitmapDescriptor icon;

  /// Rotation angle of a marker, in degrees.
  final double rotation;

  /// Opacity.
  ///
  /// The value ranges from `0` (completely transparent) to `1` (completely opaque).
  final double alpha;

  /// Indicates whether a marker is visible.
  ///
  /// The options are `true` (yes) and `false` (no).
  final bool visible;

  /// Z-index of a marker.
  ///
  /// The z-index indicates the overlapping order of a marker.
  /// A marker with a larger z-index overlaps that with a smaller z-index.
  /// Markers with the same z-index overlap each other in a random order.
  /// By default, the z-index is `0`.
  final double zIndex;

  /// Indicates whether a marker can be tapped.
  ///
  /// The options are `true` (yes) and `false` (no).
  final bool clickable;

  /// Indicates whether a marker is clusterable or not.
  final bool clusterable;

  /// Callback method executed when a marker is tapped.
  final VoidCallback? onClick;

  /// Callback method executed when marker dragging is finished.
  final ValueChanged<LatLng>? onDragEnd;

  /// Callback method executed when marker dragging is started.
  final ValueChanged<LatLng>? onDragStart;

  /// Callback method executed while marker is dragging.
  final ValueChanged<LatLng>? onDrag;

  /// Animations.
  final List<dynamic> animationSet;

  /// Creates a [Marker] object.
  const Marker({
    required this.markerId,
    required this.position,
    this.infoWindow = InfoWindow.noText,
    this.anchor = const Offset(0.5, 1.0),
    this.draggable = false,
    this.flat = false,
    this.icon = BitmapDescriptor.defaultMarker,
    this.rotation = 0.0,
    this.alpha = 1.0,
    this.visible = true,
    this.zIndex = 0.0,
    this.clickable = false,
    this.clusterable = false,
    this.onClick,
    this.onDragEnd,
    this.onDragStart,
    this.onDrag,
    this.animationSet = const <dynamic>[],
  });

  /// Copies a [Marker] object and updates the specified attributes.
  Marker updateCopy({
    LatLng? position,
    InfoWindow? infoWindow,
    Offset? anchor,
    bool? draggable,
    bool? flat,
    BitmapDescriptor? icon,
    double? rotation,
    double? alpha,
    bool? visible,
    double? zIndex,
    bool? clickable,
    bool? clusterable,
    VoidCallback? onClick,
    ValueChanged<LatLng>? onDragEnd,
    ValueChanged<LatLng>? onDragStart,
    ValueChanged<LatLng>? onDrag,
    List<dynamic>? animations,
  }) {
    return Marker(
      markerId: markerId,
      position: position ?? this.position,
      infoWindow: infoWindow ?? this.infoWindow,
      anchor: anchor ?? this.anchor,
      draggable: draggable ?? this.draggable,
      flat: flat ?? this.flat,
      icon: icon ?? this.icon,
      rotation: rotation ?? this.rotation,
      alpha: alpha ?? this.alpha,
      visible: visible ?? this.visible,
      zIndex: zIndex ?? this.zIndex,
      clickable: clickable ?? this.clickable,
      clusterable: clusterable ?? this.clusterable,
      onClick: onClick ?? this.onClick,
      onDragEnd: onDragEnd ?? this.onDragEnd,
      onDragStart: onDragStart ?? this.onDragStart,
      onDrag: onDrag ?? this.onDrag,
      animationSet: animations ?? animationSet,
    );
  }

  /// Clones a [Marker] object.
  Marker clone() => updateCopy();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    return other is Marker &&
        markerId == other.markerId &&
        position == other.position &&
        infoWindow == other.infoWindow &&
        anchor == other.anchor &&
        draggable == other.draggable &&
        flat == other.flat &&
        icon == other.icon &&
        rotation == other.rotation &&
        alpha == other.alpha &&
        visible == other.visible &&
        clickable == other.clickable &&
        clusterable == other.clusterable &&
        listEquals(animationSet, other.animationSet) &&
        zIndex == other.zIndex;
  }

  @override
  int get hashCode => markerId.hashCode;
}
