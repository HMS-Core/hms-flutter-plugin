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

package com.huawei.hms.flutter.health.modules.activityrecord.service;

import androidx.annotation.Nullable;

import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.health.foundation.listener.ResultListener;
import com.huawei.hms.flutter.health.foundation.listener.VoidResultListener;
import com.huawei.hms.flutter.health.modules.activityrecord.utils.ActivityRecordsConstants;
import com.huawei.hms.hihealth.ActivityRecordsController;
import com.huawei.hms.hihealth.data.ActivityRecord;
import com.huawei.hms.hihealth.data.SampleSet;
import com.huawei.hms.hihealth.options.ActivityRecordDeleteOptions;
import com.huawei.hms.hihealth.options.ActivityRecordInsertOptions;
import com.huawei.hms.hihealth.options.ActivityRecordInsertOptions.Builder;
import com.huawei.hms.hihealth.options.ActivityRecordReadOptions;
import com.huawei.hms.hihealth.result.ActivityRecordReply;

import io.flutter.Log;

import java.util.List;

public class DefaultActivityRecordService implements ActivityRecordService {
    private static final String TAG = ActivityRecordsConstants.ACTIVITY_RECORDS_MODULE;

    @Override
    public void startActivityRecord(ActivityRecordsController activityRecordsController, ActivityRecord activityRecord,
        VoidResultListener listener) {
        Log.i(TAG, "call startActivityRecord");

        Task<Void> beginTask = activityRecordsController.beginActivityRecord(activityRecord);
        // Add a listener for the ActivityRecord start success
        beginTask.addOnSuccessListener(voidValue -> {
            Log.i(TAG, "startActivityRecord success");
            listener.onSuccess(voidValue);
            // Add a listener for the ActivityRecord start failure
        }).addOnFailureListener(error -> {
            Log.i(TAG, "startActivityRecord error");
            listener.onFail(error);
        });
    }

    @Override
    public void continueActivityRecord(ActivityRecordsController activityRecordsController, String activityRecordId,
        VoidResultListener listener) {
        Log.i(TAG, "call continueActivityRecord");
        final Task<Void> task = activityRecordsController.continueActivityRecord(activityRecordId);
        task.addOnSuccessListener(voidValue -> {
            Log.i(TAG, "continueActivityRecord success");
            listener.onSuccess(voidValue);
        }).addOnFailureListener(error -> {
            Log.i(TAG, "continueActivityRecord error");
            listener.onFail(error);
        });
    }

    @Override
    public void endActivityRecord(ActivityRecordsController activityRecordsController,
        @Nullable String activityRecordId, ResultListener<List> listener) {
        Log.i(TAG, "call endActivityRecord");
        // Call the related method of ActivityRecordsController to stop activity records.
        // The input parameter can be the ID string of ActivityRecord or null
        // Stop an activity record of the current app by specifying the ID string as the input parameter
        // Stop activity records of the current app by specifying null as the input parameter
        Task<List<ActivityRecord>> endTask = activityRecordsController.endActivityRecord(activityRecordId);
        endTask.addOnSuccessListener(activityRecords -> {
            // Return the list of activity records that have stopped
            Log.i(TAG, "endActivityRecord success");
            // Return the list of activity records that have stopped
            listener.onSuccess(activityRecords);
        }).addOnFailureListener(error -> {
            Log.i(TAG, "endActivityRecord error");
            listener.onFail(error);
        });
    }

    @Override
    public void addActivityRecord(com.huawei.hms.hihealth.ActivityRecordsController activityRecordsController,
        ActivityRecord activityRecord, List<SampleSet> sampleSets, VoidResultListener listener) {
        Log.i(TAG, "call addActivityRecord");
        // Build the activity record insert request object
        ActivityRecordInsertOptions.Builder insertOptionsBuilder = new Builder();
        insertOptionsBuilder.setActivityRecord(activityRecord);
        for (SampleSet sampleSet : sampleSets) {
            insertOptionsBuilder.addSampleSet(sampleSet);
        }
        // Call the related method in the ActivityRecordsController to add activity records
        Task<Void> addTask = activityRecordsController.addActivityRecord(insertOptionsBuilder.build());
        addTask.addOnSuccessListener(voidValue -> {
            Log.i(TAG, "addActivityRecord success");
            listener.onSuccess(voidValue);
        }).addOnFailureListener(error -> {
            Log.i(TAG, "addActivityRecord error");
            listener.onFail(error);
        });
    }

    @Override
    public void getActivityRecord(ActivityRecordsController activityRecordsController,
        ActivityRecordReadOptions readRequest, ResultListener<ActivityRecordReply> listener) {
        // Call the read method of the ActivityRecordsController to obtain activity records
        Log.i(TAG, "call getActivityRecord");
        // from the Health platform based on the conditions in the request body
        Task<ActivityRecordReply> getTask = activityRecordsController.getActivityRecord(readRequest);
        getTask.addOnSuccessListener(activityRecordReply -> {
            Log.i("ActivityRecords", "getActivityRecord success");
            listener.onSuccess(activityRecordReply);
        }).addOnFailureListener(error -> {
            Log.i("ActivityRecords", "getActivityRecord error");
            listener.onFail(error);
        });
    }

    @Override
    public void deleteActivityRecord(ActivityRecordsController activityRecordsController,
        ActivityRecordDeleteOptions deleteOptions, VoidResultListener listener) {
        Task<Void> deleteTask = activityRecordsController.deleteActivityRecord(deleteOptions);
        deleteTask.addOnSuccessListener(aVoid -> {
            Log.i("ActivityRecords", "deleteActivityRecord success");
            listener.onSuccess(aVoid);
        }).addOnFailureListener(e -> {
            Log.i("ActivityRecords", "deleteActivityRecord error");
            listener.onFail(e);
        });
    }
}
