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

/// Skeleton point data.
class Modeling3dMotionCaptureSkeleton {
  /// The frame ID.
  final int? itemIdentity;

  /// The list of the skeleton point quaternions.
  final List<Modeling3dMotionCaptureQuaternion>? jointQuaternions;

  /// The skeleton point list.
  final List<Modeling3dMotionCaptureJoint>? joints;

  /// The translation parameters.
  final List<double>? jointShift;

  const Modeling3dMotionCaptureSkeleton._({
    required this.itemIdentity,
    required this.jointQuaternions,
    required this.joints,
    required this.jointShift,
  });

  factory Modeling3dMotionCaptureSkeleton._fromMap(Map<dynamic, dynamic> map) {
    return Modeling3dMotionCaptureSkeleton._(
      itemIdentity: map['itemIdentity'],
      jointQuaternions: map['jointQuaternions'] != null
          ? List<Modeling3dMotionCaptureQuaternion>.from(
              map['jointQuaternions'].map(
                (dynamic x) => Modeling3dMotionCaptureQuaternion._fromMap(x),
              ),
            )
          : null,
      joints: map['joints'] != null
          ? List<Modeling3dMotionCaptureJoint>.from(
              map['joints'].map(
                (dynamic x) => Modeling3dMotionCaptureJoint._fromMap(x),
              ),
            )
          : null,
      jointShift: map['joints'] != null
          ? List<double>.from(
              map['jointShift'].map(
                (dynamic x) => x.toDouble(),
              ),
            )
          : null,
    );
  }

  @override
  String toString() {
    return '$Modeling3dMotionCaptureSkeleton('
        'itemIdentity: $itemIdentity, '
        'jointQuaternions: $jointQuaternions, '
        'joints: $joints, '
        'jointShift: $jointShift)';
  }
}
