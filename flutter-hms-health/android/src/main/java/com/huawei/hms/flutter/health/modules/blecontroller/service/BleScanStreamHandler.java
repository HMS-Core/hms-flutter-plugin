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

package com.huawei.hms.flutter.health.modules.blecontroller.service;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.IntentFilter;

import com.huawei.hms.flutter.health.modules.blecontroller.listener.BleScanBroadcastReceiver;
import com.huawei.hms.flutter.health.modules.blecontroller.utils.BleControllerConstants;

import io.flutter.plugin.common.EventChannel.EventSink;
import io.flutter.plugin.common.EventChannel.StreamHandler;

public class BleScanStreamHandler implements StreamHandler {
    private Context context;
    private BroadcastReceiver bleScanBroadcastReceiver;

    public BleScanStreamHandler(Context context) {
        this.context = context;
    }

    @Override
    public void onListen(Object arguments, EventSink events) {
        bleScanBroadcastReceiver = new BleScanBroadcastReceiver(events);
        context.registerReceiver(bleScanBroadcastReceiver,
            new IntentFilter(BleControllerConstants.BLE_SCAN_INTENT_ACTION));
    }

    @Override
    public void onCancel(Object arguments) {
        context.unregisterReceiver(bleScanBroadcastReceiver);
    }
}
