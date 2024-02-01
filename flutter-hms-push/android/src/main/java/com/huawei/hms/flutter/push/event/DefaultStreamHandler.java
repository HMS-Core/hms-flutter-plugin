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

package com.huawei.hms.flutter.push.event;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.IntentFilter;

import com.huawei.agconnect.LocalBrdMnger;
import com.huawei.hms.flutter.push.constants.PushIntent;

import io.flutter.plugin.common.EventChannel;

public class DefaultStreamHandler implements EventChannel.StreamHandler {

    private Context context;

    private BroadcastReceiver broadcastReceiver;

    private CreateBroadcastReceiverCallback cb;

    private PushIntent intentAction;

    public DefaultStreamHandler(Context context, CreateBroadcastReceiverCallback cb, PushIntent intentAction) {
        this.context = context;
        this.cb = cb;
        this.intentAction = intentAction;
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        broadcastReceiver = cb.createBroadcastReceiver(events);
        LocalBrdMnger.getInstance(context).registerReceiver(broadcastReceiver, new IntentFilter(intentAction.id()));
    }

    @Override
    public void onCancel(Object arguments) {
        LocalBrdMnger.getInstance(context).unregisterReceiver(broadcastReceiver);
    }
}
