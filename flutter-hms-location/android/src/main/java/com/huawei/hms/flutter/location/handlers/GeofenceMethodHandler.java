/*
 * Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.location.handlers;

import android.app.Activity;
import android.app.PendingIntent;
import android.content.Intent;
import android.os.Build;
import android.util.Pair;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.location.constants.Action;
import com.huawei.hms.flutter.location.constants.Error;
import com.huawei.hms.flutter.location.listeners.DefaultFailureListener;
import com.huawei.hms.flutter.location.listeners.DefaultSuccessListener;
import com.huawei.hms.flutter.location.listeners.RemoveUpdatesSuccessListener;
import com.huawei.hms.flutter.location.listeners.RequestUpdatesFailureListener;
import com.huawei.hms.flutter.location.listeners.RequestUpdatesSuccessListener;
import com.huawei.hms.flutter.location.logger.HMSLogger;
import com.huawei.hms.flutter.location.utils.GeofenceUtils;
import com.huawei.hms.location.GeofenceRequest;
import com.huawei.hms.location.GeofenceService;
import com.huawei.hms.location.LocationServices;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GeofenceMethodHandler implements MethodCallHandler {
    private final Activity activity;

    private final GeofenceService service;

    private final Map<Integer, PendingIntent> requests;

    private int requestCode = 0;

    public GeofenceMethodHandler(final Activity activity) {
        this.activity = activity;
        service = LocationServices.getGeofenceService(activity);
        requests = new HashMap<>();
    }

    private void createGeofenceList(@NonNull final MethodCall call, @NonNull final Result result) {
        final GeofenceRequest geofenceRequest = GeofenceUtils.fromMapToGeofenceRequest(call.arguments());
        final Pair<Integer, PendingIntent> intentData = buildGeofenceIntent();

        service.createGeofenceList(geofenceRequest, intentData.second)
            .addOnSuccessListener(new RequestUpdatesSuccessListener(call.method, activity, result, intentData.first))
            .addOnFailureListener(
                new RequestUpdatesFailureListener<>(call.method, activity, result, intentData.first, requests));
    }

    private void deleteGeofenceList(@NonNull final MethodCall call, @NonNull final Result result) {
        final int incomingRequestCode = call.<Integer>arguments();

        if (!requests.containsKey(incomingRequestCode)) {
            result.error(Error.NON_EXISTING_REQUEST_ID.name(), Error.NON_EXISTING_REQUEST_ID.message(), null);
        } else {
            service.deleteGeofenceList(requests.get(incomingRequestCode))
                .addOnSuccessListener(
                    new RemoveUpdatesSuccessListener<>(call.method, activity, result, incomingRequestCode, requests))
                .addOnFailureListener(new DefaultFailureListener(call.method, activity, result));
        }
    }

    private void deleteGeofenceListWithIds(@NonNull final MethodCall call, @NonNull final Result result) {
        service.deleteGeofenceList(call.<List<String>>arguments())
            .addOnSuccessListener(new DefaultSuccessListener<>(call.method, activity, result))
            .addOnFailureListener(new DefaultFailureListener(call.method, activity, result));
    }

    private Pair<Integer, PendingIntent> buildGeofenceIntent() {
        final Intent intent = new Intent();
        intent.setPackage(activity.getPackageName());
        intent.setAction(Action.PROCESS_GEOFENCE);
        final PendingIntent pendingIntent;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            pendingIntent = PendingIntent.getBroadcast(activity.getApplicationContext(), ++requestCode,
                    intent, PendingIntent.FLAG_UPDATE_CURRENT|PendingIntent.FLAG_MUTABLE);
        } else {
            pendingIntent = PendingIntent.getBroadcast(activity.getApplicationContext(), ++requestCode,
                    intent, PendingIntent.FLAG_UPDATE_CURRENT);
        }
        requests.put(requestCode, pendingIntent);
        return Pair.create(requestCode, pendingIntent);
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer(call.method);

        switch (call.method) {
            case "createGeofenceList":
                createGeofenceList(call, result);
                break;
            case "deleteGeofenceList":
                deleteGeofenceList(call, result);
                break;
            case "deleteGeofenceListWithIds":
                deleteGeofenceListWithIds(call, result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }
}
