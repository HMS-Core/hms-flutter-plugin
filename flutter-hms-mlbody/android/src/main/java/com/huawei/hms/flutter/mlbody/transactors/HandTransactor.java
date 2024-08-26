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
import com.huawei.hms.mlsdk.handkeypoint.MLHandKeypoints;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class HandTransactor implements MLAnalyzer.MLTransactor<MLHandKeypoints> {
    private final Handler h4 = new Handler(Looper.getMainLooper());
    private final Activity activity4;
    private final MethodChannel channel4;

    public HandTransactor(Activity a, MethodChannel c) {
        this.activity4 = a;
        this.channel4 = c;
    }

    @Override
    public void destroy() {
    }

    @Override
    public void transactResult(MLAnalyzer.Result<MLHandKeypoints> result) {
        Map<String, Object> map = new HashMap<>();

        SparseArray<MLHandKeypoints> array = result.getAnalyseList();

        List<MLHandKeypoints> arrayList = new ArrayList<>(array.size());
        for (int i = 0; i < array.size(); i++) {
            arrayList.add(array.valueAt(i));
        }
        map.put("result", ToMap.HandToMap.handsToJSONArray(arrayList));
        invoke(map);
    }

    private void invoke(final Map<String, Object> args) {
        HMSLogger.getInstance(activity4).sendPeriodicEvent("handTransaction");
        h4.post(() -> channel4.invokeMethod("hand", args));
    }
}
