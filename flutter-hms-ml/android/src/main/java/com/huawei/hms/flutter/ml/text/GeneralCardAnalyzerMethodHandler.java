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
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Base64;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.flutter.ml.utils.SettingUtils;
import com.huawei.hms.flutter.ml.utils.tojson.TextToJson;
import com.huawei.hms.mlplugin.card.gcr.MLGcrCapture;
import com.huawei.hms.mlplugin.card.gcr.MLGcrCaptureFactory;
import com.huawei.hms.mlplugin.card.gcr.MLGcrCaptureResult;
import com.huawei.hms.mlsdk.text.MLText;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class GeneralCardAnalyzerMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = GeneralCardAnalyzerMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;

    private String action;

    public GeneralCardAnalyzerMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "capturePreview":
                action = "capturePreview";
                capturePreview(call);
                break;
            case "capturePhoto":
                action = "capturePhoto";
                capturePhoto(call);
                break;
            case "captureImage":
                action = "captureImage";
                captureImage(call);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void capturePreview(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("generalCardCaptureActivity");
        startCaptureActivity(callback, call);
    }

    private void capturePhoto(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("generalCardPictureTakingActivity");
        startTakingPictureActivity(callback, call);
    }

    private void captureImage(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("localGeneralCardAnalyze");
        String localCardImagePath = call.argument("path");

        if (localCardImagePath == null || localCardImagePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("localGeneralCardAnalyze", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        final String encodedImage = HmsMlUtils.pathToBase64(localCardImagePath);
        byte[] decodedString = Base64.decode(encodedImage, Base64.DEFAULT);
        Bitmap bitmap = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);

        MLGcrCapture ocrManager = MLGcrCaptureFactory.getInstance().getGcrCapture(SettingUtils.createGcrCaptureConfig(call));
        ocrManager.captureImage(bitmap, null, callback);
    }

    private void startCaptureActivity(MLGcrCapture.Callback callBack, MethodCall call) {
        MLGcrCapture ocrManager = MLGcrCaptureFactory
                .getInstance()
                .getGcrCapture(
                        SettingUtils.createGcrCaptureConfig(call),
                        SettingUtils.createGcrUiConfig(call));

        ocrManager.capturePreview(activity, null, callBack);
    }

    private void startTakingPictureActivity(MLGcrCapture.Callback callBack, MethodCall call) {
        MLGcrCapture ocrManager = MLGcrCaptureFactory
                .getInstance()
                .getGcrCapture(
                        SettingUtils.createGcrCaptureConfig(call),
                        SettingUtils.createGcrUiConfig(call));

        ocrManager.capturePhoto(activity, null, callBack);
    }

    private void onAnalyzeSuccess(MLGcrCaptureResult cardResult) {
        MLText text = cardResult.text;
        Map<String, Object> generalCardMap = new HashMap<>();
        generalCardMap.put("cardBitmap", HmsMlUtils.saveBitmapAndGetPath(activity.getApplicationContext(), cardResult.cardBitmap));
        generalCardMap.put("text", TextToJson.createMlTextJSON(text));

        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(action);
        mResult.success(new JSONObject(generalCardMap).toString());
    }

    private MLGcrCapture.Callback callback = new MLGcrCapture.Callback() {
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
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(action, MlConstants.CANCELLED);
            mResult.error(TAG, "Callback canceled", MlConstants.CANCELLED);
        }

        @Override
        public void onFailure(int i, Bitmap bitmap) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(action, String.valueOf(i));
            mResult.error(TAG, String.valueOf(i), "");
        }

        @Override
        public void onDenied() {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(action, MlConstants.DENIED);
            mResult.error(TAG, "Callback denied", MlConstants.DENIED);
        }
    };
}