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

import com.google.gson.JsonObject;
import com.huawei.hms.flutter.mltext.constant.CallbackTypes;
import com.huawei.hms.flutter.mltext.constant.Method;
import com.huawei.hms.flutter.mltext.constant.Param;
import com.huawei.hms.flutter.mltext.interfaces.IAnalyzer;
import com.huawei.hms.flutter.mltext.utils.FromMap;
import com.huawei.hms.flutter.mltext.utils.TextResponseHandler;
import com.huawei.hms.flutter.mltext.utils.SettingCreator;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.fr.MLFormRecognitionAnalyzer;
import com.huawei.hms.mlsdk.fr.MLFormRecognitionAnalyzerFactory;
import com.huawei.hms.mlsdk.fr.MLFormRecognitionAnalyzerSetting;
import com.huawei.hms.mlsdk.fr.MLFormRecognitionConstant;

import java.io.IOException;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class FormRecognitionMethodHandler implements MethodChannel.MethodCallHandler, IAnalyzer {
    private static final String TAG = FormRecognitionMethodHandler.class.getSimpleName();

    private final TextResponseHandler responseHandler;

    private MLFormRecognitionAnalyzer formAnalyzer;

    public FormRecognitionMethodHandler(final Activity activity) {
        this.responseHandler = TextResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        responseHandler.setup(TAG, call.method, result);
        switch (call.method) {
            case Method.FORM_ASYNC_ANALYSE_FRAME:
                asyncAnalyseFrame(call);
                break;
            case Method.FORM_ANALYSE_FRAME:
                analyseFrame(call);
                break;
            case Method.FORM_DESTROY:
                destroy();
                break;
            case Method.FORM_IS_AVAILABLE:
                isAvailable();
                break;
            case Method.FORM_STOP:
                stop();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void asyncAnalyseFrame(@NonNull MethodCall call) {
        String formImage = FromMap.toString(Param.PATH, call.argument(Param.PATH), false);

        MLFormRecognitionAnalyzerSetting setting = new MLFormRecognitionAnalyzerSetting.Factory().create();
        formAnalyzer = MLFormRecognitionAnalyzerFactory.getInstance().getFormRecognitionAnalyzer(setting);

        MLFrame mlFrame = SettingCreator.frameFromBitmap(formImage);

        formAnalyzer.asyncAnalyseFrame(mlFrame)
                .addOnSuccessListener(recognizeResult -> responseHandler.success(recognizeResult.toString()))
                .addOnFailureListener(responseHandler::exception);
    }

    private void analyseFrame(@NonNull MethodCall call) {
        String formImage = FromMap.toString(Param.PATH, call.argument(Param.PATH), false);

        MLFormRecognitionAnalyzerSetting setting = new MLFormRecognitionAnalyzerSetting.Factory().create();
        formAnalyzer = MLFormRecognitionAnalyzerFactory.getInstance().getFormRecognitionAnalyzer(setting);

        MLFrame mlFrame = SettingCreator.frameFromBitmap(formImage);

        SparseArray<JsonObject> recognizeResult = formAnalyzer.analyseFrame(mlFrame);
        if (recognizeResult != null
                && recognizeResult.get(0).get(Param.RET_CODE).getAsInt() == MLFormRecognitionConstant.SUCCESS) {
            responseHandler.success(recognizeResult.get(0).toString());
        } else {
            responseHandler.callbackError(-1, CallbackTypes.FORM_FAILED);
        }
    }

    @Override
    public void destroy() {
        if (formAnalyzer == null) {
            responseHandler.noService();
            return;
        }
        formAnalyzer.destroy();
        responseHandler.success(true);
    }

    @Override
    public void isAvailable() {
        if (formAnalyzer == null) {
            responseHandler.noService();
            return;
        }
        responseHandler.success(formAnalyzer.isAvailable());
    }

    @Override
    public void stop() {
        if (formAnalyzer == null) {
            responseHandler.noService();
            return;
        }
        try {
            formAnalyzer.stop();
            formAnalyzer = null;
            responseHandler.success(true);
        } catch (IOException e) {
            responseHandler.exception(e);
        }
    }
}
