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

import 'package:flutter/material.dart' show immutable;

import 'package:huawei_map/components/components.dart';

@immutable
class Cap {
  final dynamic _json;

  const Cap._(this._json);

  static const Cap squareCap = Cap._(<dynamic>['squareCap']);
  static const Cap buttCap = Cap._(<dynamic>['buttCap']);
  static const Cap roundCap = Cap._(<dynamic>['roundCap']);

  static Cap customCapFromBitmap(
    BitmapDescriptor bitmapDescriptor, {
    double refWidth = 10,
  }) {
    if (refWidth < 0.0) return roundCap;
    return Cap._(<dynamic>['customCap', bitmapDescriptor.toJson(), refWidth]);
  }

  dynamic toJson() => _json;
}
