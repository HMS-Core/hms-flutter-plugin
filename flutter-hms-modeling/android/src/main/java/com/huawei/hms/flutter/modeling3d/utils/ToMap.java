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

import com.huawei.hms.materialgeneratesdk.cloud.Modeling3dTextureDownloadResult;
import com.huawei.hms.materialgeneratesdk.cloud.Modeling3dTextureInitResult;
import com.huawei.hms.materialgeneratesdk.cloud.Modeling3dTextureQueryResult;
import com.huawei.hms.materialgeneratesdk.cloud.Modeling3dTextureUploadResult;

import java.util.HashMap;
import java.util.Map;

public class ToMap {
    public static Map<String, Object> textureDownloadToMap(Modeling3dTextureDownloadResult result) {
        final Map<String, Object> map = new HashMap<>();
        map.put("taskId", result.getTaskId());
        map.put("isComplete", result.isComplete());
        return map;
    }

    public static Map<String, Object> textureUploadToMap(Modeling3dTextureUploadResult result) {
        final Map<String, Object> map = new HashMap<>();
        map.put("taskId", result.getTaskId());
        map.put("isComplete", result.isComplete());
        return map;
    }

    public static Map<String, Object> textureInitToMap(Modeling3dTextureInitResult result) {
        final Map<String, Object> map = new HashMap<>();
        map.put("taskId", result.getTaskId());
        map.put("retCode", result.getRetCode());
        map.put("retMsg", result.getRetMsg());
        return map;
    }

    public static Map<String, Object> textureQueryToMap(Modeling3dTextureQueryResult result) {
        final Map<String, Object> map = new HashMap<>();
        map.put("taskId", result.getTaskId());
        map.put("status", result.getStatus());
        map.put("retCode", result.getRetCode());
        map.put("retMsg", result.getRetMessage());
        return map;
    }
}
