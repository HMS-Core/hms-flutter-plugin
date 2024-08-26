/*
 * Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.huawei.hms.flutter.mltext.handlers;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mltext.constant.Method;
import com.huawei.hms.flutter.mltext.constant.Param;
import com.huawei.hms.flutter.mltext.utils.FromMap;
import com.huawei.hms.flutter.mltext.utils.TextResponseHandler;
import com.huawei.hms.flutter.mltext.utils.SettingCreator;
import com.huawei.hms.flutter.mltext.utils.tomap.DocToMap;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.document.MLDocumentAnalyzer;

import java.io.IOException;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class DocumentAnalyzerMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = DocumentAnalyzerMethodHandler.class.getSimpleName();

    private final TextResponseHandler responseHandler;

    private MLDocumentAnalyzer docAnalyzer;

    public DocumentAnalyzerMethodHandler(final Activity activity) {
        this.responseHandler = TextResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        responseHandler.setup(TAG, call.method, result);
        switch (call.method) {
            case Method.ASYNC_DOCUMENT_ANALYZE:
                analyzeDocument(call);
                break;
            case Method.CLOSE:
                closeAnalyzer();
                break;
            case Method.STOP:
                stopAnalyzer();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void analyzeDocument(@NonNull MethodCall call) {
        String documentImagePath = FromMap.toString(Param.PATH, call.argument(Param.PATH), false);

        MLFrame frame = SettingCreator.frameFromBitmap(documentImagePath);

        docAnalyzer = MLAnalyzerFactory.getInstance()
                .getRemoteDocumentAnalyzer(SettingCreator.createDocumentSetting(call));

        docAnalyzer.asyncAnalyseFrame(frame)
                .addOnSuccessListener(mlDocument -> responseHandler.success(DocToMap.mlDocToMap(mlDocument)))
                .addOnFailureListener(responseHandler::exception);
    }

    private void closeAnalyzer() {
        if (docAnalyzer == null) {
            responseHandler.noService();
            return;
        }
        try {
            docAnalyzer.close();
            docAnalyzer = null;
            responseHandler.success(true);
        } catch (IOException e) {
            responseHandler.exception(e);
        }
    }

    private void stopAnalyzer() {
        if (docAnalyzer == null) {
            responseHandler.noService();
            return;
        }
        try {
            docAnalyzer.stop();
            docAnalyzer = null;
            responseHandler.success(true);
        } catch (IOException e) {
            responseHandler.exception(e);
        }
    }
}