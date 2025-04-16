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

/// Encapsulates attributes for setting the minimum and maximum zoom levels.
class MinMaxZoomPreference {
  /// Minimum zoom level.
  final double minZoom;

  /// Maximum zoom level.
  final double maxZoom;

  /// Unbounded zoom preference.
  static const MinMaxZoomPreference unbounded = MinMaxZoomPreference(3, 20);

  const MinMaxZoomPreference(this.minZoom, this.maxZoom);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    return other is MinMaxZoomPreference &&
        minZoom == other.minZoom &&
        maxZoom == other.maxZoom;
  }

  @override
  int get hashCode => Object.hash(minZoom, maxZoom);
}
