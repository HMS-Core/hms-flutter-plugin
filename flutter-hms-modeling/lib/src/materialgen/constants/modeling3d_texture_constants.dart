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

part of materialgen;

/// Constants of material generation.
abstract class Modeling3dTextureConstants {
  /// Working mode for material generation.
  static AlgorithmMode algorithmMode = const AlgorithmMode._();

  /// Material generation status.
  static ProgressStatus progressStatus = const ProgressStatus._();

  /// Restriction status of a material generation task.
  static RestrictStatus restrictStatus = const RestrictStatus._();
}

/// Working mode for material generation.
class AlgorithmMode {
  const AlgorithmMode._();

  /// AI mode.
  final int ai = 1;
}

/// Material generation status.
class ProgressStatus {
  const ProgressStatus._();

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

/// Restriction status of a material generation task.
class RestrictStatus {
  const RestrictStatus._();

  /// The task is not restricted.
  final int unrestrict = 0;

  /// The task is restricted.
  final int restrict = 1;
}

/// Material Progress Status types for conversion between an integer
/// status value to a semantic enum type.
///
/// You can obtain the corresponding material progress status type by:
///
/// ```
///   MaterialProgressStatusType.values[status];
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
