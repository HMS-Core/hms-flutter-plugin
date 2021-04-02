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

package com.huawei.hms.flutter.ml.text;

import android.app.Activity;
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.google.gson.JsonObject;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.FrameHolder;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.SettingUtils;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.fr.MLFormRecognitionAnalyzer;
import com.huawei.hms.mlsdk.fr.MLFormRecognitionAnalyzerFactory;
import com.huawei.hms.mlsdk.fr.MLFormRecognitionAnalyzerSetting;
import com.huawei.hms.mlsdk.fr.MLFormRecognitionConstant;

import java.io.IOException;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class FormRecognitionMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = FormRecognitionMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;

    private MLFormRecognitionAnalyzer analyzer;

    public FormRecognitionMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "asyncFormAnalyze":
                asyncFormAnalyze(call);
                break;
            case "syncFormAnalyze":
                syncFormAnalyze(call);
                break;
            case "stopFormAnalyze":
                stopFormAnalyze();
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    private void asyncFormAnalyze(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("asyncFormRecognition");
        String formImage = call.argument("path");

        MLFormRecognitionAnalyzerSetting setting = new MLFormRecognitionAnalyzerSetting.Factory().create();
        analyzer = MLFormRecognitionAnalyzerFactory.getInstance().getFormRecognitionAnalyzer(setting);

        MLFrame mlFrame = SettingUtils.createMLFrame(activity, "fromBitmap", formImage, call);
        FrameHolder.getInstance().setFrame(mlFrame);

        Task<JsonObject> recognizeTask = analyzer.asyncAnalyseFrame(mlFrame);
        recognizeTask.addOnSuccessListener(recognizeResult -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncFormRecognition");
            mResult.success(recognizeResult.toString());
        }).addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "asyncFormRecognition", mResult));
    }

    private void syncFormAnalyze(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("syncFormRecognition");
        String formImage = call.argument("path");

        MLFormRecognitionAnalyzerSetting setting = new MLFormRecognitionAnalyzerSetting.Factory().create();
        analyzer = MLFormRecognitionAnalyzerFactory.getInstance().getFormRecognitionAnalyzer(setting);

        MLFrame mlFrame = SettingUtils.createMLFrame(activity, "fromBitmap", formImage, call);
        FrameHolder.getInstance().setFrame(mlFrame);
        SparseArray<JsonObject> recognizeResult = analyzer.analyseFrame(mlFrame);

        if (recognizeResult != null && recognizeResult.get(0).get("retCode").getAsInt() == MLFormRecognitionConstant.SUCCESS) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncFormRecognition");
            mResult.success(recognizeResult.get(0).toString());
        } else {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncFormRecognition", "-1");
            mResult.error(TAG, "Sync form recognition failed", "");
        }
    }

    private void stopFormAnalyze() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stopFormRecognition");
        try {
            analyzer.stop();
            analyzer = null;
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopFormRecognition");
            mResult.success(true);
        } catch (IOException e) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopFormRecognition", e.getMessage());
            mResult.error(TAG, e.getMessage(), "");
        }
    }
}
