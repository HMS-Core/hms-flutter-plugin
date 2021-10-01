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

package com.huawei.hms.flutter.modeling3d.utils;

import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructDownloadResult;
import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructInitResult;
import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructQueryResult;
import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructUploadResult;

import java.util.HashMap;
import java.util.Map;

public final class ObjectMapper {

    private ObjectMapper() {
    }

    public static Map<String, Object> toMap(final Modeling3dReconstructInitResult initResult) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("taskId", initResult.getTaskId());
        resultMap.put("retCode", initResult.getRetCode());
        resultMap.put("retMsg", initResult.getRetMsg());
        return resultMap;
    }

    public static Map<String, Object> toMap(final Modeling3dReconstructQueryResult initResult) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("taskId", initResult.getTaskId());
        resultMap.put("status", initResult.getStatus());
        resultMap.put("retCode", initResult.getRetCode());
        resultMap.put("retMsg", initResult.getRetMessage());
        return resultMap;
    }

    public static Map<String, Object> toMap(final Modeling3dReconstructUploadResult uploadResult) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("taskId", uploadResult.getTaskId());
        resultMap.put("isComplete", uploadResult.isComplete());
        return resultMap;
    }

    public static Object toMap(Modeling3dReconstructDownloadResult downloadResult) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("taskId", downloadResult.getTaskId());
        resultMap.put("isComplete", downloadResult.isComplete());
        return resultMap;
    }

    public static Map<String, Object> toErrorMap(String taskId, int errorCode, String errorMessage) {
        HashMap<String, Object> errorMap = new HashMap<>();
        errorMap.put("taskId", taskId);
        errorMap.put("errorCode", errorCode);
        errorMap.put("errorMessage", errorMessage);
        return errorMap;
    }

    public static Map<String, Object> toProgressMap(String taskId, double progress) {
        HashMap<String, Object> progressMap = new HashMap<>();
        progressMap.put("taskId", taskId);
        progressMap.put("progress", progress);
        return progressMap;
    }

}
