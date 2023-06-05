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

package com.huawei.hms.flutter.health.modules.autorecorder;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.huawei.hms.flutter.health.foundation.constants.Constants;
import com.huawei.hms.flutter.health.foundation.helper.VoidOnCompleteResultHelper;
import com.huawei.hms.flutter.health.foundation.logger.HMSLogger;
import com.huawei.hms.flutter.health.foundation.utils.Utils;
import com.huawei.hms.flutter.health.modules.autorecorder.service.DefaultAutoRecorderService;
import com.huawei.hms.flutter.health.modules.autorecorder.utils.AutoRecorderConstants;
import com.huawei.hms.hihealth.AutoRecorderController;
import com.huawei.hms.hihealth.HuaweiHiHealth;
import com.huawei.hms.hihealth.data.DataType;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import java.util.Map;

public class AutoRecorderMethodHandler implements MethodCallHandler {
    // ViewModel instance to reach AutoRecorderController tasks
    private DefaultAutoRecorderService autoRecorderService;

    // HMS Health AutoRecorderController
    private AutoRecorderController autoRecorderController;

    // Local activity instance.
    private Activity activity;

    // Application context.
    private Context context;

    // Whether is recording now
    private boolean isRecording;

    /**
     * Initialization
     */
    public AutoRecorderMethodHandler(@Nullable Activity activity) {
        this.activity = activity;
        isRecording = false;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer(call.method);
        if (call.method.equals(AutoRecorderConstants.START_RECORD)) {
            startRecord(call, result);
        } else if (call.method.equals(AutoRecorderConstants.STOP_RECORD)) {
            stopRecord(call, result);
        } else {
            result.notImplemented();
        }
    }

    public void setActivity(@Nullable Activity activity) {
        this.activity = activity;
        if (activity != null) {
            this.context = activity.getApplicationContext();
            checkAutoRecorderController();
        }
    }

    /**
     * Record data via DataType supported by Huawei.
     * </br>
     * Start record By DataType, the data from sensor will be inserted into database automatically until call Stop
     * Interface
     *
     * @param call Flutter Method Call instance to get {@link DataType} object that contains request information.
     * @param result In the success scenario, Void instance is returned , or Exception is returned in the failure
     * scenario. Also, the interface won't always success, onCompleteStartRecordByType event will be
     * triggered once the task is completed to get the judgement of result is successful or not. The fail
     * reason includes: 1. The app hasn't been granted the scopes. 2. This type is not supported so far.
     */
    public void startRecord(final MethodCall call, final Result result) {
        checkAutoRecorderController();
        if (!isRecording) {
            isRecording = true;
            Map<String, Object> dataTypeMap = call.argument("dataType");
            if (dataTypeMap != null) {
                DataType dataType = Utils.toDataType(dataTypeMap, activity.getPackageName());
                autoRecorderService.startRecord(autoRecorderController, dataType, call.argument("notification"),
                    new VoidOnCompleteResultHelper(result, context, call.method));
            } else {
                result.error(Constants.UNKNOWN_ERROR_CODE, "startRecord - failed please provide a data type", "");
            }
        } else {
            result.error(Constants.UNKNOWN_ERROR_CODE, "record- Recorder is already started", "");
        }
    }

    /**
     * Stop recoding by specifying the data type.
     * </br>
     * Stop record By DataType, the data from sensor will NOT be inserted into database automatically
     *
     * <p>
     * Note: You are advised to obtain the record using the getRecords method or create the record by specifying the
     * data type and/or data collector. If both the data type and data collector are specified, ensure that the data
     * type in the data collector is the same as that in the record information. Otherwise, errors will occur.
     * </p>
     *
     * @param call Flutter MethodCall instance instance to get {@link DataType} object that contains request
     * information.
     * @param result In the success scenario, Void instance is returned , or Exception is returned in the failure
     * scenario. Also, the interface won't always success, onCompleteStartRecordByType event will be
     * triggered once the task is completed to get the judgement of result is successful or not. The fail
     * reason includes: 1. The app hasn't been granted the scopes. 2. This type is not supported so far.
     */
    public void stopRecord(final MethodCall call, final Result result) {
        checkAutoRecorderController();
        DataType dataType;
        if (call.arguments != null) {
            Map<String, Object> dataTypeMap = (Map<String, Object>) call.arguments;
            dataType = Utils.toDataType(dataTypeMap, activity.getPackageName());
        } else {
            result.error(Constants.UNKNOWN_ERROR_CODE, "stopRecord - failed please provide a data type", "");
            return;
        }
        try {
            autoRecorderService.stopRecord(this.autoRecorderController, dataType,
                new VoidOnCompleteResultHelper(result, context, call.method));
            isRecording = false;
        } catch (Exception e) {
            result.error(Constants.UNKNOWN_ERROR_CODE, "Ongoing record is not found", e.getMessage());
        }
    }

    /**
     * Initialize {@link AutoRecorderController}.
     */
    private void initAutoRecorderController() {
        this.autoRecorderController = HuaweiHiHealth.getAutoRecorderController(activity);
    }

    /**
     * Check whether autoRecorderController is initialized, or not.
     */
    private void checkAutoRecorderController() {
        if (this.autoRecorderController == null && activity != null) {
            initAutoRecorderController();
        }
        if (autoRecorderService == null) {
            autoRecorderService = new DefaultAutoRecorderService(activity);
        }
    }

    public void unregisterReceiver() {
        autoRecorderService.unregisterReceiver();
    }
}
