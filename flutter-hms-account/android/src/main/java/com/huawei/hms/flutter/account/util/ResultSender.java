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

package com.huawei.hms.flutter.account.util;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.common.ApiException;
import com.huawei.hms.flutter.account.logger.HMSLogger;

import io.flutter.plugin.common.MethodChannel;

public class ResultSender {
    public static void exception(Activity activity, String tag, Exception e, String methodName, MethodChannel.Result result) {
        if (e instanceof ApiException) {
            ApiException apiException = (ApiException) e;
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(methodName, String.valueOf(apiException.getStatusCode()));
            result.error(tag, apiException.getMessage(), apiException.getStatusCode());
        } else {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(methodName, e.getMessage());
            result.error(tag, e.getMessage(), null);
        }
    }

    public static void success(@NonNull Activity activity, String methodName, @NonNull MethodChannel.Result result, Object o) {
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(methodName);
        result.success(o);
    }

    public static void illegal(@NonNull Activity activity, String tag, String methodName, @NonNull MethodChannel.Result result) {
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(methodName, Constants.ILLEGAL_PARAMETER);
        result.error(tag, "Required parameters must not be null or empty!", Constants.ILLEGAL_PARAMETER);
    }
}
