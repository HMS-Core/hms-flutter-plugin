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

/// 3D object reconstruction download config.
class Modeling3dReconstructDownloadConfig {
  /// Model file format.
  /// Check [Modeling3dReconstructConstants.modelFormat] for more.
  final String modelFormat;

  /// Texture map mode.
  /// Check [Modeling3dReconstructConstants.textureMode] for more.
  final int textureMode;

  const Modeling3dReconstructDownloadConfig({
    this.modelFormat = 'OBJ',
    this.textureMode = 0,
  });

  Map<String, dynamic> _toMap() {
    return <String, dynamic>{
      'modelFormat': modelFormat,
      'textureMode': textureMode,
    };
  }
}
