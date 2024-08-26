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

package com.huawei.hms.flutter.push.receiver.remote;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import com.huawei.hms.flutter.push.constants.Code;
import com.huawei.hms.flutter.push.constants.PushIntent;

import java.util.Objects;

import io.flutter.plugin.common.EventChannel;

public class RemoteMessageSentDeliveredReceiver extends BroadcastReceiver {
    final EventChannel.EventSink events;

    public RemoteMessageSentDeliveredReceiver(EventChannel.EventSink events) {
        this.events = events;
    }

    @Override
    public void onReceive(Context context, Intent intent) {
        if (Objects.requireNonNull(intent.getAction()).equals(PushIntent.REMOTE_MESSAGE_SENT_DELIVERED_ACTION.id())) {
            try {
                final String err = intent.getStringExtra(PushIntent.REMOTE_MESSAGE_ERROR.id());
                if (err != null) {
                    this.events.error(Code.RESULT_ERROR.code(), err, "");
                } else {
                    String res = intent.getStringExtra(PushIntent.REMOTE_MESSAGE.id());
                    this.events.success(res);
                }
            } catch (Exception e) {
                this.events.error("", e.getMessage(), "");
            }
        }
    }
}
