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
import com.huawei.hms.flutter.nearbyservice.utils.HmsHelper;
import com.huawei.hms.flutter.nearbyservice.utils.ToMap;
import com.huawei.hms.flutter.nearbyservice.utils.constants.ErrorCodes;
import com.huawei.hms.nearby.discovery.ConnectCallback;
import com.huawei.hms.nearby.discovery.ConnectInfo;
import com.huawei.hms.nearby.discovery.ConnectResult;

import io.flutter.plugin.common.EventChannel;

import java.util.HashMap;

public class ConnectCallbackStreamHandler extends ConnectCallback implements EventChannel.StreamHandler {

    private static final String TAG = "ConnectCallbackHandler";

    private final Context context;

    private EventChannel.EventSink event;

    ConnectCallbackStreamHandler(Context context) {
        this.context = context;
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink event) {
        Log.i(TAG, "ConnectCallbackHandler onListen");
        this.event = event;
    }

    @Override
    public void onCancel(Object arguments) {
        Log.i(TAG, "ConnectCallbackHandler onCancel");
        this.event = null;
    }

    @Override
    public void onEstablish(String endpointId, ConnectInfo connectInfo) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("ConnectCallback.onEstablish");
        if (event == null) {
            HMSLogger.getInstance(context).sendSingleEvent("ConnectCallback.onEstablish", ErrorCodes.ERROR_DISCOVERY);
            Log.e(TAG, "onEstablish | EventSink is null. You should define a listener for the ConnectCallbackStream.");
            return;
        }

        HashMap<String, Object> info = new HashMap<>();
        info.put("authCode", connectInfo.getAuthCode());
        info.put("endpointName", connectInfo.getEndpointName());
        info.put("isRemoteConnect", connectInfo.isRemoteConnect());
        Log.i(TAG, "onEstablish");
        event.success(ToMap.fromArgs("event", "onEstablish", "endpointId", endpointId, "connectInfo", info));
        HMSLogger.getInstance(context).sendSingleEvent("ConnectCallback.onEstablish");
    }

    @Override
    public void onResult(String endpointId, ConnectResult connectResult) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("ConnectCallback.onResult");
        if (event == null) {
            HMSLogger.getInstance(context).sendSingleEvent("ConnectCallback.onResult", ErrorCodes.ERROR_DISCOVERY);
            Log.e(TAG, "onResult | EventSink is null. You should define a listener for the ConnectCallbackStream.");
            return;
        }

        HashMap<String, Object> res = new HashMap<>();
        res.put("statusCode", connectResult.getStatus().getStatusCode());
        res.put("getPolicy", HmsHelper.getChannelPolicyNumber(connectResult.getChannelPolicy()));
        Log.i(TAG, "onResult");
        event.success(ToMap.fromArgs("event", "onResult", "endpointId", endpointId, "connectResult", res));
        HMSLogger.getInstance(context).sendSingleEvent("ConnectCallback.onResult");
    }

    @Override
    public void onDisconnected(String endpointId) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("ConnectCallback.onDisconnected");
        if (event == null) {
            HMSLogger.getInstance(context)
                .sendSingleEvent("ConnectCallback.onDisconnected", ErrorCodes.ERROR_DISCOVERY);
            Log.e(TAG,
                "onDisconnected | EventSink is null. You should define a listener for the ConnectCallbackStream.");
            return;
        }

        Log.i(TAG, "onDisconnected");
        event.success(ToMap.fromArgs("event", "onDisconnected", "endpointId", endpointId));
        HMSLogger.getInstance(context).sendSingleEvent("ConnectCallback.onDisconnected");
    }
}

