/*
 * Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.huawei.hms.flutter.dtm;

import android.content.Context;
import android.util.Log;
import android.util.SparseArray;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class DTMPlugin implements FlutterPlugin, MethodCallHandler {
    private static final String TAG = "HmsFlutterDTM";
    public static final String METHOD_CHANNEL_NAME = "com.huawei.hms.flutter.dtm/method";
    public static final SparseArray<MethodChannel> CHANNELS = new SparseArray<>();
    private static final Map<String, String> ALL_RETURN_VALUES = new HashMap<>();
    private static FlutterPluginBinding pluginBinding;
    private MethodChannel channel;
    private DTMService dtmService;

    public static Context getContext() {
        if (pluginBinding != null) {
            return pluginBinding.getApplicationContext();
        } else {
            Log.e(TAG, "pluginBinding is null.");
            return null;
        }
    }

    public static Map<String, String> getMap() {
        return ALL_RETURN_VALUES;
    }

    private static void setPluginBinding(final FlutterPluginBinding flutterPluginBinding) {
        pluginBinding = flutterPluginBinding;
    }

    @Override
    public void onAttachedToEngine(@NonNull final FlutterPluginBinding flutterPluginBinding) {
        setPluginBinding(flutterPluginBinding);
        onAttachedToEngine(flutterPluginBinding.getApplicationContext(), flutterPluginBinding.getBinaryMessenger());
    }

    private void onAttachedToEngine(final Context applicationContext, final BinaryMessenger messenger) {
        dtmService = new DTMService(applicationContext);
        channel = new MethodChannel(messenger, METHOD_CHANNEL_NAME);
        channel.setMethodCallHandler(this);
        CHANNELS.put(0, channel);
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        Log.i(TAG, "Running method: " + call.method);
        switch (call.method) {
            case "onEvent":
                dtmService.onEvent(call, result);
                break;
            case "setCustomVariable":
                dtmService.setCustomVariable(call, result);
                break;
            case "enableLogger":
                dtmService.enableLogger(result);
                break;
            case "disableLogger":
                dtmService.disableLogger(result);
                break;
            default:
                result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull final FlutterPluginBinding binding) {
        if (channel != null) {
            channel.setMethodCallHandler(null);
        }
        setPluginBinding(null);
        channel = null;
        dtmService = null;
        CHANNELS.clear();
    }

}

