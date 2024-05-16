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

package com.huawei.hms.flutter.awareness;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.awareness.barriers.BarrierMethodCallHandler;
import com.huawei.hms.flutter.awareness.barriers.BarrierStreamHandler;
import com.huawei.hms.flutter.awareness.capture.CaptureMethodCallHandler;
import com.huawei.hms.flutter.awareness.constants.Channel;
import com.huawei.hms.flutter.awareness.utils.AwarenessUtilsMethodCallHandler;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.EventChannel.StreamHandler;
import io.flutter.plugin.common.MethodChannel;

public class AwarenessPlugin implements FlutterPlugin, ActivityAware {

    private MethodChannel captureChannel;
    private CaptureMethodCallHandler captureHandler;

    private MethodChannel barrierChannel;
    private BarrierMethodCallHandler barrierHandler;

    private EventChannel barrierListenerChannel;
    private StreamHandler barrierListenerHandler;

    private MethodChannel utilsChannel;
    private AwarenessUtilsMethodCallHandler utilsHandler;

    private void initChannels(final BinaryMessenger messenger) {
        captureChannel = new MethodChannel(messenger, Channel.CAPTURE_CHANNEL);
        barrierChannel = new MethodChannel(messenger, Channel.BARRIER_CHANNEL);
        barrierListenerChannel = new EventChannel(messenger, Channel.BARRIER_LISTENER_CHANNEL);
        utilsChannel = new MethodChannel(messenger, Channel.UTILS_CHANNEL);
    }

    private void initHandlers(final Context context) {
        captureHandler = new CaptureMethodCallHandler(context);
        barrierHandler = new BarrierMethodCallHandler(context);
        barrierListenerHandler = new BarrierStreamHandler(context);
        utilsHandler = new AwarenessUtilsMethodCallHandler(context);
    }

    private void setHandlers() {
        captureChannel.setMethodCallHandler(captureHandler);
        barrierChannel.setMethodCallHandler(barrierHandler);
        barrierListenerChannel.setStreamHandler(barrierListenerHandler);
        utilsChannel.setMethodCallHandler(utilsHandler);
    }

    private void resetHandlers() {
        captureChannel.setMethodCallHandler(null);
        barrierChannel.setMethodCallHandler(null);
        barrierListenerChannel.setStreamHandler(null);
        utilsChannel.setMethodCallHandler(null);
    }

    private void removeHandlers() {
        captureHandler = null;
        barrierHandler = null;
        barrierListenerHandler = null;
        utilsHandler = null;
    }

    private void removeChannels() {
        captureChannel = null;
        barrierChannel = null;
        barrierListenerChannel = null;
        utilsChannel = null;
    }

    private void onAttachedToEngine(@NonNull final BinaryMessenger messenger, final Context context) {
        initChannels(messenger);
        initHandlers(context);
        setHandlers();
    }

    @Override
    public void onAttachedToEngine(@NonNull final FlutterPluginBinding binding) {
        onAttachedToEngine(binding.getBinaryMessenger(), binding.getApplicationContext());
    }

    @Override
    public void onDetachedFromEngine(@NonNull final FlutterPluginBinding binding) {
        removeChannels();
    }

    @Override
    public void onAttachedToActivity(@NonNull final ActivityPluginBinding binding) {
        final Activity activity = binding.getActivity();

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
        resetHandlers();
        removeHandlers();
    }
}