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

class CircleUpdates {
  late Set<Circle> insertSet;
  late Set<CircleId> deleteSet;
  late Set<Circle> updateSet;

  CircleUpdates.update(Set<Circle> previous, Set<Circle> current) {
    final Map<CircleId, Circle> oldCircles = circleToMap(previous);
    final Map<CircleId, Circle> currCircles = circleToMap(current);

    final Set<CircleId> oldIds = oldCircles.keys.toSet();
    final Set<CircleId> currIds = currCircles.keys.toSet();

    final Set<CircleId> toDelete = oldIds.difference(currIds);

    final Set<Circle> toInsert = Set<Circle>.from(
      currIds.difference(oldIds).map((CircleId id) {
        return currCircles[id];
      }).toSet(),
    );

    final Set<Circle> toUpdate = Set<Circle>.from(
      currIds
          .intersection(oldIds)
          .map((CircleId id) => currCircles[id])
          .where((Circle? x) => isChanged(x!, oldCircles))
          .toSet(),
    );

    insertSet = toInsert;
    deleteSet = toDelete;
    updateSet = toUpdate;
  }

  bool isChanged(Circle curr, Map<CircleId, Circle> oldCircles) {
    final Circle old = oldCircles[curr.circleId]!;
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
    return other is CircleUpdates &&
        setEquals(insertSet, other.insertSet) &&
        setEquals(deleteSet, other.deleteSet) &&
        setEquals(updateSet, other.updateSet);
  }

  @override
  int get hashCode => Object.hash(insertSet, deleteSet, updateSet);
}
