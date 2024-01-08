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

import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.health.foundation.logger.HMSLogger;
import com.huawei.hms.flutter.health.foundation.utils.ExceptionHandler;
import com.huawei.hms.flutter.health.foundation.utils.Utils;
import com.huawei.hms.flutter.health.modules.autorecorder.listener.VoidOnCompleteListener;

import io.flutter.plugin.common.MethodChannel.Result;

public class VoidOnCompleteResultHelper implements VoidOnCompleteListener {
    private Result result;

    private Context context;

    private String methodName;

    public VoidOnCompleteResultHelper(@NonNull Result result, Context context, final String methodName) {
        super();
        this.result = result;
        this.context = context;
        this.methodName = methodName;
    }

    @Override
    public void onSuccess(Void voidResult) {
        // Result only resolves once on the onComplete method.
    }

    @Override
    public void onFail(Exception exception) {
        // Result only resolves once on the onComplete method.
    }

    @Override
    public void onComplete(Task<Void> taskResult) {
        if (taskResult.getException() != null) {
            String errorCode = Utils.getErrorCode(taskResult.getException());
            HMSLogger.getInstance(context).sendSingleEvent(methodName, errorCode);
            ExceptionHandler.fail(taskResult.getException(), result);
        } else {
            HMSLogger.getInstance(context).sendSingleEvent(methodName);
            result.success(toResultMap(null, true));
        }
    }
}
