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

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.FrameHolder;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.flutter.ml.utils.SettingUtils;
import com.huawei.hms.mlplugin.card.bcr.MLBcrCapture;
import com.huawei.hms.mlplugin.card.bcr.MLBcrCaptureFactory;
import com.huawei.hms.mlplugin.card.bcr.MLBcrCaptureResult;
import com.huawei.hms.mlsdk.card.MLBcrAnalyzerFactory;
import com.huawei.hms.mlsdk.card.bcr.MLBankCard;
import com.huawei.hms.mlsdk.card.bcr.MLBcrAnalyzer;
import com.huawei.hms.mlsdk.common.MLFrame;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class BankcardAnalyzerMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = BankcardAnalyzerMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;
    private MLBcrAnalyzer sdkAnalyzer;

    public BankcardAnalyzerMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "analyzeBankcard":
                analyzeBankcard(call);
                break;
            case "captureBankcard":
                startCaptureActivity(call, this.callback);
                break;
            case "stopBankcardAnalyzer":
                stopAnalyzer();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void analyzeBankcard(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("analyzeBankcard");
        String imagePath = call.argument("path");
        String frameType = call.argument("frameType");

        if (imagePath == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyzeBankcard", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing", "");
            return;
        }

        MLFrame frame = SettingUtils.createMLFrame(activity, frameType != null ? frameType : "fromBitmap", imagePath, call);
        FrameHolder.getInstance().setFrame(frame);

        sdkAnalyzer = MLBcrAnalyzerFactory.getInstance().getBcrAnalyzer(SettingUtils.createBcrAnalyzerSetting(call));
        Task<MLBankCard> task = sdkAnalyzer.asyncAnalyseFrame(frame);

        task.addOnSuccessListener(mlBankCard -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyzeBankcard");
            mResult.success(onAnalyzeSuccess(mlBankCard).toString());
        }).addOnFailureListener(bcrException -> HmsMlUtils.handleException(activity, TAG, bcrException, "analyzeBankcard", mResult));
    }

    private void startCaptureActivity(MethodCall call, MLBcrCapture.Callback callback) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("captureBankcard");
        MLBcrCapture bcrCapture = MLBcrCaptureFactory.getInstance().getBcrCapture(SettingUtils.createBcrCaptureConfig(call));
        bcrCapture.captureFrame(activity, callback);
    }

    private MLBcrCapture.Callback callback = new MLBcrCapture.Callback() {
        @Override
        public void onSuccess(MLBcrCaptureResult mlBcrCaptureResult) {
            captureResult(mlBcrCaptureResult);
        }

        @Override
        public void onCanceled() {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("captureBankcard", MlConstants.CANCELLED);
            mResult.error(TAG, "Capture canceled", MlConstants.CANCELLED);
        }

        @Override
        public void onFailure(int i, Bitmap bitmap) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("startCaptureActivity", String.valueOf(i));
            mResult.error(TAG, String.valueOf(i), String.valueOf(i));
        }

        @Override
        public void onDenied() {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("captureBankcard", MlConstants.DENIED);
            mResult.error(TAG, "Capture denied", MlConstants.DENIED);
        }
    };

    private @NonNull JSONObject onAnalyzeSuccess(@NonNull MLBankCard bankCard) {
        Map<String, Object> object = new HashMap<>();
        object.put("expire", bankCard.getExpire());
        object.put("number", bankCard.getNumber());
        object.put("type", bankCard.getType());
        object.put("organization", bankCard.getOrganization());
        object.put("issuer", bankCard.getIssuer());
        if (bankCard.getOriginalBitmap() != null) {
            object.put("originalBitmap",
                    HmsMlUtils.saveBitmapAndGetPath(
                            activity.getApplicationContext(),
                            bankCard.getOriginalBitmap()));
        }
        if (bankCard.getNumberBitmap() != null) {
            object.put("numberBitmap",
                    HmsMlUtils.saveBitmapAndGetPath(
                            activity.getApplicationContext(),
                            bankCard.getNumberBitmap()));
        }
        return new JSONObject(object);
    }

    private void captureResult(@NonNull MLBcrCaptureResult bankCardResult) {
        Map<String, Object> object = new HashMap<>();
        object.put("number", bankCardResult.getNumber());
        object.put("expire", bankCardResult.getExpire());
        object.put("type", bankCardResult.getType());
        object.put("issuer", bankCardResult.getIssuer());
        object.put("errorCode", bankCardResult.getErrorCode());
        object.put("organization", bankCardResult.getOrganization());
        if (bankCardResult.getOriginalBitmap() != null) {
            object.put("originalBitmap",
                    HmsMlUtils.saveBitmapAndGetPath(
                            activity.getApplicationContext(),
                            bankCardResult.getOriginalBitmap()));
        }
        if (bankCardResult.getNumberBitmap() != null) {
            object.put("numberBitmap",
                    HmsMlUtils.saveBitmapAndGetPath(
                            activity.getApplicationContext(),
                            bankCardResult.getNumberBitmap()));
        }
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("captureBankcard");
        mResult.success(new JSONObject(object).toString());
    }

    private void stopAnalyzer() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stopBankcardAnalyzer");
        if (sdkAnalyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopBankcardAnalyzer", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyser is not initialized.", MlConstants.UNINITIALIZED_ANALYZER);
        } else {
            sdkAnalyzer.stop();
            sdkAnalyzer = null;
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopBankcardAnalyzer");
            mResult.success(true);
        }
    }
}