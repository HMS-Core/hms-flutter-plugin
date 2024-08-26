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

class MarkerUpdates {
  late Set<Marker> insertSet;
  late Set<MarkerId> deleteSet;
  late Set<Marker> updateSet;

  MarkerUpdates.update(Set<Marker> previous, Set<Marker> current) {
    final Map<MarkerId, Marker> oldMarkers = markerToMap(previous);
    final Map<MarkerId, Marker> currMarkers = markerToMap(current);

    final Set<MarkerId> oldIds = oldMarkers.keys.toSet();
    final Set<MarkerId> currIds = currMarkers.keys.toSet();

    final Set<MarkerId> toDelete = oldIds.difference(currIds);
    final Set<Marker> toInsert = Set<Marker>.from(
      currIds.difference(oldIds).map((MarkerId id) => currMarkers[id]).toSet(),
    );
    final Set<Marker> toUpdate = Set<Marker>.from(
      currIds
          .intersection(oldIds)
          .map((MarkerId id) => currMarkers[id])
          .where((Marker? x) => isChanged(x!, oldMarkers))
          .toSet(),
    );

    insertSet = toInsert;
    deleteSet = toDelete;
    updateSet = toUpdate;
  }

  bool isChanged(Marker curr, Map<MarkerId, Marker> oldMarkers) {
    final Marker old = oldMarkers[curr.markerId]!;
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
