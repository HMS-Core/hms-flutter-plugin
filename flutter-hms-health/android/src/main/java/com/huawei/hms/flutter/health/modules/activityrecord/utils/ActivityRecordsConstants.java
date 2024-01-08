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

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public final class ActivityRecordsConstants {
    public static final String ACTIVITY_RECORDS_MODULE = "HMSActivityRecord";

    /**
     * Parsing Keys.
     */
    public static final String ACTIVITY_SUMMARY_KEY = "activitySummary";

    public static final String PACKAGE_NAME = "packageName";

    public enum ActivityRecordMethods {
        ADD_ACTIVITY_RECORD("addActivityRecord"),
        BEGIN_ACTIVITY_RECORD("beginActivityRecord"),
        CONTINUE_ACTIVITY_RECORD("continueActivityRecord"),
        END_ACTIVITY_RECORD("endActivityRecord"),
        GET_ACTIVITY_RECORD("getActivityRecord"),
        END_ALL_ACTIVITY_RECORDS("endAllActivityRecords"),
        DELETE_ACTIVITY_RECORD("deleteActivityRecord");

        private static final Map<String, ActivityRecordMethods> ENUM_MAP;

        static {
            Map<String, ActivityRecordMethods> map = new HashMap<>();
            for (ActivityRecordMethods instance : ActivityRecordMethods.values()) {
                map.put(instance.getName(), instance);
            }
            ENUM_MAP = Collections.unmodifiableMap(map);
        }

        private String name;

        ActivityRecordMethods(String name) {
            this.name = name;
        }

        public static ActivityRecordMethods get(String name) {
            return ENUM_MAP.get(name);
        }

        public String getName() {
            return name;
        }
    }
}
