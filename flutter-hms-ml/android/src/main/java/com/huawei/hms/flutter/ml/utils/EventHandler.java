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

package com.huawei.hms.flutter.ml.utils;

import android.os.Handler;
import android.os.Looper;

import io.flutter.plugin.common.EventChannel.EventSink;

public final class EventHandler {
    private static volatile EventHandler instance;
    private final Handler uiHandler = new Handler(Looper.getMainLooper());

    private EventSink sink;

    public static EventHandler getInstance() {
        if (instance == null) {
            instance = new EventHandler();
        }
        return instance;
    }

    public void setEventSink(EventSink sink1) {
        this.sink = sink1;
    }

    public EventSink getEventSink() {
        return this.sink;
    }

    public Handler getUiHandler() {
        return uiHandler;
    }
}
