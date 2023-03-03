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

package com.huawei.hms.flutter.dtm;

import android.content.Context;
import android.os.Bundle;
import android.util.Log;

import com.huawei.hms.analytics.HiAnalytics;
import com.huawei.hms.analytics.HiAnalyticsInstance;
import com.huawei.hms.analytics.HiAnalyticsTools;
import com.huawei.hms.flutter.dtm.helpers.MapUtils;
import com.huawei.hms.flutter.dtm.logger.HMSLogger;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class DTMService {
    private static final String TAG = DTMService.class.getSimpleName();
    private final HiAnalyticsInstance instance;
    private final Context context;

    DTMService(final Context mContext) {
        instance = HiAnalytics.getInstance(mContext);
        context = mContext;
        HiAnalyticsTools.enableLog();
    }

    void onEvent(final MethodCall call, final MethodChannel.Result result) {
        Log.i(TAG, "onEvent is running.");

        HMSLogger.getInstance(context).startMethodExecutionTimer("onEvent");

        final String key = call.argument("key");
        final Map<String, Object> mapValue = MapUtils.objectToMap(call.argument("value"));
        final Bundle bundle = MapUtils.mapToBundle(mapValue);

        if (instance != null) {
            instance.onEvent(key, bundle);
        }
        HMSLogger.getInstance(context).sendSingleEvent("onEvent");
        result.success(null);
    }

    void setCustomVariable(final MethodCall call, final MethodChannel.Result result) {
        Log.i(TAG, "setCustomVariable is running.");
        HMSLogger.getInstance(context).startMethodExecutionTimer("setCustomVariable");
        final String varName = call.argument("varName");
        final String value = call.argument("value").toString();
        DTMPlugin.getMap().put(varName, value);
        HMSLogger.getInstance(context).sendSingleEvent("setCustomVariable");
        result.success(null);
    }

    void enableLogger(final MethodChannel.Result result) {
        HMSLogger.getInstance(context).enableLogger();
        result.success(null);
    }

    void disableLogger(final MethodChannel.Result result) {
        HMSLogger.getInstance(context).disableLogger();
        result.success(null);
    }
}
