/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License")
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.hmsavailability.utils;

import android.util.Log;

public class FromMap {
    private static final String TAG = FromMap.class.getSimpleName();

    public static Integer toInteger(String key, Object value) {
        if (!(value instanceof Integer)) {
            Log.w(TAG, "toInteger | Integer value expected for " + key);
            return null;
        }
        return (Integer) value;
    }
}
