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

import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.EventHandler;
import com.huawei.hms.flutter.ml.utils.FrameHolder;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.ml.utils.SettingUtils;
import com.huawei.hms.flutter.ml.utils.tojson.TextToJson;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.text.MLText;
import com.huawei.hms.mlsdk.text.MLTextAnalyzer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class TextAnalyzerMethodHandler implements MethodChannel.MethodCallHandler, EventChannel.StreamHandler {
    private static String TAG = TextAnalyzerMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;
    private MLTextAnalyzer analyzer;

    public TextAnalyzerMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "asyncTextAnalyze":
                asyncTextAnalyze(call);
                break;
            case "syncTextAnalyze":
                syncTextAnalyze(call);
                break;
            case "getAnalyzeType":
                getAnalyzeType();
                break;
            case "isAvailable":
                isAnalyzerAvailable();
                break;
            case "stopTextAnalyzer":
                stopAnalyzer();
                break;
            default:
                break;
        }
    }

    private void asyncTextAnalyze(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("asyncTextAnalyze");
        String imagePath = call.argument("path");
        String textFrame = call.argument("frameType");
        Boolean isRemote = call.argument("isRemote");

        if (imagePath == null || imagePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncTextAnalyze", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        if (isRemote == null) isRemote = true;

        if (isRemote) {
            analyzer = MLAnalyzerFactory.getInstance().getRemoteTextAnalyzer(SettingUtils.createRemoteTextSetting(call));
        } else {
            analyzer = MLAnalyzerFactory.getInstance().getLocalTextAnalyzer(SettingUtils.createLocalTextSetting(call));
        }

        MLFrame frame = SettingUtils.createMLFrame(
                activity,
                textFrame != null ? textFrame : "fromBitmap",
                imagePath,
                call
        );
        FrameHolder.getInstance().setFrame(frame);

        Task<MLText> asyncTextTask = analyzer.asyncAnalyseFrame(frame);

        asyncTextTask.addOnSuccessListener(text -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncTextAnalyze");
            mResult.success(TextToJson.createMlTextJSON(text).toString());
        }).addOnFailureListener(err -> HmsMlUtils.handleException(activity, TAG, err, "asyncTextAnalyze", mResult));
    }

    private void syncTextAnalyze(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("syncTextAnalyze");
        String sparseAnalyzeImagePath = call.argument("path");
        String sparseTextFrame = call.argument("frameType");

        if (sparseAnalyzeImagePath == null || sparseAnalyzeImagePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncTextAnalyze", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        analyzer = SettingUtils.createAnalyzerForSyncDetection(call, activity);

        MLFrame sparseFrame = SettingUtils.createMLFrame(
                activity,
                sparseTextFrame != null ? sparseTextFrame : "fromBitmap",
                sparseAnalyzeImagePath,
                call
        );
        FrameHolder.getInstance().setFrame(sparseFrame);

        SparseArray<MLText.Block> sparseArray = analyzer.analyseFrame(sparseFrame);

        List<MLText.Block> blocks = new ArrayList<>(sparseArray.size());
        for (int i = 0; i < sparseArray.size(); i++) {
            blocks.add(sparseArray.get(i));
        }
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncTextAnalyze");
        mResult.success(TextToJson.textBlockToJSONArray(blocks).toString());
    }

    private void isAnalyzerAvailable() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("isTextAnalyzerAvailable");
        if (analyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("isTextAnalyzerAvailable", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyzer is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
        } else {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("isTextAnalyzerAvailable");
            mResult.success(analyzer.isAvailable());
        }
    }

    private void getAnalyzeType() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getTextAnalyzeType");
        if (analyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getTextAnalyzeType", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyzer is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
        } else {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getTextAnalyzeType");
            mResult.success(analyzer.getAnalyseType());
        }
    }

    private void stopAnalyzer() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stopTextAnalyzer");
        if (analyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopTextAnalyzer", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyser is not initialized.", MlConstants.UNINITIALIZED_ANALYZER);
        } else {
            try {
                analyzer.close();
                analyzer.release();
                analyzer = null;
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopTextAnalyzer");
                mResult.success(true);
            } catch (IOException e) {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopTextAnalyzer", e.getMessage());
                mResult.error(TAG, e.getMessage(), "");
            }
        }
    }

    @Override
    public void onListen(Object g, EventChannel.EventSink s) {
        EventHandler.getInstance().setEventSink(s);
    }

    @Override
    public void onCancel(Object g) {
        EventHandler.getInstance().setEventSink(null);
    }
}