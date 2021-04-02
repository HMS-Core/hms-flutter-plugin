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

class MarkerUpdates {
  Set<Marker> insertSet;
  Set<MarkerId> deleteSet;
  Set<Marker> updateSet;

  bool isChanged(Marker curr, Map<MarkerId, Marker> oldMarkers) {
    final Marker old = oldMarkers[curr.markerId];
    return curr != old;
  }

  MarkerUpdates.update(Set<Marker> previous, Set<Marker> current) {
    if (previous == null) {
      previous = Set<Marker>.identity();
    }

    if (current == null) {
      current = Set<Marker>.identity();
    }

    final Map<MarkerId, Marker> oldMarkers = markerToMap(previous);
    final Map<MarkerId, Marker> currMarkers = markerToMap(current);

    final Set<MarkerId> oldIds = oldMarkers.keys.toSet();
    final Set<MarkerId> currIds = currMarkers.keys.toSet();

    final Set<MarkerId> _toDelete = oldIds.difference(currIds);

    final Set<Marker> _toInsert =
        currIds.difference(oldIds).map((id) => currMarkers[id]).toSet();

    final Set<Marker> _toUpdate = currIds
        .intersection(oldIds)
        .map((id) => currMarkers[id])
        .where((x) => isChanged(x, oldMarkers))
        .toSet();

    insertSet = _toInsert;
    deleteSet = _toDelete;
    updateSet = _toUpdate;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final MarkerUpdates check = other;
    return setEquals(insertSet, check.insertSet) &&
        setEquals(deleteSet, check.deleteSet) &&
        setEquals(updateSet, check.updateSet);
  }

  @override
  int get hashCode => hashValues(insertSet, deleteSet, updateSet);
}
