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

import 'package:huawei_map/components/components.dart';

import 'dart:ui' show hashValues;

import 'package:flutter/foundation.dart' show setEquals;

class GroundOverlayUpdates {
  Set<GroundOverlay> insertSet;
  Set<GroundOverlayId> deleteSet;
  Set<GroundOverlay> updateSet;

  bool isChanged(GroundOverlay curr,
      Map<GroundOverlayId, GroundOverlay> oldGroundOverlays) {
    final GroundOverlay old = oldGroundOverlays[curr.groundOverlayId];
    return curr != old;
  }

  GroundOverlayUpdates.update(
      Set<GroundOverlay> previous, Set<GroundOverlay> current) {
    if (previous == null) {
      previous = Set<GroundOverlay>.identity();
    }

    if (current == null) {
      current = Set<GroundOverlay>.identity();
    }

    final Map<GroundOverlayId, GroundOverlay> oldGroundOverlays =
        groundOverlayToMap(previous);
    final Map<GroundOverlayId, GroundOverlay> currGroundOverlays =
        groundOverlayToMap(current);

    final Set<GroundOverlayId> oldIds = oldGroundOverlays.keys.toSet();
    final Set<GroundOverlayId> currIds = currGroundOverlays.keys.toSet();

    final Set<GroundOverlayId> _toDelete = oldIds.difference(currIds);

    final Set<GroundOverlay> _toInsert =
        currIds.difference(oldIds).map((id) => currGroundOverlays[id]).toSet();

    final Set<GroundOverlay> _toUpdate = currIds
        .intersection(oldIds)
        .map((id) => currGroundOverlays[id])
        .where((x) => isChanged(x, oldGroundOverlays))
        .toSet();

    insertSet = _toInsert;
    deleteSet = _toDelete;
    updateSet = _toUpdate;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final GroundOverlayUpdates check = other;
    return setEquals(insertSet, check.insertSet) &&
        setEquals(deleteSet, check.deleteSet) &&
        setEquals(updateSet, check.updateSet);
  }

  @override
  int get hashCode => hashValues(insertSet, deleteSet, updateSet);
}
