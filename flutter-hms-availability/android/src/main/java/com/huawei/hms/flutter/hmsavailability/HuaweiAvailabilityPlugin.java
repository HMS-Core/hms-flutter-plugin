/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.hmsavailability;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.hmsavailability.handlers.HmsAvailabilityHandler;
import com.huawei.hms.flutter.hmsavailability.utils.Constants;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

public class HuaweiAvailabilityPlugin implements FlutterPlugin, ActivityAware {
    private FlutterPluginBinding mFlutterPluginBinding;
    private ActivityPluginBinding mActivityPluginBinding;

    private MethodChannel hmsAvailabilityChannel;

    private void onAttachedToEngine(final BinaryMessenger messenger, final Activity activity) {
        initChannels(messenger);
        setHandlers(activity, messenger);
    }

    private void initChannels(BinaryMessenger messenger) {
        hmsAvailabilityChannel = new MethodChannel(messenger, Constants.HMS_METHOD);
    }

    private void setHandlers(Activity activity, BinaryMessenger messenger) {
        HmsAvailabilityHandler hmsAvailabilityHandler = new HmsAvailabilityHandler(activity, messenger);
        if (mActivityPluginBinding != null) {
            mActivityPluginBinding.addActivityResultListener(hmsAvailabilityHandler);
        }
        hmsAvailabilityChannel.setMethodCallHandler(hmsAvailabilityHandler);
    }

    private void removeChannels() {
        hmsAvailabilityChannel = null;
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        this.mFlutterPluginBinding = binding;
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        this.mFlutterPluginBinding = null;
        removeChannels();
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        mActivityPluginBinding = binding;
        if (mFlutterPluginBinding != null) {
            onAttachedToEngine(mFlutterPluginBinding.getBinaryMessenger(), binding.getActivity());
        }
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        mActivityPluginBinding = binding;
        if (mFlutterPluginBinding != null) {
            onAttachedToEngine(mFlutterPluginBinding.getBinaryMessenger(), binding.getActivity());
        }
    }

    @Override
    public void onDetachedFromActivity() {
        hmsAvailabilityChannel.setMethodCallHandler(null);
        mActivityPluginBinding = null;
    }
}
