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

package com.huawei.hms.flutter.nearbyservice.transfer;

import android.app.Activity;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.nearbyservice.logger.HMSLogger;
import com.huawei.hms.flutter.nearbyservice.utils.FromMap;
import com.huawei.hms.flutter.nearbyservice.utils.HmsHelper;
import com.huawei.hms.flutter.nearbyservice.utils.ToMap;
import com.huawei.hms.flutter.nearbyservice.utils.constants.ErrorCodes;
import com.huawei.hms.nearby.Nearby;
import com.huawei.hms.nearby.transfer.Data;
import com.huawei.hms.nearby.transfer.TransferEngine;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import java.util.List;
import java.util.Map;

public class TransferMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = "TransferMethodHandler";

    private final Activity activity;

    private final TransferEngine transferEngine;

    public TransferMethodHandler(Activity activity) {
        this.transferEngine = Nearby.getTransferEngine(activity);
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer(call.method);
        switch (call.method) {
            case "sendData":
                new SendDataThread(call, result).start();
                break;
            case "sendMultiEndpointData":
                new SendMultiEndpointDataThread(call, result).start();
                break;
            case "cancelDataTransfer":
                cancelDataTransfer(call, result);
                break;
            default:
                HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent(call.method, ErrorCodes.NOT_FOUND);
                result.notImplemented();
        }
    }

    void cancelDataTransfer(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "cancelDataTransfer");
        Long dataId = FromMap.toLong("dataId", call.argument("dataId"));
        if (dataId == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
            Log.e(TAG, "Data id is null or empty.");
            HmsHelper.errorHandler(result, ErrorCodes.NULL_PARAM, "Data id is null or empty.", "");
            return;
        }

        transferEngine.cancelDataTransfer(dataId).addOnSuccessListener(aVoid -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
            Log.i(TAG, "cancelDataTransfer success");
            HmsHelper.successHandler(result);
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent(call.method, ErrorCodes.ERROR_TRANSFER);
            Log.e(TAG, "cancelDataTransfer | " + e.getMessage());
            HmsHelper.errorHandler(result, ErrorCodes.ERROR_TRANSFER, e.getMessage(), "");
        });
    }

    class SendDataThread extends Thread {
        private final MethodCall call;

        private final MethodChannel.Result result;

        SendDataThread(MethodCall call, MethodChannel.Result result) {
            super("sendData");
            this.call = call;
            this.result = result;
        }

        @Override
        public void run() {
            Log.i(TAG, "sendData");
            String endpointId = FromMap.toString("endpointId", call.argument("endpointId"), false);
            if (endpointId == null) {
                HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
                Log.e(TAG, "sendMultiEndpointData Remote endpoint id is null or empty.");
                HmsHelper.errorHandler(result, ErrorCodes.NULL_PARAM, "Remote endpoint id is null or empty.", "");
                return;
            }

            Map<String, Object> dataMap = ToMap.fromObject(call.argument("data"));
            if (dataMap.isEmpty()) {
                HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
                Log.e(TAG, "sendMultiEndpointData Data is null or empty.");
                HmsHelper.errorHandler(result, ErrorCodes.NULL_PARAM, "Data is null or empty.", "");
                return;
            }

            Integer type = FromMap.toInteger("type", dataMap.get("type"));
            if (type == null) {
                HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
                Log.e(TAG, "sendMultiEndpointData Data type is null.");
                HmsHelper.errorHandler(result, ErrorCodes.NULL_PARAM, "Data type is null.", "");
                return;
            }

            Data data = HmsHelper.parseData(dataMap, type, FromMap.toBoolean("isUri", call.argument("isUri")),
                activity.getContentResolver());

            if (data == null) {
                HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
                Log.e(TAG, "Data is null.");
                HmsHelper.errorHandler(result, ErrorCodes.ERROR_TRANSFER, "Data is null.", "");
            } else {
                transferEngine.sendData(endpointId, data).addOnSuccessListener(aVoid -> {
                    HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
                    Log.i(TAG, "sendMultiEndpointData sendData success");
                    HmsHelper.successHandler(result);
                }).addOnFailureListener(e -> {
                    HMSLogger.getInstance(activity.getApplicationContext())
                        .sendSingleEvent(call.method, ErrorCodes.ERROR_TRANSFER);
                    Log.e(TAG, "sendMultiEndpointData sendData | " + e.getMessage());
                    HmsHelper.errorHandler(result, ErrorCodes.ERROR_TRANSFER, e.getMessage(), "");
                });
            }
        }
    }

    class SendMultiEndpointDataThread extends Thread {
        private final MethodCall call;

        private final MethodChannel.Result result;

        SendMultiEndpointDataThread(MethodCall call, MethodChannel.Result result) {
            super("sendMultiEndpointData");
            this.call = call;
            this.result = result;
        }

        @Override
        public void run() {
            Log.i(TAG, "sendMultiEndpointData");
            List<String> endpointIds = FromMap.toStringArrayList("endpointIds", call.argument("endpointIds"));
            if (endpointIds.isEmpty()) {
                HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
                Log.e(TAG, "Remote endpoint ids are null or empty.");
                HmsHelper.errorHandler(result, ErrorCodes.NULL_PARAM, "Remote endpoint ids are null or empty.", "");
                return;
            }

            Map<String, Object> dataMap = ToMap.fromObject(call.argument("data"));
            if (dataMap.isEmpty()) {
                HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
                Log.e(TAG, "Data is null or empty.");
                HmsHelper.errorHandler(result, ErrorCodes.NULL_PARAM, "Data is null or empty.", "");
                return;
            }

            Integer type = FromMap.toInteger("type", dataMap.get("type"));
            if (type == null) {
                HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
                Log.e(TAG, "Data type is null.");
                HmsHelper.errorHandler(result, ErrorCodes.NULL_PARAM, "Data type is null.", "");
                return;
            }

            Data data = HmsHelper.parseData(dataMap, type, FromMap.toBoolean("isUri", call.argument("usePfd")),
                activity.getContentResolver());

            if (data == null) {
                HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent(call.method, ErrorCodes.ERROR_TRANSFER);
                Log.e(TAG, "Data is null.");
                HmsHelper.errorHandler(result, ErrorCodes.ERROR_TRANSFER, "Data is null.", "");
            } else {
                transferEngine.sendData(endpointIds, data).addOnSuccessListener(aVoid -> {
                    HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
                    Log.i(TAG, "success");
                    HmsHelper.successHandler(result);
                }).addOnFailureListener(e -> {
                    HMSLogger.getInstance(activity.getApplicationContext())
                        .sendSingleEvent(call.method, ErrorCodes.ERROR_TRANSFER);
                    Log.e(TAG, "sendMultiEndpointData | " + e.getMessage());
                    HmsHelper.errorHandler(result, ErrorCodes.ERROR_TRANSFER, e.getMessage(), "");
                });
            }
        }
    }
}
