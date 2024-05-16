/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.site;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.site.handlers.MethodCallHandlerImp;
import com.huawei.hms.flutter.site.services.SiteService;
import com.huawei.hms.flutter.site.utils.HMSLogger;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

public class SitePlugin implements FlutterPlugin, ActivityAware {
    private MethodChannel methodChannel;
    private MethodChannel.MethodCallHandler methodCallHandler;
    private HMSLogger hmsLogger;
    private SiteService service;

    private void onAttachedToEngine(@NonNull final BinaryMessenger messenger, @NonNull final Context context) {
        methodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.site/MethodChannel");
        hmsLogger = HMSLogger.getInstance(context);
    }

    private void onDetachedFromEngine() {
        hmsLogger = null;
        methodChannel = null;
    }

    private void onAttachedToActivity(@NonNull final Activity activity) {
        service = new SiteService(activity);
        methodCallHandler = new MethodCallHandlerImp(hmsLogger, service);
        if (methodChannel != null) {
            methodChannel.setMethodCallHandler(methodCallHandler);
        }
    }

    @Override
    public void onAttachedToEngine(@NonNull final FlutterPluginBinding binding) {
        onAttachedToEngine(binding.getBinaryMessenger(), binding.getApplicationContext());
    }

    @Override
    public void onDetachedFromEngine(@NonNull final FlutterPluginBinding binding) {
        onDetachedFromEngine();
    }

    @Override
    public void onAttachedToActivity(@NonNull final ActivityPluginBinding binding) {
        onAttachedToActivity(binding.getActivity());
        binding.addActivityResultListener(service);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull final ActivityPluginBinding binding) {
        onAttachedToActivity(binding);
    }

    @Override
    public void onDetachedFromActivity() {
        if (methodChannel != null) {
            methodChannel.setMethodCallHandler(null);
        }
        methodCallHandler = null;
        service = null;
    }
}
