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

import 'package:flutter/foundation.dart' show setEquals;

import 'package:huawei_map/components/components.dart';

class GroundOverlayUpdates {
  late Set<GroundOverlay> insertSet;
  late Set<GroundOverlayId> deleteSet;
  late Set<GroundOverlay> updateSet;

  bool isChanged(GroundOverlay curr,
      Map<GroundOverlayId, GroundOverlay> oldGroundOverlays) {
    final GroundOverlay old = oldGroundOverlays[curr.groundOverlayId]!;
    return curr != old;
  }

  GroundOverlayUpdates.update(
      Set<GroundOverlay> previous, Set<GroundOverlay> current) {
    final Map<GroundOverlayId, GroundOverlay> oldGroundOverlays =
        groundOverlayToMap(previous);
    final Map<GroundOverlayId, GroundOverlay> currGroundOverlays =
        groundOverlayToMap(current);

    final Set<GroundOverlayId> oldIds = oldGroundOverlays.keys.toSet();
    final Set<GroundOverlayId> currIds = currGroundOverlays.keys.toSet();

    final Set<GroundOverlayId> _toDelete = oldIds.difference(currIds);

    final Set<GroundOverlay> _toInsert = Set<GroundOverlay>.from(
        currIds.difference(oldIds).map((id) => currGroundOverlays[id]).toSet());

    final Set<GroundOverlay> _toUpdate = Set<GroundOverlay>.from(currIds
        .intersection(oldIds)
        .map((id) => currGroundOverlays[id])
        .where((x) => isChanged(x!, oldGroundOverlays))
        .toSet());

    insertSet = _toInsert;
    deleteSet = _toDelete;
    updateSet = _toUpdate;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is GroundOverlayUpdates &&
        setEquals(this.insertSet, other.insertSet) &&
        setEquals(this.deleteSet, other.deleteSet) &&
        setEquals(this.updateSet, other.updateSet);
  }

  @override
  int get hashCode => Object.hash(insertSet, deleteSet, updateSet);
}
