/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.scan;

import android.app.Activity;
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.scan.customizedview.CustomizedViewMethodCallHandler;
import com.huawei.hms.flutter.scan.multiprocessor.MultiProcessorMethodCallHandler;
import com.huawei.hms.flutter.scan.scanutils.ScanUtilsMethodCallHandler;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

public class ScanPlugin implements FlutterPlugin, ActivityAware {
    public final static SparseArray<MethodChannel> SCAN_CHANNELS = new SparseArray<>();

    private Activity activity;

    private FlutterPluginBinding flutterPluginBinding;

    private MethodChannel scanUtilsChannel;

    private ScanUtilsMethodCallHandler scanUtilsMethodCallHandler;

    private MethodChannel multiProcessorChannel;

    private MultiProcessorMethodCallHandler multiProcessorMethodCallHandler;

    private MethodChannel customizedViewChannel;

    private CustomizedViewMethodCallHandler customizedViewMethodCallHandler;

    private MethodChannel remoteViewChannel;

    private void initChannels(final BinaryMessenger messenger) {
        // init channels
        scanUtilsChannel = new MethodChannel(messenger, "scanUtilsChannel");
        multiProcessorChannel = new MethodChannel(messenger, "multiProcessorChannel");
        customizedViewChannel = new MethodChannel(messenger, "customizedViewChannel");
        remoteViewChannel = new MethodChannel(messenger, "remoteViewChannel");
    }

    private void initHandlers() {
        scanUtilsMethodCallHandler = new ScanUtilsMethodCallHandler(activity,scanUtilsChannel);
        multiProcessorMethodCallHandler = new MultiProcessorMethodCallHandler(activity, multiProcessorChannel);
        customizedViewMethodCallHandler = new CustomizedViewMethodCallHandler(activity, customizedViewChannel,
            remoteViewChannel);
    }

    private void setHandlers() {
        scanUtilsChannel.setMethodCallHandler(scanUtilsMethodCallHandler);
        multiProcessorChannel.setMethodCallHandler(multiProcessorMethodCallHandler);
        customizedViewChannel.setMethodCallHandler(customizedViewMethodCallHandler);
    }

    private void resetHandlers() {
        if (scanUtilsChannel != null) {
            scanUtilsChannel.setMethodCallHandler(null);
        }
        if (multiProcessorChannel != null) {
            multiProcessorChannel.setMethodCallHandler(null);
        }
        if (customizedViewChannel != null) {
            customizedViewChannel.setMethodCallHandler(null);
        }
        if (remoteViewChannel != null) {
            remoteViewChannel.setMethodCallHandler(null);
        }
    }

    private void removeHandlers() {
        scanUtilsMethodCallHandler = null;
        multiProcessorMethodCallHandler = null;
        customizedViewMethodCallHandler = null;
    }

    private void removeChannels() {
        // remove channels
        scanUtilsChannel = null;
        multiProcessorChannel = null;
        customizedViewChannel = null;
        remoteViewChannel = null;
        SCAN_CHANNELS.clear();
    }

    private void onAttachedToEngine(final BinaryMessenger messenger, Activity activity) {
        this.activity = activity;
        initChannels(messenger);
        initHandlers();
        setHandlers();
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        this.flutterPluginBinding = flutterPluginBinding;
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        this.flutterPluginBinding = null;
        resetHandlers();
        removeHandlers();
        removeChannels();
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        if (flutterPluginBinding != null) {
            onAttachedToEngine(flutterPluginBinding.getBinaryMessenger(), binding.getActivity());
            binding.addActivityResultListener(scanUtilsMethodCallHandler);
            binding.addActivityResultListener(multiProcessorMethodCallHandler);
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
        resetHandlers();
        removeHandlers();
        removeChannels();
    }
}
