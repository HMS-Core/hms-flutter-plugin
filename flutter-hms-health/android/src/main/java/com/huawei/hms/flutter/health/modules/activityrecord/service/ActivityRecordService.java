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

import com.huawei.hms.flutter.health.foundation.listener.ResultListener;
import com.huawei.hms.flutter.health.foundation.listener.VoidResultListener;
import com.huawei.hms.hihealth.data.ActivityRecord;
import com.huawei.hms.hihealth.data.SampleSet;
import com.huawei.hms.hihealth.options.ActivityRecordDeleteOptions;
import com.huawei.hms.hihealth.options.ActivityRecordReadOptions;
import com.huawei.hms.hihealth.result.ActivityRecordReply;

import java.util.List;

public interface ActivityRecordService {
    void startActivityRecord(final com.huawei.hms.hihealth.ActivityRecordsController activityRecordsController,
        final ActivityRecord activityRecord, final VoidResultListener listener);

    void continueActivityRecord(final com.huawei.hms.hihealth.ActivityRecordsController activityRecordsController,
        final String activityRecordId, final VoidResultListener listener);

    void endActivityRecord(final com.huawei.hms.hihealth.ActivityRecordsController activityRecordsController,
        final @Nullable String activityRecordId, final ResultListener<List> listener);

    void addActivityRecord(final com.huawei.hms.hihealth.ActivityRecordsController activityRecordsController,
        final ActivityRecord activityRecord, final List<SampleSet> sampleSet, final VoidResultListener listener);

    void getActivityRecord(final com.huawei.hms.hihealth.ActivityRecordsController activityRecordsController,
        final ActivityRecordReadOptions readRequest, final ResultListener<ActivityRecordReply> listener);

    void deleteActivityRecord(final com.huawei.hms.hihealth.ActivityRecordsController activityRecordsController,
        final ActivityRecordDeleteOptions deleteOptions, final VoidResultListener listener);
}
