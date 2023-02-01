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

package com.huawei.hms.flutter.ar;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ar.constants.Channel;
import com.huawei.hms.flutter.ar.constants.Constants;
import com.huawei.hms.flutter.ar.handlers.AREngineCommonHandler;
import com.huawei.hms.flutter.ar.view.ARSceneViewFactory;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

public class AREnginePlugin implements FlutterPlugin, ActivityAware {
    private FlutterPluginBinding pluginBinding;

    private MethodChannel arEngineCommonChannel;

    private AREngineCommonHandler arEngineCommonHandler;

    private Activity activity;

    private void initChannels(BinaryMessenger messenger) {
        arEngineCommonChannel = new MethodChannel(messenger, Channel.AR_ENGINE_COMMON);
    }

    private void initHandlers() {
        if (arEngineCommonHandler == null) {
            arEngineCommonHandler = new AREngineCommonHandler(activity);
            arEngineCommonChannel.setMethodCallHandler(arEngineCommonHandler);
        }
    }

    private void removeChannels() {
        arEngineCommonChannel = null;
    }

    private void removeHandlers() {
        if (arEngineCommonChannel != null) {
            arEngineCommonChannel.setMethodCallHandler(null);
        }
        arEngineCommonHandler = null;
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        initChannels(flutterPluginBinding.getBinaryMessenger());
        this.pluginBinding = flutterPluginBinding;
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        removeHandlers();
        removeChannels();
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding activityBinding) {
        this.activity = activityBinding.getActivity();
        initHandlers();
        if (pluginBinding != null) {
            ARSceneViewFactory arSceneViewFactory = new ARSceneViewFactory(pluginBinding.getBinaryMessenger(),
                activity);
            pluginBinding.getPlatformViewRegistry().registerViewFactory(Constants.VIEW_TYPE, arSceneViewFactory);
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
        this.activity = null;
    }
}
