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

package com.huawei.hms.flutter.health.modules.datacontroller.utils;

import com.huawei.hms.flutter.health.foundation.constants.Constants;
import com.huawei.hms.flutter.health.foundation.utils.ExceptionHandler;
import com.huawei.hms.flutter.health.foundation.utils.Utils;
import com.huawei.hms.flutter.health.modules.activityrecord.utils.ActivityRecordUtils;
import com.huawei.hms.hihealth.HiHealthOptions;
import com.huawei.hms.hihealth.data.ActivityRecord;
import com.huawei.hms.hihealth.data.DataCollector;
import com.huawei.hms.hihealth.data.DataType;
import com.huawei.hms.hihealth.data.Group;
import com.huawei.hms.hihealth.data.SampleSet;
import com.huawei.hms.hihealth.options.DeleteOptions;
import com.huawei.hms.hihealth.options.ReadOptions;
import com.huawei.hms.hihealth.options.UpdateOptions;
import com.huawei.hms.hihealth.result.ReadReply;
import com.huawei.hms.support.api.client.Status;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

import java.security.InvalidParameterException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

public final class DataControllerUtils {
    private DataControllerUtils() {
    }

    /**
     * Converts Flutter MethodCall instance into {@link HiHealthOptions} instance.
     */
    public static synchronized HiHealthOptions toHiHealthOptions(final MethodCall methodCall,
        final String packageName) {
        HiHealthOptions.Builder hiHealthOptionsBuilder = HiHealthOptions.builder();
        if (methodCall.arguments instanceof ArrayList) {
            ArrayList<Map<String, Object>> requestOptions = (ArrayList<Map<String, Object>>) methodCall.arguments;
            for (Map<String, Object> option : requestOptions) {
                DataType requestedDataType = Utils.toDataType((Map<String, Object>) option.get("dataType"),
                    packageName);
                Integer accessType = (Integer) option.get("accessType");
                if (accessType != null) {
                    hiHealthOptionsBuilder.addDataType(requestedDataType, accessType);
                }
            }
        }
        return hiHealthOptionsBuilder.build();
    }

    /**
     * Converts Flutter MethodCall instance into {@link UpdateOptions} instance.
     */
    public static synchronized UpdateOptions toUpdateOptions(final MethodCall methodCall, final Result result,
        final String packageName) {
        try {
            long startTimeMillis = Utils.getLong(methodCall, "startTime");
            long endTimeMillis = Utils.getLong(methodCall, "endTime");
            TimeUnit timeUnit = Utils.toTimeUnit((String) methodCall.argument("timeUnit"));
            SampleSet sampleSet = Utils.toSampleSet(Utils.getMap(methodCall, "sampleSet"), result, packageName);
            return new UpdateOptions.Builder().setTimeInterval(startTimeMillis, endTimeMillis, timeUnit)
                .setSampleSet(sampleSet)
                .build();
        } catch (InvalidParameterException e) {
            ExceptionHandler.fail(e, result);
        }
        throw new InvalidParameterException("UpdateOptions parameters are empty or wrong.");
    }

    /**
     * Converts Flutter MethodCall instance into {@link ReadOptions} instance.
     */
    public static synchronized ReadOptions toReadOptions(final MethodCall methodCall, final Result result,
        final String packageName) {
        try {
            ReadOptions.Builder readOptionsBuilder = new ReadOptions.Builder();
            readOptionsBuilder = new HmsReadOptionsBuilder(readOptionsBuilder,
                (HashMap<String, Object>) methodCall.arguments, packageName).setTimeRange()
                .setPageSize()
                .maybeAllowRemoteInquiry()
                .maybePolymerize()
                .maybeGroupByTime()
                .read()
                .build();
            return readOptionsBuilder.build();

        } catch (InvalidParameterException e) {
            ExceptionHandler.fail(e, result);
        }
        return null;
    }

    /**
     * Converts Flutter MethodCall instance into {@link DeleteOptions} instance.
     */
    public static synchronized DeleteOptions toDeleteOptions(final MethodCall methodCall, final Result result,
        final String packageName) {
        try {
            DeleteOptions.Builder builder = new DeleteOptions.Builder();
            HashMap<String, Object> callMap = (HashMap<String, Object>) methodCall.arguments;
            if (callMap == null) {
                result.error(DataControllerConstants.DATA_CONTROLLER_MODULE, "DeleteOptions are null", "");
                return builder.build();
            }
            builder = new HMSDeleteOptionsBuilder(builder, callMap, packageName).setTimeInterval()
                .addDataTypes()
                .addDataCollectors()
                .addActivityRecords()
                .maybeDeleteAllActivityRecords()
                .maybeDeleteAllData()
                .build();
            return builder.build();
        } catch (InvalidParameterException e) {
            ExceptionHandler.fail(e, result);
        }
        return null;
    }

    public static synchronized Map<String, Object> readReplyToMap(final ReadReply readReply) {
        HashMap<String, Object> resultMap = new HashMap<>();
        ArrayList<Map<String, Object>> groupResults = new ArrayList<>();
        ArrayList<Map<String, Object>> sampleSetResults = new ArrayList<>();
        for (Group group : readReply.getGroups()) {
            groupResults.add(groupToMap(group));
        }
        for (SampleSet sampleSet : readReply.getSampleSets()) {
            sampleSetResults.add(ActivityRecordUtils.sampleSetToMap(sampleSet));
        }
        Status status = readReply.getStatus();
        resultMap.put("status", status.getStatusMessage());
        resultMap.put("groups", groupResults);
        resultMap.put("sampleSets", sampleSetResults);
        return resultMap;
    }

    public static synchronized Map<String, Object> groupToMap(final Group group) {
        HashMap<String, Object> resultMap = new HashMap<>();
        resultMap.put("startTime", group.getStartTime(TimeUnit.MILLISECONDS));
        resultMap.put("endTime", group.getEndTime(TimeUnit.MILLISECONDS));
        resultMap.put("activityRecord", ActivityRecordUtils.activityRecordToMap(group.getActivityRecord()));
        resultMap.put("activityType", group.getActivityType());
        resultMap.put("hasMoreSample", group.hasMoreSample());
        ArrayList<Map<String, Object>> sampleSets = new ArrayList<>();
        for (SampleSet sampleSet : group.getSampleSets()) {
            sampleSets.add(ActivityRecordUtils.sampleSetToMap(sampleSet));
        }
        resultMap.put("sampleSets", sampleSets);
        resultMap.put("groupType", group.getGroupType());
        return resultMap;
    }

    private static class HmsReadOptionsBuilder {
        private ReadOptions.Builder builder;

        private Map<String, Object> readOptionsMap;

        private String packageName;

        HmsReadOptionsBuilder(ReadOptions.Builder builder, final Map<String, Object> readOptionsMap,
            String packageName) {
            this.builder = builder;
            this.readOptionsMap = readOptionsMap;
            this.packageName = packageName;
        }

        HmsReadOptionsBuilder setPageSize() {
            if (Boolean.FALSE.equals(Utils.hasKey(readOptionsMap, "pageSize"))) {
                return this;
            }
            this.builder.setPageSize((int) readOptionsMap.get("pageSize"));
            return this;
        }

        HmsReadOptionsBuilder setTimeRange() {
            if (Boolean.FALSE.equals(Utils.hasKey(readOptionsMap, Constants.START_TIME_KEY) && Boolean.FALSE.equals(
                Utils.hasKey(readOptionsMap, Constants.END_TIME_KEY))) && Boolean.FALSE.equals(
                Utils.hasKey(readOptionsMap, Constants.TIME_UNIT_KEY))) {
                return this;
            }
            this.builder.setTimeRange((long) readOptionsMap.get(Constants.START_TIME_KEY),
                (long) readOptionsMap.get(Constants.END_TIME_KEY),
                Utils.toTimeUnit((String) readOptionsMap.get(Constants.TIME_UNIT_KEY)));
            return this;
        }

        HmsReadOptionsBuilder maybeAllowRemoteInquiry() {
            boolean allow = Utils.getBoolOrDefault(readOptionsMap, "allowRemoteInquiry");
            if (allow) {
                this.builder.allowRemoteInquiry();
            }
            return this;
        }

        HmsReadOptionsBuilder maybeGroupByTime() {
            HashMap<String, Object> groupByTime = (HashMap<String, Object>) readOptionsMap.get("groupByTime");
            if (groupByTime != null) {
                int duration = (int) groupByTime.get("duration");
                TimeUnit timeUnit = Utils.toTimeUnit((String) groupByTime.get("timeUnit"));
                this.builder.groupByTime(duration, timeUnit);
            }
            return this;
        }

        HmsReadOptionsBuilder maybePolymerize() {
            ArrayList<HashMap<String, Object>> polymerizedDataCollectors
                = (ArrayList<HashMap<String, Object>>) readOptionsMap.get("polymerizedDataCollectors");
            ArrayList<HashMap<String, Object>> polymerizedDataTypes
                = (ArrayList<HashMap<String, Object>>) readOptionsMap.get("polymerizedDataTypes");
            if (polymerizedDataCollectors != null && !polymerizedDataCollectors.isEmpty()) {
                for (HashMap<String, Object> map : polymerizedDataCollectors) {
                    DataCollector dataCollector = Utils.toDataCollector(
                        (HashMap<String, Object>) map.get("dataCollector"), packageName);
                    DataType outputDataType = Utils.toDataType((Map<String, Object>) map.get("outputDataType"),
                        packageName);
                    if (dataCollector != null) {
                        this.builder.polymerize(dataCollector, outputDataType);
                    }
                }
            }
            if (polymerizedDataTypes != null && !polymerizedDataTypes.isEmpty()) {
                for (HashMap<String, Object> map : polymerizedDataTypes) {
                    DataType inputDataType = Utils.toDataType((Map<String, Object>) map.get("inputDataType"),
                        packageName);
                    DataType outputDataType = Utils.toDataType((Map<String, Object>) map.get("outputDataType"),
                        packageName);
                    this.builder.polymerize(inputDataType, outputDataType);
                }
            }
            return this;
        }

        HmsReadOptionsBuilder read() {
            ArrayList<HashMap<String, Object>> dataCollectors = (ArrayList<HashMap<String, Object>>) readOptionsMap.get(
                DataControllerConstants.DATA_COLLECTORS_KEY);
            ArrayList<HashMap<String, Object>> dataTypes = (ArrayList<HashMap<String, Object>>) readOptionsMap.get(
                DataControllerConstants.DATA_TYPES_KEY);
            if (dataCollectors != null && !dataCollectors.isEmpty()) {
                for (HashMap<String, Object> map : dataCollectors) {
                    DataCollector dataCollector = Utils.toDataCollector(map, packageName);
                    if (dataCollector != null) {
                        this.builder.read(dataCollector);
                    }
                }
            }
            if (dataTypes != null && !dataTypes.isEmpty()) {
                for (HashMap<String, Object> map : dataTypes) {
                    DataType dataType = Utils.toDataType(map, packageName);
                    this.builder.read(dataType);
                }
            }
            return this;
        }

        ReadOptions.Builder build() {
            return builder;
        }
    }

    private static class HMSDeleteOptionsBuilder {
        private DeleteOptions.Builder builder;

        private Map<String, Object> deleteOptionsMap;

        private String packageName;

        HMSDeleteOptionsBuilder(DeleteOptions.Builder builder, final Map<String, Object> deleteOptionsMap,
            final String packageName) {
            this.builder = builder;
            this.deleteOptionsMap = deleteOptionsMap;
            this.packageName = packageName;
        }

        HMSDeleteOptionsBuilder setTimeInterval() {
            if (Boolean.TRUE.equals(Utils.hasKey(deleteOptionsMap, Constants.START_TIME_KEY)) && Boolean.TRUE.equals(
                Utils.hasKey(deleteOptionsMap, Constants.END_TIME_KEY))) {
                builder.setTimeInterval(Utils.getLong(deleteOptionsMap, Constants.START_TIME_KEY),
                    Utils.getLong(deleteOptionsMap, Constants.END_TIME_KEY),
                    Utils.toTimeUnit((String) deleteOptionsMap.get(Constants.TIME_UNIT_KEY)));
            }
            return this;
        }

        HMSDeleteOptionsBuilder addDataTypes() {
            if (Boolean.TRUE.equals(Utils.hasKey(deleteOptionsMap, DataControllerConstants.DATA_TYPES_KEY))) {
                ArrayList<Map<String, Object>> dataTypeMaps = (ArrayList<Map<String, Object>>) deleteOptionsMap.get(
                    "dataTypes");
                if (dataTypeMaps != null) {
                    for (Map<String, Object> dataTypeMap : dataTypeMaps) {
                        DataType dataType = Utils.toDataType(dataTypeMap, packageName);
                        builder.addDataType(dataType);
                    }
                }
            }
            return this;
        }

        HMSDeleteOptionsBuilder addDataCollectors() {
            if (Boolean.TRUE.equals(Utils.hasKey(deleteOptionsMap, DataControllerConstants.DATA_COLLECTORS_KEY))) {
                ArrayList<Map<String, Object>> dataCollectorMaps
                    = (ArrayList<Map<String, Object>>) deleteOptionsMap.get(
                    DataControllerConstants.DATA_COLLECTORS_KEY);
                if (dataCollectorMaps != null) {
                    for (Map<String, Object> dataCollectorMap : dataCollectorMaps) {
                        DataCollector dataCollector = Utils.toDataCollector(dataCollectorMap, packageName);
                        builder.addDataCollector(dataCollector);
                    }
                }
            }
            return this;
        }

        HMSDeleteOptionsBuilder addActivityRecords() {
            if (Boolean.TRUE.equals(Utils.hasKey(deleteOptionsMap, "activityRecords"))) {
                ArrayList<Map<String, Object>> activityRecordMaps
                    = (ArrayList<Map<String, Object>>) deleteOptionsMap.get("activityRecords");
                if (activityRecordMaps != null) {
                    for (Map<String, Object> activityRecordMap : activityRecordMaps) {
                        ActivityRecord activityRecord = ActivityRecordUtils.toActivityRecord(activityRecordMap,
                            packageName);
                        builder.addActivityRecord(activityRecord);
                    }
                }
            }
            return this;
        }

        HMSDeleteOptionsBuilder maybeDeleteAllActivityRecords() {
            if (Boolean.TRUE.equals(Utils.hasKey(deleteOptionsMap, "deleteAllActivityRecords")) && Boolean.TRUE.equals(
                deleteOptionsMap.get("deleteAllActivityRecords"))) {
                builder.deleteAllActivityRecords();
            }
            return this;
        }

        HMSDeleteOptionsBuilder maybeDeleteAllData() {
            if (Boolean.TRUE.equals(Utils.hasKey(deleteOptionsMap, "deleteAllData")) && Boolean.TRUE.equals(
                deleteOptionsMap.get("deleteAllData"))) {
                builder.deleteAllData();
            }
            return this;
        }

        DeleteOptions.Builder build() {
            return builder;
        }
    }
}
