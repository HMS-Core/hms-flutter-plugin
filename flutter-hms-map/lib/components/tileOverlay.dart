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

import 'package:flutter/foundation.dart' show listEquals, immutable;

import 'package:huawei_map/components/components.dart';

@immutable
class TileOverlay {
  final TileOverlayId tileOverlayId;
  final bool? fadeIn;
  final double? transparency;
  final bool? visible;
  final double? zIndex;
  final dynamic tileProvider;

  TileOverlay({
    required this.tileOverlayId,
    required this.tileProvider,
    this.fadeIn,
    this.transparency,
    this.visible,
    this.zIndex,
  });

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

  TileOverlay clone() => updateCopy();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is TileOverlay &&
        this.tileOverlayId == other.tileOverlayId &&
        (this.tileProvider is List
            ? listEquals(this.tileProvider, other.tileProvider)
            : this.tileProvider == other.tileProvider) &&
        this.fadeIn == other.fadeIn &&
        this.transparency == other.transparency &&
        this.visible == other.visible &&
        this.zIndex == other.zIndex;
  }

  @override
  int get hashCode => tileOverlayId.hashCode;
}
