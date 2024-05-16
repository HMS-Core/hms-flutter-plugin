/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.awareness.utils;

import android.content.Context;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.awareness.constants.Method;
import com.huawei.hms.flutter.awareness.logger.HMSLogger;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class AwarenessUtilsMethodCallHandler implements MethodCallHandler {
    private final HMSLogger logger;

    public AwarenessUtilsMethodCallHandler(final Context context) {
        logger = HMSLogger.getInstance(context);
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        switch (call.method) {
            case Method.ENABLE_LOGGER:
                logger.enableLogger();
                break;
            case Method.DISABLE_LOGGER:
                logger.disableLogger();
                break;
            default:
                result.notImplemented();
        }
    }
}
