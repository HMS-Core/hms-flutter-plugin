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

package com.huawei.hms.flutter.health.foundation.utils;

import static com.huawei.hms.flutter.health.foundation.constants.Constants.BASE_MODULE_NAME;
import static com.huawei.hms.flutter.health.foundation.constants.Constants.DATA_TYPE_KEY;
import static com.huawei.hms.flutter.health.foundation.constants.Constants.DATA_TYPE_NAME_KEY;
import static com.huawei.hms.flutter.health.foundation.constants.Constants.TIME_UNIT_KEY;
import static com.huawei.hms.flutter.health.foundation.utils.MapUtils.toObject;
import static com.huawei.hms.flutter.health.modules.datacontroller.utils.DataControllerConstants.DATA_COLLECTOR_NAME_KEY;
import static com.huawei.hms.flutter.health.modules.datacontroller.utils.DataControllerConstants.DATA_GENERATE_TYPE_KEY;
import static com.huawei.hms.flutter.health.modules.datacontroller.utils.DataControllerConstants.DATA_STREAM_NAME;
import static com.huawei.hms.flutter.health.modules.datacontroller.utils.DataControllerConstants.DEVICE_ID_KEY;
import static com.huawei.hms.flutter.health.modules.datacontroller.utils.DataControllerConstants.DEVICE_INFO_KEY;
import static com.huawei.hms.flutter.health.modules.datacontroller.utils.DataControllerConstants.IS_LOCALIZED_KEY;

import android.util.Log;

import com.huawei.hms.common.ApiException;
import com.huawei.hms.flutter.health.foundation.constants.Constants;
import com.huawei.hms.flutter.health.modules.healthcontroller.HealthRecordUtils;
import com.huawei.hms.hihealth.data.ActivitySummary;
import com.huawei.hms.hihealth.data.DataCollector;
import com.huawei.hms.hihealth.data.DataType;
import com.huawei.hms.hihealth.data.DeviceInfo;
import com.huawei.hms.hihealth.data.Field;
import com.huawei.hms.hihealth.data.PaceSummary;
import com.huawei.hms.hihealth.data.SamplePoint;
import com.huawei.hms.hihealth.data.SampleSection;
import com.huawei.hms.hihealth.data.SampleSet;

import com.google.gson.Gson;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

import java.security.InvalidParameterException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.TimeUnit;

public final class Utils {
    private Utils() {
    }

    /**
     * Returns whether key is in the Map instance or not.
     *
     * @param callMap Flutter call map instance.
     * @param key String key.
     * @return Boolean
     */
    public static synchronized boolean hasKey(final Map<String, Object> callMap, final String key) {
        if (callMap == null) {
            return false;
        }
        return callMap.containsKey(key);
    }

    /**
     * In case callMap instance has requested key, returns the String Value, in case not, returns empty string.
     *
     * @param callMap HashMap<String, Object> instance.
     * @param key String key value.
     * @return String
     */
    public static synchronized String createEmptyStringIfNull(final Map<String, Object> callMap, final String key) {
        if (hasKey(callMap, key)) {
            return (String) callMap.get(key);
        }
        return "";
    }

    /**
     * Returns String into {@link TimeUnit} Instance. In case it doesn't exist returns {@code TimeUnit.MILLISECONDS}
     *
     * @param timeUnitStr String value.
     * @return {@link TimeUnit} instance.
     */
    public static synchronized TimeUnit toTimeUnit(final String timeUnitStr) {
        Constants.TimeUnitTypes variable = Constants.TimeUnitTypes.fromString(timeUnitStr);
        return variable != null ? variable.getTimeUnitType() : TimeUnit.MILLISECONDS;
    }

    /**
     * Returns Map<String, Object> instance into {@link TimeUnit} Instance. In case it doesn't exist returns {@code
     * TimeUnit.MILLISECONDS}
     *
     * @param map Map<String, Object> value.
     * @return {@link TimeUnit} instance.
     */
    public static synchronized TimeUnit toTimeUnit(final Map<String, Object> map) {
        if (map.containsKey(TIME_UNIT_KEY)) {
            return toTimeUnit(String.valueOf(map.get(TIME_UNIT_KEY)));
        }
        return TimeUnit.MILLISECONDS;
    }

    /**
     * Converts into {@link SampleSet} instance.
     *
     * @param sampleSetMap sampleSetMap that includes {@link SampleSet data} from the Flutter Platform.
     * @param result Flutter Result that resolved with fail status in case of missing parameters.
     * @param packageName Package name of the application.
     * @return SampleSet instance.
     */
    public static synchronized SampleSet toSampleSet(final Map<String, Object> sampleSetMap, final Result result,
        final String packageName) {
        if (sampleSetMap.get(Constants.DATA_COLLECTOR_KEY) != null) {
            DataCollector dataCollector = toDataCollector(
                HealthRecordUtils.fromObject(sampleSetMap.get(Constants.DATA_COLLECTOR_KEY)), packageName);
            final SampleSet sampleSet = SampleSet.create(dataCollector);
            ArrayList<Map<String, Object>> samplePoints = HealthRecordUtils.toMapArrayList("samplePoints",
                sampleSetMap.get("samplePoints"));
            if (!samplePoints.isEmpty()) {
                for (Map<String, Object> sp : samplePoints) {
                    // Build a sampling point.
                    SamplePoint samplePoint = toSamplePoint(sampleSet, sp);
                    // Save a sampling point to the sampling dataset.
                    sampleSet.addSample(samplePoint);
                }
            } else {
                throw new InvalidParameterException("Empty or wrong parameters for SampleSet.");
            }
            return sampleSet;
        } else {
            result.error(BASE_MODULE_NAME, "Sample Point List is null or empty", "");
        }
        throw new InvalidParameterException("Empty or wrong parameters for SampleSet.");
    }

    public static ActivitySummary toActivitySummary(final Map<String, Object> callMap, String packageName) {
        ActivitySummary activitySummary = new ActivitySummary();
        if (Utils.hasKey(callMap, "paceSummary")) {
            final PaceSummary paceSummary = toPaceSummary((HashMap<String, Object>) callMap.get("paceSummary"));
            activitySummary.setPaceSummary(paceSummary);
        }
        if (Utils.hasKey(callMap, "dataSummary")) {
            final List<SamplePoint> dataSummary = toDataSummary(
                (ArrayList<Map<String, Object>>) callMap.get("dataSummary"), packageName);
            activitySummary.setDataSummary(dataSummary);
        }
        if (Utils.hasKey(callMap, "sectionSummary")) {
            final List<SampleSection> sectionSummary = toSectionSummary(
                (ArrayList<Map<String, Object>>) callMap.get("sectionSummary"), packageName);
            activitySummary.setSectionSummary(sectionSummary);
        }
        return activitySummary;
    }

    public static synchronized List<SamplePoint> toDataSummary(final List<Map<String, Object>> dataSummaryList,
        String packageName) {
        final List<SamplePoint> dataSummary = new ArrayList<>();
        for (Map<String, Object> samplePointMap : dataSummaryList) {
            if (samplePointMap != null) {
                final SamplePoint samplePoint = toSamplePoint(samplePointMap, packageName);
                dataSummary.add(samplePoint);
            }
        }
        return dataSummary;
    }

    public static synchronized List<SampleSection> toSectionSummary(List<Map<String, Object>> list,
        String packageName) {
        final List<SampleSection> sectionSummary = new ArrayList<>();
        for (Map<String, Object> sampleSectionMap : list) {
            if (sampleSectionMap != null) {
                final SampleSection sampleSection = toSampleSection(sampleSectionMap, packageName);
                sectionSummary.add(sampleSection);
            }
        }
        return sectionSummary;
    }

    private static synchronized PaceSummary toPaceSummary(final Map<String, Object> paceMap) {
        PaceSummary paceSummary = new PaceSummary();
        if (Utils.hasKey(paceMap, "avgPace")) {
            paceSummary.setAvgPace((Double) paceMap.get("avgPace"));
        }
        if (Utils.hasKey(paceMap, "bestPace")) {
            paceSummary.setBestPace((Double) paceMap.get("bestPace"));
        }
        if (Utils.hasKey(paceMap, "paceMap")) {
            paceSummary.setPaceMap((HashMap<String, Double>) paceMap.get("paceMap"));
        }
        if (Utils.hasKey(paceMap, "britishPaceMap")) {
            paceSummary.setBritishPaceMap((HashMap<String, Double>) paceMap.get("britishPaceMap"));
        }
        if (Utils.hasKey(paceMap, "partTimeMap")) {
            paceSummary.setPartTimeMap((HashMap<String, Double>) paceMap.get("partTimeMap"));
        }
        if (Utils.hasKey(paceMap, "britishPartTimeMap")) {
            paceSummary.setBritishPartTimeMap((HashMap<String, Double>) paceMap.get("britishPartTimeMap"));
        }

        return paceSummary;
    }

    public static synchronized SamplePoint toSamplePoint(final SampleSet sampleSet,
        final Map<String, Object> sampleSetMap) {
        Gson gson = new Gson();
        sampleSetMap.remove(Constants.DATA_COLLECTOR_KEY);
        FlutterSamplePoint flutterSamplePoint = gson.fromJson(sampleSetMap.toString(), FlutterSamplePoint.class);
        Field requestedField = flutterSamplePoint.fieldValue.field.getField();
        boolean isSampling = flutterSamplePoint.isSampling;
        SamplePoint samplePoint;
        if (!isSampling) {
            samplePoint = sampleSet.createSamplePoint()
                .setTimeInterval(flutterSamplePoint.startTime, flutterSamplePoint.endTime,
                    Utils.toTimeUnit(sampleSetMap));
        } else {
            long samplingTimeMillis = flutterSamplePoint.samplingTime;
            samplePoint = sampleSet.createSamplePoint()
                .setSamplingTime(samplingTimeMillis, Utils.toTimeUnit(sampleSetMap));
        }
        if (flutterSamplePoint.fieldValue.intValue != null) {
            samplePoint.getFieldValue(requestedField).setIntValue(flutterSamplePoint.fieldValue.intValue);
            return samplePoint;
        }
        if (flutterSamplePoint.fieldValue.longValue != null) {
            samplePoint.getFieldValue(requestedField).setLongValue(flutterSamplePoint.fieldValue.longValue);
            return samplePoint;
        }
        if (flutterSamplePoint.fieldValue.floatValue != null) {
            samplePoint.getFieldValue(requestedField).setFloatValue(flutterSamplePoint.fieldValue.floatValue);
            return samplePoint;
        }
        if (flutterSamplePoint.fieldValue.stringValue != null) {
            samplePoint.getFieldValue(requestedField).setStringValue(flutterSamplePoint.fieldValue.stringValue);
            return samplePoint;
        }
        if (flutterSamplePoint.fieldValue.mapValue != null) {
            for (Map.Entry<String, Float> fieldVal : flutterSamplePoint.fieldValue.mapValue.entrySet()) {
                samplePoint.getFieldValue(requestedField).setKeyValue(fieldVal.getKey(), fieldVal.getValue());
            }
            return samplePoint;
        }
        return samplePoint;
    }

    public static synchronized SamplePoint toSamplePoint(final Map<String, Object> samplePointMap, String packageName) {
        SamplePoint.Builder samplePoint;
        List<Field> fields;
        if (samplePointMap.containsKey(Constants.DATA_COLLECTOR_KEY)) {
            final Map<String, Object> dataCollectorMap = HealthRecordUtils.fromObject(
                samplePointMap.get(Constants.DATA_COLLECTOR_KEY));
            final DataCollector dataCollector = toDataCollector(dataCollectorMap, packageName);
            fields = dataCollector.getDataType().getFields();
            samplePoint = new SamplePoint.Builder(dataCollector);
            samplePointMap.remove(Constants.DATA_COLLECTOR_KEY);
        } else {
            final Map<String, Object> dataTypeMap = HealthRecordUtils.fromObject(samplePointMap.get(DATA_TYPE_KEY));
            final DataType dataType = toDataType(dataTypeMap, packageName);
            fields = dataType.getFields();
            samplePoint = new SamplePoint.Builder(dataType);
            samplePointMap.remove(Constants.DATA_TYPE_KEY);
        }

        Gson gson = new Gson();
        FlutterSamplePoint flutterSamplePoint = gson.fromJson(samplePointMap.toString(), FlutterSamplePoint.class);
        Field requestedField = flutterSamplePoint.fieldValue.field.getField();
        if (!flutterSamplePoint.isSampling && flutterSamplePoint.startTime != 0 && flutterSamplePoint.endTime != 0) {
            samplePoint.setTimeInterval(flutterSamplePoint.startTime, flutterSamplePoint.endTime,
                Utils.toTimeUnit(flutterSamplePoint.timeUnit));
        } else {
            samplePoint.setSamplingTime(flutterSamplePoint.samplingTime, Utils.toTimeUnit(flutterSamplePoint.timeUnit));
        }
        switch (requestedField.getFormat()) {
            case Field.FORMAT_INT32:
                samplePoint.setFieldValue(requestedField, flutterSamplePoint.fieldValue.intValue);
                break;
            case Field.FORMAT_FLOAT:
                samplePoint.setFieldValue(requestedField, flutterSamplePoint.fieldValue.floatValue);
                break;
            case Field.FORMAT_STRING:
                samplePoint.setFieldValue(requestedField, flutterSamplePoint.fieldValue.stringValue);
                break;
            case Field.FORMAT_MAP:
                samplePoint.setFieldValue(requestedField, String.valueOf(flutterSamplePoint.fieldValue.mapValue));
                break;
            case Field.FORMAT_LONG:
                samplePoint.setFieldValue(requestedField, flutterSamplePoint.fieldValue.longValue);
                break;
            default:
                break;
        }
        SamplePoint sp = samplePoint.build();
        List<Map<String, Object>> metadataList = HealthRecordUtils.toMapArrayList("metadataValues",
            samplePointMap.get("metadataValues"));
        if (!metadataList.isEmpty()) {
            for (Map<String, Object> m : metadataList) {
                String key = (String) m.get("key");
                String value = (String) m.get("value");
                sp.addMetadata(key, value);
            }
        }
        Map<String, Object> pairMap = HealthRecordUtils.fromObject(samplePointMap.get("pairs"));
        if (!pairMap.isEmpty()) {
            for (Field field : fields) {
                if (pairMap.containsKey(field.getName()) && pairMap.get(field.getName())!= null) {
                    HealthRecordUtils.setFieldValues(sp, field, pairMap.get(field.getName()));
                }
            }
        }
        return sp;
    }

    public static synchronized SampleSection toSampleSection(final Map<String, Object> map, String packageName) {
        final SampleSection.Builder builder = new SampleSection.Builder();

        if (map.containsKey("sectionNum")) {
            builder.setSectionNum(Integer.parseInt(Objects.requireNonNull(map.get("sectionNum")).toString()));
        }
        if (map.containsKey("sectionTime")) {
            builder.setSectionTime(Long.parseLong(Objects.requireNonNull(map.get("sectionTime")).toString()),
                TimeUnit.MILLISECONDS);
        }
        if (map.containsKey("startTime")) {
            builder.setStartTime(Long.parseLong(Objects.requireNonNull(map.get("startTime")).toString()),
                TimeUnit.MILLISECONDS);
        }
        if (map.containsKey("endTime")) {
            builder.setEndTime(Long.parseLong(Objects.requireNonNull(map.get("endTime")).toString()),
                TimeUnit.MILLISECONDS);
        }
        if (map.containsKey("sectionDataList")) {
            final ArrayList<Map<String, Object>> list = HealthRecordUtils.toMapArrayList("sectionDataList",
                map.get("sectionDataList"));
            final List<SamplePoint> sectionDataList = new ArrayList<>();
            for (Map<String, Object> sectionDataMap : list) {
                sectionDataList.add(toSamplePoint(sectionDataMap, packageName));
            }
            builder.setSectionDataList(sectionDataList);
        }
        return builder.build();
    }

    public static synchronized DataCollector toDataCollector(final Map<String, Object> dataCollectorMap,
        String packageName) {
        DataCollector.Builder builder = new DataCollector.Builder();
        builder = new HmsDataCollectorBuilder(builder, dataCollectorMap, packageName).setDataStreamName()
            .setDeviceId()
            .setDataCollectorName()
            .setDeviceInfo()
            .setLocalized()
            .setDataGenerateType()
            .setDataType()
            .build();
        return builder.setPackageName(packageName).build();
    }

    public static boolean getBoolOrDefault(final Map<String, Object> callMap, final String key) {
        if (callMap.get(key) != null) {
            return (boolean) callMap.get(key);
        } else {
            return false;
        }
    }

    public static long getLong(final MethodCall call, final String key) {
        if (call.argument(key) != null) {
            return (long) call.argument(key);
        } else {
            throw new InvalidParameterException("Long type parameter is null or empty");
        }
    }

    /* Private Declarations */

    public static long getLong(final Map<String, Object> callMap, final String key) {
        if (callMap.containsKey(key)) {
            return (long) callMap.get(key);
        } else {
            throw new InvalidParameterException("Long type parameter is null or empty");
        }
    }

    public static int getInt(final MethodCall call, final String key) {
        if (call.argument(key) != null) {
            return (int) call.argument(key);
        } else {
            throw new InvalidParameterException("int type parameter is null or empty");
        }
    }

    public static Map<String, Object> getMap(final MethodCall call, final String key) {
        if (call.argument(key) instanceof HashMap) {
            return (HashMap<String, Object>) call.argument(key);
        } else {
            throw new InvalidParameterException(key + " is null or empty");
        }
    }

    public static DataType toDataType(final Map<String, Object> map, final String packageName) {
        DataType dataType;
        // Try to convert DataTypeConstant.
        dataType = Constants.toDataType((String) map.get("name"));
        if (dataType != null) {
            return dataType;
        } else {
            // Create DataType from map.
            String name = (String) map.get("name");
            boolean isPolymerizedFlag = Utils.getBoolOrDefault(map, "isPolymerizedFlag");
            boolean isSelfDefined = Utils.getBoolOrDefault(map, "isSelfDefined");
            String scopeNameRead = (String) map.get("scopeNameRead");
            String scopeNameWrite = (String) map.get("scopeNameWrite");

            List<Map<String, Object>> fieldList = HealthRecordUtils.toMapArrayList("fields", map.get("fields"));
            Log.i("qqq", String.valueOf(fieldList));
            List<Field> convertedFields = new ArrayList<>();
            if (!fieldList.isEmpty()) {
                for (Map<String, Object> field : fieldList) {
                    Field f = toField(field);
                    convertedFields.add(f);
                }
            }
            return new DataType(name, scopeNameRead, scopeNameWrite, "", convertedFields, isPolymerizedFlag,
                isSelfDefined, packageName);
        }
    }

    public static List<DataType> toDataTypeList(List<Map<String, Object>> mapList, String packageName) {
        List<DataType> list = new ArrayList<>();

        for (Map<String, Object> innerMap : mapList) {
            DataType type = toDataType(innerMap, packageName);
            list.add(type);
        }
        return list;
    }

    public static Field toField(Map<String, Object> objectMap) {
        Field field;
        String name = (String) objectMap.get(Constants.NAME_KEY);
        int format = (int) objectMap.get(Constants.FORMAT_KEY);
        if (format < 1 || format > 5) {
            throw new InvalidParameterException("Field type format is wrong!");
        }
        field = Constants.toField(name,format);
        if (field == null) {
            // Constant conversion fails create a new Field.
            field = new Field(name, format);
        }
        return field;
    }

    public static Field toField(final String name, final int format) {
        Field field;
        if (format < 1 || format > 5) {
            throw new InvalidParameterException("Field type format is wrong!");
        }
        field = Constants.toField(name, format);
        if (field == null) {
            // Constant conversion fails create a new Field.
            field = new Field(name, format);
        }
        return field;
    }

    public static String getErrorCode(Exception exception) {
        String errorCode;
        if (exception instanceof ApiException) {
            errorCode = String.valueOf(((ApiException) exception).getStatusCode());
        } else if (exception instanceof SecurityException) {
            errorCode = String.valueOf((exception).getLocalizedMessage());
        } else {
            errorCode = Constants.UNKNOWN_ERROR_CODE;
        }
        return errorCode;
    }

    private static class FlutterSamplePoint {
        boolean isSampling;

        long startTime;

        long endTime;

        long samplingTime;

        FieldValue fieldValue;

        String timeUnit;

        public FlutterSamplePoint(boolean isSampling, long startTime, long endTime, long samplingTime,
            FieldValue fieldValue, String timeUnit) {
            this.isSampling = isSampling;
            this.startTime = startTime;
            this.endTime = endTime;
            this.samplingTime = samplingTime;
            this.fieldValue = fieldValue;
            this.timeUnit = timeUnit;
        }
    }

    private static class FieldValue {
        FieldData field;

        Integer intValue;

        Long longValue;

        Float floatValue;

        String stringValue;

        Map<String, Float> mapValue;

        public FieldValue(FieldData field, Integer intValue, Long longValue, Float floatValue, String stringValue,
            Map<String, Float> mapValue) {
            this.field = field;
            this.intValue = intValue;
            this.longValue = longValue;
            this.floatValue = floatValue;
            this.stringValue = stringValue;
            this.mapValue = mapValue;
        }

        private static class FieldData {
            String name;

            int format;

            public FieldData(String name, int format) {
                this.name = name;
                this.format = format;
            }

            public Field getField() {
                return Utils.toField(name, format);
            }
        }
    }

    private static class HmsDataCollectorBuilder {
        private DataCollector.Builder builder;

        private Map<String, Object> dataCollectorMap;

        private String packageName;

        HmsDataCollectorBuilder(DataCollector.Builder builder, final Map<String, Object> dataCollectorMap,
            String packageName) {
            this.builder = builder;
            this.dataCollectorMap = dataCollectorMap;
            this.packageName = packageName;
        }

        HmsDataCollectorBuilder setDataStreamName() {
            if (Utils.hasKey(dataCollectorMap, DATA_STREAM_NAME)) {
                this.builder.setDataStreamName((String) dataCollectorMap.get(DATA_STREAM_NAME));
            }
            return this;
        }

        HmsDataCollectorBuilder setDeviceId() {
            if (Utils.hasKey(dataCollectorMap, DEVICE_ID_KEY)) {
                this.builder.setDeviceId((String) dataCollectorMap.get(DEVICE_ID_KEY));
            }
            return this;
        }

        HmsDataCollectorBuilder setDataCollectorName() {
            if (Utils.hasKey(dataCollectorMap, DATA_COLLECTOR_NAME_KEY)) {
                this.builder.setDataCollectorName((String) dataCollectorMap.get(DATA_COLLECTOR_NAME_KEY));
            }
            return this;
        }

        HmsDataCollectorBuilder setDeviceInfo() {
            if (Utils.hasKey(dataCollectorMap, DEVICE_INFO_KEY)) {
                this.builder.setDeviceInfo(
                    toObject((HashMap<String, Object>) dataCollectorMap.get(DEVICE_INFO_KEY), DeviceInfo.class));
            }
            return this;
        }

        HmsDataCollectorBuilder setLocalized() {
            if (Utils.hasKey(dataCollectorMap, IS_LOCALIZED_KEY)) {
                this.builder.setLocalized((Boolean) Objects.requireNonNull(dataCollectorMap.get(IS_LOCALIZED_KEY)));
            }
            return this;
        }

        HmsDataCollectorBuilder setDataGenerateType() {
            if (Utils.hasKey(dataCollectorMap, DATA_GENERATE_TYPE_KEY)) {
                this.builder.setDataGenerateType(
                    (Integer) Objects.requireNonNull(dataCollectorMap.get(DATA_GENERATE_TYPE_KEY)));
            }
            return this;
        }

        HmsDataCollectorBuilder setDataType() {
            if (Utils.hasKey(dataCollectorMap, DATA_TYPE_KEY)) {
                try {
                    DataType dataType = toDataType(HealthRecordUtils.fromObject(dataCollectorMap.get(DATA_TYPE_KEY)),
                        packageName);
                    this.builder.setDataType(dataType);
                    return this;

                } catch (Exception e) {
                    Log.e(BASE_MODULE_NAME, e.getMessage());
                }
            } else if (Utils.hasKey(dataCollectorMap, DATA_TYPE_NAME_KEY)) {
                final String dataTypeName = (String) dataCollectorMap.get(DATA_TYPE_NAME_KEY);
                this.builder.setDataType(dataTypeName);
            }
            return this;
        }

        DataCollector.Builder build() {
            return builder;
        }
    }
}
