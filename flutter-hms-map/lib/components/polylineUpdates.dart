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

class PolylineUpdates {
  Set<Polyline> insertSet;
  Set<PolylineId> deleteSet;
  Set<Polyline> updateSet;

  bool isChanged(
      Polyline current, Map<PolylineId, Polyline> previousPolylines) {
    final Polyline old = previousPolylines[current.polylineId];
    return current != old;
  }

  PolylineUpdates.update(Set<Polyline> previous, Set<Polyline> current) {
    if (previous == null) {
      previous = Set<Polyline>.identity();
    }

    if (current == null) {
      current = Set<Polyline>.identity();
    }

    final Map<PolylineId, Polyline> oldPolylines = polylineToMap(previous);
    final Map<PolylineId, Polyline> currPolylines = polylineToMap(current);

    final Set<PolylineId> oldIds = oldPolylines.keys.toSet();
    final Set<PolylineId> currIds = currPolylines.keys.toSet();

    final Set<PolylineId> _toDelete = oldIds.difference(currIds);

    final Set<Polyline> _toInsert =
        currIds.difference(oldIds).map((id) => currPolylines[id]).toSet();

    final Set<Polyline> _toUpdate = currIds
        .intersection(oldIds)
        .map((id) => currPolylines[id])
        .where((x) => isChanged(x, oldPolylines))
        .toSet();

    insertSet = _toInsert;
    deleteSet = _toDelete;
    updateSet = _toUpdate;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final PolylineUpdates check = other;
    return setEquals(insertSet, check.insertSet) &&
        setEquals(deleteSet, check.deleteSet) &&
        setEquals(updateSet, check.updateSet);
  }

  @override
  int get hashCode => hashValues(insertSet, deleteSet, updateSet);
}
