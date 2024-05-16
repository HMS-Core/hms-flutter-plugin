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

package com.huawei.hms.flutter.nearbyservice.beacon;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.nearbyservice.logger.HMSLogger;
import com.huawei.hms.flutter.nearbyservice.utils.FromMap;
import com.huawei.hms.flutter.nearbyservice.utils.HmsHelper;
import com.huawei.hms.flutter.nearbyservice.utils.constants.ErrorCodes;
import com.huawei.hms.nearby.Nearby;
import com.huawei.hms.nearby.beacon.BeaconMsgCondition;
import com.huawei.hms.nearby.beacon.BeaconPicker;
import com.huawei.hms.nearby.beacon.GetBeaconOption;
import com.huawei.hms.nearby.beacon.RawBeaconCondition;
import com.huawei.hms.nearby.beacon.TriggerOption;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BeaconMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = "BeaconMethodHandler";

    private final Activity activity;

    BeaconPicker beaconPicker;

    public BeaconMethodHandler(EventChannel eventChannel, Activity activity) {
        this.activity = activity;
        BeaconStreamHandler beaconStreamHandler = new BeaconStreamHandler(activity);
        eventChannel.setStreamHandler(beaconStreamHandler);

    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer(call.method);
        switch (call.method) {
            case "registerScanTask":
                registerScanTask(call, result);
                break;
            case "unRegisterScanTask":
                unRegisterScanTask(call, result);
                break;
            case "getRawBeaconConditions":
                getRawBeaconConditions(call, result);
                break;
            case "getBeaconMsgConditions":
                getBeaconMsgConditions(call, result);
                break;
            default:
                HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent(call.method, ErrorCodes.NOT_FOUND);
                result.notImplemented();
                break;
        }
    }

    private void registerScanTask(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "registerBeaconScan");
        Integer beaconType = 1;
        beaconType = FromMap.toInteger("beaconType", call.argument("beaconType"));
        String beaconId = FromMap.toString("beaconId", call.argument("beaconId"), true);
        String namespace = FromMap.toString("namespace", call.argument("namespace"), true);
        String type = FromMap.toString("type", call.argument("type"), true);

        TriggerOption triggerOption = new TriggerOption.Builder().setTriggerMode(2)
            .setTriggerClassName(BeaconReceiver.class.getName())
            .build();
        Intent intent = new Intent();
        intent.putExtra(GetBeaconOption.KEY_TRIGGER_OPTION, triggerOption);
        if (namespace == null && type == null && beaconId != null) {
            beaconPicker = new BeaconPicker.Builder().includeBeaconId(beaconId, beaconType).build();
        } else if (beaconId == null && namespace != null && type != null) {
            beaconPicker = new BeaconPicker.Builder().includeNamespaceType(namespace, type).build();
        } else if (beaconId == null && namespace == null && type == null) {
            beaconPicker = new BeaconPicker.Builder().build();
        } else {
            beaconPicker = new BeaconPicker.Builder().includeNamespaceType(namespace, type, beaconId, beaconType)
                .build();
        }

        GetBeaconOption getBeaconOption = new GetBeaconOption.Builder().picker(beaconPicker).build();
        Nearby.getBeaconEngine(activity.getApplicationContext())
            .registerScanTask(intent, getBeaconOption)
            .addOnSuccessListener(aVoid -> {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
                Log.i(TAG, "registerScanTask success");
                HmsHelper.successHandler(result);

            })
            .addOnFailureListener(e -> {
                HMSLogger.getInstance(activity).sendSingleEvent(call.method, ErrorCodes.ERROR_MESSAGE);
                Log.i(TAG, "registerScanTask failure");
                HmsHelper.errorHandler(result, ErrorCodes.ERROR_MESSAGE, "registerScanTask failure | " + e.getMessage(),
                    "");
            });
    }

    private void unRegisterScanTask(MethodCall call, MethodChannel.Result result) {
        TriggerOption triggerOption = new TriggerOption.Builder().setTriggerMode(2)
            .setTriggerClassName(BeaconReceiver.class.getName())
            .build();
        Intent intent = new Intent();
        intent.putExtra(GetBeaconOption.KEY_TRIGGER_OPTION, triggerOption);
        Nearby.getBeaconEngine(activity).unRegisterScanTask(intent).addOnSuccessListener(aVoid -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
            Log.i(TAG, "unRegisterScanTask success");
            HmsHelper.successHandler(result);

        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity).sendSingleEvent(call.method, ErrorCodes.ERROR_MESSAGE);
            Log.i(TAG, "unRegisterScanTask failure");
            HmsHelper.errorHandler(result, ErrorCodes.ERROR_MESSAGE, "unRegisterScanTask failure | " + e.getMessage(),
                "");
        });
    }

    private void getRawBeaconConditions(MethodCall call, MethodChannel.Result result) {
        if (beaconPicker == null) {
            HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent(call.method, ErrorCodes.ERROR_MESSAGE);
            result.error(ErrorCodes.ERROR_MESSAGE, "BeaconPicker is null. Call registerBeaconScan first.", "");
            return;
        }
        List<RawBeaconCondition> rawBeaconConditionList;
        Integer beaconType = FromMap.toInteger("beaconType", call.argument("beaconType"));
        if (beaconType == null) {
            rawBeaconConditionList = beaconPicker.getRawBeaconConditions();
        } else {
            rawBeaconConditionList = beaconPicker.getRawBeaconConditions(beaconType);
        }
        final List<Map<String, Object>> rbcList = new ArrayList<>();
        Map<String, Object> map = new HashMap<>();
        for (final RawBeaconCondition rbc : rawBeaconConditionList) {
            map.put("beaconId", rbc.getBeaconId());
            map.put("beaconType", rbc.getBeaconType());
            rbcList.add(map);
        }
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
        result.success(rbcList);
    }

    private void getBeaconMsgConditions(MethodCall call, MethodChannel.Result result) {
        if (beaconPicker == null) {
            HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent(call.method, ErrorCodes.ERROR_MESSAGE);
            result.error(ErrorCodes.ERROR_MESSAGE, "BeaconPicker is null. Call registerBeaconScan first.", "");
            return;
        }
        List<BeaconMsgCondition> beaconMsgConditions = beaconPicker.getBeaconMsgConditions();
        final List<Map<String, Object>> bmcList = new ArrayList<>();
        Map<String, Object> map = new HashMap<>();
        for (final BeaconMsgCondition bmc : beaconMsgConditions) {
            map.put("beaconId", bmc.getBeaconId());
            map.put("beaconType", bmc.getBeaconType());
            map.put("namespace", bmc.getNamespace());
            map.put("type", bmc.getType());
            bmcList.add(map);
        }
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
        result.success(bmcList);
    }
}
