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

package com.huawei.hms.flutter.mlimage.handlers;

import android.app.Activity;
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mlimage.constant.Param;
import com.huawei.hms.flutter.mlimage.constant.Method;
import com.huawei.hms.flutter.mlimage.utils.Commons;
import com.huawei.hms.flutter.mlimage.utils.FromMap;
import com.huawei.hms.flutter.mlimage.utils.MLResponseHandler;
import com.huawei.hms.flutter.mlimage.utils.SettingCreator;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.objects.MLObject;
import com.huawei.hms.mlsdk.objects.MLObjectAnalyzer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class ObjectDetectionMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = ObjectDetectionMethodHandler.class.getSimpleName();

    private final MLResponseHandler responseHandler;

    private MLObjectAnalyzer objectAnalyzer;

    public ObjectDetectionMethodHandler(Activity activity) {
        this.responseHandler = MLResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        responseHandler.setup(TAG, call.method, result);
        switch (call.method) {
            case Method.STOP_OBJECT_DETECTION:
                stopAnalyzer();
                break;
            case Method.ASYNC_ANALYZE_FRAME:
                asyncAnalyzeFrame(call);
                break;
            case Method.ANALYZE_FRAME:
                analyzeFrame(call);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void asyncAnalyzeFrame(@NonNull MethodCall call) {
        String objectImagePath = FromMap.toString(Param.PATH, call.argument(Param.PATH), false);

        objectAnalyzer = MLAnalyzerFactory.getInstance().getLocalObjectAnalyzer(SettingCreator.createObjectAnalyzerSetting(call));

        MLFrame frame = SettingCreator.frameFromBitmap(objectImagePath);

        objectAnalyzer.asyncAnalyseFrame(frame)
                .addOnSuccessListener(mlObjects -> responseHandler.success(objectToJSONArray(mlObjects)))
                .addOnFailureListener(responseHandler::exception);

    }

    private void analyzeFrame(@NonNull MethodCall call) {
        String objectImagePath1 = FromMap.toString(Param.PATH, call.argument(Param.PATH), false);

        objectAnalyzer = MLAnalyzerFactory.getInstance().getLocalObjectAnalyzer(SettingCreator.createObjectAnalyzerSetting(call));

        MLFrame frame = SettingCreator.frameFromBitmap(objectImagePath1);

        SparseArray<MLObject> objects = objectAnalyzer.analyseFrame(frame);
        List<MLObject> list = new ArrayList<>(objects.size());
        for (int i = 0; i < objects.size(); i++) {
            list.add(objects.get(i));
        }

        responseHandler.success(objectToJSONArray(list));
    }

    private void stopAnalyzer() {
        if (objectAnalyzer == null) {
            responseHandler.noService();
            return;
        }

        try {
            objectAnalyzer.stop();
            objectAnalyzer = null;
            responseHandler.success(true);
        } catch (IOException e) {
            responseHandler.exception(e);
        }
    }

    public static ArrayList<Map<String, Object>> objectToJSONArray(List<MLObject> list) {
        ArrayList<Map<String, Object>> obList = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLObject object = list.get(i);
            map.put(Param.BORDER, Commons.createBorderMap(object.getBorder()));
            map.put(Param.POSSIBILITY, object.getTypePossibility());
            map.put(Param.TRACING_IDENTITY, object.getTracingIdentity());
            map.put(Param.TYPE, object.getTypeIdentity());
            obList.add(map);
        }
        return obList;
    }
}
