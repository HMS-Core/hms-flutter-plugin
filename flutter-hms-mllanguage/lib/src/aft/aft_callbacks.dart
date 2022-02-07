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

part of 'ml_remote_aft_listener.dart';

/// Called if an audio transcription error occurs.
typedef _OnError = void Function(String taskId, int errCode, String errMsg);

/// Reserved.
typedef _OnEvent = void Function(String taskId, int eventId);

/// Reserved.
typedef _OnInitComplete = void Function(String taskId);

/// Called when the audio transcription result is returned on the cloud.
typedef _OnResult = void Function(String taskId, MLRemoteAftResult result);

/// Reserved.
typedef _OnUploadProgress(String taskId, double progress);
