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

/// Defines the joint type for a [Polyline].
@immutable
class JointType {
  /// Type of the joint.
  ///
  /// The options include `0`, `1`, and `2`.
  final int type;

  const JointType._(this.type);

  /// Default type.
  static const JointType mitered = JointType._(0);

  /// Flat bevel.
  static const JointType bevel = JointType._(1);

  /// Round.
  static const JointType round = JointType._(2);
}
