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

package com.huawei.hms.flutter.location.handlers;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.IntentFilter;

import com.huawei.hms.flutter.location.constants.Action;
import com.huawei.hms.flutter.location.logger.HMSLogger;
import com.huawei.hms.flutter.location.receivers.GeofenceBroadcastReceiver;

import io.flutter.plugin.common.EventChannel.EventSink;
import io.flutter.plugin.common.EventChannel.StreamHandler;

public class GeofenceStreamHandler implements StreamHandler {
    private final Context context;

    private BroadcastReceiver broadcastReceiver;

    public GeofenceStreamHandler(final Context context) {
        this.context = context;
    }

    @Override
    public void onListen(final Object arguments, final EventSink events) {
        broadcastReceiver = new GeofenceBroadcastReceiver(events);
        context.registerReceiver(broadcastReceiver, new IntentFilter(Action.PROCESS_GEOFENCE));

        HMSLogger.getInstance(context).sendSingleEvent("GeofenceStreamHandler.onListen");
    }

    @Override
    public void onCancel(final Object arguments) {
        context.unregisterReceiver(broadcastReceiver);
        broadcastReceiver = null;

        HMSLogger.getInstance(context).sendSingleEvent("GeofenceStreamHandler.onCancel");
    }
}
