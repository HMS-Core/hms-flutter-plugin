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

/// Defines a cap that is applied at the start or end vertex of a [Polyline].
@immutable
class Cap {
  final dynamic _json;

  const Cap._(this._json);

  /// Sets the start or end vertex of a polyline to the square type.
  static const Cap squareCap = Cap._(<dynamic>['squareCap']);

  /// Defines a cap that is squared off exactly at the start or end vertex of a polyline.
  static const Cap buttCap = Cap._(<dynamic>['buttCap']);

  /// Represents a semicircle with a radius equal to a half of the stroke width.
  ///
  /// The semicircle will be centered at the start or end vertex of a polyline.
  static const Cap roundCap = Cap._(<dynamic>['roundCap']);

  /// Constructs a cap with a bitmap overlay that is centered at the start or end vertex of a [Polyline], orientated to the direction of the line's first or last edge, and scaled with respect to the line's stroke width.
  static Cap customCapFromBitmap(
    BitmapDescriptor bitmapDescriptor, {
    double refWidth = 10,
  }) {
    if (refWidth < 0.0) {
      return roundCap;
    }
    return Cap._(
      <dynamic>[
        'customCap',
        bitmapDescriptor.toJson(),
        refWidth,
      ],
    );
  }

  dynamic toJson() => _json;
}
