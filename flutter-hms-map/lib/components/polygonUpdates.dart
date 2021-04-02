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

class PolygonUpdates {
  Set<Polygon> insertSet;
  Set<PolygonId> deleteSet;
  Set<Polygon> updateSet;

  bool isChanged(Polygon current, Map<PolygonId, Polygon> oldPolygons) {
    final Polygon old = oldPolygons[current.polygonId];
    return current != old;
  }

  PolygonUpdates.update(Set<Polygon> previous, Set<Polygon> current) {
    if (previous == null) {
      previous = Set<Polygon>.identity();
    }
    if (current == null) {
      current = Set<Polygon>.identity();
    }

    final Map<PolygonId, Polygon> oldPolygons = polygonToMap(previous);
    final Map<PolygonId, Polygon> currPolygons = polygonToMap(current);

    final Set<PolygonId> oldIds = oldPolygons.keys.toSet();
    final Set<PolygonId> currIds = currPolygons.keys.toSet();

    final Set<PolygonId> _toDelete = oldIds.difference(currIds);

    final Set<Polygon> _toInsert =
        currIds.difference(oldIds).map((id) => currPolygons[id]).toSet();

    final Set<Polygon> _toUpdate = currIds
        .intersection(oldIds)
        .map((id) => currPolygons[id])
        .where((x) => isChanged(x, oldPolygons))
        .toSet();

    insertSet = _toInsert;
    deleteSet = _toDelete;
    updateSet = _toUpdate;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final PolygonUpdates check = other;
    return setEquals(insertSet, check.insertSet) &&
        setEquals(deleteSet, check.deleteSet) &&
        setEquals(updateSet, check.updateSet);
  }

  @override
  int get hashCode => hashValues(insertSet, deleteSet, updateSet);
}
