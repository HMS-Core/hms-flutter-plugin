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

package com.huawei.hms.flutter.health.modules.activityrecord;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.huawei.hms.flutter.health.foundation.helper.ResultHelper;
import com.huawei.hms.flutter.health.foundation.helper.VoidResultHelper;
import com.huawei.hms.flutter.health.foundation.logger.HMSLogger;
import com.huawei.hms.flutter.health.foundation.utils.Utils;
import com.huawei.hms.flutter.health.modules.activityrecord.service.DefaultActivityRecordService;
import com.huawei.hms.flutter.health.modules.activityrecord.utils.ActivityRecordUtils;
import com.huawei.hms.flutter.health.modules.activityrecord.utils.ActivityRecordsConstants.ActivityRecordMethods;
import com.huawei.hms.flutter.health.modules.healthcontroller.HealthRecordUtils;
import com.huawei.hms.hihealth.ActivityRecordsController;
import com.huawei.hms.hihealth.HiHealthStatusCodes;
import com.huawei.hms.hihealth.HuaweiHiHealth;
import com.huawei.hms.hihealth.data.ActivityRecord;
import com.huawei.hms.hihealth.data.SampleSet;
import com.huawei.hms.hihealth.options.ActivityRecordDeleteOptions;
import com.huawei.hms.hihealth.options.ActivityRecordReadOptions;
import com.huawei.hms.hihealth.result.ActivityRecordReply;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ActivityRecordsMethodHandler implements MethodCallHandler {
    private ActivityRecordsController activityRecordsController;

    private DefaultActivityRecordService flutterActivityRecordsImpl;

    private Activity activity;

    private Context context;

    public ActivityRecordsMethodHandler(@Nullable Activity activity) {
        this.activity = activity;
        this.flutterActivityRecordsImpl = new DefaultActivityRecordService();
        initActivityRecordsController();
    }

    public void setActivity(@Nullable Activity activity) {
        this.activity = activity;
        if (activity != null) {
            this.context = activity.getApplicationContext();
        }
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer(call.method);
        switch (ActivityRecordMethods.get(call.method)) {
            case ADD_ACTIVITY_RECORD:
                addActivityRecord(call, result);
                break;
            case GET_ACTIVITY_RECORD:
                getActivityRecord(call, result);
                break;
            case BEGIN_ACTIVITY_RECORD:
                beginActivityRecord(call, result);
                break;
            case CONTINUE_ACTIVITY_RECORD:
                continueActivityRecord(call, result);
                break;
            case END_ACTIVITY_RECORD:
                endActivityRecord(call, result);
                break;
            case END_ALL_ACTIVITY_RECORDS:
                endAllActivityRecords(call, result);
                break;
            case DELETE_ACTIVITY_RECORD:
                deleteActivityRecord(call, result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void addActivityRecord(final MethodCall call, final Result result) {
        checkActivityRecordsController();
        // Build the time range of the request object: start time and end time
        // Build the activity record request object
        ActivityRecord activityRecord = ActivityRecordUtils.toActivityRecord(Utils.getMap(call, "activityRecord"),
            activity.getPackageName());

        List<SampleSet> sampleSets = new ArrayList<>();
        List<Map<String, Object>> sampleSetMaps = call.argument("sampleSets");
        if (sampleSetMaps != null) {
            for (Map<String, Object> sampleSetMap : sampleSetMaps) {
                sampleSets.add(Utils.toSampleSet(sampleSetMap, result, activity.getPackageName()));
            }
            flutterActivityRecordsImpl.addActivityRecord(this.activityRecordsController, activityRecord, sampleSets,
                new VoidResultHelper(result, context, call.method));
        } else {
            String errorCode = String.valueOf(HiHealthStatusCodes.INPUT_PARAM_MISSING);
            HMSLogger.getInstance(context).sendSingleEvent(call.method, errorCode);
            result.error(errorCode, "Please provide valid sample sets.", "");
        }
    }

    public void beginActivityRecord(final MethodCall call, final Result result) {
        checkActivityRecordsController();
        if (call.arguments == null) {
            result.error(String.valueOf(HiHealthStatusCodes.INPUT_PARAM_MISSING),
                "Please specify a valid activity record", "");
            return;
        }
        // Build an ActivityRecord object
        ActivityRecord activityRecord = ActivityRecordUtils.toActivityRecord((HashMap<String, Object>) call.arguments,
            activity.getPackageName());
        // Calling beginActivity.
        flutterActivityRecordsImpl.startActivityRecord(this.activityRecordsController, activityRecord,
            new VoidResultHelper(result, context, call.method));
    }

    public void continueActivityRecord(final MethodCall call, final Result result) {
        checkActivityRecordsController();
        final String activityRecordId = (String) call.arguments;
        flutterActivityRecordsImpl.continueActivityRecord(this.activityRecordsController, activityRecordId,
            new VoidResultHelper(result, context, call.method));
    }

    public void endActivityRecord(final MethodCall call, final Result result) {
        checkActivityRecordsController();
        String activityRecordId = (String) call.arguments;
        // Call the related method of ActivityRecordsController to stop activity records.
        // The input parameter can be the ID string of ActivityRecord or null
        // Stop an activity record of the current app by specifying the ID string as the input parameter
        // Stop activity records of the current app by specifying null as the input parameter
        // Return the list of activity records that have stopped
        flutterActivityRecordsImpl.endActivityRecord(this.activityRecordsController, activityRecordId,
            new ResultHelper<>(List.class, result, context, call.method));
    }

    private void getActivityRecord(final MethodCall call, final Result result) {
        checkActivityRecordsController();

        // Build the request body for reading activity records
        ActivityRecordReadOptions readRequest = ActivityRecordUtils.toActivityRecordReadOptions(call);

        // Get the requested ActivityRecords
        flutterActivityRecordsImpl.getActivityRecord(this.activityRecordsController, readRequest,
            new ResultHelper<>(ActivityRecordReply.class, result, context, call.method));
    }

    public void endAllActivityRecords(final MethodCall call, final Result result) {
        checkActivityRecordsController();
        flutterActivityRecordsImpl.endActivityRecord(this.activityRecordsController, null,
            new ResultHelper<>(List.class, result, context, call.method));
    }

    public void deleteActivityRecord(final MethodCall call, final Result result) {
        checkActivityRecordsController();
        Map<String, Object> reqMap = HealthRecordUtils.fromObject(call.arguments);
        if (reqMap.isEmpty()) {
            String errorCode = String.valueOf(HiHealthStatusCodes.INPUT_PARAM_MISSING);
            HMSLogger.getInstance(activity).sendSingleEvent(call.method, errorCode);
            result.error(errorCode, "Please provide valid parameters", null);
            return;
        }

        ActivityRecordDeleteOptions opt = ActivityRecordUtils.buildDeleteOptions(reqMap);
        flutterActivityRecordsImpl.deleteActivityRecord(this.activityRecordsController, opt,
            new VoidResultHelper(result, activity, call.method));
    }

    private void checkActivityRecordsController() {
        if (this.activityRecordsController == null && this.activity != null) {
            initActivityRecordsController();
        }
    }

    private void initActivityRecordsController() {
        if (activity == null) {
            return;
        }
        activityRecordsController = HuaweiHiHealth.getActivityRecordsController(activity);
    }
}
