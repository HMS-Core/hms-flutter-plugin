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

package com.huawei.hms.flutter.modeling3d.utils;

import android.content.Context;
import android.os.Handler;

import io.flutter.plugin.common.MethodChannel.Result;

public final class ResultHandler {
    private ResultHandler() {
    }

    public static void handleErrorOnUIThread(Context context, final Result result, String errorCode, String errorMessage) {
        new Handler(context.getMainLooper()).post(() -> result.error(errorCode, "Result Code: " + errorCode + " ErrorMessage: " + errorMessage, null));
    }

    public static void handleSuccessOnUIThread(Context context, final Result result, Object resultObject) {
        new Handler(context.getMainLooper()).post(() -> result.success(resultObject));
    }
}
