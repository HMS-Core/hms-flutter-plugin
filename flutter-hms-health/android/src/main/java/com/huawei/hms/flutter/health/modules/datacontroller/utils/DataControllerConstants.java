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

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public final class DataControllerConstants {
    public static final String DATA_CONTROLLER_MODULE = "HMSDataController";

    /**
     * Constant Variable Keys That will be Used in Serializing/Deserializing operations related to {@link
     * com.huawei.hms.hihealth.DataController}
     */
    public static final String DATA_STREAM_NAME = "dataStreamName";

    public static final String DEVICE_ID_KEY = "deviceId";

    public static final String DEVICE_INFO_KEY = "deviceInfo";

    public static final String DATA_COLLECTOR_NAME_KEY = "dataCollectorName";

    public static final String IS_LOCALIZED_KEY = "isLocalized";

    public static final String DATA_GENERATE_TYPE_KEY = "dataGenerateType";

    public static final String DATA_TYPE_KEY = "dataType";

    public static final String DATA_TYPES_KEY = "dataTypes";

    public static final String DATA_COLLECTORS_KEY = "dataCollectors";

    private DataControllerConstants() {
    }

    public enum DataControllerMethods {
        INIT("init"),
        CLEAR_ALL("clearAll"),
        DELETE("delete"),
        INSERT("insert"),
        READ("read"),
        READ_DAILY_SUMMATION("readDailySummation"),
        READ_TODAY_SUMMATION("readTodaySummation"),
        READ_DAILY_SUMMATION_LIST("readDailySummationList"),
        READ_TODAY_SUMMATION_LIST("readTodaySummationList"),
        UPDATE("update"),
        READ_LATEST_DATA("readLatestData");

        private static final Map<String, DataControllerMethods> ENUM_MAP;

        static {
            Map<String, DataControllerMethods> map = new HashMap<>();
            for (DataControllerMethods instance : DataControllerMethods.values()) {
                map.put(instance.getName(), instance);
            }
            ENUM_MAP = Collections.unmodifiableMap(map);
        }

        private String name;

        DataControllerMethods(String name) {
            this.name = name;
        }

        public static DataControllerMethods get(String name) {
            return ENUM_MAP.get(name);
        }

        public String getName() {
            return name;
        }
    }
}
