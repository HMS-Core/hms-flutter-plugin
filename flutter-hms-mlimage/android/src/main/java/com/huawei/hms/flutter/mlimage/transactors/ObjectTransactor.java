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

import com.huawei.hms.flutter.mlimage.handlers.ObjectDetectionMethodHandler;
import com.huawei.hms.flutter.mlimage.logger.HMSLogger;
import com.huawei.hms.mlsdk.common.MLAnalyzer;
import com.huawei.hms.mlsdk.objects.MLObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class ObjectTransactor implements MLAnalyzer.MLTransactor<MLObject> {
    private final Handler h2 = new Handler(Looper.getMainLooper());
    private final Activity activity;
    private final MethodChannel channel;

    public ObjectTransactor(Activity activity, MethodChannel channel) {
        this.activity = activity;
        this.channel = channel;
    }

    @Override
    public void destroy() {

    }

    @Override
    public void transactResult(MLAnalyzer.Result<MLObject> result) {
        Map<String, Object> map = new HashMap<>();

        SparseArray<MLObject> array = result.getAnalyseList();

        List<MLObject> objects = new ArrayList<>(array.size());
        for (int i = 0; i < array.size(); i++) {
            objects.add(array.get(i));
        }
        map.put("result", ObjectDetectionMethodHandler.objectToJSONArray(objects));
        invoke(map);
    }

    private void invoke(Map<String, Object> map) {
        HMSLogger.getInstance(activity).sendPeriodicEvent("objectStream");
        h2.post(() -> channel.invokeMethod("object", map));
    }
}
