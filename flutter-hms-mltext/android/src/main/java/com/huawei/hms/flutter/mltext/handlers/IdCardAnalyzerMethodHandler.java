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
import com.huawei.hms.flutter.mltext.constant.Param;
import com.huawei.hms.flutter.mltext.constant.CallbackTypes;
import com.huawei.hms.flutter.mltext.utils.Commons;
import com.huawei.hms.flutter.mltext.utils.FromMap;
import com.huawei.hms.flutter.mltext.utils.TextResponseHandler;
import com.huawei.hms.mlplugin.card.icr.vn.MLVnIcrCapture;
import com.huawei.hms.mlplugin.card.icr.vn.MLVnIcrCaptureConfig;
import com.huawei.hms.mlplugin.card.icr.vn.MLVnIcrCaptureFactory;
import com.huawei.hms.mlplugin.card.icr.vn.MLVnIcrCaptureResult;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class IdCardAnalyzerMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = IdCardAnalyzerMethodHandler.class.getSimpleName();

    private final Activity activity;
    private final TextResponseHandler responseHandler;

    public IdCardAnalyzerMethodHandler(final Activity activity) {
        this.activity = activity;
        this.responseHandler = TextResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        responseHandler.setup(TAG, call.method, result);
        switch (call.method) {
            case Method.CAPTURE_ID_CARD:
                captureIdCard();
                break;
            case Method.ANALYZE_ID_CARD_IMAGE:
                analyzeIdCardImage(call);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void captureIdCard() {
        MLVnIcrCaptureConfig config = new MLVnIcrCaptureConfig.Factory().create();
        MLVnIcrCapture icrCapture = MLVnIcrCaptureFactory.getInstance().getIcrCapture(config);
        icrCapture.capture(idCallback, activity);
    }

    private void analyzeIdCardImage(MethodCall call) {
        String path = FromMap.toString(Param.PATH, call.argument(Param.PATH), false);

        Bitmap bitmap = BitmapFactory.decodeFile(path);

        MLVnIcrCaptureConfig config = new MLVnIcrCaptureConfig.Factory().create();
        MLVnIcrCapture icrCapture = MLVnIcrCaptureFactory.getInstance().getIcrCapture(config);
        icrCapture.captureImage(bitmap, idCallback);
    }

    private void idCardSuccess(MLVnIcrCaptureResult card) {
        Map<String, Object> map = new HashMap<>();
        if (card.getCardBitmap() != null) {
            map.put(Param.BYTES, Commons.bitmapToByteArray(card.getCardBitmap()));
        }
        map.put(Param.BIRTHDAY, card.getBirthday());
        map.put(Param.ID_NUM, card.getIdNum());
        map.put(Param.NAME, card.getName());
        map.put(Param.SEX, card.getSex());
        map.put(Param.SIDE_TYPE, card.getSideType());
        responseHandler.success(map);
    }

    private final MLVnIcrCapture.CallBack idCallback = new MLVnIcrCapture.CallBack() {
        @Override
        public void onSuccess(MLVnIcrCaptureResult idCardResult) {
            idCardSuccess(idCardResult);
        }

        @Override
        public void onCanceled() {
            responseHandler.callbackError(-1, CallbackTypes.ID_CARD_CANCELED);
        }

        @Override
        public void onFailure(int retCode, Bitmap bitmap) {
            responseHandler.callbackError(retCode, CallbackTypes.ID_CARD_FAILED);
        }

        @Override
        public void onDenied() {
            responseHandler.callbackError(-2, CallbackTypes.ID_CARD_DENIED);
        }
    };
}
