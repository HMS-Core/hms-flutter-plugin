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
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mltext.constant.Method;
import com.huawei.hms.flutter.mltext.constant.CallbackTypes;
import com.huawei.hms.flutter.mltext.constant.Param;
import com.huawei.hms.flutter.mltext.utils.FromMap;
import com.huawei.hms.flutter.mltext.utils.Commons;
import com.huawei.hms.flutter.mltext.utils.TextResponseHandler;
import com.huawei.hms.flutter.mltext.utils.SettingCreator;
import com.huawei.hms.flutter.mltext.utils.tomap.TextToMap;
import com.huawei.hms.mlplugin.card.gcr.MLGcrCapture;
import com.huawei.hms.mlplugin.card.gcr.MLGcrCaptureFactory;
import com.huawei.hms.mlplugin.card.gcr.MLGcrCaptureResult;
import com.huawei.hms.mlsdk.text.MLText;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class GeneralCardAnalyzerMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = GeneralCardAnalyzerMethodHandler.class.getSimpleName();

    private final Activity activity;
    private final TextResponseHandler responseHandler;

    public GeneralCardAnalyzerMethodHandler(final Activity activity) {
        this.activity = activity;
        this.responseHandler = TextResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        responseHandler.setup(TAG, call.method, result);
        switch (call.method) {
            case Method.CAPTURE_PREVIEW:
                capturePreview(call);
                break;
            case Method.CAPTURE_PHOTO:
                capturePhoto(call);
                break;
            case Method.CAPTURE_IMAGE:
                captureImage(call);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void capturePreview(@NonNull MethodCall call) {
        startCaptureActivity(callback, call);
    }

    private void capturePhoto(@NonNull MethodCall call) {
        startTakingPictureActivity(callback, call);
    }

    private void captureImage(@NonNull MethodCall call) {
        String localCardImagePath = FromMap.toString(Param.PATH, call.argument(Param.PATH), false);

        Bitmap bitmap = BitmapFactory.decodeFile(localCardImagePath);

        MLGcrCapture ocrManager = MLGcrCaptureFactory.getInstance()
                .getGcrCapture(SettingCreator.createGcrCaptureConfig(call));
        ocrManager.captureImage(bitmap, null, callback);
    }

    private void startCaptureActivity(MLGcrCapture.Callback callBack, MethodCall call) {
        MLGcrCapture ocrManager = MLGcrCaptureFactory
                .getInstance()
                .getGcrCapture(
                        SettingCreator.createGcrCaptureConfig(call),
                        SettingCreator.createGcrUiConfig(call));

        ocrManager.capturePreview(activity, null, callBack);
    }

    private void startTakingPictureActivity(MLGcrCapture.Callback callBack, MethodCall call) {
        MLGcrCapture ocrManager = MLGcrCaptureFactory
                .getInstance()
                .getGcrCapture(
                        SettingCreator.createGcrCaptureConfig(call),
                        SettingCreator.createGcrUiConfig(call));

        ocrManager.capturePhoto(activity, null, callBack);
    }

    private void onAnalyzeSuccess(MLGcrCaptureResult cardResult) {
        MLText text = cardResult.text;
        Map<String, Object> generalCardMap = new HashMap<>();
        generalCardMap.put(Param.CARD_BYTES, Commons.bitmapToByteArray(cardResult.cardBitmap));
        generalCardMap.put(Param.TEXT, TextToMap.createMlTextJSON(text));

        responseHandler.success(generalCardMap);
    }

    private final MLGcrCapture.Callback callback = new MLGcrCapture.Callback() {
        @Override
        public int onResult(MLGcrCaptureResult mlGcrCaptureResult, Object o) {
            if (mlGcrCaptureResult == null) {
                return MLGcrCaptureResult.CAPTURE_CONTINUE;
            }
            onAnalyzeSuccess(mlGcrCaptureResult);
            return MLGcrCaptureResult.CAPTURE_STOP;
        }

        @Override
        public void onCanceled() {
            responseHandler.callbackError(-1, CallbackTypes.GCR_CANCELED);
        }

        @Override
        public void onFailure(int i, Bitmap bitmap) {
            responseHandler.callbackError(i, CallbackTypes.GCR_FAILED);
        }

        @Override
        public void onDenied() {
            responseHandler.callbackError(-2, CallbackTypes.GCR_DENIED);
        }
    };
}