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

package com.huawei.hms.flutter.health.modules.healthcontroller;

import android.util.Log;
import android.util.Pair;

import com.huawei.hms.flutter.health.foundation.utils.Utils;
import com.huawei.hms.flutter.health.modules.activityrecord.utils.ActivityRecordUtils;
import com.huawei.hms.hihealth.data.DataCollector;
import com.huawei.hms.hihealth.data.DataType;
import com.huawei.hms.hihealth.data.Field;
import com.huawei.hms.hihealth.data.HealthRecord;
import com.huawei.hms.hihealth.data.SamplePoint;
import com.huawei.hms.hihealth.data.SampleSet;
import com.huawei.hms.hihealth.data.Value;
import com.huawei.hms.hihealth.options.HealthRecordDeleteOptions;
import com.huawei.hms.hihealth.options.HealthRecordReadOptions;
import com.huawei.hms.hihealth.result.HealthRecordReply;

import io.flutter.plugin.common.MethodChannel;

import java.security.InvalidParameterException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

public final class HealthRecordUtils {
    private HealthRecordUtils() {
    }

    public static Integer toInteger(String key, Object value) {
        if (!(value instanceof Integer)) {
            Log.w("HealthRecordUtils", "toInteger | Integer value expected for " + key);
            return null;
        }
        return (Integer) value;
    }

    private static String toString(String key, Object value, boolean canBeEmpty) {
        if (!(value instanceof String) || ((String) value).isEmpty() && !canBeEmpty) {
            Log.w("HealthRecordUtils", "toString | Non-empty String expected for " + key);
            return null;
        }
        return (String) value;
    }

    public static <T> List<T> toTypeOfArrayList(Object obj, Class<T> clazz) {
        List<T> result = new ArrayList<>();
        if (obj instanceof List<?>) {
            for (Object o : (List<?>) obj) {
                result.add(clazz.cast(o));
            }
            return result;
        }
        return null;
    }

    public static Long toLong(String key, Object value) {
        if (value instanceof Long) {
            return (Long) value;
        } else if (value instanceof Integer) {
            return ((Integer) value).longValue();
        } else if (value instanceof Double) {
            return ((Double) value).longValue();
        } else if (value instanceof String) {
            return Long.parseLong((String) value);
        } else {
            Log.w("HealthRecordUtils", "toLong | Long value expected for " + key);
            return null;
        }
    }

    private static Number toNumber(Object value) {
        if (value instanceof Long) {
            return (Long) value;
        } else if (value instanceof Integer) {
            return (Integer) value;
        } else if (value instanceof Double) {
            return (Double) value;
        } else {
            Log.w("HealthRecordUtils", "toLong | Long value expected for " + "value");
            return null;
        }
    }

    public static Boolean toBoolean(String key, Object value) {
        if (!(value instanceof Boolean)) {
            Log.w("HealthRecordUtils",
                "toBoolean | Boolean value expected for " + key + ". Returning false as default.");
            return false;
        }
        return (Boolean) value;
    }

    public static Map<String, Object> fromObject(Object args) {
        Map<String, Object> resMap = new HashMap<>();
        if (args instanceof Map) {
            for (Object entry : ((Map) args).entrySet()) {
                if (entry instanceof Map.Entry) {
                    resMap.put(((Map.Entry) entry).getKey().toString(), ((Map.Entry) entry).getValue());
                }
            }
        }
        return resMap;
    }

    private static Pair<Field, Number> toFieldValuePair(Map<String, Object> map) {
        if (!map.isEmpty()) {
            final Map<String, Object> fieldMap = fromObject(map.get("field"));
            final Field field = Utils.toField(fieldMap);

            final Number value = toNumber(map.get("value"));

            return new Pair<>(field, value);
        }
        return null;
    }

    public static ArrayList<Map<String, Object>> toMapArrayList(String key, Object value) {
        ArrayList<Map<String, Object>> arrList = new ArrayList<>();
        if (value instanceof ArrayList) {
            Object[] objArr = ((ArrayList) value).toArray();
            for (Object o : objArr) {
                arrList.add(fromObject(o));
            }
        } else {
            Log.w("TAG", "toMapArrayList | List expected for " + key);
        }
        return arrList;
    }

    public static HealthRecordReadOptions createHRReadOptions(Map<String, Object> map) {
        HealthRecordReadOptions.Builder builder = new HealthRecordReadOptions.Builder();

        Map<String, Object> dataCollectorMap = fromObject(map.get("dataCollector"));
        String packageName = (String) map.get("packageName");

        if (!dataCollectorMap.isEmpty()) {
            DataCollector dataCollector = Utils.toDataCollector(dataCollectorMap, packageName);
            builder.readByDataCollector(dataCollector);
        }

        Map<String, Object> dataTypeMap = fromObject(map.get("dataType"));
        if (!dataTypeMap.isEmpty()) {
            DataType dataType = Utils.toDataType(dataTypeMap, packageName);
            builder.readByDataType(dataType);
        }

        Long startTime = toLong("startTime", map.get("startTime"));
        Long endTime = toLong("endTime", map.get("endTime"));
        String timeUnit = toString("timeUnit", map.get("timeUnit"), false);
        TimeUnit unit = Utils.toTimeUnit(timeUnit);

        if (startTime != null && endTime != null) {
            builder.setTimeInterval(startTime, endTime, unit);
        }

        Boolean readFromAllApps = (Boolean) map.get("readFromAllApps");
        if (readFromAllApps) {
            builder.readHealthRecordsFromAllApps();
        }

        String appToRemove = (String) map.get("appToRemove");
        if (appToRemove != null) {
            builder.removeApplication(appToRemove);
        }

        List<Map<String, Object>> dataTypesMap = toMapArrayList("subDataTypeList", map.get("subDataTypeList"));
        if (!dataTypesMap.isEmpty()) {
            List<DataType> dataTypes = Utils.toDataTypeList(dataTypesMap, packageName);
            builder.setSubDataTypeList(dataTypes);
        }

        return builder.build();
    }

    public static HealthRecordDeleteOptions createHRDeleteOptions(Map<String, Object> map, String packageName) {
        HealthRecordDeleteOptions.Builder builder = new HealthRecordDeleteOptions.Builder();

        Long startTime = toLong("startTime", map.get("startTime"));
        Long endTime = toLong("endTime", map.get("endTime"));
        String timeUnit = toString("timeUnit", map.get("timeUnit"), false);
        List<String> hrIDList = toTypeOfArrayList(map.get("hrIDs"), String.class);
        List<Map<String, Object>> subDataTypeList = toMapArrayList("subDataTypeList", map.get("subDataTypeList"));
        Map<String, Object> dataTypeMap = fromObject(map.get("dataType"));
        Boolean deleteSubData = toBoolean("deleteSubData", map.get("deleteSubData"));
        TimeUnit unit = Utils.toTimeUnit(timeUnit);

        if (startTime != null && endTime != null) {
            builder.setTimeInterval(startTime, endTime, unit);
        }
        if (hrIDList != null) {
            builder.setHealthRecordIds(hrIDList);
        }
        if (!subDataTypeList.isEmpty()) {
            List<DataType> types = Utils.toDataTypeList(subDataTypeList, packageName);
            builder.setSubDataTypeList(types);
        }
        if (!dataTypeMap.isEmpty()) {
            final DataType type = Utils.toDataType(dataTypeMap, packageName);
            builder.setDataType(type);
        }
        builder.isDeleteSubData(deleteSubData);
        return builder.build();
    }

    public static HealthRecord createHR(Map<String, Object> map, String packageName, MethodChannel.Result result)
        throws InvalidParameterException {
        Map<String, Object> dataCollectorMap = fromObject(map.get("dataCollector"));

        if (dataCollectorMap.isEmpty()) {
            throw new InvalidParameterException("Data collector must not be null");
        }
        Long startTime = toLong("startTime", map.get("startTime"));
        Long endTime = toLong("endTime", map.get("endTime"));
        String metadata = toString("metadata", map.get("metadata"), false);
        List<Map<String, Object>> samplePoints = toMapArrayList("subSummary", map.get("subSummary"));
        List<Map<String, Object>> sampleSets = toMapArrayList("subDetails", map.get("subDetails"));
        List<Map<String, Object>> fieldValueList = toMapArrayList("fields", map.get("fields"));
        List<Pair<Field, Number>> fieldPairs = new ArrayList<>();
        for (Map<String, Object> obj : fieldValueList) {
            fieldPairs.add(toFieldValuePair(obj));
        }
        DataCollector dataCollector = Utils.toDataCollector(dataCollectorMap, packageName);
        List<SamplePoint> points = buildSPList(samplePoints);
        List<SampleSet> sets = buildSSList(sampleSets);

        HealthRecord.Builder builder = new HealthRecord.Builder(dataCollector);
        for (Pair<Field, Number> pair : fieldPairs) {

            if (pair.second instanceof Integer) {
                builder.setFieldValue(pair.first, pair.second.intValue());
            } else if (pair.second instanceof Long) {
                builder.setFieldValue(pair.first, pair.second.longValue());
            } else if (pair.second instanceof Double) {
                builder.setFieldValue(pair.first, pair.second.doubleValue());
            } else {
                Log.i("test", "not supported");
            }
        }

        if (startTime != null) {
            builder.setStartTime(startTime, TimeUnit.MILLISECONDS);
        }
        if (endTime != null) {
            builder.setEndTime(endTime, TimeUnit.MILLISECONDS);
        }
        if (metadata != null) {
            builder.setMetadata(metadata);
        }
        builder.setDataCollector(dataCollector).setSubDataSummary(points).setSubDataDetails(sets);
        return builder.build();
    }

    public static Map<String, Object> hrReplyToMap(HealthRecordReply reply) {
        List<Map<String, Object>> repliesMap = new ArrayList<>();
        for (HealthRecord record : reply.getHealthRecords()) {
            repliesMap.add(hrToMap(record));
        }
        Map<String, Object> resMap = new HashMap<>();
        resMap.put("healthRecords", repliesMap);
        return resMap;
    }

    public static Map<String, Object> hrToMap(HealthRecord hr) {
        Map<String, Object> hrMap = new HashMap<>();
        List<Map<String, Object>> dataSumList = new ArrayList<>();
        List<Map<String, Object>> subDetailList = new ArrayList<>();

        hrMap.put("startTime", hr.getStartTime(TimeUnit.MILLISECONDS));
        hrMap.put("endTime", hr.getEndTime(TimeUnit.MILLISECONDS));
        hrMap.put("dataCollector", ActivityRecordUtils.dataCollectorToMap(hr.getDataCollector()));
        hrMap.put("fieldValues", ActivityRecordUtils.fieldValuesToMap(hr.getFieldValues()));
        hrMap.put("metadata", hr.getMetadata());

        for (SamplePoint point : hr.getSubDataSummary()) {
            Map<String, Object> pointMap = ActivityRecordUtils.samplePointToMap(point);
            dataSumList.add(pointMap);
        }
        hrMap.put("subDataSummary", dataSumList);
        for (SampleSet set : hr.getSubDataDetails()) {
            Map<String, Object> setMap = ActivityRecordUtils.sampleSetToMap(set);
            subDetailList.add(setMap);
        }
        hrMap.put("subDataDetails", subDetailList);
        hrMap.put("healthRecordId", hr.getHealthRecordId());
        return hrMap;
    }

    private static List<SamplePoint> buildSPList(List<Map<String, Object>> list) {
        List<SamplePoint> samplePoints = new ArrayList<>();
        if (!list.isEmpty()) {
            for (Map<String, Object> map : list) {
                SamplePoint point = buildSamplePoint(map);
                samplePoints.add(point);
            }
        }
        return samplePoints;
    }

    private static SamplePoint buildSamplePoint(Map<String, Object> map) {
        Map<String, Object> dcMap = fromObject(map.get("dataCollector"));
        Map<String, Object> dtMap = fromObject(map.get("dataType"));
        Map<String, Object> pairMap = fromObject(map.get("pairs"));
        String packageName = toString("packageName", dcMap.get("packageName"), false);

        Long startTime = toLong("startTime", map.get("startTime"));
        Long endTime = toLong("endTime", map.get("endTime"));
        Long samplingTime = toLong("samplingTime", map.get("samplingTime"));
        Boolean isSampling = toBoolean("isSampling", map.get("isSampling"));
        String timeUnitStr = toString("timeUnit", map.get("timeUnit"), false);
        TimeUnit timeUnit = Utils.toTimeUnit(timeUnitStr);

        Long id = toLong("id", map.get("id"));
        String metadata = toString("metadata", map.get("metadata"), false);

        List<Map<String, Object>> metadataValues = toMapArrayList("metadataValues", map.get("metadataValues"));

        SamplePoint.Builder builder;
        List<Field> fields;
        if (!dcMap.isEmpty()) {
            final DataCollector dataCollector = Utils.toDataCollector(dcMap, packageName);
            fields = dataCollector.getDataType().getFields();
            builder = new SamplePoint.Builder(dataCollector);
        } else {
            final DataType dataType = Utils.toDataType(dtMap, packageName);
            fields = dataType.getFields();
            builder = new SamplePoint.Builder(dataType);
        }

        if (startTime != null && endTime != null) {
            builder.setTimeInterval(startTime, endTime, timeUnit);
        }
        if (isSampling && samplingTime != null) {
            builder.setSamplingTime(samplingTime, timeUnit);
        }
        if (id != null) {
            builder.setId(id);
        }
        if (metadata != null) {
            builder.setMetadata(metadata);
        }
        SamplePoint samplePoint = builder.build();
        for (Field field : fields) {
            if (pairMap.containsKey(field.getName())) {
                setFieldValues(samplePoint, field, pairMap.get(field.getName()));
            }
        }
        if (!metadataValues.isEmpty()) {
            for (Map<String, Object> m : metadataValues) {
                String key = (String) m.get("key");
                String val = (String) m.get("value");
                samplePoint.addMetadata(key, val);
            }
        }
        return samplePoint;
    }

    private static List<SampleSet> buildSSList(List<Map<String, Object>> list) {
        List<SampleSet> sets = new ArrayList<>();
        if (!list.isEmpty()) {
            for (Map<String, Object> map : list) {
                SampleSet set = buildSampleSet(map);
                sets.add(set);
            }
        }
        return sets;
    }

    private static SampleSet buildSampleSet(Map<String, Object> map) {
        Map<String, Object> dcMap = fromObject(map.get("dataCollector"));
        if (dcMap.isEmpty()) {
            throw new InvalidParameterException("DataCollector must not be null");
        }

        String packageName = toString("packageName", dcMap.get("packageName"), false);
        List<Map<String, Object>> samplePointList = (List<Map<String, Object>>) map.get("samplePoints");

        DataCollector collector = Utils.toDataCollector(dcMap, packageName);
        SampleSet sampleSet = SampleSet.create(collector);

        for (Map<String, Object> rawSamplePoint : samplePointList) {
            SamplePoint samplePoint = buildSamplePoint(rawSamplePoint);
            sampleSet.addSample(samplePoint);
        }

        return sampleSet;
    }

    public static void setFieldValues(SamplePoint samplePoint, Field field, Object value) {
        Value val = samplePoint.getFieldValue(field);
        if (value instanceof Integer) {
            val.setIntValue((Integer) value);
        } else if (value instanceof Double) {
            val.setDoubleValue((Double) value);
        } else if (value instanceof Long) {
            val.setLongValue((Long) value);
        } else if (value instanceof String) {
            val.setStringValue((String) value);
        }
    }
}
