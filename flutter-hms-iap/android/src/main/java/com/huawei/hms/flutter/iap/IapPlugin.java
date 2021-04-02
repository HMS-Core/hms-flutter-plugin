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

package com.huawei.hms.flutter.iap;

import android.app.Activity;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class IapPlugin implements FlutterPlugin, ActivityAware {
    private MethodChannel mMethodChannel;
    private MethodCallHandlerImpl mMethodCallHandler;

    public static void registerWith(final Registrar registrar) {
        final IapPlugin instance = new IapPlugin();
        final Activity activity = registrar.activity();
        final BinaryMessenger messenger = registrar.messenger();
        instance.onAttachedToEngine(messenger);
        instance.mMethodCallHandler = new MethodCallHandlerImpl(activity);
        instance.mMethodChannel.setMethodCallHandler(instance.mMethodCallHandler);
    }

    private void onAttachedToEngine(@NonNull BinaryMessenger messenger) {
        mMethodChannel = new MethodChannel(messenger, "IapClient");
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        onAttachedToEngine(binding.getBinaryMessenger());
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        mMethodChannel = null;
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        final Activity activity = binding.getActivity();
        mMethodCallHandler = new MethodCallHandlerImpl(activity);
        mMethodChannel.setMethodCallHandler(mMethodCallHandler);
        binding.addActivityResultListener(mMethodCallHandler);
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
        mMethodChannel.setMethodCallHandler(null);
        mMethodCallHandler = null;
    }
}
