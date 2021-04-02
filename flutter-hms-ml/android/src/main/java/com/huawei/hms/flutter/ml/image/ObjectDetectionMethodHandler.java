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
import com.huawei.hms.flutter.ml.utils.tojson.FaceToJson;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.ml.utils.SettingUtils;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.objects.MLObject;
import com.huawei.hms.mlsdk.objects.MLObjectAnalyzer;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class ObjectDetectionMethodHandler implements MethodChannel.MethodCallHandler, EventChannel.StreamHandler {
    private static String TAG = ObjectDetectionMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;
    private MLObjectAnalyzer analyzer;

    public ObjectDetectionMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "asyncAnalyzeFrame":
                asyncAnalyzeFrame(call);
                break;
            case "analyzeFrame":
                analyzeFrame(call);
                break;
            case "stopObjectAnalyzer":
                stopAnalyzer();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    public static JSONObject objJSON(MLObject object) {
        Map<String, Object> map = new HashMap<>();
        map.put("border", FaceToJson.createBorderJSON(object.getBorder()));
        map.put("possibility", object.getTypePossibility());
        map.put("tracingIdentity", object.getTracingIdentity());
        map.put("type", object.getTypeIdentity());
        return new JSONObject(map);
    }

    private @NonNull
    JSONArray objectToJSONArray(@NonNull List<MLObject> list) {
        ArrayList<Map<String, Object>> obList = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLObject object = list.get(i);
            map.put("border", FaceToJson.createBorderJSON(object.getBorder()));
            map.put("possibility", object.getTypePossibility());
            map.put("tracingIdentity", object.getTracingIdentity());
            map.put("type", object.getTypeIdentity());
            obList.add(map);
        }
        return new JSONArray(obList);
    }

    private void asyncAnalyzeFrame(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("asyncObjectDetection");
        final String objectImagePath = call.argument("path");
        final String objectFrameType = call.argument("frameType");

        if (objectImagePath == null || objectImagePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncObjectDetection", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }
        analyzer = MLAnalyzerFactory.getInstance().getLocalObjectAnalyzer(SettingUtils.createObjectAnalyzerSetting(call));

        MLFrame frame = SettingUtils.createMLFrame(
                activity,
                objectFrameType != null ? objectFrameType : "fromBitmap",
                objectImagePath,
                call);
        FrameHolder.getInstance().setFrame(frame);

        Task<List<MLObject>> asyncObjectTask = analyzer.asyncAnalyseFrame(frame);
        asyncObjectTask.addOnSuccessListener(mlObjects -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncObjectDetection");
            mResult.success(objectToJSONArray(mlObjects).toString());
        }).addOnFailureListener(objectError -> HmsMlUtils.handleException(activity, TAG, objectError, "asyncObjectDetection", mResult));

    }

    private void analyzeFrame(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("syncObjectDetection");
        final String objectImagePath1 = call.argument("path");
        final String objectFrameType1 = call.argument("frameType");

        if (objectImagePath1 == null || objectImagePath1.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncObjectDetection", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }
        analyzer = MLAnalyzerFactory.getInstance().getLocalObjectAnalyzer(SettingUtils.createObjectAnalyzerSetting(call));

        MLFrame frame = SettingUtils.createMLFrame(
                activity,
                objectFrameType1 != null ? objectFrameType1 : "fromBitmap",
                objectImagePath1,
                call);
        FrameHolder.getInstance().setFrame(frame);

        SparseArray<MLObject> objects = analyzer.analyseFrame(frame);
        List<MLObject> list = new ArrayList<>(objects.size());
        for (int i = 0; i < objects.size(); i++) {
            list.add(objects.get(i));
        }
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncObjectDetection");
        mResult.success(objectToJSONArray(list).toString());
    }

    private void stopAnalyzer() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stopObjectAnalyzer");
        if (analyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopObjectAnalyzer", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyzer is not initalized", MlConstants.UNINITIALIZED_ANALYZER);
        } else {
            try {
                analyzer.stop();
                analyzer = null;
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopObjectAnalyzer");
                mResult.success(true);
            } catch (IOException e) {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopObjectAnalyzer", e.getMessage());
                mResult.error(TAG, e.getMessage(), "");
            }
        }
    }

    @Override
    public void onListen(Object o, EventChannel.EventSink eve) {
        EventHandler.getInstance().setEventSink(eve);
    }

    @Override
    public void onCancel(Object ar) {
        EventHandler.getInstance().setEventSink(null);
    }
}
