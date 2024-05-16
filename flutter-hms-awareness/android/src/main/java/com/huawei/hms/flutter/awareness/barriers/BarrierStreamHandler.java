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

package com.huawei.hms.flutter.awareness.barriers;

import android.content.Context;
import android.content.IntentFilter;

import io.flutter.plugin.common.EventChannel.EventSink;
import io.flutter.plugin.common.EventChannel.StreamHandler;

public class BarrierStreamHandler implements StreamHandler {
    private BarrierReceiver barrierReceiver;
    private final Context context;

    public BarrierStreamHandler(final Context mContext) {
        context = mContext;
    }

    @Override
    public void onListen(final Object arguments, final EventSink eventSink) {
        barrierReceiver = new BarrierReceiver(eventSink);
        context.registerReceiver(barrierReceiver, new IntentFilter(context.getPackageName() + "RECEIVER_ACTION"));
    }

    @Override
    public void onCancel(final Object arguments) {
        context.unregisterReceiver(barrierReceiver);
    }
}
