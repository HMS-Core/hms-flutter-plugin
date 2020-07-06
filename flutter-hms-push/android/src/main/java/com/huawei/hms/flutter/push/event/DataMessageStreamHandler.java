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

package com.huawei.hms.flutter.push.event;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.IntentFilter;

import com.huawei.hms.flutter.push.constants.PushIntent;
import com.huawei.hms.flutter.push.receiver.DataMessageReceiver;

import io.flutter.plugin.common.EventChannel.StreamHandler;
import io.flutter.plugin.common.EventChannel.EventSink;

public class DataMessageStreamHandler implements StreamHandler {

    private Context context;

    public DataMessageStreamHandler(Context context) {
        this.context = context;
    }

    @Override
    public void onListen(Object arguments, EventSink events) {
        BroadcastReceiver dataMessageEventBroadcastReceiver = createDataMessageEventBroadcastReceiver(events);
        context.registerReceiver(
                dataMessageEventBroadcastReceiver,
                new IntentFilter(PushIntent.DATA_MESSAGE_INTENT_ACTION.id())
        );
    }

    @Override
    public void onCancel(Object arguments) {

    }

    private BroadcastReceiver createDataMessageEventBroadcastReceiver(final EventSink events) {
        return new DataMessageReceiver(events);
    }
}
