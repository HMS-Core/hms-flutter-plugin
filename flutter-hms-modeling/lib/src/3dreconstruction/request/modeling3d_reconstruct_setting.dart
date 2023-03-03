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

/// Settings for 3D object reconstruction.
class Modeling3dReconstructSetting {
  /// Mesh count level for a 3D object reconstruction task.
  /// Check [Modeling3dReconstructConstants.faceLevel] for more.
  final int faceLevel;

  /// Extra scanning status for a 3D object reconstruction task.
  /// Check [Modeling3dReconstructConstants.needRescan] for more.
  final String needRescan;

  /// Working mode for 3D object reconstruction.
  /// Check [Modeling3dReconstructConstants.reconstructMode] for more.
  final int reconstructMode;

  /// ID of the task on which an extra scanning task is based.
  final String taskId;

  /// Type of a 3D object reconstruction task.
  /// Check [Modeling3dReconstructConstants.taskType] for more.
  final int taskType;

  /// Texture map mode.
  /// Check [Modeling3dReconstructConstants.textureMode] for more.
  final int textureMode;

  const Modeling3dReconstructSetting({
    this.faceLevel = 0,
    this.needRescan = 'true',
    this.reconstructMode = 0,
    this.taskId = '0',
    this.taskType = 0,
    this.textureMode = 0,
  });

  Map<String, dynamic> _toMap() {
    return <String, dynamic>{
      'faceLevel': faceLevel,
      'needRescan': needRescan,
      'reconstructMode': reconstructMode,
      'taskId': taskId,
      'taskType': taskType,
      'textureMode': textureMode,
    };
  }
}
