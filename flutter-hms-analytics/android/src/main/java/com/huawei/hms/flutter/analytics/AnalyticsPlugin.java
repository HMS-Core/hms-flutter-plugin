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

import android.util.Log;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import java.util.Map;

public class AnalyticsPlugin implements FlutterPlugin, MethodCallHandler {
    private String TAG = AnalyticsPlugin.class.getSimpleName();

    private AnalyticsService analyticsService;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(),
            "com.huawei.hms.flutter.analytics");
        analyticsService = new AnalyticsService(flutterPluginBinding.getApplicationContext());
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall methodCall, @NonNull Result result) {
        Log.i(TAG, " Running method : " + methodCall.method);

        Map<String, Object> params = (Map<String, Object>) methodCall.arguments;

        if (Methods.CLEAR_CACHED_DATA.methodName().equals(methodCall.method)) {
            analyticsService.clearCachedData(result);
            return;
        }

        if (Methods.GET_AAID.methodName().equals(methodCall.method)) {
            analyticsService.getAAID(result);
            return;
        }

        if (Methods.GET_USER_PROFILES.methodName().equals(methodCall.method)) {
            analyticsService.getUserProfiles(params, result);
            return;
        }

        if (Methods.PAGE_START.methodName().equals(methodCall.method)) {
            analyticsService.pageStart(params, result);
            return;
        }

        if (Methods.PAGE_END.methodName().equals(methodCall.method)) {
            analyticsService.pageEnd(params, result);
            return;
        }

        if (Methods.SET_MIN_ACTIVITY_SESSIONS.methodName().equals(methodCall.method)) {
            analyticsService.setMinActivitySessions(params, result);
            return;
        }

        if (Methods.SET_PUSH_TOKEN.methodName().equals(methodCall.method)) {
            analyticsService.setPushToken(params, result);
            return;
        }

        if (Methods.SET_SESSIONS_DURATION.methodName().equals(methodCall.method)) {
            analyticsService.setSessionDuration(params, result);
            return;
        }

        if (Methods.SET_USER_ID.methodName().equals(methodCall.method)) {
            analyticsService.setUserId(params, result);
            return;
        }

        if (Methods.SET_USER_PROFILE.methodName().equals(methodCall.method)) {
            analyticsService.setUserProfile(params, result);
            return;
        }

        if (Methods.ON_EVENT.methodName().equals(methodCall.method)) {
            analyticsService.onEvent(params, result);
            return;
        }

        if (Methods.ENABLE_LOG.methodName().equals(methodCall.method)) {
            analyticsService.enableLog(result);
            return;
        }

        if (Methods.ENABLE_LOG_WITH_LEVEL.methodName().equals(methodCall.method)) {
            analyticsService.enableLogWithLevel(params, result);
            return;
        }

        result.notImplemented();
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        Log.i(TAG, "onDetachedFromEngine is called.");
        analyticsService.unRegHmsSvcEvent(null);
    }

    private enum Methods {
        CLEAR_CACHED_DATA("clearCachedData"),

        GET_AAID("getAAID"),

        GET_USER_PROFILES("getUserProfiles"),

        PAGE_START("pageStart"),

        PAGE_END("pageEnd"),

        SET_MIN_ACTIVITY_SESSIONS("setMinActivitySessions"),

        SET_PUSH_TOKEN("setPushToken"),

        SET_SESSIONS_DURATION("setSessionDuration"),

        SET_USER_ID("setUserId"),

        SET_USER_PROFILE("setUserProfile"),

        ON_EVENT("onEvent"),

        ENABLE_LOG("enableLog"),

        ENABLE_LOG_WITH_LEVEL("enableLogWithLevel");

        private String methodName;

        Methods(String methodName) {
            this.methodName = methodName;
        }

        public String methodName() {
            return methodName;
        }
    }
}
