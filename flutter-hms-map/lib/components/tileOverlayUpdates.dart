/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'dart:ui' show hashValues;

import 'package:flutter/foundation.dart' show setEquals;

import 'package:huawei_map/components/components.dart';

class TileOverlayUpdates {
  Set<TileOverlay> insertSet;
  Set<TileOverlayId> deleteSet;
  Set<TileOverlay> updateSet;

  bool isChanged(
      TileOverlay curr, Map<TileOverlayId, TileOverlay> oldTileOverlays) {
    final TileOverlay old = oldTileOverlays[curr.tileOverlayId];
    return curr != old;
  }

  TileOverlayUpdates.update(
      Set<TileOverlay> previous, Set<TileOverlay> current) {
    if (previous == null) {
      previous = Set<TileOverlay>.identity();
    }

    if (current == null) {
      current = Set<TileOverlay>.identity();
    }

    final Map<TileOverlayId, TileOverlay> oldTileOverlays =
        tileOverlayToMap(previous);
    final Map<TileOverlayId, TileOverlay> currTileOverlays =
        tileOverlayToMap(current);

    final Set<TileOverlayId> oldIds = oldTileOverlays.keys.toSet();
    final Set<TileOverlayId> currIds = currTileOverlays.keys.toSet();

    final Set<TileOverlayId> _toDelete = oldIds.difference(currIds);

    final Set<TileOverlay> _toInsert =
        currIds.difference(oldIds).map((id) => currTileOverlays[id]).toSet();

    final Set<TileOverlay> _toUpdate = currIds
        .intersection(oldIds)
        .map((id) => currTileOverlays[id])
        .where((x) => isChanged(x, oldTileOverlays))
        .toSet();

    insertSet = _toInsert;
    deleteSet = _toDelete;
    updateSet = _toUpdate;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final TileOverlayUpdates check = other;
    return setEquals(insertSet, check.insertSet) &&
        setEquals(deleteSet, check.deleteSet) &&
        setEquals(updateSet, check.updateSet);
  }

  @override
  int get hashCode => hashValues(insertSet, deleteSet, updateSet);
}
