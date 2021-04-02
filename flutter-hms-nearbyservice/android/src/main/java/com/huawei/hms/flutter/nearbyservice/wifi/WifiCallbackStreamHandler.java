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

package com.huawei.hms.flutter.nearbyservice.wifi;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.huawei.hms.flutter.nearbyservice.logger.HMSLogger;
import com.huawei.hms.flutter.nearbyservice.utils.ToMap;
import com.huawei.hms.flutter.nearbyservice.utils.constants.ErrorCodes;
import com.huawei.hms.nearby.discovery.ScanEndpointInfo;
import com.huawei.hms.nearby.wifishare.WifiShareCallback;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.EventChannel;

public class WifiCallbackStreamHandler extends WifiShareCallback implements EventChannel.StreamHandler {
    private static final String TAG = "WifiCallbackHandler";

    private EventChannel.EventSink event;
    private final Context context;

    WifiCallbackStreamHandler(Context context) {
        this.context = context;
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink event) {
        Log.i(TAG, "onListen");
        this.event = event;
    }

    @Override
    public void onCancel(Object arguments) {
        Log.i(TAG, "onCancel");
        this.event = null;
    }


    @Override
    public void onFound(String endpointId, ScanEndpointInfo scanEndpointInfo) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("WifiShareCallback.onFound");
        Log.i(TAG, "onFound");
        if (event == null) {
            HMSLogger.getInstance(context).sendSingleEvent("WifiShareCallback.onFound", ErrorCodes.ERROR_WIFI);
            Log.e(TAG, "onFound | EventSink is null. You should define a listener for the WifiCallbackHandler.");
            return;
        }

        HashMap<String, Object> info = new HashMap<>();
        info.put("name", scanEndpointInfo.getName());
        info.put("serviceId", scanEndpointInfo.getServiceId());
        eventSuccess(event, ToMap.fromArgs("event", "onFound", "endpointId", endpointId, "scanEndpointInfo", info));
        HMSLogger.getInstance(context).sendSingleEvent("WifiShareCallback.onFound");
    }

    @Override
    public void onLost(String endpointId) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("WifiShareCallback.onLost");
        Log.i(TAG, "onLost");
        if (event == null) {
            HMSLogger.getInstance(context).sendSingleEvent("WifiShareCallback.onLost", ErrorCodes.ERROR_WIFI);
            Log.e(TAG, "onLost | EventSink is null. You should define a listener for the WifiCallbackHandler.");
            return;
        }

        eventSuccess(event, ToMap.fromArgs("event", "onLost", "endpointId", endpointId));
        HMSLogger.getInstance(context).sendSingleEvent("WifiShareCallback.onLost");
    }

    @Override
    public void onFetchAuthCode(String endpointId, String authCode) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("WifiShareCallback.onFetchAuthCode");
        Log.i(TAG, "onFetchAuthCode");
        if (event == null) {
            HMSLogger.getInstance(context).sendSingleEvent("WifiShareCallback.onLost", ErrorCodes.ERROR_WIFI);
            Log.e(TAG, "onFetchAuthCode | EventSink is null. You should define a listener for the WifiCallbackHandler.");
            return;
        }

        eventSuccess(event, ToMap.fromArgs("event", "onFetchAuthCode", "endpointId", endpointId, "authCode", authCode));
        HMSLogger.getInstance(context).sendSingleEvent("WifiShareCallback.onFetchAuthCode");
    }

    @Override
    public void onWifiShareResult(String endpointId, int statusCode) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("WifiShareCallback.onWifiShareResult");
        Log.i(TAG, "onWifiShareResult");
        if (event == null) {
            HMSLogger.getInstance(context).sendSingleEvent("WifiShareCallback.onWifiShareResult", ErrorCodes.ERROR_WIFI);
            Log.e(TAG, "onWifiShareResult | EventSink is null. You should define a listener for the WifiCallbackHandler.");
            return;
        }

        eventSuccess(event, ToMap.fromArgs("event", "onWifiShareResult", "endpointId", endpointId, "statusCode", statusCode));
        HMSLogger.getInstance(context).sendSingleEvent("WifiShareCallback.onWifiShareResult");
    }

    private void eventSuccess(EventChannel.EventSink event, Map<String, Object> eventMap) {
        new Handler(Looper.getMainLooper()).post(() -> event.success(eventMap));
    }
}
