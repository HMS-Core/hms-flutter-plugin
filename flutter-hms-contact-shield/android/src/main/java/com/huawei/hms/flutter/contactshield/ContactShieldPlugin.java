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

package com.huawei.hms.flutter.contactshield;

import android.content.BroadcastReceiver;

import androidx.annotation.NonNull;

import com.huawei.hms.contactshield.ContactShieldCallback;
import com.huawei.hms.flutter.contactshield.handlers.ContactShieldBroadcastReceiver;
import com.huawei.hms.flutter.contactshield.handlers.ContactShieldCallbackHandler;
import com.huawei.hms.flutter.contactshield.handlers.ContactShieldMethodCallHandler;
import com.huawei.hms.flutter.contactshield.utils.ObjectProvider;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;

public class ContactShieldPlugin implements FlutterPlugin, ActivityAware {
    private MethodChannel channel;
    private MethodCallHandler handler;
    private BroadcastReceiver receiver;
    private ContactShieldCallback callback;

    @Override
    public void onAttachedToEngine(@NonNull final FlutterPluginBinding binding) {
        channel = new MethodChannel(binding.getBinaryMessenger(),
                "com.huawei.hms.flutter.contactshield_MethodChannel");
        callback = new ContactShieldCallbackHandler(channel);
        receiver = new ContactShieldBroadcastReceiver(binding.getApplicationContext(), callback);
        binding.getApplicationContext().registerReceiver(receiver, ObjectProvider.getIntentFilter());
    }

    @Override
    public void onDetachedFromEngine(@NonNull final FlutterPluginBinding binding) {
        binding.getApplicationContext().unregisterReceiver(receiver);
        receiver = null;
        callback = null;
        channel = null;
    }

    @Override
    public void onAttachedToActivity(@NonNull final ActivityPluginBinding binding) {
        handler = new ContactShieldMethodCallHandler(binding.getActivity());
        if (channel != null) {
            channel.setMethodCallHandler(handler);
        }
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
        if (channel != null) {
            channel.setMethodCallHandler(null);
        }
        handler = null;
    }
}
