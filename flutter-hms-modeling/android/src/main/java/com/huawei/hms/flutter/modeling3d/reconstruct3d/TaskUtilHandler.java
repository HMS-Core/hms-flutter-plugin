/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.modeling3d.reconstruct3d;

import android.content.Context;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.modeling3d.utils.Constants;
import com.huawei.hms.flutter.modeling3d.utils.Constants.TaskUtilsMethods;
import com.huawei.hms.flutter.modeling3d.utils.HMSLogger;
import com.huawei.hms.flutter.modeling3d.utils.ObjectMapper;
import com.huawei.hms.flutter.modeling3d.utils.ResultHandler;
import com.huawei.hms.flutter.modeling3d.utils.ValueGetter;
import com.huawei.hms.objreconstructsdk.Modeling3dReconstructConstants;
import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructQueryResult;
import com.huawei.hms.objreconstructsdk.cloud.Modeling3dReconstructTaskUtils;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public final class TaskUtilHandler implements MethodChannel.MethodCallHandler {
    private static final String DOTTING_TAG = "ReconstructTaskUtil.";

    private Modeling3dReconstructTaskUtils modeling3dReconstructTaskUtils;

    private final Context context;

    private final HMSLogger hmsLogger;

    public TaskUtilHandler(Context context) {
        this.context = context;
        this.hmsLogger = HMSLogger.getInstance(context);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (Constants.TaskUtilsMethods.getEnum(call.method)) {
            case GET_INSTANCE:
                hmsLogger.startMethodExecutionTimer(DOTTING_TAG + TaskUtilsMethods.GET_INSTANCE.getMethodName());
                modeling3dReconstructTaskUtils = Modeling3dReconstructTaskUtils.getInstance(context);
                hmsLogger.sendSingleEvent(DOTTING_TAG + TaskUtilsMethods.GET_INSTANCE.getMethodName());
                result.success(true);
                break;
            case QUERY_TASK:
                queryTask(call, result);
                break;
            case DELETE_TASK:
                deleteTasK(call, result);
                break;
            case SET_TASK_RESTRICT_STATUS:
                setTaskRestrictStatus(call, result);
                break;
            case QUERY_TASK_RESTRICT_STATUS:
                queryTaskRestrictStatus(call, result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void queryTask(final MethodCall call, final MethodChannel.Result result) {
        hmsLogger.startMethodExecutionTimer(DOTTING_TAG + TaskUtilsMethods.QUERY_TASK.getMethodName());
        String taskId = ValueGetter.getString(Constants.TASK_ID, call);
        new Thread(() -> {
            Modeling3dReconstructQueryResult queryResult = modeling3dReconstructTaskUtils.queryTask(taskId);
            String resultTaskId = queryResult.getTaskId();
            if (resultTaskId == null || taskId.equals("")) {
                int errorCode = queryResult.getRetCode();
                ResultHandler.handleErrorOnUIThread(context, result, String.valueOf(errorCode),
                    "No Task Id. Return Message: " + queryResult.getRetMessage());
                hmsLogger.sendSingleEvent(DOTTING_TAG + TaskUtilsMethods.QUERY_TASK.getMethodName(),
                    String.valueOf(errorCode));
            } else {
                ResultHandler.handleSuccessOnUIThread(context, result, ObjectMapper.toMap(queryResult));
                hmsLogger.sendSingleEvent(DOTTING_TAG + TaskUtilsMethods.QUERY_TASK.getMethodName());
            }
        }).start();
    }

    private void deleteTasK(final MethodCall call, final MethodChannel.Result result) {
        hmsLogger.startMethodExecutionTimer(DOTTING_TAG + TaskUtilsMethods.DELETE_TASK.getMethodName());
        String taskId = ValueGetter.getString(Constants.TASK_ID, call);
        new Thread(() -> {
            int resultCode = modeling3dReconstructTaskUtils.deleteTask(taskId);
            if (resultCode == 0) {
                hmsLogger.sendSingleEvent(DOTTING_TAG + TaskUtilsMethods.DELETE_TASK.getMethodName());
            } else {
                hmsLogger.sendSingleEvent(DOTTING_TAG + TaskUtilsMethods.DELETE_TASK.getMethodName(),
                    String.valueOf(resultCode));
            }
            ResultHandler.handleSuccessOnUIThread(context, result, resultCode);
        }).start();
    }

    private void setTaskRestrictStatus(final MethodCall call, final MethodChannel.Result result) {
        hmsLogger.startMethodExecutionTimer(DOTTING_TAG + TaskUtilsMethods.SET_TASK_RESTRICT_STATUS.getMethodName());
        int status = ValueGetter.getInteger("restrictStatus", call);
        String taskId = ValueGetter.getString(Constants.TASK_ID, call);
        new Thread(() -> {
            int resultCode;
            if (status == Modeling3dReconstructConstants.RestrictStatus.UNRESTRICT) {
                resultCode = modeling3dReconstructTaskUtils.setTaskRestrictStatus(taskId,
                    Modeling3dReconstructConstants.RestrictStatus.RESTRICT);
            } else {
                resultCode = modeling3dReconstructTaskUtils.setTaskRestrictStatus(taskId,
                    Modeling3dReconstructConstants.RestrictStatus.UNRESTRICT);
            }
            if (resultCode == 0) {
                hmsLogger.sendSingleEvent(DOTTING_TAG + TaskUtilsMethods.SET_TASK_RESTRICT_STATUS.getMethodName());
            } else {
                hmsLogger.sendSingleEvent(DOTTING_TAG + TaskUtilsMethods.SET_TASK_RESTRICT_STATUS.getMethodName(),
                    String.valueOf(resultCode));
            }
            ResultHandler.handleSuccessOnUIThread(context, result, resultCode);
        }).start();
    }

    private void queryTaskRestrictStatus(final MethodCall call, final MethodChannel.Result result) {
        hmsLogger.startMethodExecutionTimer(DOTTING_TAG + TaskUtilsMethods.QUERY_TASK_RESTRICT_STATUS.getMethodName());
        String taskId = ValueGetter.getString("taskId", call);
        new Thread(() -> {
            int statusCode = modeling3dReconstructTaskUtils.queryTaskRestrictStatus(taskId);
            if (statusCode == 0 || statusCode == 1) {
                hmsLogger.sendSingleEvent(DOTTING_TAG + TaskUtilsMethods.QUERY_TASK_RESTRICT_STATUS.getMethodName());
            } else {
                hmsLogger.sendSingleEvent(DOTTING_TAG + TaskUtilsMethods.QUERY_TASK_RESTRICT_STATUS.getMethodName(),
                    String.valueOf(statusCode));
            }
            ResultHandler.handleSuccessOnUIThread(context, result, statusCode);
        }).start();
    }

}
