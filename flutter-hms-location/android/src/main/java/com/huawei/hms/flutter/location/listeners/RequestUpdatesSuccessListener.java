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

package com.huawei.hms.flutter.location.listeners;

import android.content.Context;

import com.huawei.hmf.tasks.OnSuccessListener;
import com.huawei.hms.flutter.location.logger.HMSLogger;

import io.flutter.plugin.common.MethodChannel.Result;

public class RequestUpdatesSuccessListener implements OnSuccessListener<Void> {
    private final Result result;

    private final Integer requestCode;

    private final Context context;

    private final String methodName;

    public RequestUpdatesSuccessListener(final String methodName, final Context context, final Result result,
        final Integer requestCode) {
        this.methodName = methodName;
        this.context = context;
        this.result = result;
        this.requestCode = requestCode;
    }

    @Override
    public void onSuccess(final Void avoid) {
        HMSLogger.getInstance(context).sendSingleEvent(methodName);
        result.success(requestCode);
    }
}
