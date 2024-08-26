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
import com.huawei.hms.mlsdk.skeleton.MLSkeleton;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class SkeletonTransactor implements MLAnalyzer.MLTransactor<MLSkeleton> {
    private final Handler h5 = new Handler(Looper.getMainLooper());
    private final Activity activity5;
    private final MethodChannel channel5;

    public SkeletonTransactor(Activity a, MethodChannel c) {
        this.activity5 = a;
        this.channel5 = c;
    }

    @Override
    public void transactResult(MLAnalyzer.Result<MLSkeleton> result) {
        Map<String, Object> m = new HashMap<>();

        SparseArray<MLSkeleton> sparseArray = result.getAnalyseList();
        List<MLSkeleton> arrayList = new ArrayList<>(sparseArray.size());
        for (int i = 0; i < sparseArray.size(); i++) {
            arrayList.add(sparseArray.valueAt(i));
        }
        m.put("result", ToMap.SkeletonToMap.skeletonToJSONArray(arrayList));
        invoke(m);
    }

    @Override
    public void destroy() {
    }

    private void invoke(final Map<String, Object> args) {
        HMSLogger.getInstance(activity5).sendPeriodicEvent("skeletonTransaction");
        h5.post(() -> channel5.invokeMethod("skeleton", args));
    }
}
