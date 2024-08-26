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

import com.huawei.hmf.tasks.OnFailureListener;
import com.huawei.hms.common.ApiException;
import com.huawei.hms.flutter.location.logger.HMSLogger;
import com.huawei.hms.flutter.location.utils.ObjectUtils;

import io.flutter.plugin.common.MethodChannel.Result;

public class DefaultFailureListener implements OnFailureListener {
    private final String methodName;

    private final Context context;

    private final Result result;

    public DefaultFailureListener(final String methodName, final Context context, final Result result) {
        this.methodName = methodName;
        this.context = context;
        this.result = result;
    }

    @Override
    public void onFailure(final Exception e) {
        final ApiException ex = ObjectUtils.cast(e, ApiException.class);
        final String statusCodeString = Integer.toString(ex.getStatusCode());

        HMSLogger.getInstance(context).sendSingleEvent(methodName, statusCodeString);
        result.error(statusCodeString, ex.getMessage(), null);
    }
}
