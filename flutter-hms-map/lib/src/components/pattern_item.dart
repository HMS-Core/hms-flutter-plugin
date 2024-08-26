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

/// Describes the stroke pattern of a polyline.
@immutable
class PatternItem {
  final dynamic _type;

  /// Dot type.
  static const PatternItem dot = PatternItem._(<dynamic>[_Param.dot]);

  /// Obtains a dash-type [PatternItem] object with a specified [length].
  static PatternItem dash(double length) {
    return PatternItem._(<dynamic>[_Param.dash, length]);
  }

  /// Obtains a gap-type [PatternItem] object with a specified [length].
  static PatternItem gap(double length) {
    return PatternItem._(<dynamic>[_Param.gap, length]);
  }

  const PatternItem._(this._type);

  dynamic toJson() => _type;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    return other is PatternItem && listEquals(_type, other._type);
  }

  @override
  int get hashCode => _type.hashCode;
}
