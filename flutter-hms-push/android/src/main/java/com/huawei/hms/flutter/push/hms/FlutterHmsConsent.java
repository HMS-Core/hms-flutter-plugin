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

package com.huawei.hms.flutter.push.hms;

import android.content.Context;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.push.constants.Code;
import com.huawei.hms.flutter.push.logger.HMSLogger;
import com.huawei.hms.push.HmsConsent;

import io.flutter.plugin.common.MethodChannel.Result;

public class FlutterHmsConsent {
    private static final String TAG = FlutterHmsConsent.class.getSimpleName();

    private final HMSLogger hmsLogger;

    private final Context context;

    public FlutterHmsConsent(@NonNull Context context) {
        this.context = context;
        hmsLogger = HMSLogger.getInstance(context);
    }

    public void consentOn(final Result result) {
        try {
            hmsLogger.startMethodExecutionTimer("consentOn");
            HmsConsent.getInstance(context).consentOn().addOnCompleteListener(task -> {
                if (task.isSuccessful()) {
                    hmsLogger.sendSingleEvent("consentOn");
                    result.success(Code.RESULT_SUCCESS.code());
                } else {
                    hmsLogger.sendSingleEvent("consentOn", Code.RESULT_UNKNOWN.code());
                    result.error(Code.RESULT_UNKNOWN.code(), task.getException().getMessage(),
                        task.getException().getCause());
                }
            });
        } catch (Exception e) {
            hmsLogger.sendSingleEvent("consentOn", Code.RESULT_UNKNOWN.code());
            result.error(Code.RESULT_UNKNOWN.code(), e.getMessage(), e.getCause());
        }
    }

    public void consentOff(final Result result) {
        try {
            hmsLogger.startMethodExecutionTimer("consentOff");
            HmsConsent.getInstance(context).consentOff().addOnCompleteListener(task -> {
                if (task.isSuccessful()) {
                    hmsLogger.sendSingleEvent("consentOff");
                    result.success(Code.RESULT_SUCCESS.code());
                } else {
                    hmsLogger.sendSingleEvent("consentOff", Code.RESULT_UNKNOWN.code());
                    result.error(Code.RESULT_UNKNOWN.code(), task.getException().getMessage(),
                        task.getException().getCause());
                }
            });
        } catch (Exception e) {
            hmsLogger.sendSingleEvent("consentOff", Code.RESULT_UNKNOWN.code());
            result.error(Code.RESULT_UNKNOWN.code(), e.getMessage(), e.getCause());
        }
    }
}
