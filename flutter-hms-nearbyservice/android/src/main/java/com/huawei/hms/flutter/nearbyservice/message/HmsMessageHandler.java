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

import static com.huawei.hms.nearby.discovery.Distance.DISTANCE_UNKNOWN;

import android.content.Context;
import android.util.Log;
import android.util.SparseArray;

import com.huawei.hms.flutter.nearbyservice.logger.HMSLogger;
import com.huawei.hms.flutter.nearbyservice.utils.ToMap;
import com.huawei.hms.nearby.discovery.BleSignal;
import com.huawei.hms.nearby.discovery.Distance;
import com.huawei.hms.nearby.message.Message;
import com.huawei.hms.nearby.message.MessageHandler;

import io.flutter.plugin.common.EventChannel;

import java.util.HashMap;

public class HmsMessageHandler extends MessageHandler {
    public static final SparseArray<HmsMessageHandler> MESSAGE_CBS = new SparseArray<>();

    private static final String TAG = "HmsMessageHandler";

    private final int id;

    private final EventChannel.EventSink event;

    private final Context context;

    public HmsMessageHandler(EventChannel.EventSink event, int id, Context context) {
        MESSAGE_CBS.put(id, this);
        this.id = id;
        this.event = event;
        this.context = context;
    }

    public static void remove(int id) {
        MESSAGE_CBS.remove(id);
    }

    public static void clear() {
        MESSAGE_CBS.clear();
    }

    @Override
    public void onFound(Message message) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("MessageHandler.onFound");
        Log.i(TAG, "onFound");
        HashMap<String, Object> messageMap = new HashMap<>();
        messageMap.put("namespace", message.getNamespace());
        messageMap.put("type", message.getType());
        messageMap.put("content", message.getContent());
        event.success(ToMap.fromArgs("event", "onFound", "message", messageMap, "id", id));
        HMSLogger.getInstance(context).sendSingleEvent("MessageHandler.onFound");
    }

    @Override
    public void onLost(Message message) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("MessageHandler.onLost");
        Log.i(TAG, "onLost");
        HashMap<String, Object> messageMap = new HashMap<>();
        messageMap.put("namespace", message.getNamespace());
        messageMap.put("type", message.getType());
        messageMap.put("content", message.getContent());
        event.success(ToMap.fromArgs("event", "onLost", "message", messageMap, "id", id));
        HMSLogger.getInstance(context).sendSingleEvent("MessageHandler.onLost");
    }

    @Override
    public void onDistanceChanged(Message message, Distance distance) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("MessageHandler.onDistanceChanged");
        Log.i(TAG, "onDistanceChanged");
        HashMap<String, Object> messageMap = new HashMap<>();
        messageMap.put("namespace", message.getNamespace());
        messageMap.put("type", message.getType());
        messageMap.put("content", message.getContent());
        HashMap<String, Object> distanceMap = new HashMap<>();

        distanceMap.put("isUnknown", DISTANCE_UNKNOWN.compareTo(distance));
        distanceMap.put("meters",
            Double.isNaN(distance.getMeters()) ? DISTANCE_UNKNOWN.getMeters() : distance.getMeters());
        distanceMap.put("precision", distance.getPrecision());
        event.success(
            ToMap.fromArgs("event", "onDistanceChanged", "message", messageMap, "distance", distanceMap, "id", id));
        HMSLogger.getInstance(context).sendSingleEvent("MessageHandler.onDistanceChanged");
    }

    @Override
    public void onBleSignalChanged(Message message, BleSignal bleSignal) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("MessageHandler.onBleSignalChanged");
        Log.i(TAG, "onBleSignalChanged");

        HashMap<String, Object> messageMap = new HashMap<>();
        messageMap.put("namespace", message.getNamespace());
        messageMap.put("type", message.getType());
        messageMap.put("content", message.getContent());

        HashMap<String, Object> bleMap = new HashMap<>();
        bleMap.put("rssi", bleSignal.getRssi());
        bleMap.put("txPower", bleSignal.getTxPower());

        event.success(
            ToMap.fromArgs("event", "onBleSignalChanged", "message", messageMap, "bleSignal", bleMap, "id", id));
        HMSLogger.getInstance(context).sendSingleEvent("MessageHandler.onBleSignalChanged");
    }
}
