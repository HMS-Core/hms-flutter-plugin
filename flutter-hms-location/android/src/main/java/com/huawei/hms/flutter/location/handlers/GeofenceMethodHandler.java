/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.location.handlers;

import android.app.Activity;
import android.app.PendingIntent;
import android.content.Intent;
import android.util.Pair;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.location.constants.Action;
import com.huawei.hms.flutter.location.constants.Errors;
import com.huawei.hms.flutter.location.listeners.DefaultFailureListener;
import com.huawei.hms.flutter.location.listeners.DefaultSuccessListener;
import com.huawei.hms.flutter.location.listeners.RemoveUpdatesSuccessListener;
import com.huawei.hms.flutter.location.listeners.RequestUpdatesFailureListener;
import com.huawei.hms.flutter.location.listeners.RequestUpdatesSuccessListener;
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
    private final Activity mActivity;

    private final GeofenceService mGeofenceService;

    private final Map<Integer, PendingIntent> mRequests;

    private int mRequestCode = 0;

    public GeofenceMethodHandler(final Activity activity) {
        mActivity = activity;
        mGeofenceService = LocationServices.getGeofenceService(activity);
        mRequests = new HashMap<>();
    }

    private void createGeofenceList(@NonNull final MethodCall call, @NonNull final Result result) {
        final GeofenceRequest geofenceRequest = GeofenceUtils.fromMapToGeofenceRequest(
            call.<Map<String, Object>>arguments());
        final Pair<Integer, PendingIntent> intentData = buildPendingIntent();
        mGeofenceService.createGeofenceList(geofenceRequest, intentData.second)
            .addOnSuccessListener(new RequestUpdatesSuccessListener(result, intentData.first))
            .addOnFailureListener(new RequestUpdatesFailureListener<>(result, intentData.first, mRequests));
    }

    private void deleteGeofenceList(@NonNull final MethodCall call, @NonNull final Result result) {
        final int requestCode = call.<Integer>arguments();
        if (!mRequests.containsKey(requestCode)) {
            result.error(Errors.NON_EXISTING_REQUEST_ID.name(), Errors.NON_EXISTING_REQUEST_ID.message(), null);
        } else {
            mGeofenceService.deleteGeofenceList(mRequests.get(requestCode))
                .addOnSuccessListener(new RemoveUpdatesSuccessListener<>(result, requestCode, mRequests))
                .addOnFailureListener(new DefaultFailureListener(result));
        }
    }

    private void deleteGeofenceListWithIds(@NonNull final MethodCall call, @NonNull final Result result) {
        mGeofenceService.deleteGeofenceList(call.<List<String>>arguments())
            .addOnSuccessListener(new DefaultSuccessListener<Void>(result))
            .addOnFailureListener(new DefaultFailureListener(result));
    }

    private Pair<Integer, PendingIntent> buildPendingIntent() {
        final Intent intent = new Intent();
        intent.setPackage(mActivity.getPackageName());
        intent.setAction(Action.PROCESS_GEOFENCE.id());
        final PendingIntent pendingIntent = PendingIntent.getBroadcast(mActivity.getApplicationContext(),
            mRequestCode++, intent, PendingIntent.FLAG_UPDATE_CURRENT);
        mRequests.put(mRequestCode, pendingIntent);
        return Pair.create(mRequestCode, pendingIntent);
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
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
