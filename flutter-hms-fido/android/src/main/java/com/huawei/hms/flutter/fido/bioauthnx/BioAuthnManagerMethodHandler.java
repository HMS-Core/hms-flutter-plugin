/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.fido.bioauthnx;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.fido.logger.HMSLogger;
import com.huawei.hms.support.api.fido.bioauthn.BioAuthnManager;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class BioAuthnManagerMethodHandler implements MethodChannel.MethodCallHandler {
    private final Activity activity;

    public BioAuthnManagerMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "canAuth":
                performCanAuth(result);
                break;
            case "enableLogger":
                enableLogger(result);
                break;
            case "disableLogger":
                disableLogger(result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void enableLogger(MethodChannel.Result result) {
        HMSLogger.getInstance(activity.getApplicationContext()).enableLogger();
        result.success(true);
    }

    private void disableLogger(MethodChannel.Result result) {
        HMSLogger.getInstance(activity.getApplicationContext()).disableLogger();
        result.success(true);
    }

    /**
     * Checks whether fingerprint authentication is available.
     */
    private void performCanAuth(MethodChannel.Result result) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("bioAuthnManagerCanAuth");
        BioAuthnManager manager = new BioAuthnManager(activity);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("bioAuthnManagerCanAuth");
        result.success(manager.canAuth());
    }
}
