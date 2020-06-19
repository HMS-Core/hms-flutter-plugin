/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.location.receivers;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import com.huawei.hms.flutter.location.utils.GeofenceUtils;
import com.huawei.hms.location.GeofenceData;

import io.flutter.plugin.common.EventChannel.EventSink;

public class GeofenceBroadcastReceiver extends BroadcastReceiver {
    private final EventSink mEventSink;

    public GeofenceBroadcastReceiver(final EventSink eventSink) {
        mEventSink = eventSink;
    }

    @Override
    public void onReceive(final Context context, final Intent intent) {
        if (intent != null) {
            final GeofenceData geofenceData = GeofenceData.getDataFromIntent(intent);
            mEventSink.success(GeofenceUtils.fromGeofenceDataToMap(geofenceData));
        }
    }
}
