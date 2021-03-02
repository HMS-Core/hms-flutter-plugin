/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.gameservice;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.api.HuaweiMobileServicesUtil;
import com.huawei.hms.flutter.gameservice.common.Constants;
import com.huawei.hms.flutter.gameservice.controllers.GameServiceController;
import com.huawei.hms.jos.JosApps;
import com.huawei.hms.jos.JosAppsClient;

import io.flutter.Log;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class HuaweiGameServicePlugin implements FlutterPlugin, ActivityAware {
    private static final String TAG = "HuaweiGameServicePlugin";

    private Activity activity;

    private MethodChannel gameServiceChannel;

    public static void registerWith(Registrar registrar) {
        HuaweiMobileServicesUtil.setApplication(registrar.activity().getApplication());
        JosAppsClient appsClient = JosApps.getJosAppsClient(registrar.activity());
        appsClient.init();
        final MethodChannel gameServiceChannel = new MethodChannel(registrar.messenger(),
            Constants.Channel.GAME_SERVICE_METHOD_CHANNEL);
        gameServiceChannel.setMethodCallHandler(new GameServiceController(registrar.activity(), gameServiceChannel));
    }

    private void init() {
        JosAppsClient appsClient = JosApps.getJosAppsClient(activity);
        appsClient.init();
        Log.i(TAG, "init success");
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        gameServiceChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(),
            Constants.Channel.GAME_SERVICE_METHOD_CHANNEL);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        if (gameServiceChannel != null) {
            gameServiceChannel.setMethodCallHandler(null);
            teardownMethodChannel(gameServiceChannel);
        }
    }

    @Override
    public void onAttachedToActivity(ActivityPluginBinding binding) {
        this.activity = binding.getActivity();
        HuaweiMobileServicesUtil.setApplication(activity.getApplication());
        init();
        if (gameServiceChannel != null) {
            gameServiceChannel.setMethodCallHandler(new GameServiceController(activity, gameServiceChannel));
        }
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        onAttachedToActivity(binding);
    }

    @Override
    public void onDetachedFromActivity() {
        if (activity != null) {
            activity = null;
        }
    }

    private void teardownMethodChannel(final MethodChannel channel) {
        if (channel != null) {
            channel.setMethodCallHandler(null);
        }
    }
}
