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

import '../result/result_export.dart';

/// Error callback.
typedef void OnError(String taskId, int errorCode, String message);

/// Default result callback.
typedef void OnResult(String taskId);

/// Download progress callback.
typedef void OnDownloadProgress(String taskId, double progress);

/// Download result callback.
typedef void OnDownloadResult(
    String taskId, Modeling3dReconstructDownloadResult downloadResult);

/// Upload progress callback.
typedef void OnUploadProgress(String taskId, double progress);

/// Upload result callback.
typedef void OnUploadResult(
    String taskId, Modeling3dReconstructUploadResult uploadResult);
