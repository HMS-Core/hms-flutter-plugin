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

import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.EventHandler;
import com.huawei.hms.flutter.ml.utils.tojson.FaceToJson;
import com.huawei.hms.mlsdk.common.MLAnalyzer;
import com.huawei.hms.mlsdk.common.MLResultTrailer;
import com.huawei.hms.mlsdk.face.MLFace;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

public class MaxFaceTransactor extends MLResultTrailer<MLFace> {
    private Activity activity;

    public MaxFaceTransactor(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void objectCreateCallback(int var1, MLFace var2) {
        Map<String, Object> mainMap = new HashMap<>();
        Map<String, Object> map = new HashMap<>();
        map.put("itemId", var1);
        map.put("face", FaceToJson.liveFaceJSON(var2));
        mainMap.put("objectCreateCallback", map);
        HMSLogger.getInstance(activity.getApplicationContext()).sendPeriodicEvent("objectCreateCallback");
        sendEvent(new JSONObject(mainMap).toString());
    }

    @Override
    public void objectUpdateCallback(MLAnalyzer.Result<MLFace> result, MLFace var2) {
        Map<String, Object> mainMap = new HashMap<>();
        Map<String, Object> map = new HashMap<>();
        SparseArray<MLFace> faceSparseArray = result.getAnalyseList();
        MLFace face = faceSparseArray.get(0);
        map.put("result", FaceToJson.liveFaceJSON(face));
        map.put("isAnalyzerAvailable", result.isAnalyzerAvaliable());
        mainMap.put("objectUpdateCallback", map);
        HMSLogger.getInstance(activity.getApplicationContext()).sendPeriodicEvent("objectUpdateCallback");
        sendEvent(new JSONObject(mainMap).toString());
    }

    @Override
    public void lostCallback(MLAnalyzer.Result<MLFace> result) {
        Map<String, Object> mainMap = new HashMap<>();
        SparseArray<MLFace> faceSparseArray = result.getAnalyseList();
        MLFace face = faceSparseArray.get(0);
        mainMap.put("lostCallback", FaceToJson.liveFaceJSON(face));
        HMSLogger.getInstance(activity.getApplicationContext()).sendPeriodicEvent("lostCallback");
        sendEvent(new JSONObject(mainMap).toString());
    }

    @Override
    public void completeCallback() {
        Map<String, Object> mainMap = new HashMap<>();
        Map<String, Object> map = new HashMap<>();
        map.put("onComplete", true);
        mainMap.put("completeCallback", map);
        HMSLogger.getInstance(activity.getApplicationContext()).sendPeriodicEvent("completeCallback");
        sendEvent(new JSONObject(mainMap).toString());
    }

    private void sendEvent(final String event) {
        EventHandler.getInstance().getUiHandler().post(() -> EventHandler.getInstance().getEventSink().success(event));
    }
}
