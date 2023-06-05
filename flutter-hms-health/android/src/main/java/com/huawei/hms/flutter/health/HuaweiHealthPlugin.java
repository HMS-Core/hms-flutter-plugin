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

package com.huawei.hms.flutter.health;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.health.foundation.constants.Channel;
import com.huawei.hms.flutter.health.modules.activityrecord.ActivityRecordsMethodHandler;
import com.huawei.hms.flutter.health.modules.appinfo.AppInfoMethodHandler;
import com.huawei.hms.flutter.health.modules.auth.HealthAuthMethodHandler;
import com.huawei.hms.flutter.health.modules.autorecorder.AutoRecorderMethodHandler;
import com.huawei.hms.flutter.health.modules.autorecorder.service.AutoRecorderStreamHandler;
import com.huawei.hms.flutter.health.modules.datacontroller.DataControllerMethodHandler;
import com.huawei.hms.flutter.health.modules.healthcontroller.HealthControllerMethodHandler;
import com.huawei.hms.flutter.health.modules.settingcontroller.SettingControllerMethodHandler;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;

public class HuaweiHealthPlugin implements FlutterPlugin, ActivityAware {
    private ActivityPluginBinding mActivityBinding;

    private MethodChannel authMethodChannel;

    private MethodChannel activityRecordMethodChannel;

    private MethodChannel dataControllerMethodChannel;

    private MethodChannel settingControllerMethodChannel;

    private MethodChannel autoRecorderMethodChannel;

    private MethodChannel bleControllerMethodChannel;

    private MethodChannel appInfoMethodChannel;

    private MethodChannel healthControllerMethodChannel;

    private EventChannel autoRecorderEventChannel;

    private HealthAuthMethodHandler authMethodHandler;

    private ActivityRecordsMethodHandler activityRecordsMethodHandler;

    private DataControllerMethodHandler dataControllerMethodHandler;

    private SettingControllerMethodHandler settingControllerMethodHandler;

    private AutoRecorderMethodHandler autoRecorderMethodHandler;

    private HealthControllerMethodHandler healthControllerMethodHandler;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        initChannels(flutterPluginBinding.getBinaryMessenger());
        setHandlers();
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        mActivityBinding = binding;
        setupActivity(mActivityBinding.getActivity());
        mActivityBinding.addActivityResultListener(authMethodHandler);
        mActivityBinding.addActivityResultListener(settingControllerMethodHandler);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        teardownActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        onAttachedToActivity(binding);
    }

    @Override
    public void onDetachedFromActivity() {
        teardownActivity();
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        teardownChannels();
    }

    private void initChannels(BinaryMessenger messenger) {
        authMethodChannel = new MethodChannel(messenger, Channel.HMS_HEALTH_AUTH_METHOD_CHANNEL);
        activityRecordMethodChannel = new MethodChannel(messenger, Channel.HMS_HEALTH_ACTIVITY_RECORDS_CHANNEL);
        dataControllerMethodChannel = new MethodChannel(messenger, Channel.HMS_HEALTH_DATA_CONTROLLER_METHOD_CHANNEL);
        settingControllerMethodChannel = new MethodChannel(messenger,
            Channel.HMS_HEALTH_SETTING_CONTROLLER_METHOD_CHANNEL);
        autoRecorderMethodChannel = new MethodChannel(messenger, Channel.HMS_HEALTH_AUTO_RECORDER_METHOD_CHANNEL);
        autoRecorderEventChannel = new EventChannel(messenger, Channel.HMS_HEALTH_AUTO_RECORDER_EVENT_CHANNEL);
        bleControllerMethodChannel = new MethodChannel(messenger, Channel.HMS_HEALTH_BLE_CONTROLLER_METHOD_CHANNEL);
        appInfoMethodChannel = new MethodChannel(messenger, Channel.HMS_HEALTH_APP_INFO_METHOD_CHANNEL);
        healthControllerMethodChannel = new MethodChannel(messenger,
            Channel.HMS_HEALTH_HEALTH_CONTROLLER_METHOD_CHANNEL);
    }

    private void setHandlers() {
        authMethodHandler = new HealthAuthMethodHandler(null);
        authMethodChannel.setMethodCallHandler(authMethodHandler);

        activityRecordsMethodHandler = new ActivityRecordsMethodHandler(null);
        activityRecordMethodChannel.setMethodCallHandler(activityRecordsMethodHandler);

        dataControllerMethodHandler = new DataControllerMethodHandler(null);
        dataControllerMethodChannel.setMethodCallHandler(dataControllerMethodHandler);

        settingControllerMethodHandler = new SettingControllerMethodHandler(null);
        settingControllerMethodChannel.setMethodCallHandler(settingControllerMethodHandler);

        autoRecorderMethodHandler = new AutoRecorderMethodHandler(null);
        autoRecorderMethodChannel.setMethodCallHandler(autoRecorderMethodHandler);

        appInfoMethodChannel.setMethodCallHandler(new AppInfoMethodHandler());

        healthControllerMethodHandler = new HealthControllerMethodHandler(null);
        healthControllerMethodChannel.setMethodCallHandler(healthControllerMethodHandler);
    }

    private void setupActivity(Activity activity) {
        authMethodHandler.setActivity(activity);
        activityRecordsMethodHandler.setActivity(activity);
        dataControllerMethodHandler.setActivity(activity);
        settingControllerMethodHandler.setActivity(activity);
        autoRecorderMethodHandler.setActivity(activity);
        healthControllerMethodHandler.setActivity(activity);
        autoRecorderEventChannel.setStreamHandler(new AutoRecorderStreamHandler(activity.getApplicationContext()));
    }

    private void teardownActivity() {
        authMethodHandler.setActivity(null);
        activityRecordsMethodHandler.setActivity(null);
        dataControllerMethodHandler.setActivity(null);
        settingControllerMethodHandler.setActivity(null);
        autoRecorderMethodHandler.unregisterReceiver();
        autoRecorderMethodHandler.setActivity(null);
        autoRecorderEventChannel.setStreamHandler(null);
        if (mActivityBinding != null) {
            mActivityBinding.removeActivityResultListener(authMethodHandler);
            mActivityBinding = null;
        }
    }

    private void teardownChannels() {
        authMethodChannel.setMethodCallHandler(null);
        activityRecordMethodChannel.setMethodCallHandler(null);
        dataControllerMethodChannel.setMethodCallHandler(null);
        settingControllerMethodChannel.setMethodCallHandler(null);
        autoRecorderMethodChannel.setMethodCallHandler(null);
        bleControllerMethodChannel.setMethodCallHandler(null);
        appInfoMethodChannel.setMethodCallHandler(null);
        healthControllerMethodChannel.setMethodCallHandler(null);
        authMethodChannel = null;
        activityRecordMethodChannel = null;
        dataControllerMethodChannel = null;
        settingControllerMethodChannel = null;
        autoRecorderMethodChannel = null;
        autoRecorderEventChannel = null;
        bleControllerMethodChannel = null;
        appInfoMethodChannel = null;
        healthControllerMethodChannel = null;
    }
}
