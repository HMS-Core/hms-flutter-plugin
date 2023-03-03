/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.drive.services.batch;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import com.huawei.hms.flutter.drive.common.Constants;

import io.flutter.plugin.common.EventChannel;

public class BatchReceiver extends BroadcastReceiver {
    EventChannel.EventSink eventSink;

    public BatchReceiver(final EventChannel.EventSink eventSink) {
        this.eventSink = eventSink;
    }

    @Override
    public void onReceive(final Context context, final Intent intent) {
        try {
            final String batchError = intent.getStringExtra("batchError");
            if (batchError != null) {
                eventSink.error(Constants.UNKNOWN_ERROR, batchError, "");
            } else {
                final String batchResponse = intent.getStringExtra("batchResponse");
                if (batchResponse != null) {
                    eventSink.success(batchResponse);
                }
            }
        } catch (Exception e) {
            eventSink.error(Constants.UNKNOWN_ERROR, e.getMessage(), "");
        }
    }
}
