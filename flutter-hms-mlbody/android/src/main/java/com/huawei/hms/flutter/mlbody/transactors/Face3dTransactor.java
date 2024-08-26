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
import com.huawei.hms.mlsdk.face.face3d.ML3DFace;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class Face3dTransactor implements MLAnalyzer.MLTransactor<ML3DFace> {
    private final Handler h1 = new Handler(Looper.getMainLooper());
    private final Activity activity1;
    private final MethodChannel channel1;

    public Face3dTransactor(Activity a, MethodChannel c) {
        this.activity1 = a;
        this.channel1 = c;
    }

    @Override
    public void transactResult(MLAnalyzer.Result<ML3DFace> result) {
        Map<String, Object> map = new HashMap<>();

        SparseArray<ML3DFace> items = result.getAnalyseList();

        List<ML3DFace> arrayList = new ArrayList<>(items.size());
        for (int i = 0; i < items.size(); i++) {
            arrayList.add(items.valueAt(i));
        }
        map.put("result", ToMap.FaceToMap.face3DToJSONArray(arrayList));
        invoke(map);
    }

    @Override
    public void destroy() {
    }

    private void invoke(final Map<String, Object> args) {
        HMSLogger.getInstance(activity1).sendPeriodicEvent("face3d#transaction");
        h1.post(() -> channel1.invokeMethod("face3d", args));
    }
}
