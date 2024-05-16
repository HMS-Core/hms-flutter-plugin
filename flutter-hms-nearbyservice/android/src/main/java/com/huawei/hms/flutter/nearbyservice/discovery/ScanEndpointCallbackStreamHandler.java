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

package com.huawei.hms.flutter.nearbyservice.discovery;

import android.content.Context;
import android.util.Log;

import com.huawei.hms.flutter.nearbyservice.logger.HMSLogger;
import com.huawei.hms.flutter.nearbyservice.utils.ToMap;
import com.huawei.hms.flutter.nearbyservice.utils.constants.ErrorCodes;
import com.huawei.hms.nearby.discovery.ScanEndpointCallback;
import com.huawei.hms.nearby.discovery.ScanEndpointInfo;

import io.flutter.plugin.common.EventChannel;

import java.util.HashMap;

public class ScanEndpointCallbackStreamHandler extends ScanEndpointCallback implements EventChannel.StreamHandler {

    private static final String TAG = "ScanCallbackHandler";

    private final Context context;

    private EventChannel.EventSink event;

    ScanEndpointCallbackStreamHandler(Context context) {
        this.context = context;
    }

    @Override
    public void onCancel(Object arguments) {
        Log.i(TAG, "ScanCallbackHandler onCancel");
        this.event = null;
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink event) {
        Log.i(TAG, "ScanCallbackHandler onListen");
        this.event = event;
    }

    @Override
    public void onFound(String endpointId, ScanEndpointInfo scanEndpointInfo) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("ScanEndpointCallback.onFound");
        Log.i(TAG, "onFound");
        if (event == null) {
            HMSLogger.getInstance(context).sendSingleEvent("ScanEndpointCallback.onFound", ErrorCodes.ERROR_DISCOVERY);
            Log.e(TAG, "onFound | EventSink is null. You should define a listener for the ScanEndpointCallbackStream.");
            return;
        }

        HashMap<String, Object> info = new HashMap<>();
        info.put("name", scanEndpointInfo.getName());
        info.put("serviceId", scanEndpointInfo.getServiceId());
        event.success(ToMap.fromArgs("event", "onFound", "endpointId", endpointId, "scanEndpointInfo", info));
        HMSLogger.getInstance(context).sendSingleEvent("ScanEndpointCallback.onFound");
    }

    @Override
    public void onLost(String endpointId) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("ScanEndpointCallback.onLost");
        Log.i(TAG, "onLost");
        if (event == null) {
            HMSLogger.getInstance(context).sendSingleEvent("ScanEndpointCallback.onLost", ErrorCodes.ERROR_DISCOVERY);
            Log.e(TAG, "onLost | EventSink is null. You should define a listener for the ScanEndpointCallbackStream.");
            return;
        }
        event.success(ToMap.fromArgs("event", "onLost", "endpointId", endpointId));
        HMSLogger.getInstance(context).sendSingleEvent("ScanEndpointCallback.onLost");
    }
}
