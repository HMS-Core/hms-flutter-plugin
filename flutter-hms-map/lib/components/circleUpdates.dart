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

class CircleUpdates {
  Set<Circle> insertSet;
  Set<CircleId> deleteSet;
  Set<Circle> updateSet;

  bool isChanged(Circle curr, Map<CircleId, Circle> oldCircles) {
    final Circle old = oldCircles[curr.circleId];
    return curr != old;
  }

  CircleUpdates.update(Set<Circle> previous, Set<Circle> current) {
    if (previous == null) {
      previous = Set<Circle>.identity();
    }

    if (current == null) {
      current = Set<Circle>.identity();
    }

    final Map<CircleId, Circle> oldCircles = circleToMap(previous);
    final Map<CircleId, Circle> currCircles = circleToMap(current);

    final Set<CircleId> oldIds = oldCircles.keys.toSet();
    final Set<CircleId> currIds = currCircles.keys.toSet();

    final Set<CircleId> _toDelete = oldIds.difference(currIds);

    final Set<Circle> _toInsert =
        currIds.difference(oldIds).map((id) => currCircles[id]).toSet();

    final Set<Circle> _toUpdate = currIds
        .intersection(oldIds)
        .map((id) => currCircles[id])
        .where((x) => isChanged(x, oldCircles))
        .toSet();

    insertSet = _toInsert;
    deleteSet = _toDelete;
    updateSet = _toUpdate;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final CircleUpdates check = other;
    return setEquals(insertSet, check.insertSet) &&
        setEquals(deleteSet, check.deleteSet) &&
        setEquals(updateSet, check.updateSet);
  }

  @override
  int get hashCode => hashValues(insertSet, deleteSet, updateSet);
}
