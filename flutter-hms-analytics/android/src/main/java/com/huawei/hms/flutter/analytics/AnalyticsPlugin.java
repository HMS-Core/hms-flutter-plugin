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
import android.util.Log;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;

public class AnalyticsPlugin implements FlutterPlugin, MethodCallHandler {
    private static final String TAG = AnalyticsPlugin.class.getSimpleName();

    private AnalyticsService analyticsService;
    private MethodChannel channel;

    public static void registerWith(PluginRegistry.Registrar registrar) {
        final AnalyticsPlugin instance = new AnalyticsPlugin();
        instance.onAttachedToEngine(registrar.context(), registrar.messenger());
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        onAttachedToEngine(flutterPluginBinding.getApplicationContext(), flutterPluginBinding.getBinaryMessenger());
    }

    private void onAttachedToEngine(Context applicationContext, BinaryMessenger messenger) {
        channel = new MethodChannel(messenger, "com.huawei.hms.flutter.analytics");
        analyticsService = new AnalyticsService(applicationContext);
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall methodCall, @NonNull Result result) {
        Log.i(TAG, " Running method : " + methodCall.method);

        switch (Methods.valueOf(methodCall.method)) {
            case clearCachedData:
                analyticsService.clearCachedData(result);
                break;
            case setAnalyticsEnabled:
                analyticsService.setAnalyticsEnabled(methodCall, result);
                break;
            case getAAID:
                analyticsService.getAAID(result);
                break;
            case getUserProfiles:
                analyticsService.getUserProfiles(methodCall, result);
                break;
            case pageStart:
                analyticsService.pageStart(methodCall, result);
                break;
            case pageEnd:
                analyticsService.pageEnd(methodCall, result);
                break;
            case setMinActivitySessions:
                analyticsService.setMinActivitySessions(methodCall, result);
                break;
            case setPushToken:
                analyticsService.setPushToken(methodCall, result);
                break;
            case setSessionDuration:
                analyticsService.setSessionDuration(methodCall, result);
                break;
            case setUserId:
                analyticsService.setUserId(methodCall, result);
                break;
            case setUserProfile:
                analyticsService.setUserProfile(methodCall, result);
                break;
            case onEvent:
                analyticsService.onEvent(methodCall, result);
                break;
            case enableLog:
                analyticsService.enableLog(result);
                break;
            case enableLogWithLevel:
                analyticsService.enableLogWithLevel(methodCall, result);
                break;
            case enableLogger:
                analyticsService.enableLogger(result);
                break;
            case disableLogger:
                analyticsService.disableLogger(result);
                break;
            default:
                result.error("platformError", "Not supported on Android platform", "");
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        if (channel != null) {
            channel.setMethodCallHandler(null);
            channel = null;
        }
        analyticsService = null;
    }

    private enum Methods {
        clearCachedData,
        setAnalyticsEnabled,
        getAAID,
        getUserProfiles,
        pageStart,
        pageEnd,
        setMinActivitySessions,
        setPushToken,
        setSessionDuration,
        setUserId,
        setUserProfile,
        onEvent,
        enableLog,
        enableLogWithLevel,
        enableLogger,
        disableLogger,
    }
}
