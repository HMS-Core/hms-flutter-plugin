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

part of objreconstruct;

/// Constants of 3D object reconstruction.
abstract class Modeling3dReconstructConstants {
  /// Working mode for 3D object reconstruction.
  static const ReconstructMode reconstructMode = ReconstructMode._();

  /// Restriction status of a 3D object reconstruction task.
  static const RestrictStatus restrictStatus = RestrictStatus._();

  /// 3D object reconstruction status.
  static const ProgressStatus progressStatus = ProgressStatus._();

  /// Texture map mode.
  static const TextureMode textureMode = TextureMode._();

  /// Mesh count level for a 3D object reconstruction task.
  static const FaceLevel faceLevel = FaceLevel._();

  /// Extra scanning status of a 3D object reconstruction task.
  static const NeedRescan needRescan = NeedRescan._();

  /// 3D model format.
  static const ModelFormat modelFormat = ModelFormat._();

  /// Reason for a failed 3D object reconstruction task.
  static const ReconstructFailCode reconstructFailCode =
      ReconstructFailCode._();

  /// Type of a 3D object reconstruction task.
  static const TaskType taskType = TaskType._();
}

/// Working mode for 3D object reconstruction.
class ReconstructMode {
  const ReconstructMode._();

  /// PICTURE mode.
  final int picture = 0;
}

/// Restriction status of a 3D object reconstruction task.
class RestrictStatus {
  const RestrictStatus._();

  /// Not restricted.
  final int unrestrict = 0;

  /// Restricted.
  final int restrict = 1;
}

/// 3D object reconstruction status.
class ProgressStatus {
  const ProgressStatus._();

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

  /// The 3D object reconstruction task is under risk control check.
  final int riskControlAuditInProgress = 5;

  /// The 3D object reconstruction task passes the risk control check.
  final int riskControlPassed = 6;

  /// The 3D object reconstruction task failed to pass the risk control check.
  final int riskControlFailed = 7;
}

/// Texture map mode.
class TextureMode {
  const TextureMode._();

  /// Normal mode.
  final int normal = 0;

  /// PBR mode.
  final int pbr = 1;
}

/// Mesh count level for a 3D object reconstruction task.
class FaceLevel {
  const FaceLevel._();

  /// High.
  final int high = 0;

  /// Medium.
  final int medium = 1;

  /// Low.
  final int low = 2;
}

/// Extra scanning status of a 3D object reconstruction task.
class NeedRescan {
  const NeedRescan._();

  /// Disabled.
  final String close = 'false';

  /// Enabled.
  final String open = 'true';
}

/// 3D model format.
class ModelFormat {
  const ModelFormat._();

  /// glTF format.
  final String GLTF = 'GLTF';

  /// OBJ format.
  final String OBJ = 'OBJ';
}

/// Reason for a failed 3D object reconstruction task.
class ReconstructFailCode {
  const ReconstructFailCode._();

  /// Internal error.
  final int INNER_ERROR = 1;

  /// Image file verification failed.
  final int FILE_CHECK_FAILED = 2;

  /// Invalid image.
  final int PICTURE_ILLEGAL = 3;

  /// The algorithm processing failed.
  final int ALGORITHM_FAILED = 4;

  /// The quota of API calls is used up.
  final int BILLING_QUOTA_EXHAUSTED = 5;

  /// The project is in arrears.
  final int BILLING_OVERDUE = 6;
}

/// Type of a 3D object reconstruction task.
class TaskType {
  const TaskType._();

  /// 3D object reconstruction.
  final int OBJ_RECONSTRUCT = 0;

  /// Auto rigging.
  final int AUTO_RIGGING = 2;
}

/// Reconstruct Progress Status types for conversion between an integer
/// status value to a semantic enum type.
///
/// You can obtain the corresponding Reconstruct Progress Status Type by:
///
/// ```
///   ReconstructProgressStatusType.values[status];
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
  reconstructFailed,

  /// A 3D object reconstruction task is under risk control check.
  riskControlAuditInProgress,

  /// A 3D object reconstruction task passes the risk control check.
  riskControlPassed,

  /// A 3D object reconstruction task failed to pass the risk control check.
  riskControlFailed,
}
