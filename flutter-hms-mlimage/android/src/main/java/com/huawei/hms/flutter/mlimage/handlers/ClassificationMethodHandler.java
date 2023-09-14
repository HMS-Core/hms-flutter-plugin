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

import com.huawei.hms.flutter.mlimage.constant.Method;
import com.huawei.hms.flutter.mlimage.constant.Param;
import com.huawei.hms.flutter.mlimage.utils.MLResponseHandler;
import com.huawei.hms.flutter.mlimage.utils.SettingCreator;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.classification.MLImageClassification;
import com.huawei.hms.mlsdk.classification.MLImageClassificationAnalyzer;
import com.huawei.hms.mlsdk.common.MLFrame;

import org.json.JSONArray;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class ClassificationMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = ClassificationMethodHandler.class.getSimpleName();

    private final MLResponseHandler responseHandler;

    private MLImageClassificationAnalyzer classificationAnalyzer;

    public ClassificationMethodHandler(Activity activity) {
        this.responseHandler = MLResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        responseHandler.setup(TAG, call.method, result);
        switch (call.method) {
            case Method.ASYNC_CLASSIFICATION:
                asyncClassification(call);
                break;
            case Method.SYNC_CLASSIFICATION:
                syncClassification(call);
                break;
            case Method.GET_ANALYZER_TYPE:
                getType();
                break;
            case Method.STOP:
                stop();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    public static JSONArray createClassificationsJSON(List<MLImageClassification> classifications) {
        ArrayList<Map<String, Object>> clsList = new ArrayList<>();
        for (int i = 0; i < classifications.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLImageClassification classification = classifications.get(i);
            map.put(Param.CLASSIFICATION_IDENTITY, classification.getClassificationIdentity());
            map.put(Param.NAME, classification.getName());
            map.put(Param.POSSIBILITY, classification.getPossibility());
            clsList.add(map);
        }
        return new JSONArray(clsList);
    }

    private void getClsList(SparseArray<MLImageClassification> sparseArray) {
        List<MLImageClassification> list = new ArrayList<>(sparseArray.size());
        for (int i = 0; i < sparseArray.size(); i++) {
            list.add(sparseArray.get(i));
        }
        responseHandler.success(createClassificationsJSON(list).toString());
    }

    private void asyncClassification(@NonNull MethodCall call) {
        String path = call.argument(Param.PATH);
        Boolean isRemote = call.argument(Param.IS_REMOTE);

        if (isRemote != null && isRemote) {
            classificationAnalyzer = MLAnalyzerFactory.getInstance().getRemoteImageClassificationAnalyzer(SettingCreator.getRemoteClsSetting(call));

            MLFrame frame = SettingCreator.frameFromBitmap(path);

            classificationAnalyzer.asyncAnalyseFrame(frame)
                    .addOnSuccessListener(classifications -> responseHandler.success(createClassificationsJSON(classifications).toString()))
                    .addOnFailureListener(responseHandler::exception);
        } else {
            classificationAnalyzer = MLAnalyzerFactory.getInstance().getLocalImageClassificationAnalyzer(SettingCreator.getLocalClsSetting(call));

            MLFrame frame = SettingCreator.frameFromBitmap(path);

            classificationAnalyzer.asyncAnalyseFrame(frame)
                    .addOnSuccessListener(classifications -> responseHandler.success(createClassificationsJSON(classifications).toString()))
                    .addOnFailureListener(responseHandler::exception);
        }
    }

    private void syncClassification(@NonNull MethodCall call) {
        String path = call.argument(Param.PATH);
        Boolean isRemote = call.argument(Param.IS_REMOTE);

        if (isRemote != null && isRemote) {
            classificationAnalyzer = MLAnalyzerFactory.getInstance().getRemoteImageClassificationAnalyzer(SettingCreator.getRemoteClsSetting(call));

            MLFrame frame = SettingCreator.frameFromBitmap(path);

            SparseArray<MLImageClassification> sparseArray = classificationAnalyzer.analyseFrame(frame);
            getClsList(sparseArray);
        } else {
            classificationAnalyzer = MLAnalyzerFactory.getInstance().getLocalImageClassificationAnalyzer(SettingCreator.getLocalClsSetting(call));

            MLFrame frame = SettingCreator.frameFromBitmap(path);

            SparseArray<MLImageClassification> sparseArray = classificationAnalyzer.analyseFrame(frame);
            getClsList(sparseArray);
        }
    }

    private void getType() {
        if (classificationAnalyzer == null) {
            responseHandler.noService();
            return;
        }
        responseHandler.success(classificationAnalyzer.getAnalyzerType());
    }

    private void stop() {
        if (classificationAnalyzer == null) {
            responseHandler.noService();
            return;
        }
        try {
            classificationAnalyzer.stop();
            classificationAnalyzer = null;
            responseHandler.success(true);
        } catch (IOException ee) {
            responseHandler.exception(ee);
        }
    }
}
