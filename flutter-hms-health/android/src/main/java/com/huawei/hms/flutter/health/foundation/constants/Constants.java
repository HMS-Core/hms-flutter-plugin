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

package com.huawei.hms.flutter.health.foundation.constants;

import com.huawei.hms.hihealth.data.DataType;
import com.huawei.hms.hihealth.data.Field;

import io.flutter.Log;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

public interface Constants {
    String UNKNOWN_ERROR_CODE = "-1";
    String BASE_MODULE_NAME = "HMSFlutterHealth";

    /**
     * Constant Variable Keys That Will be Used among Flutter Side.
     */
    String ID_KEY = "id";
    String NAME_KEY = "name";
    String DESCRIPTION_KEY = "description";
    String ACTIVITY_TYPE_KEY = "activityTypeId";
    String START_TIME_KEY = "startTime";
    String END_TIME_KEY = "endTime";
    String FORMAT_KEY = "format";
    String TIME_UNIT_KEY = "timeUnit";
    String DATA_TYPE_KEY = "dataType";
    String DATA_TYPE_NAME_KEY = "dataTypeName";
    String IS_SUCCESS_KEY = "isSuccess";
    String DATA_COLLECTOR_KEY = "dataCollector";
    String FIELDS_KEY = "fields";

    static DataType toDataType(String dataTypeName) {
        java.lang.reflect.Field[] declaredFields = DataType.class.getDeclaredFields();
        List<java.lang.reflect.Field> staticFields = new ArrayList<>();
        for (java.lang.reflect.Field field : declaredFields) {
            if (java.lang.reflect.Modifier.isStatic(field.getModifiers()) && field.getType().equals(DataType.class)) {
                staticFields.add(field);
            }
        }
        for (java.lang.reflect.Field constantDataType : staticFields) {
            try {
                DataType dataType = (DataType) constantDataType.get(null);
                if (dataType.getName().equals(dataTypeName)) {
                    return dataType;
                }
            } catch (IllegalAccessException e) {
                Log.i(BASE_MODULE_NAME, e.getMessage());
            }
        }
        return null;
    }

    /**
     * Returns a {@link Field} constant from the fieldName by using reflection on {@link Field} class. If a match is not
     * found null is returned.
     *
     * @param fieldName The name of the field to be converted.
     * @return Field constant If the name matches, otherwise null.
     */
    static Field toField(String fieldName, int format) {
        java.lang.reflect.Field[] declaredFields = Field.class.getDeclaredFields();
        List<java.lang.reflect.Field> staticFields = new ArrayList<>();
        for (java.lang.reflect.Field field : declaredFields) {
            if (java.lang.reflect.Modifier.isStatic(field.getModifiers()) && field.getType().equals(Field.class)) {
                staticFields.add(field);
            }
        }
        for (java.lang.reflect.Field field : staticFields) {
            try {
                Field f = (Field) field.get(null);
                if (f.getName().equals(fieldName) && f.getFormat() == format) {
                    return f;
                }
            } catch (IllegalAccessException e) {
                Log.i(BASE_MODULE_NAME, e.getMessage());
            }
        }
        return null;
    }

    /**
     * {@link TimeConstants} used among converting time params from Flutter Call Maps into Java Side.
     */
    enum TimeConstants {
        START,
        END,
        DURATION
    }

    /**
     * {@link TimeUnit} types.
     */
    enum TimeUnitTypes {
        /* Time units */
        NANOSECONDS("NANOSECONDS", TimeUnit.NANOSECONDS),
        MICROSECONDS("MICROSECONDS", TimeUnit.MICROSECONDS),
        MILLISECONDS("MILLISECONDS", TimeUnit.MILLISECONDS),
        SECONDS("SECONDS", TimeUnit.SECONDS),
        MINUTES("MINUTES", TimeUnit.MINUTES),
        HOURS("HOURS", TimeUnit.HOURS),
        DAYS("DAYS", TimeUnit.DAYS);

        private final String value;

        private final TimeUnit type;

        TimeUnitTypes(String value, TimeUnit type) {
            this.value = value;
            this.type = type;
        }

        public static TimeUnitTypes fromString(String text) {
            for (TimeUnitTypes variable : TimeUnitTypes.values()) {
                if (variable.value.equalsIgnoreCase(text)) {
                    return variable;
                }
            }
            return null;
        }

        public TimeUnit getTimeUnitType() {
            return type;
        }
    }
}
