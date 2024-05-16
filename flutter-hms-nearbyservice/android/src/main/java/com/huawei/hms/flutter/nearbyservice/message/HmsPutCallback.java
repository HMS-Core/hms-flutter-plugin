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
import android.util.SparseArray;

import com.huawei.hms.flutter.nearbyservice.logger.HMSLogger;
import com.huawei.hms.flutter.nearbyservice.utils.ToMap;
import com.huawei.hms.nearby.message.PutCallback;

import io.flutter.plugin.common.EventChannel;

public class HmsPutCallback extends PutCallback {
    public static final SparseArray<HmsPutCallback> PUT_CBS = new SparseArray<>();

    private static final String TAG = "HmsPutCallback";

    private final int id;

    private final EventChannel.EventSink event;

    private final Context context;

    public HmsPutCallback(EventChannel.EventSink event, int id, Context context) {
        PUT_CBS.put(id, this);
        this.id = id;
        this.event = event;
        this.context = context;
    }

    public static void remove(int id) {
        PUT_CBS.remove(id);
    }

    public static void clear() {
        PUT_CBS.clear();
    }

    @Override
    public void onTimeout() {
        HMSLogger.getInstance(context).startMethodExecutionTimer("PutCallback.onTimeout");
        Log.i(TAG, "onTimeout");
        event.success(ToMap.fromArgs("event", "onPutTimeout", "id", id));
        HMSLogger.getInstance(context).sendSingleEvent("PutCallback.onTimeout");
    }
}
