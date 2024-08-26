/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.push.constants;

public interface LocalNotification {
    interface Priority {
        String MAX = "max";
        String HIGH = "high";
        String DEFAULT = "default";
        String LOW = "low";
        String MIN = "min";
    }

    interface Repeat {
        interface Type {
            String HOUR = "hour";
            String MINUTE = "minute";
            String DAY = "day";
            String WEEK = "week";
            String CUSTOM_TIME = "custom_time";
        }

        interface Time {
            int ONE_MINUTE = 60000;
            int ONE_HOUR = 3600000;
            int ONE_DAY = 86400000;
            int ONE_WEEK = 604800000;
        }

    }

    interface Visibility {
        String PUBLIC = "public";
        String SECRET = "secret";
        String PRIVATE = "private";
    }

    interface Importance {
        String MAX = "max";
        String HIGH = "high";
        String DEFAULT = "default";
        String LOW = "low";
        String MIN = "min";
        String NONE = "none";
        String UNSPECIFIED = "unspecified";
    }

    enum Bitmap {
        BIG_PICTURE,
        LARGE_ICON
    }
}
