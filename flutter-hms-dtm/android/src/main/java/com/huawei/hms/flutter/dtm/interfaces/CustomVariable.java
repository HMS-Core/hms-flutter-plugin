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

package com.huawei.hms.flutter.dtm.interfaces;

import android.content.Context;
import android.util.Log;

import com.huawei.hms.dtm.ICustomVariable;
import com.huawei.hms.flutter.dtm.DTMPlugin;
import com.huawei.hms.flutter.dtm.logger.HMSLogger;

import java.util.Map;

public class CustomVariable implements ICustomVariable {
    private static final String TAG = "CustomVariable";

    @Override
    public String getValue(final Map<String, Object> map) {
        final Context context = DTMPlugin.getContext();
        if (context != null) {
            HMSLogger.getInstance(context).startMethodExecutionTimer(TAG);
        }

        String name = "";
        final Object value = map.get("varName");
        if (!(value instanceof String) || ((String) value).isEmpty()) {
            Log.w(TAG, "toString | Non-empty String expected for varName");
        } else {
            name = value.toString();
        }

        String returnValue = "";
        if (DTMPlugin.getMap().containsKey(name)) {
            returnValue = DTMPlugin.getMap().get(name);
        }
        if (context != null) {
            HMSLogger.getInstance(context).sendSingleEvent(TAG);
        }
        return returnValue;
    }
}
