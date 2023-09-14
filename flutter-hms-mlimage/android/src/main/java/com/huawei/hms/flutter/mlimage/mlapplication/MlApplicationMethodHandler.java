/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.mlimage.mlapplication;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mlimage.constant.Method;
import com.huawei.hms.flutter.mlimage.constant.Param;
import com.huawei.hms.flutter.mlimage.logger.HMSLogger;
import com.huawei.hms.flutter.mlimage.utils.FromMap;
import com.huawei.hms.flutter.mlimage.utils.MLResponseHandler;
import com.huawei.hms.mlsdk.common.MLApplication;

import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MlApplicationMethodHandler implements MethodChannel.MethodCallHandler {
    private final static String TAG = MlApplicationMethodHandler.class.getSimpleName();

    private final Activity activity;
    private final MLResponseHandler responseHandler;

    public MlApplicationMethodHandler(Activity activity) {
        this.activity = activity;
        this.responseHandler = MLResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        responseHandler.setup(TAG, call.method, result);
        switch (call.method) {
            case Method.SET_API_KEY:
                setApiKey(call);
                break;
            case Method.SET_ACCESS_TOKEN:
                setAccessToken(call);
                break;
            case Method.SET_USER_REGION:
                setUserRegion(call);
                break;
            case Method.GET_COUNTRY_CODE:
                getCountryCode();
                break;
            case Method.ENABLE_LOGGER:
                enableLogger();
                break;
            case Method.DISABLE_LOGGER:
                disableLogger();
                break;
            default:
                result.notImplemented();
        }
    }

    private void setApiKey(@NonNull MethodCall call) {
        final String key = FromMap.toString(Param.KEY, call.argument(Param.KEY), false);
        MLApplication.getInstance().setApiKey(key);
        responseHandler.success(true);
    }

    private void setAccessToken(@NonNull MethodCall call) {
        final String key = FromMap.toString(Param.TOKEN, call.argument(Param.TOKEN), false);
        MLApplication.getInstance().setAccessToken(key);
        responseHandler.success(true);
    }

    private void setUserRegion(@NonNull MethodCall call) {
        final Integer region = FromMap.toInteger("region", call.argument("region"));
        MLApplication.getInstance().setUserRegion(Objects.requireNonNull(region));
        responseHandler.success(true);
    }

    private void getCountryCode() {
        final String countryCode = MLApplication.getInstance().getCountryCode();
        responseHandler.success(countryCode);
    }

    private void enableLogger() {
        HMSLogger.getInstance(activity).enableLogger();
        responseHandler.success(null);
    }

    private void disableLogger() {
        HMSLogger.getInstance(activity).disableLogger();
        responseHandler.success(null);
    }
}
