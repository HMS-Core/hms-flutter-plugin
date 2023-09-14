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

import com.huawei.hms.flutter.mlimage.constant.Param;
import com.huawei.hms.flutter.mlimage.logger.HMSLogger;
import com.huawei.hms.mlsdk.classification.MLImageClassification;
import com.huawei.hms.mlsdk.common.MLAnalyzer;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class ClassificationTransactor implements MLAnalyzer.MLTransactor<MLImageClassification> {
    private final Handler h1 = new Handler(Looper.getMainLooper());
    private final Activity activity;
    private final MethodChannel channel;

    public ClassificationTransactor(Activity activity, MethodChannel channel) {
        this.activity = activity;
        this.channel = channel;
    }

    @Override
    public void destroy() {

    }

    @Override
    public void transactResult(MLAnalyzer.Result<MLImageClassification> result) {
        Map<String, Object> map = new HashMap<>();

        SparseArray<MLImageClassification> sparseArray = result.getAnalyseList();
        List<MLImageClassification> cls = new ArrayList<>(sparseArray.size());
        for (int i = 0; i < sparseArray.size(); i++) {
            cls.add(sparseArray.valueAt(i));
        }
        map.put("result", clsList(cls));
        invoke(map);
    }

    private void invoke(Map<String, Object> map) {
        HMSLogger.getInstance(activity).sendPeriodicEvent("classificationStream");
        h1.post(() -> channel.invokeMethod("classification", map));
    }

    private ArrayList<Map<String, Object>> clsList(List<MLImageClassification> classifications) {
        ArrayList<Map<String, Object>> clsList = new ArrayList<>();
        for (int i = 0; i < classifications.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLImageClassification classification = classifications.get(i);
            map.put(Param.CLASSIFICATION_IDENTITY, classification.getClassificationIdentity());
            map.put(Param.NAME, classification.getName());
            map.put(Param.POSSIBILITY, classification.getPossibility());
            clsList.add(map);
        }
        return clsList;
    }
}
