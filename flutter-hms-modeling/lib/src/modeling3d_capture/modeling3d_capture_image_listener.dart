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

/// Image listener for Modeling3d Capture
class Modeling3dCaptureImageListener {
  /// Callback when collection progress is received.
  final void Function(
    int progress,
  )? onProgress;

  ///Callback when image collection is complete.
  final void Function()? onResult;

  /// Callback when an error occurs during image collection.
  final void Function(
    int errorCode,
    String message,
  )? onError;

  const Modeling3dCaptureImageListener({
    this.onProgress,
    this.onResult,
    this.onError,
  });
}
