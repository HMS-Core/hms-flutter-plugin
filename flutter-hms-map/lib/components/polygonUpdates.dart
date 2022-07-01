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

class PolygonUpdates {
  late Set<Polygon> insertSet;
  late Set<PolygonId> deleteSet;
  late Set<Polygon> updateSet;

  bool isChanged(Polygon current, Map<PolygonId, Polygon> oldPolygons) {
    final Polygon old = oldPolygons[current.polygonId]!;
    return current != old;
  }

  PolygonUpdates.update(Set<Polygon> previous, Set<Polygon> current) {
    final Map<PolygonId, Polygon> oldPolygons = polygonToMap(previous);
    final Map<PolygonId, Polygon> currPolygons = polygonToMap(current);

    final Set<PolygonId> oldIds = oldPolygons.keys.toSet();
    final Set<PolygonId> currIds = currPolygons.keys.toSet();

    final Set<PolygonId> _toDelete = oldIds.difference(currIds);

    final Set<Polygon> _toInsert = Set<Polygon>.from(
        currIds.difference(oldIds).map((id) => currPolygons[id]).toSet());

    final Set<Polygon> _toUpdate = Set<Polygon>.from(currIds
        .intersection(oldIds)
        .map((id) => currPolygons[id])
        .where((x) => isChanged(x!, oldPolygons))
        .toSet());

    insertSet = _toInsert;
    deleteSet = _toDelete;
    updateSet = _toUpdate;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is PolygonUpdates &&
        setEquals(this.insertSet, other.insertSet) &&
        setEquals(this.deleteSet, other.deleteSet) &&
        setEquals(this.updateSet, other.updateSet);
  }

  @override
  int get hashCode => Object.hash(insertSet, deleteSet, updateSet);
}
