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

/// A tile overlay is a set of images to be displayed on a map.
///
/// It can be transparent and enable you to add new functions to an existing map.
@immutable
class TileOverlay {
  /// Unique Tile Overlay ID.
  final TileOverlayId tileOverlayId;

  /// Indicates whether a tile overlay fades in.
  final bool? fadeIn;

  /// Transparency of a tile overlay.
  final double? transparency;

  /// Indicates whether a tile overlay is visible.
  ///
  /// If the tile overlay is invisible, it will not be drawn but all other states will be preserved.
  /// By default, a tile overlay is visible.
  final bool? visible;

  /// Z-index of a tile overlay.
  ///
  /// The z-index indicates the overlapping order of a tile overlay.
  /// A tile overlay with a larger z-index overlaps that with a smaller z-index.
  /// Tile overlays with the same z-index overlap each other in a random order.
  final double? zIndex;

  /// Provider of a tile overlay.
  final dynamic tileProvider;

  /// Creates a [TileOverlay] object.
  const TileOverlay({
    required this.tileOverlayId,
    required this.tileProvider,
    this.fadeIn,
    this.transparency,
    this.visible,
    this.zIndex,
  });

  /// Copies a [TileOverlay] object and updates the specified attributes.
  TileOverlay updateCopy({
    dynamic tileProvider,
    bool? fadeIn,
    double? transparency,
    bool? visible,
    double? zIndex,
  }) {
    return TileOverlay(
      tileOverlayId: tileOverlayId,
      tileProvider: tileProvider ?? this.tileProvider,
      fadeIn: fadeIn ?? this.fadeIn,
      transparency: transparency ?? this.transparency,
      visible: visible ?? this.visible,
      zIndex: zIndex ?? this.zIndex,
    );
  }

  /// Clones a [TileOverlay] object.
  TileOverlay clone() => updateCopy();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    return other is TileOverlay &&
        tileOverlayId == other.tileOverlayId &&
        (tileProvider is List
            ? listEquals(tileProvider, other.tileProvider)
            : tileProvider == other.tileProvider) &&
        fadeIn == other.fadeIn &&
        transparency == other.transparency &&
        visible == other.visible &&
        zIndex == other.zIndex;
  }

  @override
  int get hashCode => tileOverlayId.hashCode;
}
