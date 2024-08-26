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

/// Encapsulates bound attribute.
class CameraTargetBounds {
  /// Rectangular area defined using a pair of [longitude] and [latitude].
  final LatLngBounds? bounds;

  /// Unbounded camera bounds.
  static const CameraTargetBounds unbounded = CameraTargetBounds(null);

  const CameraTargetBounds(this.bounds);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    return other is CameraTargetBounds && bounds == other.bounds;
  }

  @override
  int get hashCode => bounds.hashCode;
}
