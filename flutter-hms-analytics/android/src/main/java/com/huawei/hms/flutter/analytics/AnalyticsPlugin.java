/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.analytics;

import android.content.Context;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.analytics.handler.HMSAnalyticsMethodCallHandler;

import java.lang.ref.WeakReference;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

public class AnalyticsPlugin implements FlutterPlugin {
    private HMSAnalyticsMethodCallHandler analyticsMethodCallHandler;
    private MethodChannel channel;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        onAttachedToEngine(flutterPluginBinding.getApplicationContext(), flutterPluginBinding.getBinaryMessenger());
    }

    private void onAttachedToEngine(Context applicationContext, BinaryMessenger messenger) {
        WeakReference<Context> weakContext = new WeakReference<>(applicationContext);
        channel = new MethodChannel(messenger, "com.huawei.hms.flutter.analytics");
        analyticsMethodCallHandler = new HMSAnalyticsMethodCallHandler(weakContext);
        channel.setMethodCallHandler(analyticsMethodCallHandler);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        if (channel != null) {
            channel.setMethodCallHandler(null);
            channel = null;
        }
        analyticsMethodCallHandler = null;
    }
}
