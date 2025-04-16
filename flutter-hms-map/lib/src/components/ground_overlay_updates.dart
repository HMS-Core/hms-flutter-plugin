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

class GroundOverlayUpdates {
  late Set<GroundOverlay> insertSet;
  late Set<GroundOverlayId> deleteSet;
  late Set<GroundOverlay> updateSet;

  GroundOverlayUpdates.update(
    Set<GroundOverlay> previous,
    Set<GroundOverlay> current,
  ) {
    final Map<GroundOverlayId, GroundOverlay> oldGroundOverlays =
        groundOverlayToMap(previous);
    final Map<GroundOverlayId, GroundOverlay> currGroundOverlays =
        groundOverlayToMap(current);

    final Set<GroundOverlayId> oldIds = oldGroundOverlays.keys.toSet();
    final Set<GroundOverlayId> currIds = currGroundOverlays.keys.toSet();

    final Set<GroundOverlayId> toDelete = oldIds.difference(currIds);
    final Set<GroundOverlay> toInsert = Set<GroundOverlay>.from(
      currIds
          .difference(oldIds)
          .map((GroundOverlayId id) => currGroundOverlays[id])
          .toSet(),
    );
    final Set<GroundOverlay> toUpdate = Set<GroundOverlay>.from(
      currIds
          .intersection(oldIds)
          .map((GroundOverlayId id) => currGroundOverlays[id])
          .where((GroundOverlay? x) => isChanged(x!, oldGroundOverlays))
          .toSet(),
    );

    insertSet = toInsert;
    deleteSet = toDelete;
    updateSet = toUpdate;
  }

  bool isChanged(
    GroundOverlay curr,
    Map<GroundOverlayId, GroundOverlay> oldGroundOverlays,
  ) {
    final GroundOverlay old = oldGroundOverlays[curr.groundOverlayId]!;
    return curr != old;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    return other is GroundOverlayUpdates &&
        setEquals(insertSet, other.insertSet) &&
        setEquals(deleteSet, other.deleteSet) &&
        setEquals(updateSet, other.updateSet);
  }

  @override
  int get hashCode => Object.hash(insertSet, deleteSet, updateSet);
}
