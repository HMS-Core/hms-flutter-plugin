/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

/// Constants of 3D object reconstruction.
class Modeling3dReconstructConstants {
  static const _ReconstructMode reconstructMode = _ReconstructMode();
  static const _RestrictStatus restrictStatus = _RestrictStatus();
  static const _ProgressStatus progressStatus = _ProgressStatus();
}

/// Constants of the working mode for 3D object reconstruction.
class _ReconstructMode {
  const _ReconstructMode();

  /// PICTURE mode.
  final int picture = 0;
}

/// Defines the restriction status of a 3D object reconstruction task.
class _RestrictStatus {
  const _RestrictStatus();

  /// Not restricted.
  final int unrestrict = 0;

  /// Restricted.
  final int restrict = 1;
}

/// 3D object reconstruction status.
class _ProgressStatus {
  const _ProgressStatus();

  /// Task initialization is completed.
  final int inited = 0;

  /// File upload is completed.
  final int uploadCompleted = 1;

  /// A 3D object reconstruction task starts.
  final int reconstructStart = 2;

  /// A 3D object reconstruction task is completed.
  final int reconstructCompleted = 3;

  /// A 3D object reconstruction task fails.
  final int reconstructFailed = 4;
}

/// Reconstruct Progress Status types for conversion between an integer
/// status value to a semantic enum type.
///
/// You can obtain the corresponding Reconstruct Progress Status Type by:
/// ```
/// ReconstructProgressStatusEnum.values[status];
/// ```
enum ReconstructProgressStatusType {
  /// Task initialization is completed.
  inited,

  /// File upload is completed.
  uploadCompleted,

  /// A 3D object reconstruction task starts.
  reconstructStart,

  /// A 3D object reconstruction task is completed.
  reconstructCompleted,

  /// A 3D object reconstruction task fails.
  reconstructFailed
}
