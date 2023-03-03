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

package com.huawei.hms.flutter.modeling3d.reconstruct3d;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.modeling3d.utils.HMSLogger;
import com.huawei.hms.flutter.modeling3d.utils.ObjectMapper;
import com.huawei.hms.flutter.modeling3d.utils.ResultHandler;
import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructQueryResult;
import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructTaskUtils;

import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public final class TaskUtilHandler implements MethodChannel.MethodCallHandler {
    private static final String DOTTING_TAG = "ReconstructTaskUtil.";
    private final Activity activity;

    public TaskUtilHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        HMSLogger.getInstance(activity).startMethodExecutionTimer(DOTTING_TAG + call.method);
        switch (call.method) {
            case "queryTask":
                queryTask(call, result);
                break;
            case "deleteTask":
                deleteTasK(call, result);
                break;
            case "setTaskRestrictStatus":
                setTaskRestrictStatus(call, result);
                break;
            case "queryTaskRestrictStatus":
                queryTaskRestrictStatus(call, result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void queryTask(MethodCall call, MethodChannel.Result result) {
        final String taskId = Objects.requireNonNull(call.argument("taskId"));
        new Thread(() -> {
            final Modeling3dReconstructQueryResult queryResult = Modeling3dReconstructTaskUtils.getInstance(activity).queryTask(taskId);
            final String resultTaskId = queryResult.getTaskId();
            if (resultTaskId == null || taskId.equals("")) {
                final int errorCode = queryResult.getRetCode();
                ResultHandler.handleErrorOnUIThread(activity, result, String.valueOf(errorCode), "No Task Id. Return Message: " + queryResult.getRetMessage());
                HMSLogger.getInstance(activity).sendSingleEvent(DOTTING_TAG + "queryTask", String.valueOf(errorCode));
            } else {
                ResultHandler.handleSuccessOnUIThread(activity, result, ObjectMapper.toMap(queryResult));
                HMSLogger.getInstance(activity).sendSingleEvent(DOTTING_TAG + "queryTask");
            }
        }).start();
    }

    private void deleteTasK(MethodCall call, MethodChannel.Result result) {
        final String taskId = Objects.requireNonNull(call.argument("taskId"));
        new Thread(() -> {
            final int resultCode = Modeling3dReconstructTaskUtils.getInstance(activity).deleteTask(taskId);
            if (resultCode == 0) {
                HMSLogger.getInstance(activity).sendSingleEvent(DOTTING_TAG + "deleteTask");
            } else {
                HMSLogger.getInstance(activity).sendSingleEvent(DOTTING_TAG + "deleteTask", String.valueOf(resultCode));
            }
            ResultHandler.handleSuccessOnUIThread(activity, result, resultCode);
        }).start();
    }

    private void setTaskRestrictStatus(MethodCall call, MethodChannel.Result result) {
        final String taskId = Objects.requireNonNull(call.argument("taskId"));
        final int restrictStatus = Objects.requireNonNull(call.argument("restrictStatus"));

        new Thread(() -> {
            final int resultCode = Modeling3dReconstructTaskUtils.getInstance(activity).setTaskRestrictStatus(taskId, restrictStatus);
            if (resultCode == 0) {
                HMSLogger.getInstance(activity).sendSingleEvent(DOTTING_TAG + "setTaskRestrictStatus");
            } else {
                HMSLogger.getInstance(activity).sendSingleEvent(DOTTING_TAG + "setTaskRestrictStatus", String.valueOf(resultCode));
            }
            ResultHandler.handleSuccessOnUIThread(activity, result, resultCode);
        }).start();
    }

    private void queryTaskRestrictStatus(MethodCall call, MethodChannel.Result result) {
        final String taskId = Objects.requireNonNull(call.argument("taskId"));

        new Thread(() -> {
            final int statusCode = Modeling3dReconstructTaskUtils.getInstance(activity).queryTaskRestrictStatus(taskId);
            if (statusCode == 0 || statusCode == 1) {
                HMSLogger.getInstance(activity).sendSingleEvent(DOTTING_TAG + "queryTaskRestrictStatus");
            } else {
                HMSLogger.getInstance(activity).sendSingleEvent(DOTTING_TAG + "queryTaskRestrictStatus", String.valueOf(statusCode));
            }
            ResultHandler.handleSuccessOnUIThread(activity, result, statusCode);
        }).start();
    }
}
