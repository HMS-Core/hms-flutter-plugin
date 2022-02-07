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

import 'ml_remote_aft_result.dart';

part 'aft_callbacks.dart';

class MLRemoteAftListener {
  /// Called if an audio transcription error occurs.
  _OnError onError;

  /// Reserved.
  _OnEvent onEvent;

  /// Reserved.
  _OnInitComplete onInitComplete;

  /// Called when the audio transcription result is returned on the cloud.
  _OnResult onResult;

  /// Reserved.
  _OnUploadProgress onUploadProgress;

  MLRemoteAftListener(
    this.onError,
    this.onEvent,
    this.onInitComplete,
    this.onResult,
    this.onUploadProgress,
  );
}
