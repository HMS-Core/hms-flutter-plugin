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

import static com.huawei.hms.flutter.nearbyservice.utils.constants.ErrorCodes.ERROR_DISCOVERY;

import android.app.Activity;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.nearbyservice.logger.HMSLogger;
import com.huawei.hms.flutter.nearbyservice.utils.FromMap;
import com.huawei.hms.flutter.nearbyservice.utils.HmsHelper;
import com.huawei.hms.flutter.nearbyservice.utils.ToMap;
import com.huawei.hms.flutter.nearbyservice.utils.constants.ErrorCodes;
import com.huawei.hms.nearby.Nearby;
import com.huawei.hms.nearby.discovery.ChannelPolicy;
import com.huawei.hms.nearby.discovery.ConnectOption;
import com.huawei.hms.nearby.discovery.DiscoveryEngine;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import java.util.Locale;
import java.util.Map;

public class DiscoveryMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = "DiscoveryMethodHandler";

    private final ConnectCallbackStreamHandler connectCallback;

    private final ScanEndpointCallbackStreamHandler scanCallback;

    private final DataCallbackStreamHandler dataCallback;

    private final DiscoveryEngine discoveryEngine;

    private final Activity activity;

    public DiscoveryMethodHandler(EventChannel eventChannelConnect, EventChannel eventChannelScan,
        EventChannel eventChannelData, Activity activity) {
        this.activity = activity;
        this.discoveryEngine = Nearby.getDiscoveryEngine(activity);

        this.connectCallback = new ConnectCallbackStreamHandler(activity.getApplicationContext());
        this.scanCallback = new ScanEndpointCallbackStreamHandler(activity.getApplicationContext());
        this.dataCallback = new DataCallbackStreamHandler(activity.getApplicationContext());

        eventChannelConnect.setStreamHandler(connectCallback);
        eventChannelScan.setStreamHandler(scanCallback);
        eventChannelData.setStreamHandler(dataCallback);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer(call.method);
        switch (call.method) {
            case "acceptConnect":
                acceptConnect(call, result);
                break;
            case "disconnect":
                disconnect(call, result);
                break;
            case "rejectConnect":
                rejectConnect(call, result);
                break;
            case "requestConnectEx":
                requestConnectEx(call, result);
                break;
            case "startBroadcasting":
                startBroadcasting(call, result);
                break;
            case "startScan":
                startScan(call, result);
                break;
            case "stopBroadcasting":
                stopBroadCasting(call, result);
                break;
            case "disconnectAll":
                disconnectAll(call, result);
                break;
            case "stopScan":
                stopScan(call, result);
                break;
            default:
                HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent(call.method, ErrorCodes.NOT_FOUND);
                result.notImplemented();
                break;
        }
    }

    void acceptConnect(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "acceptConnect");
        String endpointId = FromMap.toString("endpointId", call.argument("endpointId"), false);
        if (endpointId == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
            Log.e(TAG, "Remote endpoint id is null or empty.");
            result.error(ErrorCodes.NULL_PARAM, "Remote endpoint id is null or empty.", "");
            return;
        }

        discoveryEngine.acceptConnect(endpointId, dataCallback).addOnSuccessListener(aVoid -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
            Log.i(TAG, "acceptConnect success");
            HmsHelper.successHandler(result);
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent(call.method, ErrorCodes.ERROR_DISCOVERY);
            Log.e(TAG, "acceptConnect | " + e.getMessage());
            HmsHelper.errorHandler(result, ErrorCodes.ERROR_DISCOVERY, e.getMessage(), "");
        });
    }

    void disconnect(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "disconnect");
        String endpointId = FromMap.toString("endpointId", call.argument("endpointId"), false);
        if (endpointId == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
            Log.e(TAG, "Remote endpoint id is null or empty.");
            result.error(ErrorCodes.NULL_PARAM, "Remote endpoint id is null or empty.", "");
            return;
        }

        discoveryEngine.disconnect(endpointId);
        result.success(true);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
        Log.i(TAG, "disconnect call success");
    }

    void rejectConnect(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "rejectConnect");
        String endpointId = FromMap.toString("endpointId", call.argument("endpointId"), false);
        if (endpointId == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
            Log.e(TAG, "Remote endpoint id is null or empty.");
            result.error(ErrorCodes.NULL_PARAM, "Remote endpoint id is null or empty.", "");
            return;
        }

        discoveryEngine.rejectConnect(endpointId).addOnSuccessListener(aVoid -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ERROR_DISCOVERY);
            Log.i(TAG, "rejectConnect success");
            HmsHelper.successHandler(result);
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ERROR_DISCOVERY);
            Log.e(TAG, "rejectConnect | " + e.getMessage());
            HmsHelper.errorHandler(result, ErrorCodes.ERROR_DISCOVERY, e.getMessage(), "");
        });
    }

    public void requestConnectEx(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "requestConnectEx");
        String name = FromMap.toString("name", call.argument("name"), false);
        if (name == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
            Log.e(TAG, "Local endpoint name is null or empty.");
            result.error(ErrorCodes.NULL_PARAM, "Local endpoint name is null or empty.", "");
            return;
        }

        String endpointId = FromMap.toString("endpointId", call.argument("endpointId"), false);
        if (endpointId == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
            Log.e(TAG, "Remote endpoint id is null or empty.");
            result.error(ErrorCodes.NULL_PARAM, "Remote endpoint id is null or empty.", "");
            return;
        }

        Map<String, Object> optionMap = ToMap.fromObject(call.argument("ConnectOption"));

        Map<String, Object> policyMap = ToMap.fromObject(optionMap.get("policyMap"));
        if (optionMap.isEmpty() && policyMap.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
            Log.e(TAG, "ConnectOption is null or empty.");
            result.error(ErrorCodes.NULL_PARAM, "ConnectOption is null or empty.", "");
            return;
        }

        int channelPolicyNumber = FromMap.toInteger("policy", policyMap.get("policy"));
        ChannelPolicy channelPolicy = HmsHelper.getChannelPolicyByNumber(channelPolicyNumber);

        ConnectOption connectOption = new ConnectOption.Builder().setPolicy(channelPolicy).build();

        discoveryEngine.requestConnectEx(name, endpointId, connectCallback, connectOption)
            .addOnSuccessListener(unused -> {
                HmsHelper.successHandler(result);
            })
            .addOnFailureListener(e -> {
                HmsHelper.errorHandler(result, ErrorCodes.ERROR_DISCOVERY,
                    String.format(Locale.ENGLISH, "requestConnectEx: %s", e.getMessage()), "");
            });
    }

    void startBroadcasting(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "startBroadcasting");
        String name = FromMap.toString("name", call.argument("name"), false);
        if (name == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
            Log.e(TAG, "Local endpoint name is null or empty.");
            result.error(ErrorCodes.NULL_PARAM, "Local endpoint name is null or empty.", "");
            return;
        }

        String serviceId = FromMap.toString("serviceId", call.argument("serviceId"), false);
        if (serviceId == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
            Log.e(TAG, "Service id is null or empty.");
            result.error(ErrorCodes.NULL_PARAM, "Service id is null or empty.", "");
            return;
        }

        Map<String, Object> optionMap = ToMap.fromObject(call.argument("broadcastOption"));
        if (optionMap.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
            Log.e(TAG, "BroadcastOption is null or empty.");
            result.error(ErrorCodes.NULL_PARAM, "BroadcastOption is null or empty.", "");
            return;
        }

        discoveryEngine.startBroadcasting(name, serviceId, connectCallback,
            HmsHelper.createBroadcastOption(ToMap.fromObject(optionMap.get("policy")))).addOnSuccessListener(aVoid -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
            Log.i(TAG, "startBroadcasting success");
            HmsHelper.successHandler(result);
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ERROR_DISCOVERY);
            Log.e(TAG, "startBroadcasting | " + e.getMessage());
            HmsHelper.errorHandler(result, ErrorCodes.ERROR_DISCOVERY, e.getMessage(), "");
        });
    }

    void startScan(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "startScan");
        String serviceId = FromMap.toString("serviceId", call.argument("serviceId"), false);
        if (serviceId == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
            Log.e(TAG, "Service id is null or empty.");
            result.error(ErrorCodes.NULL_PARAM, "Service id is null or empty.", "");
            return;
        }

        Map<String, Object> optionMap = ToMap.fromObject(call.argument("scanOption"));
        if (optionMap.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
            Log.e(TAG, "ScanOption is null or empty.");
            result.error(ErrorCodes.NULL_PARAM, "ScanOption is null or empty.", "");
            return;
        }

        discoveryEngine.startScan(serviceId, scanCallback,
            HmsHelper.createScanOption(ToMap.fromObject(optionMap.get("policy")))).addOnSuccessListener(aVoid -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
            Log.i(TAG, "startScan success");
            HmsHelper.successHandler(result);
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ERROR_DISCOVERY);
            Log.e(TAG, "startScan | " + e.getMessage());
            HmsHelper.errorHandler(result, ErrorCodes.ERROR_DISCOVERY, e.getMessage(), "");
        });
    }

    void stopBroadCasting(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "stopBroadCasting");
        discoveryEngine.stopBroadcasting();
        result.success(null);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
        Log.i(TAG, "stopBroadCasting call success");
    }

    void disconnectAll(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "disconnectAll");
        discoveryEngine.disconnectAll();
        result.success(null);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
        Log.i(TAG, "disconnectAll call success");
    }

    void stopScan(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "stopScan");
        discoveryEngine.stopScan();
        result.success(null);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
        Log.i(TAG, "stopScan call success");
    }
}
