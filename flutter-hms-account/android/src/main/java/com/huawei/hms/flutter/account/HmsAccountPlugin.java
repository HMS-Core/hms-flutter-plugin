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


package com.huawei.hms.flutter.account;

import android.app.Activity;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class HmsAccountPlugin implements FlutterPlugin, ActivityAware {
    private MethodChannel methodChannel;

    public static void registerWith(Registrar registrar) {
        HmsAccountPlugin hmsAccountPlugin = new HmsAccountPlugin();
        final BinaryMessenger rMessenger = registrar.messenger();
        hmsAccountPlugin.onAttachedToEngine(rMessenger);
    }

    private void onAttachedToEngine(final BinaryMessenger messenger) {
        initializeChannels(messenger);
    }

    private void initializeChannels(final BinaryMessenger messenger) {
        methodChannel = new MethodChannel(messenger, "huawei_account");
    }

    @Override
    public void onAttachedToEngine(FlutterPluginBinding flutterPluginBinding) {
        onAttachedToEngine(flutterPluginBinding.getBinaryMessenger());
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        methodChannel.setMethodCallHandler(null);
        methodChannel = null;
    }

    @Override
    public void onAttachedToActivity(ActivityPluginBinding activityPluginBinding) {
        final Activity activity = activityPluginBinding.getActivity();
        MethodHandler methodHandler = new MethodHandler(activity, methodChannel);
        activityPluginBinding.addActivityResultListener(methodHandler);
        methodChannel.setMethodCallHandler(methodHandler);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding activityPluginBinding) {
        onAttachedToActivity(activityPluginBinding);
    }

    @Override
    public void onDetachedFromActivity() {
        methodChannel.setMethodCallHandler(null);
        methodChannel = null;
    }
}
