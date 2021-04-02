/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.ml.transactors;

import android.app.Activity;
import android.util.SparseArray;

import com.huawei.hms.flutter.ml.image.ClassificationMethodHandler;
import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.EventHandler;
import com.huawei.hms.mlsdk.classification.MLImageClassification;
import com.huawei.hms.mlsdk.common.MLAnalyzer;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

public class ClassificationTransactor implements MLAnalyzer.MLTransactor<MLImageClassification> {

    private Activity activity;

    public ClassificationTransactor(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void destroy() {

    }

    @Override
    public void transactResult(MLAnalyzer.Result<MLImageClassification> result) {
        Map<String, Object> map = new HashMap<>();

        SparseArray<MLImageClassification> faceSparseArray = result.getAnalyseList();
        MLImageClassification classification = faceSparseArray.get(0);

        map.put("isAnalyzerAvailable", result.isAnalyzerAvaliable());
        map.put("result", ClassificationMethodHandler.clsToJSON(classification));
        sendEvent(new JSONObject(map).toString());
    }

    private void sendEvent(final String event) {
        HMSLogger.getInstance(activity.getApplicationContext()).sendPeriodicEvent("liveClassificationAnalyze");
        EventHandler.getInstance().getUiHandler().post(() -> EventHandler.getInstance().getEventSink().success(event));
    }
}
