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

/// Model preview configuration for a 3D object reconstruction task.
class Modeling3dReconstructPreviewConfig {
  /// Texture map mode.
  /// Check [Modeling3dReconstructConstants.textureMode] for more.
  //
  /// Currently, only two modes are supported: normal mode and PBR mode.
  /// Preview is not supported for auto rigging.
  final int textureMode;

  const Modeling3dReconstructPreviewConfig({
    this.textureMode = 0,
  });

  Map<String, dynamic> _toMap() {
    return <String, dynamic>{
      'textureMode': textureMode,
    };
  }
}
