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

package com.huawei.hms.flutter.nearbyservice.beacon;

import static android.content.Context.RECEIVER_EXPORTED;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.IntentFilter;
import android.os.Build;
import android.util.Log;

import com.huawei.hms.flutter.nearbyservice.logger.HMSLogger;

import io.flutter.plugin.common.EventChannel;

public class BeaconStreamHandler implements EventChannel.StreamHandler {
    private static final String TAG = "BeaconStreamHandler";

    private final Activity activity;

    private BroadcastReceiver broadcastReceiver;

    private static final String ACTION_SCAN_ONFOUND_RESULT = "com.huawei.hms.nearby.action.ONFOUND_BEACON";

    public BeaconStreamHandler(Activity activity) {
        this.activity = activity;
    }

    @SuppressLint("UnspecifiedRegisterReceiverFlag")
    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        Log.i(TAG, "BeaconStreamHandler onListen");
        broadcastReceiver = new BeaconReceiver(events);
        IntentFilter intentFilter = new IntentFilter(ACTION_SCAN_ONFOUND_RESULT);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            activity.getApplicationContext().registerReceiver(broadcastReceiver, intentFilter, RECEIVER_EXPORTED);
        } else {
            activity.getApplicationContext().registerReceiver(broadcastReceiver, intentFilter);
        }

        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("BeaconStreamHandler.onListen");
    }

    @Override
    public void onCancel(Object arguments) {
        Log.i(TAG, "BeaconStreamHandler onCancel");
        activity.getApplicationContext().unregisterReceiver(broadcastReceiver);
        broadcastReceiver = null;
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("BeaconStreamHandler.onCancel");
    }
}
