/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.ar.handlers;

import android.app.Activity;
import android.content.ActivityNotFoundException;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ar.constants.Constants;
import com.huawei.hms.flutter.ar.logger.HMSLogger;
import com.huawei.hms.plugin.ar.core.util.AREngineAvailability;

import io.flutter.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class AREngineCommonHandler implements MethodCallHandler {
    private static final String TAG = AREngineCommonHandler.class.getSimpleName();

    private Activity activity;

    public AREngineCommonHandler(Activity act) {
        activity = act;
    }

    public void navigateToAppMarketPage(Result result) {
        try {
            AREngineAvailability.navigateToAppMarketPage(activity);
        } catch (SecurityException e) {
            Log.w(TAG, "the target app has no permission of media");
            result.error(TAG, "The target app has no permission of media. Message: " + e.getMessage(),
                e.getStackTrace());
        } catch (ActivityNotFoundException e) {
            Log.w(TAG, "the target activity is not found: " + e.getMessage());
            result.error(TAG, "the target activity is not found. Message: " + e.getMessage(), e.getStackTrace());
        }
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "isArEngineServiceApkReady":
                result.success(AREngineAvailability.isArEngineServiceApkReady(activity.getApplicationContext()));
                break;
            case "navigateToAppMarketPage":
                navigateToAppMarketPage(result);
                break;
            default:
                onMethodCallLogger(call, result);
                break;
        }
    }

    public void onMethodCallLogger(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "enableLogger":
                HMSLogger.getInstance(activity).enableLogger();
                result.success(Constants.RESULT_SUCCESS);
                break;
            case "disableLogger":
                HMSLogger.getInstance(activity).disableLogger();
                result.success(Constants.RESULT_SUCCESS);
                break;
            default:
                result.notImplemented();
                break;
        }
    }
}
