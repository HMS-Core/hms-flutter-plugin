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

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.FrameHolder;
import com.huawei.hms.flutter.ml.utils.tojson.DocumentToJson;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.ml.utils.SettingUtils;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.document.MLDocument;
import com.huawei.hms.mlsdk.document.MLDocumentAnalyzer;

import java.io.IOException;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class DocumentAnalyzerMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = DocumentAnalyzerMethodHandler.class.getSimpleName();

    private Activity activity;
    private MLDocumentAnalyzer analyzer;
    private MethodChannel.Result mResult;

    public DocumentAnalyzerMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "asyncDocumentAnalyze":
                analyzeDocument(call);
                break;
            case "close":
                closeAnalyzer();
                break;
            case "stop":
                stopAnalyzer();
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    private void analyzeDocument(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("asyncDocumentAnalyze");
        String documentImagePath = call.argument("path");
        String frameType = call.argument("frameType");

        if (documentImagePath == null || documentImagePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncDocumentAnalyze", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        this.analyzer = MLAnalyzerFactory.getInstance().getRemoteDocumentAnalyzer(SettingUtils.createDocumentSetting(call));

        MLFrame frame = SettingUtils.createMLFrame(
                activity,
                frameType != null ? frameType : "fromBitmap",
                documentImagePath,
                call);
        FrameHolder.getInstance().setFrame(frame);

        Task<MLDocument> task = analyzer.asyncAnalyseFrame(frame);

        task.addOnSuccessListener(mlDocument -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncDocumentAnalyze");
            mResult.success(DocumentToJson.createMlDocumentJSON(mlDocument).toString());
        }).addOnFailureListener(documentAnalyzeError -> HmsMlUtils.handleException(activity, TAG, documentAnalyzeError, "asyncDocumentAnalyze", mResult));
    }

    private void closeAnalyzer() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("closeDocumentAnalyzer");
        if (analyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("closeDocumentAnalyzer", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error("Error", "Analyzer is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
        } else {
            try {
                analyzer.close();
                analyzer = null;
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("closeDocumentAnalyzer");
                mResult.success(true);
            } catch (IOException e) {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("closeDocumentAnalyzer", e.getMessage());
                mResult.error(TAG, e.getMessage(), "");
            }
        }
    }

    private void stopAnalyzer() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stopDocumentAnalyzer");
        if (analyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopDocumentAnalyzer", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error("Error", "Analyzer is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
        } else {
            try {
                analyzer.stop();
                analyzer = null;
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopDocumentAnalyzer");
                mResult.success(true);
            } catch (IOException e) {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopDocumentAnalyzer", e.getMessage());
                mResult.error(TAG, e.getMessage(), "");
            }
        }
    }
}