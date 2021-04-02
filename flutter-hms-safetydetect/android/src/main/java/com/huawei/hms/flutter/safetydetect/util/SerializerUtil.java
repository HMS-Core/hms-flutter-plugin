/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.safetydetect.util;

import com.huawei.hms.support.api.entity.safetydetect.MaliciousAppsData;

import java.util.HashMap;
import java.util.Map;

public final class SerializerUtil {
    private SerializerUtil() {
    }

    public static Map<String, Object> serializeMaliciousAppData(MaliciousAppsData maliciousAppsData) {
        HashMap<String, Object> serializedMap = new HashMap<>();
        serializedMap.put("apkCategory", maliciousAppsData.getApkCategory());
        serializedMap.put("apkPackageName", maliciousAppsData.getApkPackageName());
        serializedMap.put("apkSha256", maliciousAppsData.getApkSha256());
        return serializedMap;
    }
}
