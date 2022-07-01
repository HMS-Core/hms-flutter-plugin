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

import 'package:huawei_map/components/components.dart';
import 'package:huawei_map/utils/toJson.dart';

Map<GroundOverlayId, GroundOverlay> groundOverlayToMap(
    Iterable<GroundOverlay> groundOverlays) {
  return Map<GroundOverlayId, GroundOverlay>.fromEntries(groundOverlays.map(
      (GroundOverlay groundOverlay) => MapEntry<GroundOverlayId, GroundOverlay>(
          groundOverlay.groundOverlayId, groundOverlay.clone())));
}

List<Map<String, dynamic>> groundOverlayToList(
    Set<GroundOverlay> groundOverlays) {
  return groundOverlays
      .map<Map<String, dynamic>>((GroundOverlay g) => groundOverlayToJson(g))
      .toList();
}
