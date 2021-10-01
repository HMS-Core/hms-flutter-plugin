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

/// Constants of material generation.
class Modeling3dTextureConstants {
  static AlgorithmMode algorithmMode = const AlgorithmMode();
  static ProgressStatus progressStatus = const ProgressStatus();
  static RestrictStatus restrictStatus = const RestrictStatus();
}

/// Defines the working mode for material generation through Modeling3dTextureConstants.
class AlgorithmMode {
  const AlgorithmMode();

  /// AI mode.
  final int ai = 1;
}

/// Defines the status of material generation through Modeling3dTextureConstants.
class ProgressStatus {
  const ProgressStatus();

  /// Task initialization is completed.
  final int inited = 0;

  /// File upload is completed.
  final int uploadCompleted = 1;

  /// A material generation task starts.
  final int textureStart = 2;

  /// A material generation task is completed.
  final int textureCompleted = 3;

  /// A material generation task fails.
  final int textureFailed = 4;
}

/// Defines whether a material generation task is restricted through Modeling3dTextureConstants.
class RestrictStatus {
  const RestrictStatus();

  /// The task is not restricted.
  final int unrestrict = 0;

  /// The task is restricted.
  final int restrict = 1;
}

/// Material Progress Status types for conversion between an integer
/// status value to a semantic enum type.
///
/// You can obtain the corresponding Material Progress Status Type by:
/// ```
/// MaterialProgressStatusEnum.values[status];
/// ```
enum MaterialProgressStatusType {
  /// Task initialization is completed.
  inited,

  /// File upload is completed.
  uploadCompleted,

  /// A material generation task starts.
  textureStart,

  /// A material generation task is completed.
  textureCompleted,

  /// A material generation task fails.
  textureFailed,
}
