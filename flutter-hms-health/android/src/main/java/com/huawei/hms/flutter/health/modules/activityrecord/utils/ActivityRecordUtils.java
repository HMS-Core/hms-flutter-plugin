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

package com.huawei.hms.flutter.health.modules.activityrecord.utils;

import static com.huawei.hms.flutter.health.foundation.constants.Constants.ACTIVITY_TYPE_KEY;
import static com.huawei.hms.flutter.health.foundation.constants.Constants.DESCRIPTION_KEY;
import static com.huawei.hms.flutter.health.foundation.constants.Constants.ID_KEY;
import static com.huawei.hms.flutter.health.foundation.constants.Constants.NAME_KEY;
import static com.huawei.hms.flutter.health.modules.activityrecord.utils.ActivityRecordsConstants.ACTIVITY_SUMMARY_KEY;
import static com.huawei.hms.flutter.health.modules.activityrecord.utils.ActivityRecordsConstants.PACKAGE_NAME;

import androidx.annotation.Nullable;

import com.huawei.hms.flutter.health.foundation.constants.Constants;
import com.huawei.hms.flutter.health.foundation.utils.Utils;
import com.huawei.hms.flutter.health.modules.healthcontroller.HealthRecordUtils;
import com.huawei.hms.hihealth.data.ActivityRecord;
import com.huawei.hms.hihealth.data.ActivitySummary;
import com.huawei.hms.hihealth.data.DataCollector;
import com.huawei.hms.hihealth.data.DataType;
import com.huawei.hms.hihealth.data.DeviceInfo;
import com.huawei.hms.hihealth.data.Field;
import com.huawei.hms.hihealth.data.MapValue;
import com.huawei.hms.hihealth.data.PaceSummary;
import com.huawei.hms.hihealth.data.SamplePoint;
import com.huawei.hms.hihealth.data.SampleSection;
import com.huawei.hms.hihealth.data.SampleSet;
import com.huawei.hms.hihealth.data.ScopeLangItem;
import com.huawei.hms.hihealth.data.Value;
import com.huawei.hms.hihealth.options.ActivityRecordDeleteOptions;
import com.huawei.hms.hihealth.options.ActivityRecordReadOptions;
import com.huawei.hms.hihealth.result.ActivityRecordReply;

import io.flutter.plugin.common.MethodCall;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.TimeUnit;

public final class ActivityRecordUtils {
    /**
     * Looks for each key and converts Flutter callMap instance into {@link ActivityRecord} instance.
     *
     * @param callMap HashMap instance from Flutter call that will be converted.
     * @return {@link ActivityRecord} instance.
     */
    public static synchronized ActivityRecord toActivityRecord(final Map<String, Object> callMap, String packageName) {
        // Build an ActivityRecord object
        ActivityRecord.Builder builder = new ActivityRecord.Builder();
        if (callMap.get(ID_KEY) != null) {
            builder.setId((String) callMap.get(ID_KEY));
        }
        builder.setName(Utils.createEmptyStringIfNull(callMap, NAME_KEY));
        builder.setDesc(Utils.createEmptyStringIfNull(callMap, DESCRIPTION_KEY));
        builder.setActivityTypeId((String) callMap.get(ACTIVITY_TYPE_KEY));
        if (Boolean.TRUE.equals(Utils.hasKey(callMap, ACTIVITY_SUMMARY_KEY))) {
            builder.setActivitySummary(
                Utils.toActivitySummary((HashMap<String, Object>) callMap.get(ACTIVITY_SUMMARY_KEY), packageName));
        }
        setBuilderTime(builder, callMap, Constants.TimeConstants.START);
        setBuilderTime(builder, callMap, Constants.TimeConstants.END);
        setBuilderTime(builder, callMap, Constants.TimeConstants.DURATION);

        return builder.build();
    }

    /**
     * Sets {@link ActivityRecord.Builder} Time
     */
    private static synchronized void setBuilderTime(ActivityRecord.Builder builder, final Map<String, Object> map,
        final Constants.TimeConstants time) {
        switch (time) {
            case START:
                if (map.get("startTimeMillis") != null) {
                    long startMillis = (long) map.get("startTimeMillis");
                    builder.setStartTime(startMillis, Utils.toTimeUnit(map));
                }
                break;
            case END:
                if (map.get("endTimeMillis") != null) {
                    long endMillis = (long) map.get("endTimeMillis");
                    builder.setEndTime(endMillis, Utils.toTimeUnit(map));
                }
                break;
            case DURATION:
                if (map.get("activeTimeMillis") != null) {
                    long dur = (long) map.get("activeTimeMillis");
                    builder.setDurationTime(dur, Utils.toTimeUnit(map));
                }
                break;
        }
    }

    /* Private Methods */

    /**
     * Converts into {@link ActivityRecordReadOptions} instance.
     */
    public static synchronized ActivityRecordReadOptions toActivityRecordReadOptions(final MethodCall call) {
        String activityRecordId = call.argument("activityRecordId");
        String activityRecordName = call.argument("activityRecordName");
        ActivityRecordReadOptions.Builder builder = new ActivityRecordReadOptions.Builder();
        long startTime = Utils.getLong(call, Constants.START_TIME_KEY);
        long endTime = Utils.getLong(call, Constants.END_TIME_KEY);
        builder.setTimeInterval(startTime, endTime, Utils.toTimeUnit((String) call.argument(Constants.TIME_UNIT_KEY)));

        setBuilderRecord(builder, activityRecordId, RecordTypes.ID);
        setBuilderRecord(builder, activityRecordName, RecordTypes.NAME);
        return builder.build();
    }

    /**
     * Sets {@link ActivityRecordReadOptions.Builder} Records
     */
    private static synchronized void setBuilderRecord(final ActivityRecordReadOptions.Builder builder,
        final @Nullable String recordVal, final RecordTypes types) {
        if (recordVal == null) {
            return;
        }
        if (types == RecordTypes.ID) {
            builder.setActivityRecordId(recordVal);
        } else if (types == RecordTypes.NAME) {
            builder.setActivityRecordName(recordVal);
        }
    }

    public static synchronized List<Map<String, Object>> activityRecordReplyToMap(
        final ActivityRecordReply recordReply) {
        ArrayList<Map<String, Object>> resultList = new ArrayList<>();
        for (ActivityRecord record : recordReply.getActivityRecords()) {
            HashMap<String, Object> resultMap = new HashMap<>();
            resultMap.put("activityRecord", activityRecordToMap(record));
            resultList.add(resultMap);
        }
        return resultList;
    }

    public static synchronized Map<String, Object> activityRecordToMap(final ActivityRecord activityRecord) {
        Map<String, Object> map = new HashMap<>();
        if (activityRecord != null) {
            map.put("activityType", activityRecord.getActivityType());
            map.put("appDetailsUrl",
                activityRecord.getAppDetailsUrl() != null ? activityRecord.getAppDetailsUrl() : "");
            map.put("appDomainName",
                activityRecord.getAppDomainName() != null ? activityRecord.getAppDomainName() : "");
            map.put("appVersion", activityRecord.getAppVersion() != null ? activityRecord.getAppVersion() : "");
            map.put("description", activityRecord.getDesc());
            map.put("id", activityRecord.getId());
            map.put("startTime", activityRecord.getStartTime(TimeUnit.MILLISECONDS));
            map.put("endTime", activityRecord.getEndTime(TimeUnit.MILLISECONDS));
            map.put("durationTime", activityRecord.getDurationTime(TimeUnit.MILLISECONDS));
            map.put("name", activityRecord.getName() != null ? activityRecord.getName() : "");
            map.put(PACKAGE_NAME, activityRecord.getPackageName() != null ? activityRecord.getPackageName() : "");
            map.put("hasDurationTime", activityRecord.hasDurationTime());
            map.put("isKeepGoing", activityRecord.isKeepGoing());
            map.put("timeZone", activityRecord.getTimeZone());
            map.put("activitySummary", activitySummaryToMap(activityRecord.getActivitySummary()));
            map.put("deviceInfo", deviceInfoToMap(activityRecord.getDeviceInfo()));
        }
        return map;
    }

    public static synchronized Map<String, Object> activitySummaryToMap(final ActivitySummary activitySummary) {
        final HashMap<String, Object> map = new HashMap<>();
        if (activitySummary != null) {
            map.put("paceSummary", paceSummaryToMap(activitySummary.getPaceSummary()));

            final ArrayList<Map<String, Object>> dataSummary = new ArrayList<>();
            for (SamplePoint point : activitySummary.getDataSummary()) {
                dataSummary.add(samplePointToMap(point));
            }
            map.put("dataSummary", dataSummary);

            final ArrayList<Map<String, Object>> sectionSummary = new ArrayList<>();
            for (SampleSection section : activitySummary.getSectionSummary()) {
                sectionSummary.add(sampleSectionToMap(section));
            }
            map.put("sectionSummary", sectionSummary);
        }
        return map;
    }

    public static synchronized Map<String, Object> paceSummaryToMap(final PaceSummary paceSummary) {
        HashMap<String, Object> map = new HashMap<>();
        if (paceSummary != null) {
            map.put("avgPace", paceSummary.getAvgPace() != null ? paceSummary.getAvgPace() : 0);
            map.put("bestPace", paceSummary.getBestPace() != null ? paceSummary.getBestPace() : 0);
            map.put("paceMap", paceSummary.getPaceMap());
            map.put("britishPaceMap", paceSummary.getBritishPaceMap());
            map.put("partTimeMap", paceSummary.getPartTimeMap());
            map.put("britishPartTimeMap", paceSummary.getBritishPartTimeMap());
            map.put("sportHealthPaceMap", paceSummary.getSportHealthPaceMap());
        }
        return map;
    }

    public static synchronized Map<String, Object> samplePointToMap(final SamplePoint samplePoint) {
        HashMap<String, Object> map = new HashMap<>();
        if (samplePoint != null) {
            map.put("fieldValues", fieldValuesToMap(samplePoint.getFieldValues()));
            map.put("startTime", samplePoint.getStartTime(TimeUnit.MILLISECONDS));
            map.put("endTime", samplePoint.getEndTime(TimeUnit.MILLISECONDS));
            map.put("samplingTime", samplePoint.getSamplingTime(TimeUnit.MILLISECONDS));
            map.put("dataCollector", dataCollectorToMap(samplePoint.getDataCollector()));
            map.put("dataTypeId", samplePoint.getDataTypeId());
            map.put("dataType", dataTypeToMap(samplePoint.getDataType()));
            map.put("insertionTime", (samplePoint.getInsertionTime(TimeUnit.MILLISECONDS)));
            map.put("id", (int) samplePoint.getId());
        }
        return map;
    }

    public static synchronized Map<String, Object> sampleSectionToMap(final SampleSection sampleSection) {
        final HashMap<String, Object> map = new HashMap<>();
        if (sampleSection != null) {
            map.put("sectionNum", sampleSection.getSectionNum());
            map.put("sectionTime", sampleSection.getSectionTime(TimeUnit.MILLISECONDS));
            map.put("startTime", sampleSection.getStartTime(TimeUnit.MILLISECONDS));
            map.put("endTime", sampleSection.getEndTime(TimeUnit.MILLISECONDS));
            final List<Map<String, Object>> sectionDataList = new ArrayList<>();
            for (SamplePoint sp : sampleSection.getSectionDataList()) {
                sectionDataList.add(samplePointToMap(sp));
            }
            map.put("sectionDataList", sectionDataList);
        }
        return map;
    }

    public static synchronized Map<String, Object> fieldValuesToMap(Map<String, Value> fieldValue) {
        HashMap<String, Object> resultMap = new HashMap<>();
        for (Entry<String, Value> pair : fieldValue.entrySet()) {
            Value value = pair.getValue();
            switch (value.getFormat()) {
                case Field.FORMAT_INT32:
                    resultMap.put(pair.getKey(), value.asIntValue());
                    break;
                case Field.FORMAT_FLOAT:
                    resultMap.put(pair.getKey(), value.asDoubleValue());
                    break;
                case Field.FORMAT_STRING:
                    resultMap.put(pair.getKey(), value.asStringValue());
                    break;
                case Field.FORMAT_MAP:
                    HashMap<String, MapValue> floatMap = new HashMap<>();
                    for (String key : value.getMap().keySet()) {
                        floatMap.put(key, value.getMapValue(key));
                    }
                    resultMap.put(pair.getKey(), floatMap);
                    break;
                case Field.FORMAT_LONG:
                    resultMap.put(pair.getKey(), (int) (value).asLongValue());
                    break;
                default:
                    throw new IllegalStateException("Unexpected value: " + value.getFormat());
            }
        }
        return resultMap;
    }

    public static synchronized Map<String, Object> dataCollectorToMap(final DataCollector dataCollector) {
        HashMap<String, Object> map = new HashMap<>();
        if (dataCollector != null) {
            map.put("dataCollectorName", dataCollector.getDataCollectorName());
            map.put(PACKAGE_NAME, dataCollector.getPackageName());
            map.put("dataStreamId", dataCollector.getDataStreamId());
            map.put("dataStreamName", dataCollector.getDataStreamName());
            map.put("dataGenerateType", dataCollector.getDataGenerateType());
            map.put("deviceId", dataCollector.getDeviceId());
            map.put("dataType", dataTypeToMap(dataCollector.getDataType()));
            map.put("deviceInfo", deviceInfoToMap(dataCollector.getDeviceInfo()));
            map.put("isLocalized", dataCollector.isLocalized());
        }
        return map;
    }

    public static synchronized Map<String, Object> dataTypeToMap(final DataType dataType) {
        HashMap<String, Object> map = new HashMap<>();
        if (dataType != null) {
            map.put("name", dataType.getName());
            map.put(PACKAGE_NAME, dataType.getPackageName());
            ArrayList<Map<String, Object>> fieldsArray = new ArrayList<>();
            for (Field field : dataType.getFields()) {
                fieldsArray.add(fieldToMap(field));
            }
            map.put("fields", fieldsArray);
        }
        return map;
    }

    public static synchronized Map<String, Object> fieldToMap(final Field field) {
        HashMap<String, Object> map = new HashMap<>();
        if (field != null) {
            map.put("name", field.getName());
            map.put("format", field.getFormat());
            map.put("isOptional", field.isOptional());
        }
        return map;
    }

    public static synchronized Map<String, Object> deviceInfoToMap(final DeviceInfo deviceInfo) {
        HashMap<String, Object> map = new HashMap<>();
        if (deviceInfo != null) {
            map.put("deviceIdentifier", deviceInfo.getDeviceIdentifier());
            map.put("deviceType", deviceInfo.getDeviceType());
            map.put("manufacturer", deviceInfo.getManufacturer());
            map.put("modelName", deviceInfo.getModelName());
            map.put("platformType", deviceInfo.getPlatformType());
            map.put("uuid", deviceInfo.getUuid());
            map.put("isFromBleDevice", deviceInfo.isFromBleDevice());
        }
        return map;
    }

    public static synchronized List<Map<String, Object>> listActivityRecordToMap(
        final List<ActivityRecord> activityRecords) {
        ArrayList<Map<String, Object>> resultList = new ArrayList<>();
        for (ActivityRecord record : activityRecords) {
            resultList.add(activityRecordToMap(record));
        }
        return resultList;
    }

    public static synchronized List<Map<String, Object>> listSampleSetToMap(
            final List<SampleSet> sampleSets) {
        ArrayList<Map<String, Object>> resultList = new ArrayList<>();
        for (SampleSet sampleSet : sampleSets) {
            resultList.add(sampleSetToMap(sampleSet));
        }
        return resultList;
    }

    public static synchronized Map<String, Object> sampleSetToMap(final SampleSet sampleSet) {
        HashMap<String, Object> resultMap = new HashMap<>();
        resultMap.put("dataCollector", dataCollectorToMap(sampleSet.getDataCollector()));
        List<SamplePoint> samplePoints = sampleSet.getSamplePoints();
        ArrayList<HashMap<String, Object>> resultList = new ArrayList<>();
        for (SamplePoint samplePoint : samplePoints) {
            resultList.add(new HashMap<>(samplePointToMap(samplePoint)));
        }
        resultMap.put("samplePoints", resultList);
        return resultMap;
    }

    public static synchronized Map<String, Object> scopeLangItemToMap(final ScopeLangItem scopeLangItem) {
        HashMap<String, Object> resultMap = new HashMap<>();
        if (scopeLangItem != null){
        resultMap.put("appName", scopeLangItem.getAppName());
        resultMap.put("appIconPath", scopeLangItem.getAppIconPath());
        resultMap.put("authTime", scopeLangItem.getAuthTime());
        resultMap.put("url2Desc", scopeLangItem.getUrl2Desc());
        }
        return resultMap;
    }

    public static ActivityRecordDeleteOptions buildDeleteOptions(Map<String, Object> map) {
        ActivityRecordDeleteOptions.Builder builder = new ActivityRecordDeleteOptions.Builder();
        List<DataType> types = new ArrayList<>();
        String packageName = (String) map.get("packageName");
        Long startTime = HealthRecordUtils.toLong("startTime", map.get("startTime"));
        Long endTime = HealthRecordUtils.toLong("endTime", map.get("endTime"));
        String timeUnit = (String) map.get("timeUnit");
        List<String> activityRecordIDs = HealthRecordUtils.toTypeOfArrayList(map.get("activityRecordIDs"),
            String.class);
        List<Map<String, Object>> subDataTypeList = HealthRecordUtils.toMapArrayList("subDataTypes",
            map.get("subDataTypes"));
        Boolean deleteSubData = HealthRecordUtils.toBoolean("deleteSubData", map.get("deleteSubData"));

        TimeUnit unit = Utils.toTimeUnit(timeUnit);

        if (startTime != null && endTime != null) {
            builder.setTimeInterval(startTime, endTime, unit);
        }
        if (activityRecordIDs != null) {
            builder.setActivityRecordIds(activityRecordIDs);
        }
        if (!subDataTypeList.isEmpty()) {
            for (Map<String, Object> m : subDataTypeList) {
                final DataType dataType = Utils.toDataType(m, packageName);
                types.add(dataType);
            }
            builder.setSubDataTypeList(types);
        }
        builder.isDeleteSubData(deleteSubData);
        return builder.build();
    }

    enum RecordTypes {
        ID,
        NAME
    }
}
