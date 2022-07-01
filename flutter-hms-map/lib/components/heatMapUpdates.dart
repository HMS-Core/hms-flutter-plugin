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

class HeatMapUpdates {
  late Set<HeatMap> insertSet;
  late Set<HeatMapId> deleteSet;
  late Set<HeatMap> updateSet;

  bool isChanged(HeatMap curr, Map<HeatMapId, HeatMap> oldHeatMaps) {
    final HeatMap old = oldHeatMaps[curr.heatMapId]!;
    return curr != old;
  }

  HeatMapUpdates.update(Set<HeatMap> previous, Set<HeatMap> current) {
    final Map<HeatMapId, HeatMap> oldHeatMaps = heatMapToMap(previous);
    final Map<HeatMapId, HeatMap> currHeatMaps = heatMapToMap(current);

    final Set<HeatMapId> oldIds = oldHeatMaps.keys.toSet();
    final Set<HeatMapId> currIds = currHeatMaps.keys.toSet();

    final Set<HeatMapId> _toDelete = oldIds.difference(currIds);

    final Set<HeatMap> _toInsert = Set<HeatMap>.from(
        currIds.difference(oldIds).map((id) => currHeatMaps[id]).toSet());

    final Set<HeatMap> _toUpdate = Set<HeatMap>.from(currIds
        .intersection(oldIds)
        .map((id) => currHeatMaps[id])
        .where((x) => isChanged(x!, oldHeatMaps))
        .toSet());

    insertSet = _toInsert;
    deleteSet = _toDelete;
    updateSet = _toUpdate;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is MarkerUpdates &&
        setEquals(this.insertSet, other.insertSet) &&
        setEquals(this.deleteSet, other.deleteSet) &&
        setEquals(this.updateSet, other.updateSet);
  }

  @override
  int get hashCode => Object.hash(insertSet, deleteSet, updateSet);
}
