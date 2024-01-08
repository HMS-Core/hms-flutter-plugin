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
import static com.huawei.hms.flutter.health.foundation.utils.MapUtils.toResultMapWithMessage;

import android.content.Context;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.health.foundation.listener.ResultListener;
import com.huawei.hms.flutter.health.foundation.logger.HMSLogger;
import com.huawei.hms.flutter.health.foundation.utils.ExceptionHandler;
import com.huawei.hms.flutter.health.foundation.utils.Utils;
import com.huawei.hms.flutter.health.modules.activityrecord.utils.ActivityRecordUtils;
import com.huawei.hms.flutter.health.modules.datacontroller.utils.DataControllerUtils;
import com.huawei.hms.hihealth.data.ActivityRecord;
import com.huawei.hms.hihealth.data.DataType;
import com.huawei.hms.hihealth.data.SampleSet;
import com.huawei.hms.hihealth.data.ScopeLangItem;
import com.huawei.hms.hihealth.result.ActivityRecordReply;
import com.huawei.hms.hihealth.result.ReadReply;

import io.flutter.plugin.common.MethodChannel.Result;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public final class ResultHelper<T> implements ResultListener<T> {
    // Internal Flutter Result instance that will be initialized during construction.
    private Result result;

    // Internal Class type instance that will be initialized during construction.
    private Class<T> type;

    // Application Context
    private Context context;

    // The method name which has initiated this listener.
    private String methodName;

    public ResultHelper(Class<T> classType, final @NonNull Result result, Context context, final String methodName) {
        this.type = classType;
        this.result = result;
        this.context = context;
        this.methodName = methodName;
    }

    /**
     * Looks for class type, then Returns success result via Flutter Result instance.
     *
     * @param healthResult Health Result instance.
     */
    @Override
    public void onSuccess(T healthResult) {
        HMSLogger.getInstance(context).sendSingleEvent(methodName);
        if (type.equals(String.class)) {
            this.result.success(toResultMapWithMessage((String) healthResult, true));
        } else if (type.equals(ActivityRecordReply.class)) {
            ArrayList<Map<String, Object>> resultList = new ArrayList<>(
                ActivityRecordUtils.activityRecordReplyToMap((ActivityRecordReply) healthResult));
            this.result.success(resultList);
        } else if (type.equals(List.class) && methodName.equals("readTodaySummationList") || methodName.equals("readDailySummationList") ) {
            List<SampleSet> sampleSets = (List<SampleSet>) healthResult;
            List<Map<String, Object>> resultArray = new ArrayList<>(
                    ActivityRecordUtils.listSampleSetToMap(sampleSets));
            this.result.success(resultArray);
        } else if (type.equals(List.class)) {
            List<ActivityRecord> activityRecords = (List<ActivityRecord>) healthResult;
            ArrayList<Map<String, Object>> resultArray = new ArrayList<>(
                ActivityRecordUtils.listActivityRecordToMap(activityRecords));
            this.result.success(resultArray);
        } else if (type.equals(SampleSet.class)) {
            HashMap<String, Object> resultMap = new HashMap<>(
                ActivityRecordUtils.sampleSetToMap((SampleSet) healthResult));
            this.result.success(resultMap);
        } else if (type.equals(ReadReply.class)) {
            this.result.success(DataControllerUtils.readReplyToMap((ReadReply) healthResult));
        } else if (type.equals(DataType.class)) {
            this.result.success(ActivityRecordUtils.dataTypeToMap((DataType) healthResult));
        } else if (type.equals(ScopeLangItem.class)) {
            this.result.success(ActivityRecordUtils.scopeLangItemToMap((ScopeLangItem) healthResult));
        } else if (type.equals(Boolean.class)) {
            this.result.success(Boolean.TRUE.equals(healthResult));
        } else {
            this.result.success(toResultMap("Success", true));
        }
    }

    /**
     * Returns exception via MethodChannel.Result instance.
     *
     * @param exception Exception instance.
     */
    @Override
    public void onFail(Exception exception) {
        String errorCode = Utils.getErrorCode(exception);
        HMSLogger.getInstance(context).sendSingleEvent(methodName, errorCode);
        ExceptionHandler.fail(exception, result);
    }
}
