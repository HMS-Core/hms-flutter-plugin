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

part of modeling3d_capture;

/// Result codes related to 3D object reconstruction.
abstract class Modeling3dCaptureErrors {
  /// The device does not support the real-time guide mode.
  static const int ERR_DEVICE_NOT_SUPPORTED = 1300;

  /// Image path verification failed.
  static const int ERR_FILE_PATH_VERIFIED_FAILED = 1301;

  /// The parameter of the bounding hemisphere is invalid.
  static const int ERR_ILLEGAL_BOX_PARAMETER = 1302;

  /// Internal processing error.
  static const int ERR_INTERNAL_PROCESS = 1303;

  /// The required dependency is not integrated.
  static const int ERR_DEPENDENCY_NOT_INTEGRATED = 1304;
}
