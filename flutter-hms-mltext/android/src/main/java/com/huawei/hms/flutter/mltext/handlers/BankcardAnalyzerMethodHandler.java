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

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mltext.constant.CallbackTypes;
import com.huawei.hms.flutter.mltext.constant.Method;
import com.huawei.hms.flutter.mltext.constant.Param;
import com.huawei.hms.flutter.mltext.interfaces.IAnalyzer;
import com.huawei.hms.flutter.mltext.utils.Commons;
import com.huawei.hms.flutter.mltext.utils.FromMap;
import com.huawei.hms.flutter.mltext.utils.TextResponseHandler;
import com.huawei.hms.flutter.mltext.utils.SettingCreator;
import com.huawei.hms.mlplugin.card.bcr.MLBcrCapture;
import com.huawei.hms.mlplugin.card.bcr.MLBcrCaptureFactory;
import com.huawei.hms.mlplugin.card.bcr.MLBcrCaptureResult;
import com.huawei.hms.mlsdk.card.MLBcrAnalyzerFactory;
import com.huawei.hms.mlsdk.card.bcr.MLBankCard;
import com.huawei.hms.mlsdk.card.bcr.MLBcrAnalyzer;
import com.huawei.hms.mlsdk.common.MLFrame;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class BankcardAnalyzerMethodHandler implements MethodChannel.MethodCallHandler, IAnalyzer {
    private static final String TAG = BankcardAnalyzerMethodHandler.class.getSimpleName();

    private final Activity activity;
    private final TextResponseHandler responseHandler;

    private MLBcrAnalyzer bcrAnalyzer;

    public BankcardAnalyzerMethodHandler(Activity activity) {
        this.activity = activity;
        this.responseHandler = TextResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        responseHandler.setup(TAG, call.method, result);
        switch (call.method) {
            case Method.BANKCARD_ANALYSE_FRAME:
                analyseFrame(call);
                break;
            case Method.BANKCARD_ASYNC_ANALYSE_FRAME:
                asyncAnalyseFrame(call, this.callback);
                break;
            case Method.BANKCARD_DESTROY:
                destroy();
                break;
            case Method.BANKCARD_IS_AVAILABLE:
                isAvailable();
                break;
            case Method.BANKCARD_STOP:
                stop();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void analyseFrame(@NonNull MethodCall call) {
        String imagePath = FromMap.toString(Param.PATH, call.argument(Param.PATH), false);
        MLFrame frame = SettingCreator.frameFromBitmap(imagePath);

        bcrAnalyzer = MLBcrAnalyzerFactory.getInstance().getBcrAnalyzer(SettingCreator.createBcrAnalyzerSetting(call));

        bcrAnalyzer.asyncAnalyseFrame(frame)
                .addOnSuccessListener(this::onAnalyzeSuccess)
                .addOnFailureListener(responseHandler::exception);
    }

    private void asyncAnalyseFrame(MethodCall call, MLBcrCapture.Callback callback) {
        MLBcrCapture bcrCapture = MLBcrCaptureFactory.getInstance()
                .getBcrCapture(SettingCreator.createBcrCaptureConfig(call));
        bcrCapture.captureFrame(activity, callback);
    }

    private final MLBcrCapture.Callback callback = new MLBcrCapture.Callback() {
        @Override
        public void onSuccess(MLBcrCaptureResult mlBcrCaptureResult) {
            captureResult(mlBcrCaptureResult);
        }

        @Override
        public void onCanceled() {
            responseHandler.callbackError(-1, CallbackTypes.BCR_CANCELED);
        }

        @Override
        public void onFailure(int i, Bitmap bitmap) {
            responseHandler.callbackError(i, CallbackTypes.BCR_FAILED);
        }

        @Override
        public void onDenied() {
            responseHandler.callbackError(-2, CallbackTypes.BCR_DENIED);
        }
    };

    private void onAnalyzeSuccess(@NonNull MLBankCard bankCard) {
        Map<String, Object> object = new HashMap<>();
        object.put(Param.EXPIRE, bankCard.getExpire());
        object.put(Param.NUMBER, bankCard.getNumber());
        object.put(Param.TYPE, bankCard.getType());
        object.put(Param.ORGANIZATION, bankCard.getOrganization());
        object.put(Param.ISSUER, bankCard.getIssuer());
        if (bankCard.getOriginalBitmap() != null) {
            object.put(Param.ORIGINAL_BYTES, Commons.bitmapToByteArray(bankCard.getOriginalBitmap()));
        }
        if (bankCard.getNumberBitmap() != null) {
            object.put(Param.NUMBER_BYTES, Commons.bitmapToByteArray(bankCard.getNumberBitmap()));
        }
        responseHandler.success(object);
    }

    private void captureResult(@NonNull MLBcrCaptureResult bankCardResult) {
        Map<String, Object> object = new HashMap<>();
        object.put(Param.NUMBER, bankCardResult.getNumber());
        object.put(Param.EXPIRE, bankCardResult.getExpire());
        object.put(Param.TYPE, bankCardResult.getType());
        object.put(Param.ISSUER, bankCardResult.getIssuer());
        object.put(Param.ERROR_CODE, bankCardResult.getErrorCode());
        object.put(Param.ORGANIZATION, bankCardResult.getOrganization());
        if (bankCardResult.getOriginalBitmap() != null) {
            object.put(Param.ORIGINAL_BYTES, Commons.bitmapToByteArray(bankCardResult.getOriginalBitmap()));
        }
        if (bankCardResult.getNumberBitmap() != null) {
            object.put(Param.NUMBER_BYTES, Commons.bitmapToByteArray(bankCardResult.getNumberBitmap()));
        }
        responseHandler.success(object);
    }

    @Override
    public void destroy() {
        if (bcrAnalyzer == null) {
            responseHandler.noService();
            return;
        }
        bcrAnalyzer.destroy();
        responseHandler.success(true);
    }

    @Override
    public void isAvailable() {
        if (bcrAnalyzer == null) {
            responseHandler.noService();
            return;
        }
        responseHandler.success(bcrAnalyzer.isAvailable());
    }

    @Override
    public void stop() {
        if (bcrAnalyzer == null) {
            responseHandler.noService();
            return;
        }
        bcrAnalyzer.stop();
        bcrAnalyzer = null;
        responseHandler.success(true);
    }
}