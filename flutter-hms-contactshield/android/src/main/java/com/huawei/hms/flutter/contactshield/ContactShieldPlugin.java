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
    private static final String TAG = "ContactShieldPlugin";
    private MethodChannel channel;
    private MethodCallHandler handler;
    private BroadcastReceiver receiver;
    private ContactShieldCallback callback;

    @Override
    public void onAttachedToEngine(@NonNull final FlutterPluginBinding binding) {
        this.channel = new MethodChannel(binding.getBinaryMessenger(),
            "com.huawei.hms.flutter.contactshield_MethodChannel");
        this.callback = new ContactShieldCallbackHandler(this.channel);
        this.receiver = new ContactShieldBroadcastReceiver(binding.getApplicationContext(), this.callback);
        binding.getApplicationContext().registerReceiver(this.receiver, ObjectProvider.getIntentFilter());
    }

    @Override
    public void onDetachedFromEngine(@NonNull final FlutterPluginBinding binding) {
        binding.getApplicationContext().unregisterReceiver(this.receiver);
        this.receiver = null;
        this.callback = null;
        this.channel = null;
    }

    @Override
    public void onAttachedToActivity(@NonNull final ActivityPluginBinding binding) {
        this.handler = new ContactShieldMethodCallHandler(binding.getActivity());
        if (this.channel != null) {
            this.channel.setMethodCallHandler(this.handler);
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
        if (this.channel != null) {
            this.channel.setMethodCallHandler(null);
        }
        this.handler = null;
    }
}
