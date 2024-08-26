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
import com.huawei.hms.mlsdk.face.MLFace;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class FaceTransactor implements MLAnalyzer.MLTransactor<MLFace> {
    private final Handler h2 = new Handler(Looper.getMainLooper());
    private final Activity activity2;
    private final MethodChannel channel2;

    public FaceTransactor(Activity a, MethodChannel c) {
        this.activity2 = a;
        this.channel2 = c;
    }

    @Override
    public void transactResult(MLAnalyzer.Result<MLFace> result) {
        Map<String, Object> map = new HashMap<>();

        SparseArray<MLFace> faceSparseArray = result.getAnalyseList();

        List<MLFace> arrayList = new ArrayList<>(faceSparseArray.size());
        for (int i = 0; i < faceSparseArray.size(); i++) {
            arrayList.add(faceSparseArray.valueAt(i));
        }
        map.put("result", ToMap.FaceToMap.createMLFaceJSON(arrayList));
        invoke(map);
    }

    @Override
    public void destroy() {
    }

    private void invoke(final Map<String, Object> args) {
        HMSLogger.getInstance(activity2).sendPeriodicEvent("face#transaction");
        h2.post(() -> channel2.invokeMethod("face", args));
    }
}
