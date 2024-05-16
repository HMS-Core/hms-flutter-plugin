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

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import com.huawei.hms.flutter.nearbyservice.utils.ToMap;
import com.huawei.hms.nearby.message.BeaconInfo;

import io.flutter.plugin.common.EventChannel;

import java.util.List;

public class BeaconReceiver extends BroadcastReceiver {
    final EventChannel.EventSink eventSink;

    private static final String TAG = "BeaconReceiver";

    private static final String ACTION_SCAN_ONFOUND_RESULT = "com.huawei.hms.nearby.action.ONFOUND_BEACON";

    // 0: A beacon is lost; 1: A beacon is found.
    private static final String KEY_SCAN_ONFOUND_FLAG = "SCAN_ONFOUND_FLAG";

    // Information about the lost or found beacon.
    private static final String KEY_SCAN_BEACON_DATA = "SCAN_BEACON";

    public BeaconReceiver(EventChannel.EventSink eventSink) {
        this.eventSink = eventSink;
    }

    @Override
    public void onReceive(Context context, Intent intent) {

        String action = intent.getAction();
        if (ACTION_SCAN_ONFOUND_RESULT.equals(action)) {
            int onFound = intent.getIntExtra(KEY_SCAN_ONFOUND_FLAG, -1);
            List<BeaconInfo> beaconIds = intent.getParcelableArrayListExtra(KEY_SCAN_BEACON_DATA);
            if (beaconIds == null) {
                Log.w(TAG, "beaconIds is null");
                return;
            }
            for (BeaconInfo beacon : beaconIds) {
                Log.i(TAG, "onReceive onFound, isFound:" + onFound + ", beaconId:" + beacon.getBeaconId());
                eventSink.success(ToMap.fromObject(beacon));
            }
        }
    }
}
