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

/// Texture map download result.
class Modeling3dTextureDownloadResult {
  /// ID of a material generation task.
  /// A unique task ID is generated each time the material generation API is called.
  final String taskId;

  /// Texture map download result.
  final bool isComplete;

  const Modeling3dTextureDownloadResult._({
    required this.taskId,
    required this.isComplete,
  });

  factory Modeling3dTextureDownloadResult._fromMap(Map<dynamic, dynamic> map) {
    return Modeling3dTextureDownloadResult._(
      taskId: map['taskId'],
      isComplete: map['isComplete'],
    );
  }

  @override
  String toString() {
    return '$Modeling3dTextureDownloadResult('
        'taskId: $taskId, '
        'isComplete: $isComplete)';
  }
}
