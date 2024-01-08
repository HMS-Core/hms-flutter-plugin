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

package com.huawei.hms.flutter.health.modules.autorecorder.service;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.IntentFilter;

import com.huawei.hms.flutter.health.modules.autorecorder.listener.AutoRecorderBroadcastReceiver;
import com.huawei.hms.flutter.health.modules.autorecorder.utils.AutoRecorderConstants;

import io.flutter.plugin.common.EventChannel.EventSink;
import io.flutter.plugin.common.EventChannel.StreamHandler;

public class AutoRecorderStreamHandler implements StreamHandler {
    private Context context;

    private BroadcastReceiver autoRecorderReceiver;

    public AutoRecorderStreamHandler(Context context) {
        this.context = context;
    }

    @Override
    public void onListen(Object arguments, EventSink events) {
        autoRecorderReceiver = new AutoRecorderBroadcastReceiver(events);
        context.registerReceiver(autoRecorderReceiver,
            new IntentFilter(AutoRecorderConstants.AUTO_RECORDER_INTENT_ACTION));
    }

    @Override
    public void onCancel(Object arguments) {
        context.unregisterReceiver(autoRecorderReceiver);
    }
}
