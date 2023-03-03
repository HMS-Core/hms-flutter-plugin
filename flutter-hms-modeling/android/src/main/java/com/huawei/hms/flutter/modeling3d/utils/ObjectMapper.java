/*
 * Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.huawei.hms.flutter.modeling3d.utils;

import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructDownloadResult;
import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructInitResult;
import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructQueryResult;
import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructUploadResult;

import java.util.HashMap;
import java.util.Map;

public final class ObjectMapper {
    public static Map<String, Object> toMap(final Modeling3dReconstructInitResult initResult) {
        final Map<String, Object> map = new HashMap<>();
        map.put("taskId", initResult.getTaskId());
        map.put("retCode", initResult.getRetCode());
        map.put("retMsg", initResult.getRetMsg());
        return map;
    }

    public static Map<String, Object> toMap(Modeling3dReconstructQueryResult queryResult) {
        final Map<String, Object> map = new HashMap<>();
        map.put("taskId", queryResult.getTaskId());
        map.put("status", queryResult.getStatus());
        map.put("retCode", queryResult.getRetCode());
        map.put("retMsg", queryResult.getRetMessage());
        map.put("modelFormat", queryResult.getModelFormat());
        map.put("reconstructFailMessage", queryResult.getReconstructFailMessage());
        return map;
    }

    public static Map<String, Object> toMap(final Modeling3dReconstructUploadResult uploadResult) {
        final Map<String, Object> map = new HashMap<>();
        map.put("taskId", uploadResult.getTaskId());
        map.put("isComplete", uploadResult.isComplete());
        return map;
    }

    public static Map<String, Object> toMap(Modeling3dReconstructDownloadResult downloadResult) {
        final Map<String, Object> map = new HashMap<>();
        map.put("taskId", downloadResult.getTaskId());
        map.put("isComplete", downloadResult.isComplete());
        return map;
    }

    public static Map<String, Object> toErrorMap(String taskId, int errorCode, String errorMessage) {
        final Map<String, Object> map = new HashMap<>();
        map.put("taskId", taskId);
        map.put("errorCode", errorCode);
        map.put("errorMessage", errorMessage);
        return map;
    }

    public static Map<String, Object> toProgressMap(String taskId, double progress) {
        final Map<String, Object> map = new HashMap<>();
        map.put("taskId", taskId);
        map.put("progress", progress);
        return map;
    }
}
