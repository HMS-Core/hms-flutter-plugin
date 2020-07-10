/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

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

import io.flutter.plugin.common.MethodChannel;

import java.util.Map;
import java.util.Set;

public class AnalyticsService {

    private String TAG = AnalyticsService.class.getSimpleName();

    private HiAnalyticsInstance instance;

    public AnalyticsService(Context context) {
        this.instance = HiAnalytics.getInstance(context);
    }

    public void clearCachedData(MethodChannel.Result cb) {
        Log.i(TAG, "clearCachedData is running");

        instance.clearCachedData();
        cb.success(null);
    }

    public void setAnalyticsEnabled(Map<String, Object> params, MethodChannel.Result cb) {
        Log.i(TAG, "setAnalyticsEnabled is running");

        boolean enabled = (boolean) params.get("enabled");
        instance.setAnalyticsEnabled(enabled);
    }

    public void getAAID(MethodChannel.Result cb) {
        Log.i(TAG, "getAAID is running");

        instance.getAAID().addOnSuccessListener(aaid -> {
            cb.success(aaid);
        }).addOnFailureListener(ex -> {
            cb.error(ex.getMessage(), null, null);
        });
    }

    public void getUserProfiles(Map<String, Object> params, MethodChannel.Result cb) {
        Log.i(TAG, "getUserProfiles is running");

        boolean predefined = (boolean) params.get("predefined");
        Map<String, String> userProfiles = instance.getUserProfiles(predefined);
        cb.success(userProfiles);
    }

    public void pageStart(Map<String, Object> params, MethodChannel.Result cb) {
        Log.i(TAG, "pageStart is running");

        String pageName = (String) params.get("pageName");
        String pageClassOverride = (String) params.get("pageClassOverride");
        instance.pageStart(pageName, pageClassOverride);
        cb.success(null);
    }

    public void pageEnd(Map<String, Object> params, MethodChannel.Result cb) {
        Log.i(TAG, "pageEnd is running");

        String pageName = (String) params.get("pageName");
        instance.pageEnd(pageName);
        cb.success(null);
    }

    public void regHmsSvcEvent(MethodChannel.Result cb) {
        Log.i(TAG, "regHmsSvcEvent is running");

        instance.regHmsSvcEvent();
        cb.success(null);
    }

    public void unRegHmsSvcEvent(MethodChannel.Result cb) {
        Log.i(TAG, "unRegHmsSvcEvent is running");

        instance.unRegHmsSvcEvent();
        if (cb != null) {
            cb.success(null);
        }
    }

    public void setMinActivitySessions(Map<String, Object> params, MethodChannel.Result cb) {
        Log.i(TAG, "setMinActivitySessions is running");

        long milliseconds = Long.valueOf((int) params.get("interval"));
        instance.setMinActivitySessions(milliseconds);
        cb.success(null);
    }

    public void setPushToken(Map<String, Object> params, MethodChannel.Result cb) {
        Log.i(TAG, "setPushToken is running");

        String token = (String) params.get("token");
        instance.setPushToken(token);
        cb.success(null);
    }

    public void setSessionDuration(Map<String, Object> params, MethodChannel.Result cb) {
        Log.i(TAG, "setSessionDuration is running");

        long milliseconds = Long.valueOf((int) params.get("duration"));
        instance.setSessionDuration(milliseconds);
        cb.success(null);
    }

    public void setUserId(Map<String, Object> params, MethodChannel.Result cb) {
        Log.i(TAG, "setUserId is running");

        String userId = (String) params.get("userId");
        instance.setUserId(userId);
        cb.success(null);
    }

    public void setUserProfile(Map<String, Object> params, MethodChannel.Result cb) {
        Log.i(TAG, "setUserProfile is running");

        String key = (String) params.get("key");
        String value = (String) params.get("value");
        instance.setUserProfile(key, value);
        cb.success(null);
    }

    public void onEvent(Map<String, Object> params, MethodChannel.Result cb) {
        Log.i(TAG, "onEvent is running");

        String key = (String) params.get("key");
        Map<String, Object> val = (Map<String, Object>) params.get("value");
        Bundle bundle = mapToBundle(val);
        instance.onEvent(key, bundle);
        cb.success(null);
    }

    private Bundle mapToBundle(Map<String, Object> map) {
        Bundle bundle = new Bundle();

        if (map == null) {
            return bundle;
        }

        Set<Map.Entry<String, Object>> entries = map.entrySet();
        for (Map.Entry<String, Object> entry : entries) {
            String key = entry.getKey();
            Object val = entry.getValue();

            if (val instanceof String) {
                bundle.putString(key, (String) val);
            } else if (val instanceof Boolean) {
                bundle.putBoolean(key, (Boolean) val);
            } else if (val instanceof Integer) {
                bundle.putInt(key, (Integer) val);
            } else if (val instanceof Long) {
                bundle.putLong(key, (Long) val);
            } else if (val instanceof Double) {
                bundle.putDouble(key, (Double) val);
            } else {
                throw new IllegalArgumentException(
                    "Illegal value type. Key :" + key + ", valueType : " + val.getClass().getSimpleName());
            }
        }
        return bundle;
    }

    //-------------------------------------------------------------------------
    // HiAnalyticsTools
    //-------------------------------------------------------------------------

    public void enableLog(MethodChannel.Result cb) {
        Log.i(TAG, "enableLog is running");

        HiAnalyticsTools.enableLog();
        cb.success(null);
    }

    public void enableLogWithLevel(Map<String, Object> params, MethodChannel.Result cb) {
        Log.i(TAG, "enableLogWithLevel is running");

        String level = (String) params.get("logLevel");
        Integer intValueOfLevel = null;

        try {
            intValueOfLevel = LogLevel.valueOf(level).intValue;
        } catch (IllegalArgumentException ex) {
            Log.e(TAG, "Invalid log level. level = " + level);
            cb.error("Invalid log level. level = " + level, null, null);
            return;
        }

        HiAnalyticsTools.enableLog(intValueOfLevel);
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
