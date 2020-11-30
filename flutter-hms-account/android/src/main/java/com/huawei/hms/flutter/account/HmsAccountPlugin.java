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

package com.huawei.hms.flutter.account;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.account.handlers.AuthManagerMethodHandler;
import com.huawei.hms.flutter.account.handlers.AuthServiceMethodHandler;
import com.huawei.hms.flutter.account.handlers.AuthToolMethodHandler;
import com.huawei.hms.flutter.account.handlers.NetworkToolMethodHandler;
import com.huawei.hms.flutter.account.handlers.SmsManagerMethodHandler;
import com.huawei.hms.flutter.account.logger.LoggerMethodHandler;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class HmsAccountPlugin implements FlutterPlugin, ActivityAware {
    private FlutterPluginBinding mFlutterPluginBinding;
    private ActivityPluginBinding mActivityPluginBinding;
    private MethodChannel authServiceMethodChannel;
    private MethodChannel authManagerMethodChannel;
    private MethodChannel authToolMethodChannel;
    private MethodChannel networkToolMethodChannel;
    private MethodChannel smsManagerMethodChannel;
    private MethodChannel loggerMethodChannel;

    public static void registerWith(Registrar registrar) {
        HmsAccountPlugin hmsAccountPlugin = new HmsAccountPlugin();
        registrar.publish(hmsAccountPlugin);
        hmsAccountPlugin.onAttachedToEngine(registrar.messenger(), registrar.activity());
    }

    private void onAttachedToEngine(final BinaryMessenger messenger, final Activity activity) {
        initializeChannels(messenger);
        setHandlers(activity);
    }

    private void initializeChannels(final BinaryMessenger messenger) {
        authServiceMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.account/auth/service");
        authManagerMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.account/auth/manager");
        authToolMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.account/auth/tool");
        networkToolMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.account/network/tool");
        smsManagerMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.account/sms/manager");
        loggerMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.account/logger");
    }

    private void setHandlers(Activity activity) {
        AuthServiceMethodHandler authServiceMethodHandler = new AuthServiceMethodHandler(activity);
        if (mActivityPluginBinding != null) {
            mActivityPluginBinding.addActivityResultListener(authServiceMethodHandler);
        }
        authServiceMethodChannel.setMethodCallHandler(authServiceMethodHandler);
        authManagerMethodChannel.setMethodCallHandler(new AuthManagerMethodHandler(activity));
        authToolMethodChannel.setMethodCallHandler(new AuthToolMethodHandler(activity));
        networkToolMethodChannel.setMethodCallHandler(new NetworkToolMethodHandler(activity));
        smsManagerMethodChannel.setMethodCallHandler(new SmsManagerMethodHandler(activity, smsManagerMethodChannel));
        loggerMethodChannel.setMethodCallHandler(new LoggerMethodHandler(activity));
    }

    private void removeChannels() {
        authServiceMethodChannel = null;
        authManagerMethodChannel = null;
        authToolMethodChannel = null;
        networkToolMethodChannel = null;
        smsManagerMethodChannel = null;
        loggerMethodChannel = null;
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        this.mFlutterPluginBinding = flutterPluginBinding;
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        this.mFlutterPluginBinding = null;
        removeChannels();
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding activityPluginBinding) {
        mActivityPluginBinding = activityPluginBinding;
        if (mFlutterPluginBinding != null) {
            onAttachedToEngine(mFlutterPluginBinding.getBinaryMessenger(), activityPluginBinding.getActivity());
        }
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding activityPluginBinding) {
        mActivityPluginBinding = activityPluginBinding;
        if (mFlutterPluginBinding != null) {
            onAttachedToEngine(mFlutterPluginBinding.getBinaryMessenger(), activityPluginBinding.getActivity());
        }
    }

    @Override
    public void onDetachedFromActivity() {
        authServiceMethodChannel.setMethodCallHandler(null);
        authManagerMethodChannel.setMethodCallHandler(null);
        authToolMethodChannel.setMethodCallHandler(null);
        networkToolMethodChannel.setMethodCallHandler(null);
        smsManagerMethodChannel.setMethodCallHandler(null);
        loggerMethodChannel.setMethodCallHandler(null);
        mActivityPluginBinding = null;
    }
}
