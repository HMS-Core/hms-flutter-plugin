/*
 * Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.modeling3d.reconstruct3d;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.modeling3d.utils.HMSLogger;
import com.huawei.hms.objreconstructsdk.ReconstructApplication;

import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public final class ReconstructApplicationHandler implements MethodChannel.MethodCallHandler {
    private final Activity activity;

    public ReconstructApplicationHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        final String event = "ReconstructApplication." + call.method;
        HMSLogger.getInstance(activity).startMethodExecutionTimer(event);
        switch (call.method) {
            case "setAccessToken":
                final String accessToken = Objects.requireNonNull(call.argument("accessToken"));

                ReconstructApplication.getInstance().setAccessToken(accessToken);
                HMSLogger.getInstance(activity).sendSingleEvent(event);
                result.success(true);
                break;
            case "setApiKey":
                final String apiKey = Objects.requireNonNull(call.argument("apiKey"));

                ReconstructApplication.getInstance().setApiKey(apiKey);
                HMSLogger.getInstance(activity).sendSingleEvent(event);
                result.success(true);
                break;
            default:
                result.notImplemented();
        }
    }
}
