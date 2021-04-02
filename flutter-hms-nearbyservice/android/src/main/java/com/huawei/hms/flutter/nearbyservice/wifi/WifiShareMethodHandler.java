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

package com.huawei.hms.flutter.nearbyservice.wifi;

import android.app.Activity;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.nearbyservice.logger.HMSLogger;
import com.huawei.hms.flutter.nearbyservice.utils.FromMap;
import com.huawei.hms.flutter.nearbyservice.utils.HmsHelper;
import com.huawei.hms.flutter.nearbyservice.utils.ToMap;
import com.huawei.hms.flutter.nearbyservice.utils.constants.ErrorCodes;
import com.huawei.hms.nearby.Nearby;
import com.huawei.hms.nearby.wifishare.WifiShareEngine;
import com.huawei.hms.nearby.wifishare.WifiSharePolicy;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class WifiShareMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = "WifiShareMethodHandler";

    private final WifiCallbackStreamHandler wifiCallbackHandler;
    private final WifiShareEngine wifiShareEngine;
    private final Activity activity;

    public WifiShareMethodHandler(EventChannel eventChannel, Activity activity) {
        this.activity = activity;
        this.wifiShareEngine = Nearby.getWifiShareEngine(activity);
        this.wifiCallbackHandler = new WifiCallbackStreamHandler(activity);
        eventChannel.setStreamHandler(wifiCallbackHandler);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer(call.method);
        switch (call.method) {
            case "startWifiShare":
                startWifiShare(call, result);
                break;
            case "stopWifiShare":
                stopWifiShare(call, result);
                break;
            case "shareWifiConfig":
                shareWifiConfig(call, result);
                break;
            default:
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NOT_FOUND);
                result.notImplemented();
                break;
        }
    }

    void startWifiShare(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "startWifiShare");
        WifiSharePolicy policy = HmsHelper.getWifiSharePolicy(ToMap.fromObject(call.argument("policy")));
        if (policy == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
            result.error(ErrorCodes.NULL_PARAM, "Provided WifiSharePolicy is either null, empty, or unknown.", "");
            return;
        }

        wifiShareEngine.startWifiShare(wifiCallbackHandler, policy).addOnSuccessListener(aVoid -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
            Log.i(TAG, "startWifiShare success");
            HmsHelper.successHandler(result);
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.ERROR_WIFI);
            Log.e(TAG, "startWifiShare | " + e.getMessage());
            HmsHelper.errorHandler(result, ErrorCodes.ERROR_WIFI, e.getMessage(), "");
        });
    }

    void stopWifiShare(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "stopWifiShare");
        wifiShareEngine.stopWifiShare().addOnSuccessListener(aVoid -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
            Log.i(TAG, "stopWifiShare success");
            HmsHelper.successHandler(result);
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.ERROR_WIFI);
            Log.e(TAG, "stopWifiShare | " + e.getMessage());
            HmsHelper.errorHandler(result, ErrorCodes.ERROR_WIFI, e.getMessage(), "");
        });
    }

    void shareWifiConfig(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "shareWifiConfig");
        String endpointId = FromMap.toString("endpointId", call.argument("endpointId"), false);
        if (endpointId == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
            Log.e(TAG, "Remote endpoint is null or empty.");
            result.error(ErrorCodes.ERROR_WIFI, "Remote endpoint is null or empty.", "");
            return;
        }

        wifiShareEngine.shareWifiConfig(endpointId).addOnSuccessListener(aVoid -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
            Log.i(TAG, "shareWifiConfig success");
            HmsHelper.successHandler(result);
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.ERROR_WIFI);
            Log.e(TAG, "shareWifiConfig | " + e.getMessage());
            HmsHelper.errorHandler(result, ErrorCodes.ERROR_WIFI, e.getMessage(), "");
        });
    }
}
