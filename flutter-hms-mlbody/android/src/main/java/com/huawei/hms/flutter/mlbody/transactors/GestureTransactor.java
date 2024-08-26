/*
 * Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.mlbody.transactors;

import android.app.Activity;
import android.os.Handler;
import android.os.Looper;
import android.util.SparseArray;

import com.huawei.hms.flutter.mlbody.data.HMSLogger;
import com.huawei.hms.flutter.mlbody.data.ToMap;
import com.huawei.hms.mlsdk.common.MLAnalyzer;
import com.huawei.hms.mlsdk.gesture.MLGesture;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class GestureTransactor implements MLAnalyzer.MLTransactor<MLGesture> {
    private final Handler h3 = new Handler(Looper.getMainLooper());
    private final Activity activity3;
    private final MethodChannel channel3;

    public GestureTransactor(Activity activity, MethodChannel channel) {
        this.activity3 = activity;
        this.channel3 = channel;
    }

    @Override
    public void transactResult(MLAnalyzer.Result<MLGesture> result) {
        Map<String, Object> map = new HashMap<>();
        SparseArray<MLGesture> sparseArray = result.getAnalyseList();

        List<MLGesture> list = new ArrayList<>(sparseArray.size());
        for (int i = 0; i < sparseArray.size(); i++) {
            list.add(sparseArray.get(i));
        }
        map.put("result", ToMap.GestureToMap.onGestureAnalyzeSuccess(list));
        invoke(map);
    }

    @Override
    public void destroy() {
    }

    private void invoke(final Map<String, Object> args) {
        HMSLogger.getInstance(activity3).sendPeriodicEvent("gestureTransaction");
        h3.post(() -> channel3.invokeMethod("gesture", args));
    }
}
