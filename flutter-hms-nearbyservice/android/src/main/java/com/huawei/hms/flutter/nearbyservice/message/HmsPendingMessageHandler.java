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
import com.huawei.hms.flutter.nearbyservice.utils.ToMap;
import com.huawei.hms.nearby.message.Message;
import com.huawei.hms.nearby.message.MessageHandler;

import io.flutter.plugin.common.MethodChannel;

import java.util.HashMap;

public class HmsPendingMessageHandler extends MessageHandler {

    private static final String TAG = "PendingMessageHandler";

    private final MethodChannel channel;

    private final Context context;

    public HmsPendingMessageHandler(MethodChannel channel, Context context) {
        this.channel = channel;
        this.context = context;
    }

    @Override
    public void onFound(Message message) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("MessageHandler.pendingOnFound");
        Log.i(TAG, "onFound");
        HashMap<String, Object> messageMap = new HashMap<>();
        messageMap.put("namespace", message.getNamespace());
        messageMap.put("type", message.getType());
        messageMap.put("content", message.getContent());
        channel.invokeMethod("pendingOnFound", ToMap.fromArgs("message", messageMap));
        HMSLogger.getInstance(context).sendSingleEvent("MessageHandler.pendingOnFound");
    }

    @Override
    public void onLost(Message message) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("MessageHandler.pendingOnLost");
        Log.i(TAG, "onLost");
        HashMap<String, Object> messageMap = new HashMap<>();
        messageMap.put("namespace", message.getNamespace());
        messageMap.put("type", message.getType());
        messageMap.put("content", message.getContent());
        channel.invokeMethod("pendingOnLost", ToMap.fromArgs("message", messageMap));
        HMSLogger.getInstance(context).sendSingleEvent("MessageHandler.pendingOnLost");
    }
}
