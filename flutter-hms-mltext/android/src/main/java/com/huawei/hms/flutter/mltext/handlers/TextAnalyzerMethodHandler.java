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
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mltext.constant.Method;
import com.huawei.hms.flutter.mltext.constant.Param;
import com.huawei.hms.flutter.mltext.interfaces.IAnalyzer;
import com.huawei.hms.flutter.mltext.utils.FromMap;
import com.huawei.hms.flutter.mltext.utils.TextResponseHandler;
import com.huawei.hms.flutter.mltext.utils.SettingCreator;
import com.huawei.hms.flutter.mltext.utils.tomap.TextToMap;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.text.MLText;
import com.huawei.hms.mlsdk.text.MLTextAnalyzer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class TextAnalyzerMethodHandler implements MethodChannel.MethodCallHandler, IAnalyzer {
    private static final String TAG = TextAnalyzerMethodHandler.class.getSimpleName();

    private final Activity activity;
    private final TextResponseHandler responseHandler;

    private MLTextAnalyzer txtAnalyzer;

    public TextAnalyzerMethodHandler(Activity activity) {
        this.activity = activity;
        this.responseHandler = TextResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        responseHandler.setup(TAG, call.method, result);
        switch (call.method) {
            case Method.TEXT_ASYNC_ANALYSE_FRAME:
                asyncAnalyseFrame(call);
                break;
            case Method.TEXT_ANALYSE_FRAME:
                analyseFrame(call);
                break;
            case Method.TEXT_GET_ANALYZE_TYPE:
                getAnalyzeType();
                break;
            case Method.TEXT_DESTROY:
                destroy();
                break;
            case Method.TEXT_IS_AVAILABLE:
                isAvailable();
                break;
            case Method.TEXT_STOP:
                stop();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void asyncAnalyseFrame(@NonNull MethodCall call) {
        String imagePath = FromMap.toString(Param.PATH, call.argument(Param.PATH), false);
        Boolean isRemote = FromMap.toBoolean(Param.IS_REMOTE, call.argument(Param.IS_REMOTE));

        if (isRemote) {
            txtAnalyzer = MLAnalyzerFactory.getInstance()
                    .getRemoteTextAnalyzer(SettingCreator.createRemoteTextSetting(call));
        } else {
            txtAnalyzer = MLAnalyzerFactory.getInstance()
                    .getLocalTextAnalyzer(SettingCreator.createLocalTextSetting(call));
        }
        MLFrame frame = SettingCreator.frameFromBitmap(imagePath);

        txtAnalyzer.asyncAnalyseFrame(frame)
                .addOnSuccessListener(text -> responseHandler.success(TextToMap.createMlTextJSON(text)))
                .addOnFailureListener(responseHandler::exception);
    }

    private void analyseFrame(@NonNull MethodCall call) {
        String sparseAnalyzeImagePath = FromMap.toString(Param.PATH, call.argument(Param.PATH), false);

        txtAnalyzer = SettingCreator.createAnalyzerForSyncDetection(call, activity);

        MLFrame sparseFrame = SettingCreator.frameFromBitmap(sparseAnalyzeImagePath);

        SparseArray<MLText.Block> sparseArray = txtAnalyzer.analyseFrame(sparseFrame);

        List<MLText.Block> blocks = new ArrayList<>(sparseArray.size());
        for (int i = 0; i < sparseArray.size(); i++) {
            blocks.add(sparseArray.get(i));
        }
        responseHandler.success(TextToMap.textBlockToJSONArray(blocks));
    }

    @Override
    public void destroy() {
        if (txtAnalyzer == null) {
            responseHandler.noService();
            return;
        }
        txtAnalyzer.destroy();
        responseHandler.success(true);
    }

    @Override
    public void isAvailable() {
        if (txtAnalyzer == null) {
            responseHandler.noService();
            return;
        }
        responseHandler.success(txtAnalyzer.isAvailable());
    }

    @Override
    public void stop() {
        if (txtAnalyzer == null) {
            responseHandler.noService();
            return;
        }
        try {
            txtAnalyzer.close();
            txtAnalyzer.release();
            txtAnalyzer = null;
            responseHandler.success(true);
        } catch (IOException e) {
            responseHandler.exception(e);
        }
    }

    private void getAnalyzeType() {
        if (txtAnalyzer == null) {
            responseHandler.noService();
            return;
        }
        responseHandler.success(txtAnalyzer.getAnalyseType());
    }
}
