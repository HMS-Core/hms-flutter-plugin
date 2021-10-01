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

/// Settings for 3D object reconstruction.
class Modeling3dReconstructSetting {
  late int reconstructMode;
  Modeling3dReconstructSetting({
    required this.reconstructMode,
  });

  Map<String, dynamic> toMap() {
    return {'reconstructMode': reconstructMode};
  }

  factory Modeling3dReconstructSetting.fromMap(Map<String, dynamic> map) {
    return Modeling3dReconstructSetting(
      reconstructMode: map['reconstructMode'],
    );
  }
}
