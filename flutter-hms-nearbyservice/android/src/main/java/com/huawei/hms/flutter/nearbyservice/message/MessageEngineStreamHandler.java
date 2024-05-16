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

import com.huawei.hms.flutter.nearbyservice.utils.constants.CallbackTypes;

import io.flutter.plugin.common.EventChannel;

public class MessageEngineStreamHandler implements EventChannel.StreamHandler {

    private static final String TAG = "MessageStreamHandler";

    private final Context context;

    EventChannel.EventSink event;

    MessageEngineStreamHandler(Context context) {
        this.context = context;
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink event) {
        Log.i(TAG, "MessageStreamHandler onListen");
        this.event = event;
    }

    @Override
    public void onCancel(Object arguments) {
        Log.i(TAG, "MessageStreamHandler onCancel");
        event = null;
    }

    public HmsGetCallback createGetCallback(int id) {
        return new HmsGetCallback(event, id, context);
    }

    public HmsPutCallback createPutCallback(int id) {
        return new HmsPutCallback(event, id, context);
    }

    public HmsStatusCallback createStatusCallback(int id) {
        return new HmsStatusCallback(event, id, context);
    }

    public HmsMessageHandler createMessageHandler(int id) {
        return new HmsMessageHandler(event, id, context);
    }

    public void removeCallback(String type, int id) {
        switch (type) {
            case CallbackTypes.GET_CALLBACK:
                HmsGetCallback.remove(id);
                break;
            case CallbackTypes.PUT_CALLBACK:
                HmsPutCallback.remove(id);
                break;
            case CallbackTypes.STATUS_CALLBACK:
                HmsStatusCallback.remove(id);
                break;
            case CallbackTypes.MESSAGE_HANDLER_CALLBACK:
                HmsMessageHandler.remove(id);
                break;
            default:
                Log.e(TAG, "Unknown callback type");
                break;
        }
    }

    public void removeAllCallbacks() {
        HmsGetCallback.clear();
        HmsPutCallback.clear();
        HmsStatusCallback.clear();
        HmsMessageHandler.clear();
    }
}
