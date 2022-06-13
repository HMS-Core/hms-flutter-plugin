/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.location.handlers;

import android.content.Context;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.location.logger.HMSLogger;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class HMSLoggerMethodHandler implements MethodCallHandler {
    private final Context context;

    public HMSLoggerMethodHandler(final Context context) {
        this.context = context;
    }

    @Override
    public void onMethodCall(final MethodCall call, @NonNull final Result result) {
        switch (call.method) {
            case "enableLogger":
                HMSLogger.getInstance(context).enableLogger();
                result.success(null);
                break;
            case "disableLogger":
                HMSLogger.getInstance(context).disableLogger();
                result.success(null);
                break;
            default:
                break;
        }
    }
}
