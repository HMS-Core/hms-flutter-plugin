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

class PolylineUpdates {
  late Set<Polyline> insertSet;
  late Set<PolylineId> deleteSet;
  late Set<Polyline> updateSet;

  bool isChanged(
    Polyline current,
    Map<PolylineId, Polyline> previousPolylines,
  ) {
    final Polyline old = previousPolylines[current.polylineId]!;
    return current != old;
  }

  PolylineUpdates.update(Set<Polyline> previous, Set<Polyline> current) {
    final Map<PolylineId, Polyline> oldPolylines = polylineToMap(previous);
    final Map<PolylineId, Polyline> currPolylines = polylineToMap(current);

    final Set<PolylineId> oldIds = oldPolylines.keys.toSet();
    final Set<PolylineId> currIds = currPolylines.keys.toSet();

    final Set<PolylineId> toDelete = oldIds.difference(currIds);
    final Set<Polyline> toInsert = Set<Polyline>.from(
      currIds
          .difference(oldIds)
          .map((PolylineId id) => currPolylines[id])
          .toSet(),
    );
    final Set<Polyline> toUpdate = Set<Polyline>.from(
      currIds
          .intersection(oldIds)
          .map((PolylineId id) => currPolylines[id])
          .where((Polyline? x) => isChanged(x!, oldPolylines))
          .toSet(),
    );

    insertSet = toInsert;
    deleteSet = toDelete;
    updateSet = toUpdate;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    return other is PolylineUpdates &&
        setEquals(insertSet, other.insertSet) &&
        setEquals(deleteSet, other.deleteSet) &&
        setEquals(updateSet, other.updateSet);
  }

  @override
  int get hashCode => Object.hash(insertSet, deleteSet, updateSet);
}
