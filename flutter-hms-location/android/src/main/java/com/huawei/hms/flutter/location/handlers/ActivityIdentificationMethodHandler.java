/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
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
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.core.util.Pair;

import com.huawei.hms.flutter.location.constants.Action;
import com.huawei.hms.flutter.location.constants.Error;
import com.huawei.hms.flutter.location.listeners.DefaultFailureListener;
import com.huawei.hms.flutter.location.listeners.RemoveUpdatesSuccessListener;
import com.huawei.hms.flutter.location.listeners.RequestUpdatesFailureListener;
import com.huawei.hms.flutter.location.listeners.RequestUpdatesSuccessListener;
import com.huawei.hms.flutter.location.logger.HMSLogger;
import com.huawei.hms.flutter.location.utils.ActivityUtils;
import com.huawei.hms.location.ActivityConversionRequest;
import com.huawei.hms.location.ActivityIdentification;
import com.huawei.hms.location.ActivityIdentificationService;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ActivityIdentificationMethodHandler implements MethodCallHandler {
    private static final String TAG = ActivityIdentificationMethodHandler.class.getSimpleName();

    private final Activity activity;

    private final Map<Integer, PendingIntent> requests;

    private ActivityIdentificationService service;

    private int requestCode = 0;

    public ActivityIdentificationMethodHandler(final Activity activity) {
        this.activity = activity;
        requests = new HashMap<>();
    }

    private void initActivityIdentificationService(final Result result) {
        service = ActivityIdentification.getService(activity);
        Log.i(TAG, "Activity Identification Service has been initialized.");
        result.success(null);
    }

    private void createActivityIdentificationUpdates(final MethodCall call, final Result result) {
        final Pair<Integer, PendingIntent> intentData = buildPendingIntent(Action.PROCESS_IDENTIFICATION);

        if (service == null) {
            result.error("-1", Error.ACTIVITY_IDENTIFICATION_NOT_INITIALIZED.message(), null);
            return;
        }

        service.createActivityIdentificationUpdates(call.<Integer>arguments(), intentData.second)
            .addOnSuccessListener(new RequestUpdatesSuccessListener(call.method, activity, result, intentData.first))
            .addOnFailureListener(
                new RequestUpdatesFailureListener<>(call.method, activity, result, intentData.first, requests));
    }

    private void createActivityConversionUpdates(final MethodCall call, final Result result) {
        final List<Map<String, Object>> args = call.arguments();
        final Pair<Integer, PendingIntent> intentData = buildPendingIntent(Action.PROCESS_CONVERSION);
        final ActivityConversionRequest request
            = ActivityUtils.fromActivityConversionInfoListToActivityConversionRequest(args);

        if (service == null) {
            result.error("-1", Error.ACTIVITY_IDENTIFICATION_NOT_INITIALIZED.message(), null);
            return;
        }

        service.createActivityConversionUpdates(request, intentData.second)
            .addOnSuccessListener(new RequestUpdatesSuccessListener(call.method, activity, result, intentData.first))
            .addOnFailureListener(
                new RequestUpdatesFailureListener<>(call.method, activity, result, intentData.first, requests));
    }

    private void deleteActivityIdentificationUpdates(final MethodCall call, final Result result) {
        final int incomingRequestCode = call.<Integer>arguments();

        if (!requests.containsKey(incomingRequestCode)) {
            result.error(Error.NON_EXISTING_REQUEST_ID.name(), Error.NON_EXISTING_REQUEST_ID.message(), null);
        } else {
            if (service == null) {
                result.error("-1", Error.ACTIVITY_IDENTIFICATION_NOT_INITIALIZED.message(), null);
                return;
            }

            service.deleteActivityIdentificationUpdates(requests.get(incomingRequestCode))
                .addOnSuccessListener(
                    new RemoveUpdatesSuccessListener<>(call.method, activity, result, incomingRequestCode, requests))
                .addOnFailureListener(new DefaultFailureListener(call.method, activity, result));
        }
    }

    private void deleteActivityConversionUpdates(final MethodCall call, final Result result) {
        final int incomingRequestCode = call.<Integer>arguments();

        if (!requests.containsKey(incomingRequestCode)) {
            result.error(Error.NON_EXISTING_REQUEST_ID.name(), Error.NON_EXISTING_REQUEST_ID.message(), null);
        } else {
            if (service == null) {
                result.error("-1", Error.ACTIVITY_IDENTIFICATION_NOT_INITIALIZED.message(), null);
                return;
            }

            service.deleteActivityConversionUpdates(requests.get(incomingRequestCode))
                .addOnSuccessListener(
                    new RemoveUpdatesSuccessListener<>(call.method, activity, result, incomingRequestCode, requests))
                .addOnFailureListener(new DefaultFailureListener(call.method, activity, result));
        }
    }

    private Pair<Integer, PendingIntent> buildPendingIntent(final String action) {
        final Intent intent = new Intent();

        intent.setPackage(activity.getPackageName());
        intent.setAction(action);

        final PendingIntent pendingIntent;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            pendingIntent = PendingIntent.getBroadcast(activity.getApplicationContext(), ++requestCode, intent,
                PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_MUTABLE);
        } else {
            pendingIntent = PendingIntent.getBroadcast(activity.getApplicationContext(), ++requestCode, intent,
                PendingIntent.FLAG_UPDATE_CURRENT);
        }
        requests.put(requestCode, pendingIntent);
        return Pair.create(requestCode, pendingIntent);
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        HMSLogger.getInstance(activity).startMethodExecutionTimer(call.method);

        switch (call.method) {
            case "initActivityIdentificationService":
                initActivityIdentificationService(result);
                break;
            case "createActivityIdentificationUpdates":
                createActivityIdentificationUpdates(call, result);
                break;
            case "createActivityConversionUpdates":
                createActivityConversionUpdates(call, result);
                break;
            case "deleteActivityIdentificationUpdates":
                deleteActivityIdentificationUpdates(call, result);
                break;
            case "deleteActivityConversionUpdates":
                deleteActivityConversionUpdates(call, result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }
}
