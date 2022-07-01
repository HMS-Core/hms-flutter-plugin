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

import 'package:flutter/foundation.dart' show listEquals, immutable;

import 'package:huawei_map/constants/param.dart';

@immutable
class PatternItem {
  final dynamic _type;

  const PatternItem._(this._type);

  static const PatternItem dot = PatternItem._(<dynamic>[Param.dot]);

  static PatternItem dash(double length) {
    return PatternItem._(<dynamic>[Param.dash, length]);
  }

  static PatternItem gap(double length) {
    return PatternItem._(<dynamic>[Param.gap, length]);
  }

  dynamic toJson() => _type;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is PatternItem && listEquals(this._type, other._type);
  }

  @override
  int get hashCode => _type.hashCode;
}
