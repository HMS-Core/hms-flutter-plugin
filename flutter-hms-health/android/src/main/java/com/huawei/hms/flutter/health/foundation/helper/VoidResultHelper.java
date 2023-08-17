/*
 * Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.health.foundation.helper;

import static com.huawei.hms.flutter.health.foundation.utils.MapUtils.toResultMap;

import android.content.Context;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.health.foundation.listener.VoidResultListener;
import com.huawei.hms.flutter.health.foundation.logger.HMSLogger;
import com.huawei.hms.flutter.health.foundation.utils.ExceptionHandler;
import com.huawei.hms.flutter.health.foundation.utils.Utils;

import io.flutter.plugin.common.MethodChannel.Result;

public class VoidResultHelper implements VoidResultListener {
    // Internal MethodChannel.Result instance that will be initialized during construction.
    private Result flutterResult;

    // Application context.
    private Context context;

    // Method name which initiated the listener.
    private String methodName;

    public VoidResultHelper(final @NonNull Result result, Context context, final String methodName) {
        this.flutterResult = result;
        this.context = context;
        this.methodName = methodName;
    }

    /**
     * Returns success via result instance.
     *
     * @param voidResult Health Result instance.
     */
    @Override
    public void onSuccess(Void voidResult) {
        HMSLogger.getInstance(context).sendSingleEvent(methodName);
        flutterResult.success(toResultMap(null, true));
    }

    /**
     * Returns exception via Result instance.
     *
     * @param exception Exception instance.
     */
    @Override
    public void onFail(Exception exception) {
        String errorCode = Utils.getErrorCode(exception);
        HMSLogger.getInstance(context).sendSingleEvent(methodName, errorCode);
        ExceptionHandler.fail(exception, flutterResult);
    }
}
