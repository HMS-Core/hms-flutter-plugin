/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.ads.consent;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.ads.consent.constant.ConsentStatus;
import com.huawei.hms.ads.consent.constant.DebugNeedConsent;
import com.huawei.hms.ads.consent.inter.Consent;
import com.huawei.hms.flutter.ads.logger.HMSLogger;
import com.huawei.hms.flutter.ads.utils.FromMap;
import com.huawei.hms.flutter.ads.utils.constants.ConsentConst;
import com.huawei.hms.flutter.ads.utils.constants.ErrorCodes;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.Result;

public class ConsentMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = "ConsentMethodHandler";
    private final Context context;

    public ConsentMethodHandler(final Context context) {
        this.context = context;
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        switch (call.method) {
            case "getTestDeviceId":
                getTestDeviceId(result);
                break;
            case "addTestDeviceId":
                addTestDeviceId(call, result);
                break;
            case "setDebugNeedConsent":
                setDebugNeedConsent(call, result);
                break;
            case "setUnderAgeOfPromise":
                setUnderAgeOfPromise(call, result);
                break;
            case "setConsentStatus":
                setConsentStatus(call, result);
                break;
            case "updateConsentSharedPreferences":
                updateConsentSharedPreferences(call, result);
                break;
            case "getConsentSharedPreferences":
                getConsentSharedPreferences(call, result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void getTestDeviceId(Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("getTestDeviceId");
        result.success(Consent.getInstance(context).getTestDeviceId());
        HMSLogger.getInstance(context).sendSingleEvent("getTestDeviceId");
    }

    private void addTestDeviceId(MethodCall call, MethodChannel.Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("addTestDeviceId");
        String deviceId = FromMap.toString("deviceId", call.argument("deviceId"));
        if (deviceId != null) {
            Log.i(TAG, "SDK addTestDeviceId begin");
            Consent.getInstance(context).addTestDeviceId(deviceId);
            Log.i(TAG, "SDK addTestDeviceId end");
            result.success(true);
            HMSLogger.getInstance(context).sendSingleEvent("addTestDeviceId");
        } else {
            result.error(ErrorCodes.NULL_PARAM, "Test deviceId is null? : true. addTestDevice failed.", "");
            HMSLogger.getInstance(context).sendSingleEvent("addTestDeviceId", ErrorCodes.NULL_PARAM);
        }
    }

    private void setDebugNeedConsent(MethodCall call, MethodChannel.Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("setDebugNeedConsent");
        String consentStr = FromMap.toString("needConsent", call.argument("needConsent"));
        if (consentStr != null) {
            DebugNeedConsent needConsent = DebugNeedConsent.valueOf(consentStr);
            Log.i(TAG, "SDK setDebugNeedConsent begin");
            Consent.getInstance(context).setDebugNeedConsent(needConsent);
            Log.i(TAG, "SDK setDebugNeedConsent end");
            result.success(true);
            HMSLogger.getInstance(context).sendSingleEvent("setDebugNeedConsent");
        } else {
            result.error(ErrorCodes.NULL_PARAM,
                "Null parameter provided. setDebugNeedConsent failed.",
                "");
            HMSLogger.getInstance(context).sendSingleEvent("setDebugNeedConsent", ErrorCodes.NULL_PARAM);
        }
    }

    private void setUnderAgeOfPromise(MethodCall call, MethodChannel.Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("setUnderAgeOfPromise");
        Boolean ageOfPromise = FromMap.toBoolean("ageOfPromise", call.argument("ageOfPromise"));
        Consent.getInstance(context).setUnderAgeOfPromise(ageOfPromise);
        result.success(true);
        HMSLogger.getInstance(context).sendSingleEvent("setUnderAgeOfPromise");
    }

    private void setConsentStatus(MethodCall call, MethodChannel.Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("setConsentStatus");
        String status = FromMap.toString("status", call.argument("status"));
        if (status != null) {
            ConsentStatus consentStatus = ConsentStatus.valueOf(status);
            Log.i(TAG, "setConsentStatus begin");
            Consent.getInstance(context).setConsentStatus(consentStatus);
            Log.i(TAG, "setConsentStatus end");
            result.success(true);
            HMSLogger.getInstance(context).sendSingleEvent("setConsentStatus");
        } else {
            result.error(ErrorCodes.NULL_PARAM,
                "Null parameter provided. setConsentStatus failed.",
                "");
            HMSLogger.getInstance(context).sendSingleEvent("setConsentStatus", ErrorCodes.NULL_PARAM);
        }
    }

    private void updateConsentSharedPreferences(MethodCall call, MethodChannel.Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("updateConsentSharedPreferences");
        String prefKey = FromMap.toString("key", call.argument("key"));
        if (prefKey != null &&
            (prefKey.equals(ConsentConst.SP_CONSENT_KEY) || prefKey.equals(ConsentConst.SP_PROTOCOL_KEY))) {
            Integer prefValue = FromMap.toInteger("value", call.argument("value"));
            if (prefValue != null) {
                SharedPreferences preferences =
                    context.getSharedPreferences(ConsentConst.SP_NAME, Context.MODE_PRIVATE);
                SharedPreferences.Editor editor = preferences.edit();
                editor.putInt(ConsentConst.SP_PROTOCOL_KEY, prefValue).commit();
                result.success(true);
                HMSLogger.getInstance(context).sendSingleEvent("updateConsentSharedPreferences");
            } else {
                result.error(ErrorCodes.NULL_PARAM,
                    "Value for the Shared Preference is null.",
                    "");
                HMSLogger.getInstance(context).sendSingleEvent("updateConsentSharedPreferences", ErrorCodes.NULL_PARAM);
            }
        } else {
            result.error(ErrorCodes.INVALID_PARAM,
                "Key for the Shared Preference is either invalid or null.",
                "");
            HMSLogger.getInstance(context).sendSingleEvent("updateConsentSharedPreferences", ErrorCodes.INVALID_PARAM);
        }
    }

    private void getConsentSharedPreferences(MethodCall call, MethodChannel.Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("getConsentSharedPreferences");
        String prefKey = FromMap.toString("key", call.argument("key"));
        int defValue;
        if (prefKey != null &&
            (prefKey.equals(ConsentConst.SP_CONSENT_KEY) || prefKey.equals(ConsentConst.SP_PROTOCOL_KEY))) {
            if (prefKey.equals(ConsentConst.SP_CONSENT_KEY)) {
                defValue = ConsentConst.DEFAULT_SP_CONSENT_VALUE;
            } else {
                defValue = ConsentConst.DEFAULT_SP_PROTOCOL_VALUE;
            }

            SharedPreferences preferences =
                context.getSharedPreferences(ConsentConst.SP_NAME, Context.MODE_PRIVATE);
            int value = preferences.getInt(prefKey, defValue);
            result.success(value);
            HMSLogger.getInstance(context).sendSingleEvent("getConsentSharedPreferences");
        } else {
            result.error(ErrorCodes.INVALID_PARAM,
                "Key for the Shared Preference is either invalid or null. Key: " + prefKey,
                "");
            HMSLogger.getInstance(context).sendSingleEvent("getConsentSharedPreferences", ErrorCodes.NULL_PARAM);
        }
    }
}
