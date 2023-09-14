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

package com.huawei.hms.flutter.mlimage.transactors;

import android.app.Activity;
import android.os.Handler;
import android.os.Looper;
import android.util.SparseArray;

import com.huawei.hms.flutter.mlimage.handlers.SceneDetectionMethodHandler;
import com.huawei.hms.flutter.mlimage.logger.HMSLogger;
import com.huawei.hms.mlsdk.common.MLAnalyzer;
import com.huawei.hms.mlsdk.scd.MLSceneDetection;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class SceneTransactor implements MLAnalyzer.MLTransactor<MLSceneDetection> {
    private final Handler h3 = new Handler(Looper.getMainLooper());
    private final Activity activity;
    private final MethodChannel channel;

    public SceneTransactor(Activity activity, MethodChannel channel) {
        this.activity = activity;
        this.channel = channel;
    }

    @Override
    public void destroy() {

    }

    @Override
    public void transactResult(MLAnalyzer.Result<MLSceneDetection> result) {
        Map<String, Object> map1 = new HashMap<>();

        SparseArray<MLSceneDetection> array = result.getAnalyseList();

        List<MLSceneDetection> scenes = new ArrayList<>(array.size());
        for (int i = 0; i < array.size(); i++) {
            scenes.add(array.get(i));
        }
        map1.put("result", SceneDetectionMethodHandler.sceneListToJSON(scenes));
        invoke(map1);
    }

    private void invoke(Map<String, Object> map) {
        HMSLogger.getInstance(activity).sendPeriodicEvent("sceneStream");
        h3.post(() -> channel.invokeMethod("scene", map));
    }
}
