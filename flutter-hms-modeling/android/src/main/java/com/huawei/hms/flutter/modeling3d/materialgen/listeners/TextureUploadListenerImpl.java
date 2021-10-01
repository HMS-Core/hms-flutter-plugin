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

package com.huawei.hms.flutter.modeling3d.materialgen.listeners;

import android.app.Activity;
import android.os.Handler;
import android.os.Looper;

import com.huawei.hms.flutter.modeling3d.utils.HMSLogger;
import com.huawei.hms.flutter.modeling3d.utils.ToMap;
import com.huawei.hms.materialgeneratesdk.cloud.Modeling3dTextureUploadListener;
import com.huawei.hms.materialgeneratesdk.cloud.Modeling3dTextureUploadResult;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class TextureUploadListenerImpl implements Modeling3dTextureUploadListener {
    private final Handler handler = new Handler(Looper.getMainLooper());
    private final Activity activity;
    private final MethodChannel methodChannel;

    public TextureUploadListenerImpl(Activity activity, MethodChannel ch) {
        this.activity = activity;
        this.methodChannel = ch;
    }

    @Override
    public void onUploadProgress(String s, double v, Object o) {
        Map<String, Object> m1 = new HashMap<>();
        m1.put("event", "onUploadProgress");
        m1.put("taskId", s);
        m1.put("progress", v);
        m1.put("ext", o);
        HMSLogger.getInstance(activity).sendPeriodicEvent("#materialGen-uploadFiles");
        invoke("textureUploadProgress", m1);
    }

    @Override
    public void onResult(String s, Modeling3dTextureUploadResult modeling3dTextureUploadResult, Object o) {
        Map<String, Object> m2 = new HashMap<>();
        m2.put("event", "onResult");
        m2.put("taskId", s);
        m2.put("result", ToMap.textureUploadToMap(modeling3dTextureUploadResult));
        m2.put("ext", o);
        HMSLogger.getInstance(activity).sendPeriodicEvent("#materialGen-uploadFiles");
        invoke("textureUploadResult", m2);
    }

    @Override
    public void onError(String s, int i, String s1) {
        Map<String, Object> m3 = new HashMap<>();
        m3.put("event", "onError");
        m3.put("taskId", s);
        m3.put("errorCode", i);
        m3.put("message", s1);
        HMSLogger.getInstance(activity).sendPeriodicEvent("#materialGen-uploadFiles", String.valueOf(i));
        invoke("textureUploadError", m3);
    }
    
    private void invoke(String action, Map<String, Object> map) {
        handler.post(() -> methodChannel.invokeMethod(action, map));
    }
}
