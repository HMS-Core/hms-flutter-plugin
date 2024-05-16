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

package com.huawei.hms.flutter.nearbyservice.message;

import android.content.Context;
import android.util.Log;

import com.huawei.hms.flutter.nearbyservice.logger.HMSLogger;
import com.huawei.hms.nearby.message.GetCallback;

import io.flutter.plugin.common.MethodChannel;

public class HmsPendingGetCallback extends GetCallback {
    private static final String TAG = "HmsPendingGetCallback";

    private final MethodChannel channel;

    private final Context context;

    public HmsPendingGetCallback(MethodChannel channel, Context context) {
        this.channel = channel;
        this.context = context;
    }

    @Override
    public void onTimeout() {
        HMSLogger.getInstance(context).startMethodExecutionTimer("GetCallback.pendingOnTimeout");
        Log.i(TAG, "onTimeout");
        channel.invokeMethod("pendingOnTimeout", null);
        HMSLogger.getInstance(context).sendSingleEvent("GetCallback.pendingOnTimeout");
    }
}
