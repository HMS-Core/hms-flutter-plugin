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

import com.huawei.hms.flutter.push.constants.Code;
import com.huawei.hms.flutter.push.logger.HMSLogger;
import com.huawei.hms.push.HmsProfile;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

import java.util.Objects;

public class FlutterHmsProfile {
    private final Context context;

    private final HMSLogger hmsLogger;

    public FlutterHmsProfile(Context context) {
        this.context = context;
        hmsLogger = HMSLogger.getInstance(context);
    }

    public void isSupportProfile(final Result result) {
        result.success(HmsProfile.getInstance(context).isSupportProfile());
    }

    public void addProfile(final MethodCall call, final Result result) {
        final String methodName = "addProfile";
        hmsLogger.startMethodExecutionTimer(methodName);
        int type = Objects.requireNonNull(call.argument("type"));
        String profileId = call.argument("profileId");
        HmsProfile.getInstance(context).addProfile(type, profileId).addOnSuccessListener(aVoid -> {
            result.success(true);
            hmsLogger.sendSingleEvent(methodName);
        }).addOnFailureListener(e -> {
            result.error(Code.RESULT_ERROR.code(), "AddProfile failed: " + e.getMessage(), null);
            hmsLogger.sendSingleEvent(methodName, Code.RESULT_ERROR.code());
        });
    }

    public void addMultiSenderProfile(final MethodCall call, final Result result) {
        final String methodName = "addMultiSenderProfile";
        hmsLogger.startMethodExecutionTimer(methodName);
        String subjectId = call.argument("subjectId");
        int type = Objects.requireNonNull(call.argument("type"));
        String profileId = call.argument("profileId");
        HmsProfile.getInstance(context).addProfile(subjectId, type, profileId).addOnSuccessListener(aVoid -> {
            result.success(true);
            hmsLogger.sendSingleEvent(methodName);
        }).addOnFailureListener(e -> {
            result.error(Code.RESULT_ERROR.code(), "AddMultiSenderProfile failed: " + e.getMessage(), null);
            hmsLogger.sendSingleEvent(methodName, Code.RESULT_ERROR.code());
        });
    }

    public void deleteProfile(final MethodCall call, final Result result) {
        final String methodName = "deleteProfile";
        hmsLogger.startMethodExecutionTimer(methodName);
        String profileId = call.argument("profileId");
        HmsProfile.getInstance(context).deleteProfile(profileId).addOnSuccessListener(aVoid -> {
            result.success(true);
            hmsLogger.sendSingleEvent(methodName);
        }).addOnFailureListener(e -> {
            result.error(Code.RESULT_ERROR.code(), "DeleteProfile failed: " + e.getMessage(), null);
            hmsLogger.sendSingleEvent(methodName, Code.RESULT_ERROR.code());
        });
    }

    public void deleteMultiSenderProfile(final MethodCall call, final Result result) {
        final String methodName = "deleteMultiSenderProfile";
        hmsLogger.startMethodExecutionTimer(methodName);
        String subjectId = call.argument("subjectId");
        String profileId = call.argument("profileId");
        HmsProfile.getInstance(context).deleteProfile(subjectId, profileId).addOnSuccessListener(aVoid -> {
            result.success(true);
            hmsLogger.sendSingleEvent(methodName);
        }).addOnFailureListener(e -> {
            result.error(Code.RESULT_ERROR.code(), "DeleteMultiSenderProfile failed: " + e.getMessage(), null);
            hmsLogger.sendSingleEvent(methodName, Code.RESULT_ERROR.code());
        });
    }
}
