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

class HeatMapUpdates {
  late Set<HeatMap> insertSet;
  late Set<HeatMapId> deleteSet;
  late Set<HeatMap> updateSet;

  HeatMapUpdates.update(Set<HeatMap> previous, Set<HeatMap> current) {
    final Map<HeatMapId, HeatMap> oldHeatMaps = heatMapToMap(previous);
    final Map<HeatMapId, HeatMap> currHeatMaps = heatMapToMap(current);

    final Set<HeatMapId> oldIds = oldHeatMaps.keys.toSet();
    final Set<HeatMapId> currIds = currHeatMaps.keys.toSet();

    final Set<HeatMapId> toDelete = oldIds.difference(currIds);
    final Set<HeatMap> toInsert = Set<HeatMap>.from(
      currIds
          .difference(oldIds)
          .map((HeatMapId id) => currHeatMaps[id])
          .toSet(),
    );
    final Set<HeatMap> toUpdate = Set<HeatMap>.from(
      currIds
          .intersection(oldIds)
          .map((HeatMapId id) => currHeatMaps[id])
          .where((HeatMap? x) => isChanged(x!, oldHeatMaps))
          .toSet(),
    );

    insertSet = toInsert;
    deleteSet = toDelete;
    updateSet = toUpdate;
  }

  bool isChanged(HeatMap curr, Map<HeatMapId, HeatMap> oldHeatMaps) {
    final HeatMap old = oldHeatMaps[curr.heatMapId]!;
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
    return other is MarkerUpdates &&
        setEquals(insertSet, other.insertSet) &&
        setEquals(deleteSet, other.deleteSet) &&
        setEquals(updateSet, other.updateSet);
  }

  @override
  int get hashCode => Object.hash(insertSet, deleteSet, updateSet);
}
