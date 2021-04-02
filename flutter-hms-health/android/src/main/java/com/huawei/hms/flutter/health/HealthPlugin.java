/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.health;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.health.foundation.constants.Channel;
import com.huawei.hms.flutter.health.modules.activityrecord.ActivityRecordsMethodHandler;
import com.huawei.hms.flutter.health.modules.auth.HealthAuthMethodHandler;
import com.huawei.hms.flutter.health.modules.autorecorder.AutoRecorderMethodHandler;
import com.huawei.hms.flutter.health.modules.autorecorder.service.AutoRecorderStreamHandler;
import com.huawei.hms.flutter.health.modules.blecontroller.BleControllerMethodHandler;
import com.huawei.hms.flutter.health.modules.blecontroller.service.BleScanStreamHandler;
import com.huawei.hms.flutter.health.modules.datacontroller.DataControllerMethodHandler;
import com.huawei.hms.flutter.health.modules.settingcontroller.SettingControllerMethodHandler;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * HealthPlugin
 *
 * @since 5.0.5
 */
public class HealthPlugin implements FlutterPlugin, ActivityAware {
    private MethodChannel authMethodChannel;
    private MethodChannel activityRecordMethodChannel;
    private MethodChannel dataControllerMethodChannel;
    private MethodChannel settingControllerMethodChannel;
    private MethodChannel autoRecorderMethodChannel;
    private MethodChannel bleControllerMethodChannel;
    private EventChannel autoRecorderEventChannel;
    private EventChannel bleControllerEventChannel;

    private HealthAuthMethodHandler authMethodHandler;
    private ActivityRecordsMethodHandler activityRecordsMethodHandler;
    private DataControllerMethodHandler dataControllerMethodHandler;
    private SettingControllerMethodHandler settingControllerMethodHandler;
    private AutoRecorderMethodHandler autoRecorderMethodHandler;
    private BleControllerMethodHandler bleControllerMethodHandler;

    private ActivityPluginBinding mActivityBinding;

    private void initChannels(final BinaryMessenger messenger) {
        authMethodChannel = new MethodChannel(messenger, Channel.HMS_HEALTH_AUTH_METHOD_CHANNEL);
        activityRecordMethodChannel = new MethodChannel(messenger, Channel.HMS_HEALTH_ACTIVITY_RECORDS_CHANNEL);
        dataControllerMethodChannel = new MethodChannel(messenger, Channel.HMS_HEALTH_DATA_CONTROLLER_METHOD_CHANNEL);
        settingControllerMethodChannel = new MethodChannel(messenger,
            Channel.HMS_HEALTH_SETTING_CONTROLLER_METHOD_CHANNEL);
        autoRecorderMethodChannel = new MethodChannel(messenger, Channel.HMS_HEALTH_AUTO_RECORDER_METHOD_CHANNEL);
        autoRecorderEventChannel = new EventChannel(messenger, Channel.HMS_HEALTH_AUTO_RECORDER_EVENT_CHANNEL);
        bleControllerMethodChannel = new MethodChannel(messenger, Channel.HMS_HEALTH_BLE_CONTROLLER_METHOD_CHANNEL);
        bleControllerEventChannel = new EventChannel(messenger, Channel.HMS_HEALTH_BLE_CONTROLLER_EVENT_CHANNEL);
        setHandlers();
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

        bleControllerMethodHandler = new BleControllerMethodHandler(null);
        bleControllerMethodChannel.setMethodCallHandler(bleControllerMethodHandler);
    }

    private void teardownChannels() {
        authMethodChannel.setMethodCallHandler(null);
        activityRecordMethodChannel.setMethodCallHandler(null);
        dataControllerMethodChannel.setMethodCallHandler(null);
        settingControllerMethodChannel.setMethodCallHandler(null);
        autoRecorderMethodChannel.setMethodCallHandler(null);
        bleControllerMethodChannel.setMethodCallHandler(null);
        authMethodChannel = null;
        activityRecordMethodChannel = null;
        dataControllerMethodChannel = null;
        settingControllerMethodChannel = null;
        autoRecorderMethodChannel = null;
        autoRecorderEventChannel = null;
        bleControllerMethodChannel = null;
    }

    private void setupActivity(Activity activity) {
        authMethodHandler.setActivity(activity);
        activityRecordsMethodHandler.setActivity(activity);
        dataControllerMethodHandler.setActivity(activity);
        settingControllerMethodHandler.setActivity(activity);
        autoRecorderMethodHandler.setActivity(activity);
        autoRecorderEventChannel.setStreamHandler(new AutoRecorderStreamHandler(activity.getApplicationContext()));
        bleControllerMethodHandler.setActivity(activity);
        bleControllerEventChannel.setStreamHandler(new BleScanStreamHandler(activity.getApplicationContext()));
    }

    private void teardownActivity() {
        authMethodHandler.setActivity(null);
        activityRecordsMethodHandler.setActivity(null);
        dataControllerMethodHandler.setActivity(null);
        settingControllerMethodHandler.setActivity(null);
        autoRecorderMethodHandler.unregisterReceiver();
        autoRecorderMethodHandler.setActivity(null);
        autoRecorderEventChannel.setStreamHandler(null);
        bleControllerMethodHandler.setActivity(null);
        bleControllerEventChannel.setStreamHandler(null);
        if (mActivityBinding != null) {
            mActivityBinding.removeActivityResultListener(authMethodHandler);
            mActivityBinding = null;
        }
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        initChannels(flutterPluginBinding.getBinaryMessenger());
    }

    public static void registerWith(Registrar registrar) {
        HealthPlugin healthPlugin = new HealthPlugin();
        healthPlugin.initChannels(registrar.messenger());
        healthPlugin.setupActivity(registrar.activity());
        registrar.addActivityResultListener(healthPlugin.authMethodHandler);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        teardownChannels();
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        mActivityBinding = binding;
        setupActivity(mActivityBinding.getActivity());
        mActivityBinding.addActivityResultListener(authMethodHandler);
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

}
