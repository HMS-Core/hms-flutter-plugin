/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of motion_capture;

/// Quaternion of a skeleton point.
class Modeling3dMotionCaptureQuaternion {
  /// The W coordinate.
  final double? pointW;

  /// The X coordinate.
  final double? pointX;

  /// The Y coordinate.
  final double? pointY;

  /// The Z coordinate.
  final double? pointZ;

  /// The skeleton point type.
  final int? type;

  const Modeling3dMotionCaptureQuaternion._({
    required this.pointW,
    required this.pointX,
    required this.pointY,
    required this.pointZ,
    required this.type,
  });

  factory Modeling3dMotionCaptureQuaternion._fromMap(
    Map<dynamic, dynamic> map,
  ) {
    return Modeling3dMotionCaptureQuaternion._(
      pointW: map['pointW'],
      pointX: map['pointX'],
      pointY: map['pointY'],
      pointZ: map['pointZ'],
      type: map['type'],
    );
  }

  @override
  String toString() {
    return '$Modeling3dMotionCaptureQuaternion('
        'pointW: $pointW, '
        'pointX: $pointX, '
        'pointY: $pointY, '
        'pointZ: $pointZ, '
        'type: $type)';
  }
}
