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

import io.flutter.plugin.common.EventChannel;

/**
 * Interface that is used as a callback for creating a {@link BroadcastReceiver}
 *
 * @since 5.1.1
 */
public interface CreateBroadcastReceiverCallback {
    /**
     * Creates a BroadcastReceiver.
     *
     * @param events Events from the assigned stream handler.
     * @return A BroadcastReceiver Object
     */
    BroadcastReceiver createBroadcastReceiver(EventChannel.EventSink events);
}
