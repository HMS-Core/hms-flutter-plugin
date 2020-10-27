/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.analytics;

import android.content.Context;
import android.os.Bundle;
import android.util.Log;

import com.huawei.hms.analytics.HiAnalytics;
import com.huawei.hms.analytics.HiAnalyticsInstance;
import com.huawei.hms.analytics.HiAnalyticsTools;
import com.huawei.hms.flutter.analytics.logger.HMSLogger;
import com.huawei.hms.flutter.analytics.utils.MapUtils;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import java.util.Map;

class AnalyticsService {
    private static final String TAG = AnalyticsService.class.getSimpleName();

    private HiAnalyticsInstance instance;

    private Context context;

    AnalyticsService(Context mContext) {
        this.instance = HiAnalytics.getInstance(mContext);
        context = mContext;
    }

    void clearCachedData(MethodChannel.Result cb) {
        Log.i(TAG, "clearCachedData is running");
        HMSLogger.getInstance(context).startMethodExecutionTimer("clearCachedData");

        instance.clearCachedData();
        HMSLogger.getInstance(context).sendSingleEvent("clearCachedData");
        cb.success(null);
    }

    void setAnalyticsEnabled(MethodCall call, MethodChannel.Result cb) {
        Log.i(TAG, "setAnalyticsEnabled is running");
        HMSLogger.getInstance(context).startMethodExecutionTimer("setAnalyticsEnabled");

        boolean enabled = MapUtils.toBoolean("enabled", call.argument("enabled"));
        instance.setAnalyticsEnabled(enabled);
        HMSLogger.getInstance(context).sendSingleEvent("setAnalyticsEnabled");
        cb.success(null);
    }

    void getAAID(MethodChannel.Result cb) {
        Log.i(TAG, "getAAID is running");
        HMSLogger.getInstance(context).startMethodExecutionTimer("getAAID");

        instance.getAAID().addOnSuccessListener(aaid -> {
            cb.success(aaid);
            HMSLogger.getInstance(context).sendSingleEvent("getAAID");
        }).addOnFailureListener(ex -> {
            HMSLogger.getInstance(context).sendSingleEvent("getAAID", ex.getMessage());
            cb.error(ex.getMessage(), ex.getMessage(), null);
        });
    }

    void getUserProfiles(MethodCall call, MethodChannel.Result cb) {
        Log.i(TAG, "getUserProfiles is running");
        HMSLogger.getInstance(context).startMethodExecutionTimer("getUserProfiles");

        boolean predefined = MapUtils.toBoolean("predefined", call.argument("predefined"));
        Map<String, String> userProfiles = instance.getUserProfiles(predefined);
        HMSLogger.getInstance(context).sendSingleEvent("getUserProfiles");
        cb.success(userProfiles);
    }

    void pageStart(MethodCall call, MethodChannel.Result cb) {
        Log.i(TAG, "pageStart is running");
        HMSLogger.getInstance(context).startMethodExecutionTimer("pageStart");

        String pageName = call.argument("pageName");
        String pageClassOverride = call.argument("pageClassOverride");
        instance.pageStart(pageName, pageClassOverride);
        HMSLogger.getInstance(context).sendSingleEvent("pageStart");
        cb.success(null);
    }

    void pageEnd(MethodCall call, MethodChannel.Result cb) {
        Log.i(TAG, "pageEnd is running");
        HMSLogger.getInstance(context).startMethodExecutionTimer("pageEnd");

        String pageName = call.argument("pageName");
        instance.pageEnd(pageName);
        HMSLogger.getInstance(context).sendSingleEvent("pageEnd");
        cb.success(null);
    }

    void setMinActivitySessions(MethodCall call, MethodChannel.Result cb) {
        Log.i(TAG, "setMinActivitySessions is running");
        HMSLogger.getInstance(context).startMethodExecutionTimer("setMinActivitySessions");

        Long milliseconds = MapUtils.toLong("interval", call.argument("interval"));
        if (milliseconds != null) {
            instance.setMinActivitySessions(milliseconds);
            HMSLogger.getInstance(context).sendSingleEvent("setMinActivitySessions");
            cb.success(null);
        } else {
            Log.e(TAG, "interval was null.");
            HMSLogger.getInstance(context).sendSingleEvent("setMinActivitySessions", "NULL_PARAM");
            cb.error("NULL_PARAM", "interval was null.", null);
        }
    }

    void setPushToken(MethodCall call, MethodChannel.Result cb) {
        Log.i(TAG, "setPushToken is running");
        HMSLogger.getInstance(context).startMethodExecutionTimer("setPushToken");

        String token = call.argument("token");
        instance.setPushToken(token);
        HMSLogger.getInstance(context).sendSingleEvent("setPushToken");
        cb.success(null);
    }

    void setSessionDuration(MethodCall call, MethodChannel.Result cb) {
        Log.i(TAG, "setSessionDuration is running");
        HMSLogger.getInstance(context).startMethodExecutionTimer("setSessionDuration");

        Long milliseconds = MapUtils.toLong("duration", call.argument("duration"));
        if (milliseconds != null) {
            instance.setSessionDuration(milliseconds);
            HMSLogger.getInstance(context).sendSingleEvent("setSessionDuration");
            cb.success(null);
        } else {
            Log.e(TAG, "duration was null.");
            HMSLogger.getInstance(context).sendSingleEvent("setSessionDuration", "NULL_PARAM");
            cb.error("NULL_PARAM", "duration was null.", null);
        }
    }

    void setUserId(MethodCall call, MethodChannel.Result cb) {
        Log.i(TAG, "setUserId is running");
        HMSLogger.getInstance(context).startMethodExecutionTimer("setUserId");

        String userId = call.argument("userId");
        instance.setUserId(userId);
        HMSLogger.getInstance(context).sendSingleEvent("setUserId");
        cb.success(null);
    }

    void setUserProfile(MethodCall call, MethodChannel.Result cb) {
        Log.i(TAG, "setUserProfile is running");
        HMSLogger.getInstance(context).startMethodExecutionTimer("setUserProfile");

        String key = call.argument("key");
        String value = call.argument("value");
        instance.setUserProfile(key, value);
        HMSLogger.getInstance(context).sendSingleEvent("setUserProfile");
        cb.success(null);
    }

    void onEvent(MethodCall call, MethodChannel.Result cb) {
        Log.i(TAG, "onEvent is running");
        HMSLogger.getInstance(context).startMethodExecutionTimer("onEvent");

        String key = call.argument("key");
        Map<String, Object> val = MapUtils.objectToMap(call.argument("value"));
        Bundle bundle = MapUtils.mapToBundle(val);
        instance.onEvent(key, bundle);
        HMSLogger.getInstance(context).sendSingleEvent("onEvent");
        cb.success(null);
    }

    void enableLogger(MethodChannel.Result cb) {
        Log.i(TAG, "enableLogger is running");

        HMSLogger.getInstance(context).enableLogger();
        cb.success(null);
    }

    void disableLogger(MethodChannel.Result cb) {
        Log.i(TAG, "disableLogger is running");

        HMSLogger.getInstance(context).disableLogger();
        cb.success(null);
    }

    //-------------------------------------------------------------------------
    // HiAnalyticsTools
    //-------------------------------------------------------------------------

    void enableLog(MethodChannel.Result cb) {
        Log.i(TAG, "enableLog is running");
        HMSLogger.getInstance(context).startMethodExecutionTimer("enableLog");

        HiAnalyticsTools.enableLog();
        HMSLogger.getInstance(context).sendSingleEvent("enableLog");
        cb.success(null);
    }

    void enableLogWithLevel(MethodCall call, MethodChannel.Result cb) {
        Log.i(TAG, "enableLogWithLevel is running");
        HMSLogger.getInstance(context).startMethodExecutionTimer("enableLogWithLevel");

        String level = call.argument("logLevel");
        Integer intValueOfLevel = null;

        try {
            intValueOfLevel = LogLevel.valueOf(level).intValue;
        } catch (IllegalArgumentException ex) {
            HMSLogger.getInstance(context).sendSingleEvent("enableLogWithLevel", "Invalid log level. level = " + level);

            Log.e(TAG, "Invalid log level. level = " + level);
            cb.error("INVALID_PARAM", "Invalid log level. level = " + level, null);
            return;
        }

        HiAnalyticsTools.enableLog(intValueOfLevel);
        HMSLogger.getInstance(context).sendSingleEvent("enableLogWithLevel");
        cb.success(null);
    }

    private enum LogLevel {
        DEBUG(3),
        INFO(4),
        WARN(5),
        ERROR(6);

        int intValue;

        LogLevel(int logLevel) {
            this.intValue = logLevel;
        }
    }
}
