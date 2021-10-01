/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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
package com.huawei.hms.flutter.ads.factory;

import android.util.Log;
import android.util.SparseArray;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;

public class EventChannelFactory {
    private static final String TAG = "EventChannelFactory";

    private static SparseArray<EventChannel> allEventChannels = new SparseArray<>();

    private EventChannelFactory() {
    }

    public static void create(int id, String name, BinaryMessenger messenger) {
        if (allEventChannels.get(id) == null) {
            EventChannel channel = new EventChannel(messenger, name + "/" + id);
            Log.i(TAG, "EventChannel is created");
            allEventChannels.put(id, channel);
        }
    }

    public static void setup(int id, EventChannel.StreamHandler streamHandler) {
        if (allEventChannels.get(id) != null && streamHandler != null) {
            allEventChannels.get(id).setStreamHandler(streamHandler);
        } else {
            Log.w(TAG, "Id or stream handler is null. Event listener functionality is off.");
        }
    }

    public static void dispose(int id) {
        EventChannel channel = allEventChannels.get(id);
        if (channel != null) {
            channel.setStreamHandler(null);
            allEventChannels.remove(id);
            Log.i(TAG, "EventChannel is destroyed");
        } else {
            Log.w(TAG, "EventChannel is null for the given id and can't be disposed.");
        }
    }
}
