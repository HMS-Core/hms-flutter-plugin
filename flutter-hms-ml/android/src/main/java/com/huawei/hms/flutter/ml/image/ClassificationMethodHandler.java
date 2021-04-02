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

package com.huawei.hms.flutter.ml.image;

import android.app.Activity;
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.EventHandler;
import com.huawei.hms.flutter.ml.utils.FrameHolder;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.flutter.ml.utils.SettingUtils;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.classification.MLImageClassification;
import com.huawei.hms.mlsdk.classification.MLImageClassificationAnalyzer;
import com.huawei.hms.mlsdk.common.MLFrame;

import org.json.JSONObject;
import org.json.JSONArray;

import java.io.IOException;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class ClassificationMethodHandler implements MethodChannel.MethodCallHandler, EventChannel.StreamHandler {
    private static String TAG = ClassificationMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;
    private MLImageClassificationAnalyzer analyzer;

    public ClassificationMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "asyncClassification":
                asyncClassification(call);
                break;
            case "syncClassification":
                syncClassification(call);
                break;
            case "getAnalyzerType":
                getType();
                break;
            case "stop":
                stop();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    public static JSONObject clsToJSON(MLImageClassification classification) {
        Map<String, Object> map = new HashMap<>();
        map.put("classificationIdentity", classification.getClassificationIdentity());
        map.put("name", classification.getName());
        map.put("possibility", classification.getPossibility());
        return new JSONObject(map);
    }

    private static @NonNull JSONArray createClassificationsJSON(@NonNull List<MLImageClassification> classifications) {
        ArrayList<Map<String, Object>> clsList = new ArrayList<>();
        for (int i = 0; i < classifications.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLImageClassification classification = classifications.get(i);
            map.put("classificationIdentity", classification.getClassificationIdentity());
            map.put("name", classification.getName());
            map.put("possibility", classification.getPossibility());
            clsList.add(map);
        }
        return new JSONArray(clsList);
    }

    private void getClsList(@NonNull SparseArray<MLImageClassification> sparseArray) {
        List<MLImageClassification> list = new ArrayList<>(sparseArray.size());
        for (int i = 0; i < sparseArray.size(); i++) {
            list.add(sparseArray.get(i));
        }
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncClassification");
        mResult.success(createClassificationsJSON(list).toString());
    }

    private void asyncClassification(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("asyncClassification");
        String path = call.argument("path");
        String frameType = call.argument("frameType");
        Boolean isRemote = call.argument("isRemote");

        if (isRemote != null && isRemote) {
            analyzer = MLAnalyzerFactory.getInstance().getRemoteImageClassificationAnalyzer(SettingUtils.getRemoteClsSetting(call));
            MLFrame frame = SettingUtils.createMLFrame(activity, frameType != null ? frameType : "fromBitmap", path, call);
            FrameHolder.getInstance().setFrame(frame);
            Task<List<MLImageClassification>> asyncTask = analyzer.asyncAnalyseFrame(frame);
            asyncTask.addOnSuccessListener(classifications -> {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncClassification");
                mResult.success(createClassificationsJSON(classifications).toString());
            }).addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "asyncClassification", mResult));
        } else {
            analyzer = MLAnalyzerFactory.getInstance().getLocalImageClassificationAnalyzer(SettingUtils.getLocalClsSetting(call));
            MLFrame frame = SettingUtils.createMLFrame(activity, frameType != null ? frameType : "fromBitmap", path, call);
            FrameHolder.getInstance().setFrame(frame);
            Task<List<MLImageClassification>> asyncTask1 = analyzer.asyncAnalyseFrame(frame);
            asyncTask1.addOnSuccessListener(classifications -> {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncClassification");
                mResult.success(createClassificationsJSON(classifications).toString());
            }).addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "asyncClassification", mResult));
        }
    }

    private void syncClassification(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("syncClassification");
        String path = call.argument("path");
        String frameType = call.argument("frameType");
        Boolean isRemote = call.argument("isRemote");

        if (isRemote != null && isRemote) {
            analyzer = MLAnalyzerFactory.getInstance().getRemoteImageClassificationAnalyzer(SettingUtils.getRemoteClsSetting(call));
            MLFrame frame = SettingUtils.createMLFrame(activity, frameType != null ? frameType : "fromBitmap", path, call);
            FrameHolder.getInstance().setFrame(frame);
            SparseArray<MLImageClassification> sparseArray = analyzer.analyseFrame(frame);
            getClsList(sparseArray);
        } else {
            analyzer = MLAnalyzerFactory.getInstance().getLocalImageClassificationAnalyzer(SettingUtils.getLocalClsSetting(call));
            MLFrame frame = SettingUtils.createMLFrame(activity, frameType != null ? frameType : "fromBitmap", path, call);
            FrameHolder.getInstance().setFrame(frame);
            SparseArray<MLImageClassification> sparseArray = analyzer.analyseFrame(frame);
            getClsList(sparseArray);
        }
    }

    private void getType() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getClassificationAnalyzerType");
        if (analyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getClassificationAnalyzerType", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyser is not initialized.", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getClassificationAnalyzerType");
        mResult.success(analyzer.getAnalyzerType());
    }

    private void stop() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stopClassificationAnalyzerType");
        if (analyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopClassificationAnalyzerType", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyser is not initialized.", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }
        try {
            analyzer.stop();
            analyzer = null;
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopClassificationAnalyzerType");
            mResult.success(true);
        } catch (IOException ee) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopClassificationAnalyzerType", ee.getMessage());
            mResult.error(TAG, ee.getMessage(), "");
        }
    }

    @Override
    public void onListen(Object ar, EventChannel.EventSink ev) {
        EventHandler.getInstance().setEventSink(ev);
    }

    @Override
    public void onCancel(Object ar) {
        EventHandler.getInstance().setEventSink(null);
    }
}
