/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.health.modules.datacontroller;

import static com.huawei.hms.flutter.health.foundation.utils.MapUtils.toResultMap;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.huawei.hms.flutter.health.foundation.helper.ResultHelper;
import com.huawei.hms.flutter.health.foundation.helper.VoidResultHelper;
import com.huawei.hms.flutter.health.foundation.logger.HMSLogger;
import com.huawei.hms.flutter.health.foundation.utils.ExceptionHandler;
import com.huawei.hms.flutter.health.foundation.utils.Utils;
import com.huawei.hms.flutter.health.modules.datacontroller.service.DataControllerService;
import com.huawei.hms.flutter.health.modules.datacontroller.service.DefaultDataController;
import com.huawei.hms.flutter.health.modules.datacontroller.utils.DataControllerConstants;
import com.huawei.hms.flutter.health.modules.datacontroller.utils.DataControllerConstants.DataControllerMethods;
import com.huawei.hms.flutter.health.modules.datacontroller.utils.DataControllerUtils;
import com.huawei.hms.hihealth.DataController;
import com.huawei.hms.hihealth.HiHealthOptions;
import com.huawei.hms.hihealth.HiHealthStatusCodes;
import com.huawei.hms.hihealth.HuaweiHiHealth;
import com.huawei.hms.hihealth.data.DataCollector;
import com.huawei.hms.hihealth.data.DataType;
import com.huawei.hms.hihealth.data.SampleSet;
import com.huawei.hms.hihealth.options.DeleteOptions;
import com.huawei.hms.hihealth.options.ReadOptions;
import com.huawei.hms.hihealth.options.UpdateOptions;
import com.huawei.hms.hihealth.result.ReadReply;
import com.huawei.hms.support.hwid.HuaweiIdAuthManager;
import com.huawei.hms.support.hwid.result.AuthHuaweiId;

import java.security.InvalidParameterException;
import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class DataControllerMethodHandler implements MethodCallHandler {
    private DataControllerService defaultDataController;
    private DataController dataController;

    private Activity activity;
    private Context context;

    public void setActivity(@Nullable Activity activity) {
        this.activity = activity;
        if (activity != null) {
            this.context = activity.getApplicationContext();
        }
    }

    public DataControllerMethodHandler(Activity activity) {
        this.defaultDataController = new DefaultDataController();
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer(call.method);
        switch (DataControllerMethods.get(call.method)) {
            case INIT:
                initDataController(call, result);
                break;
            case CLEAR_ALL:
                clearAll(call, result);
                break;
            case DELETE:
                delete(call, result);
                break;
            case INSERT:
                insert(call, result);
                break;
            case READ:
                read(call, result);
                break;
            case READ_DAILY_SUMMATION:
                readDailySummation(call, result);
                break;
            case READ_TODAY_SUMMATION:
                readTodaySummation(call, result);
                break;
            case UPDATE:
                update(call, result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    /**
     * Initialize a data controller object.
     * <p>
     * Note:  Before using {@link DefaultDataController} methods, always initDataController method must be called with
     * requested dataTypes.
     * </p>
     *
     * @param call   MethodCall instance, referred to dataTypeList that will be reached to create dataController.
     * @param result In the success scenario, result is returned with {@code isSuccess: true} params , or Exception is
     *               returned in the failure scenario.
     */
    public void initDataController(final MethodCall call, final Result result) {
        AuthHuaweiId signInHuaweiId = HuaweiIdAuthManager.getExtendedAuthResult(
            DataControllerUtils.toHiHealthOptions(call, activity.getPackageName()));
        this.dataController = HuaweiHiHealth.getDataController(activity, signInHuaweiId);
        result.success(toResultMap(null, true));
    }

    /**
     * Insert the user's fitness and health data into the Health platform.
     *
     * @param call   Flutter Method Call that Refers includes {@link DataCollector} and {@link SampleSet} data.
     * @param result In the success scenario, Void is returned , or Exception is returned in the failure scenario.
     */
    public void insert(final MethodCall call, final Result result) {
        checkDataController();
        // Create a sampling dataset set based on the data collector.
        final SampleSet sampleSet = Utils.toSampleSet((HashMap<String, Object>) call.arguments, result,
            activity.getPackageName());

        defaultDataController.insertData(dataController, sampleSet, new VoidResultHelper(result, context, call.method));
    }

    /**
     * Updating the User's Fitness and Health Data
     * </br>
     * 1. Build the condition for data update: a DataCollector object. 2. Build the sampling data set for the update:
     * create a sampling data set for the update based on the data collector. 3. Build the start time, end time, and
     * incremental step count for a DataType sampling point for the update. 4. Build a DataType sampling point for the
     * update 5. Add an updated DataType sampling point to the sampling data set for the update. You can add more
     * updated sampling points to the sampling data set for the update. 6. Build a parameter object for the update. 7.
     * Use the specified parameter object for the update to call the data controller to modify the sampling dataset.
     *
     * @param call   Flutter MethodCall that includes {@link UpdateOptions} data.
     * @param result In the success scenario, Void is returned , or Exception is returned in the failure scenario.
     */
    public void update(final MethodCall call, final Result result) {
        checkDataController();
        // Build a parameter object for the update.
        // Note: (1) The start time of the modified object updateOptions cannot be greater than the minimum
        // value of the start time of all sample data points in the modified data sample set
        // (2) The end time of the modified object updateOptions cannot be less than the maximum value of the
        // end time of all sample data points in the modified data sample set
        try {
            UpdateOptions updateOptions = DataControllerUtils.toUpdateOptions(call, result, activity.getPackageName());
            defaultDataController.updateData(dataController, updateOptions,
                new VoidResultHelper(result, context, call.method));
        } catch (InvalidParameterException e) {
            HMSLogger.getInstance(context)
                .sendSingleEvent(call.method, String.valueOf(HiHealthStatusCodes.INPUT_PARAM_MISSING));
            ExceptionHandler.fail(e, result);
        }
    }

    /**
     * Querying the User's Fitness and Health Data
     * <p>
     * Note: To read historical data from the Health platform, for example, to read the number of steps taken within a
     * period of time, you can specify the read conditions in ReadOptions. Furthermore, you can specify the data
     * collector, data type, and detailed data. If data is read, the data set will be returned.
     * </p>
     *
     * @param call   Flutter MethodCall that should contain {@link DataCollector} data.
     * @param result In the success scenario, {@link ReadReply} instance is returned , or Exception is returned in the
     *               failure scenario.
     */
    public void read(final MethodCall call, final Result result) {
        checkDataController();
        // Build the condition-based query object
        ReadOptions readOptions = DataControllerUtils.toReadOptions(call, result, activity.getPackageName());

        defaultDataController.readData(dataController, readOptions,
            new ResultHelper<>(ReadReply.class, result, context, call.method));
    }

    /**
     * Deleting the User's Fitness and Health Data
     *
     * <p>
     * Note: Only historical data that has been inserted by the current app can be deleted from the Health platform. *
     * </p>
     *
     * @param call   Flutter MethodCall that refers to {@link DataCollector} instance.
     * @param result In the success scenario, Void is returned , or Exception is returned in the failure scenario.
     */
    public void delete(final MethodCall call, final Result result) {
        checkDataController();
        // Build the time range for the deletion: start time and end time.
        // Build a parameter object as the conditions for the deletion.
        DeleteOptions deleteOptions = DataControllerUtils.toDeleteOptions(call, result, activity.getPackageName());

        defaultDataController.deleteData(dataController, deleteOptions,
            new VoidResultHelper(result, context, call.method));
    }

    /**
     * Querying the Summary Fitness and Health Data of the User of the Current day
     *
     * @param call   Flutter Method Call that refers to {@link DataType} instance.
     * @param result In the success scenario, {@link SampleSet} instance is returned , or Exception is returned in the
     *               failure scenario.
     */
    public void readTodaySummation(final MethodCall call, final Result result) {
        checkDataController();
        DataType dataType = Utils.toDataType((HashMap<String, Object>) call.arguments, activity.getPackageName());

        // Use the specified data type (DT_CONTINUOUS_STEPS_DELTA) to call the data controller to query
        // the summary data of this data type of the current day.
        defaultDataController.readToday(dataController, dataType,
            new ResultHelper<>(SampleSet.class, result, context, call.method));
    }

    /**
     * Querying the Summary Fitness and Health Data of the User of the Current day
     *
     * @param call   Flutter Method call that includes {@link DataType, startTime and endTime} data.
     * @param result In the success scenario, {@link SampleSet} instance is returned , or Exception is returned in the
     *               failure scenario.
     */
    public void readDailySummation(final MethodCall call, Result result) {
        // An 8-digit integer in the format of YYYYMMDD, for example, 20200803.
        int startTime = Utils.getInt(call, "startTime");
        // An 8-digit integer in the format of YYYYMMDD, for example, 20200903.
        int endTime = Utils.getInt(call, "endTime");
        checkDataController();
        Map<String, Object> dataTypeMap = (HashMap<String, Object>) call.argument(
            DataControllerConstants.DATA_TYPE_KEY);
        if (dataTypeMap != null) {
            DataType dataType = Utils.toDataType(dataTypeMap, activity.getPackageName());
            defaultDataController.readDailySummation(dataController, dataType, startTime, endTime,
                new ResultHelper<>(SampleSet.class, result, context, call.method));
        } else {
            HMSLogger.getInstance(context)
                .sendSingleEvent(call.method, String.valueOf(HiHealthStatusCodes.INPUT_PARAM_MISSING));
            result.error(DataControllerConstants.DATA_CONTROLLER_MODULE, "Error: Empty or wrong parameters.", "");
        }
    }

    /**
     * Clearing the User's Fitness and Health Data from the Device and Cloud
     *
     * @param result In the success scenario, Void is returned , or Exception is returned in the failure scenario.
     */
    public void clearAll(final MethodCall call, final Result result) {
        checkDataController();
        defaultDataController.clearTaskData(dataController, new VoidResultHelper(result, context, call.method));
    }

    /* Private Methods */

    /**
     * Initialize variable of dataController with no dataType params, in case it is null.
     */
    private void initDataController() {
        // create HiHealth Options, donnot add any datatype here.
        HiHealthOptions hiHealthOptions = HiHealthOptions.builder().build();
        // get AuthHuaweiId by HiHealth Options.
        AuthHuaweiId signInHuaweiId = HuaweiIdAuthManager.getExtendedAuthResult(hiHealthOptions);
        this.dataController = HuaweiHiHealth.getDataController(activity, signInHuaweiId);
    }

    /**
     * Check whether dataController is initialized, or not.
     */
    private void checkDataController() {
        if (this.defaultDataController == null && this.activity != null) {
            initDataController();
        }
    }

}
