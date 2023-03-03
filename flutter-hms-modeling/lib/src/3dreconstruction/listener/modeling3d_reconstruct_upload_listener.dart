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

/// Listens for image upload.
class Modeling3dReconstructUploadListener {
  /// Callback when the upload progress is received.
  final void Function(
    String taskId,
    double progress,
  )? onUploadProgress;

  /// Callback when the upload result is received.
  final void Function(
    String taskId,
    Modeling3dReconstructUploadResult result,
  )? onResult;

  /// Callback when an error occurs during upload.
  final void Function(
    String taskId,
    int errorCode,
    String message,
  )? onError;

  const Modeling3dReconstructUploadListener({
    this.onUploadProgress,
    this.onResult,
    this.onError,
  });
}
