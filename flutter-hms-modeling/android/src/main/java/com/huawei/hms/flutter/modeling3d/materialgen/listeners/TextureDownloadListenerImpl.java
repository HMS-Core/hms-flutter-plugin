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

package com.huawei.hms.flutter.modeling3d.materialgen.listeners;

import android.app.Activity;
import android.os.Handler;
import android.os.Looper;

import com.huawei.hms.flutter.modeling3d.utils.HMSLogger;
import com.huawei.hms.flutter.modeling3d.utils.ToMap;
import com.huawei.hms.materialgeneratesdk.cloud.Modeling3dTextureDownloadListener;
import com.huawei.hms.materialgeneratesdk.cloud.Modeling3dTextureDownloadResult;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class TextureDownloadListenerImpl implements Modeling3dTextureDownloadListener {
    private final Activity activity;
    private final MethodChannel methodChannel;
    private final Handler handler = new Handler(Looper.getMainLooper());

    public TextureDownloadListenerImpl(Activity activity, MethodChannel methodChannel) {
        this.activity = activity;
        this.methodChannel = methodChannel;
    }

    @Override
    public void onDownloadProgress(String s, double v, Object o) {
        final Map<String, Object> map = new HashMap<>();
        map.put("taskId", s);
        map.put("progress", v);
        map.put("ext", o);
        HMSLogger.getInstance(activity).sendPeriodicEvent("#materialGen-downloadTexture");
        invoke("textureDownloadProgress", map);
    }

    @Override
    public void onResult(String s, Modeling3dTextureDownloadResult modeling3dTextureDownloadResult, Object o) {
        final Map<String, Object> map = new HashMap<>();
        map.put("taskId", s);
        map.put("result", ToMap.textureDownloadToMap(modeling3dTextureDownloadResult));
        map.put("ext", o);
        HMSLogger.getInstance(activity).sendPeriodicEvent("#materialGen-downloadTexture");
        invoke("textureDownloadResult", map);
    }

    @Override
    public void onError(String s, int i, String s1) {
        final Map<String, Object> map = new HashMap<>();
        map.put("taskId", s);
        map.put("errorCode", i);
        map.put("message", s1);
        HMSLogger.getInstance(activity).sendPeriodicEvent("#materialGen-downloadTexture", String.valueOf(i));
        invoke("textureDownloadError", map);
    }

    private void invoke(final String action, final Map<String, Object> map) {
        handler.post(() -> methodChannel.invokeMethod(action, map));
    }
}
