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

package com.huawei.hms.flutter.awareness.barriers;

import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.os.Build;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.awareness.constants.Method;
import com.huawei.hms.flutter.awareness.constants.Param;
import com.huawei.hms.flutter.awareness.listeners.DefaultFailureListener;
import com.huawei.hms.flutter.awareness.logger.HMSLogger;
import com.huawei.hms.flutter.awareness.utils.Convert;
import com.huawei.hms.flutter.awareness.utils.ValueGetter;
import com.huawei.hms.kit.awareness.Awareness;
import com.huawei.hms.kit.awareness.BarrierClient;
import com.huawei.hms.kit.awareness.barrier.AwarenessBarrier;
import com.huawei.hms.kit.awareness.barrier.BarrierQueryRequest;
import com.huawei.hms.kit.awareness.barrier.BarrierUpdateRequest;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class BarrierMethodCallHandler implements MethodCallHandler {
    private final BarrierClient barrierClient;
    private final Context context;
    private final HMSLogger logger;
    private final PendingIntent pendingIntent;

    public BarrierMethodCallHandler(final Context mContext) {
        context = mContext;
        barrierClient = Awareness.getBarrierClient(mContext);
        logger = HMSLogger.getInstance(mContext);
        final String receiverAction = context.getPackageName() + "RECEIVER_ACTION";
        final Intent intent = new Intent(receiverAction);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            pendingIntent = PendingIntent.getBroadcast(context, 1, intent, PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_MUTABLE);
        } else {
            pendingIntent = PendingIntent.getBroadcast(context, 1, intent, PendingIntent.FLAG_UPDATE_CURRENT);
        }
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        switch (call.method) {
            case Method.QUERY_BARRIERS:
                queryBarriers(call, result);
                break;
            case Method.UPDATE_BARRIER:
                updateBarriers(call, result);
                break;
            case Method.DELETE_BARRIER:
                deleteBarrier(call, result);
                break;
            case Method.ENABLE_UPDATE_WINDOW:
                enableUpdateWindow(call);
                break;
            default:
                result.notImplemented();
        }
    }

    private void queryBarriers(final MethodCall call, final Result result) {
        final String queryBarriersMethodName = "queryBarriers";
        final BarrierQueryRequest request;
        final String queryType = ValueGetter.getString(Param.QUERY_TYPE, call);
        if (queryType.equals(Param.QUERY_TYPE_KEY)) {
            final List<String> barrierKeys = call.argument(Param.BARRIER_KEYS);
            if(barrierKeys!= null) {
                request = BarrierQueryRequest.forBarriers(Objects.requireNonNull(barrierKeys));
            } else {
                request = null;
            }
        } else if (queryType.equals(Param.QUERY_TYPE_ALL)) {
            request = BarrierQueryRequest.all();
        } else {
            request = null;
        }

        logger.startMethodExecutionTimer(queryBarriersMethodName);
        barrierClient.queryBarriers(request).addOnSuccessListener(barrierQueryResponse -> {
            result.success(Convert.barrierStatusMapToJson(barrierQueryResponse).toString());
            logger.sendSingleEvent(queryBarriersMethodName);
        }).addOnFailureListener(new DefaultFailureListener(result, logger, queryBarriersMethodName));
    }

    private void deleteBarrier(final MethodCall call, final Result result) {
        final String updateBarriersDeleteMethodName = "updateBarriers/delete";
        final BarrierUpdateRequest.Builder builder = new BarrierUpdateRequest.Builder();
        final BarrierUpdateRequest request;
        final String type = ValueGetter.getString(Param.DELETE_TYPE, call);
        if (type.equals(Param.WITH_LABEL)) {
            final String barrierLabel = ValueGetter.getString(Param.BARRIER_KEY, call);
            request = builder.deleteBarrier(barrierLabel).build();
        } else if (type.equals(Param.DELETE_ALL)) {
            request = builder.deleteAll().build();
        } else {
            request = null;
        }

        logger.startMethodExecutionTimer(updateBarriersDeleteMethodName);
        barrierClient.updateBarriers(request).addOnSuccessListener(aVoid -> {
            result.success(true);
            logger.sendSingleEvent(updateBarriersDeleteMethodName);
        }).addOnFailureListener(new DefaultFailureListener(result, logger, updateBarriersDeleteMethodName));
    }

    private void enableUpdateWindow(final MethodCall call) {
        final String startMethodExecutionTimerMethodName = "startMethodExecutionTimer";
        final boolean updateWindow = ValueGetter.getBoolean(Param.STATUS, call);
        logger.startMethodExecutionTimer(startMethodExecutionTimerMethodName);
        barrierClient.enableUpdateWindow(updateWindow);
        logger.sendSingleEvent(startMethodExecutionTimerMethodName);
    }

    private void addBarrier(final Map<String, Object> request, final Map<String, Object> args, final Result result,
        final AwarenessBarrier awarenessBarrier) {
        final String barrierLabel = ValueGetter.getString(Param.BARRIER_LABEL, request);
        final BarrierUpdateRequest.Builder builder = new BarrierUpdateRequest.Builder();
        final BarrierUpdateRequest barrierUpdateRequest = builder.addBarrier(barrierLabel, awarenessBarrier,
            pendingIntent).build();

        if (args.get(Param.AUTO_REMOVE) != null) {
            final String updateBarrierAutoRemoveMethodName = "updateBarriers/autoRemove";
            final boolean autoRemove = ValueGetter.getBoolean(Param.AUTO_REMOVE, args);
            logger.startMethodExecutionTimer(updateBarrierAutoRemoveMethodName);
            Awareness.getBarrierClient(context)
                .updateBarriers(barrierUpdateRequest, autoRemove)
                .addOnSuccessListener(aVoid -> {
                    logger.sendSingleEvent(updateBarrierAutoRemoveMethodName);
                    result.success(true);
                })
                .addOnFailureListener(new DefaultFailureListener(result, logger, updateBarrierAutoRemoveMethodName));
        } else {
            final String updateBarriersMethodName = "updateBarriers";
            logger.startMethodExecutionTimer(updateBarriersMethodName);
            Awareness.getBarrierClient(context).updateBarriers(barrierUpdateRequest).addOnSuccessListener(aVoid -> {
                result.success(true);
                logger.sendSingleEvent(updateBarriersMethodName);
            }).addOnFailureListener(new DefaultFailureListener(result, logger, updateBarriersMethodName));
        }

    }

    private void updateBarriers(final MethodCall call, final Result result) {
        final Map<String, Object> arguments = (Map<String, Object>) call.arguments;
        final Map<String, Object> request = (Map<String, Object>) arguments.get(Param.REQUEST);

        final String barrierEventType = ValueGetter.getString(Param.BARRIER_EVENT_TYPE,
            Objects.requireNonNull(request));
        final AwarenessBarrier awarenessBarrier;
        switch (barrierEventType) {
            case Param.HEADSET_BARRIER_RECEIVER_ACTION:
                awarenessBarrier = CreateBarriers.headsetBarrier(request);
                break;
            case Param.AMBIENT_LIGHT_BARRIER_RECEIVER_ACTION:
                awarenessBarrier = CreateBarriers.ambientLightBarrier(request);
                break;
            case Param.WIFI_BARRIER_RECEIVER_ACTION:
                awarenessBarrier = CreateBarriers.wifiBarrier(request);
                break;
            case Param.BLUETOOTH_BARRIER_RECEIVER_ACTION:
                awarenessBarrier = CreateBarriers.bluetoothBarrier(request);
                break;
            case Param.BEHAVIOR_BARRIER_RECEIVER_ACTION:
                awarenessBarrier = CreateBarriers.behaviorBarrier(request);
                break;
            case Param.LOCATION_BARRIER_RECEIVER_ACTION:
                awarenessBarrier = CreateBarriers.locationBarrier(request);
                break;
            case Param.SCREEN_BARRIER_RECEIVER_ACTION:
                awarenessBarrier = CreateBarriers.screenBarrier(request);
                break;
            case Param.TIME_BARRIER_RECEIVER_ACTION:
                awarenessBarrier = CreateBarriers.timeBarrier(request);
                break;
            case Param.BEACON_BARRIER_RECEIVER_ACTION:
                awarenessBarrier = CreateBarriers.beaconBarrier(request);
                break;
            case Param.COMBINED_BARRIER_RECEIVER_ACTION:
                awarenessBarrier = handleCombination(request, new ArrayList<>());
                break;
            default:
                awarenessBarrier = null;
        }
        if (awarenessBarrier != null) {
            addBarrier(request, arguments, result, awarenessBarrier);
        }
    }

    private AwarenessBarrier handleCombination(final Map<String, Object> args,
        final Collection<AwarenessBarrier> coll) {
        final String barrierType = ValueGetter.getString(Param.BARRIER_TYPE, args);
        AwarenessBarrier awarenessBarrier;

        switch (barrierType) {
            case Param.COMBINED_NOT:
                final Map<String, Object> barrierArgs = (Map<String, Object>) args.get(Param.BARRIER);
                awarenessBarrier = handleCombination(barrierArgs, new ArrayList<>());
                if (awarenessBarrier != null) {
                    awarenessBarrier = AwarenessBarrier.not(awarenessBarrier);
                }
                break;
            case Param.COMBINED_OR:
                final List<Map<String, Object>> orArgs = (List<Map<String, Object>>) args.get(Param.BARRIERS);
                if (orArgs != null) {
                    for (final Map<String, Object> innerObject : orArgs) {
                        final AwarenessBarrier innerOrBarrier = handleCombination(innerObject, new ArrayList<>());
                        coll.add(innerOrBarrier);
                    }
                }
                awarenessBarrier = AwarenessBarrier.or(coll);
                break;
            case Param.COMBINED_AND:
                final List<Map<String, Object>> andArgs = (List<Map<String, Object>>) args.get(Param.BARRIERS);
                if (andArgs != null) {
                    for (final Map<String, Object> innerObject : andArgs) {
                        final AwarenessBarrier innerAndBarrier = handleCombination(innerObject, new ArrayList<>());
                        coll.add(innerAndBarrier);
                    }
                }
                awarenessBarrier = AwarenessBarrier.and(coll);
                break;
            default:
                awarenessBarrier = findAwarenessBarrier(args);
        }
        return awarenessBarrier;
    }

    private AwarenessBarrier findAwarenessBarrier(final Map<String, Object> args) {
        final String barrierEventType = ValueGetter.getString(Param.BARRIER_EVENT_TYPE, args);
        final AwarenessBarrier awarenessBarrier;

        switch (barrierEventType) {
            case Param.HEADSET_BARRIER_RECEIVER_ACTION:
                awarenessBarrier = CreateBarriers.headsetBarrier(args);
                break;
            case Param.AMBIENT_LIGHT_BARRIER_RECEIVER_ACTION:
                awarenessBarrier = CreateBarriers.ambientLightBarrier(args);
                break;
            case Param.WIFI_BARRIER_RECEIVER_ACTION:
                awarenessBarrier = CreateBarriers.wifiBarrier(args);
                break;
            case Param.BLUETOOTH_BARRIER_RECEIVER_ACTION:
                awarenessBarrier = CreateBarriers.bluetoothBarrier(args);
                break;
            case Param.BEHAVIOR_BARRIER_RECEIVER_ACTION:
                awarenessBarrier = CreateBarriers.behaviorBarrier(args);
                break;
            case Param.LOCATION_BARRIER_RECEIVER_ACTION:
                awarenessBarrier = CreateBarriers.locationBarrier(args);
                break;
            case Param.SCREEN_BARRIER_RECEIVER_ACTION:
                awarenessBarrier = CreateBarriers.screenBarrier(args);
                break;
            case Param.TIME_BARRIER_RECEIVER_ACTION:
                awarenessBarrier = CreateBarriers.timeBarrier(args);
                break;
            case Param.BEACON_BARRIER_RECEIVER_ACTION:
                awarenessBarrier = CreateBarriers.beaconBarrier(args);
                break;
            default:
                awarenessBarrier = null;
        }
        return awarenessBarrier;
    }

}
