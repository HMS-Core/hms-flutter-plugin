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

import androidx.annotation.NonNull;
import androidx.core.util.Pair;

import com.huawei.hms.flutter.location.constants.Action;
import com.huawei.hms.flutter.location.constants.Errors;
import com.huawei.hms.flutter.location.listeners.DefaultFailureListener;
import com.huawei.hms.flutter.location.listeners.RemoveUpdatesSuccessListener;
import com.huawei.hms.flutter.location.listeners.RequestUpdatesFailureListener;
import com.huawei.hms.flutter.location.listeners.RequestUpdatesSuccessListener;
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
    private final ActivityIdentificationService mActivityIdentificationService;

    private final Activity mActivity;

    private final Map<Integer, PendingIntent> mRequests;

    private int mRequestCode = 0;

    public ActivityIdentificationMethodHandler(final Activity activity) {
        mActivityIdentificationService = ActivityIdentification.getService(activity);
        mActivity = activity;
        mRequests = new HashMap<>();
    }

    private void createActivityIdentificationUpdates(final MethodCall call, final Result result) {
        final Pair<Integer, PendingIntent> intentData = buildPendingIntent(Action.PROCESS_IDENTIFICATION.id());
        mActivityIdentificationService.createActivityIdentificationUpdates(call.<Integer>arguments(), intentData.second)
            .addOnSuccessListener(new RequestUpdatesSuccessListener(result, intentData.first))
            .addOnFailureListener(new RequestUpdatesFailureListener<>(result, intentData.first, mRequests));
    }

    private void createActivityConversionUpdates(final MethodCall call, final Result result) {
        final List<Map<String, Object>> args = call.arguments();
        final Pair<Integer, PendingIntent> intentData = buildPendingIntent(Action.PROCESS_CONVERSION.id());
        final ActivityConversionRequest request
            = ActivityUtils.fromActivityConversionInfoListToActivityConversionRequest(args);

        mActivityIdentificationService.createActivityConversionUpdates(request, intentData.second)
            .addOnSuccessListener(new RequestUpdatesSuccessListener(result, intentData.first))
            .addOnFailureListener(new RequestUpdatesFailureListener<>(result, intentData.first, mRequests));
    }

    private void deleteActivityIdentificationUpdates(final MethodCall call, final Result result) {
        final int requestCode = call.<Integer>arguments();
        if (!mRequests.containsKey(requestCode)) {
            result.error(Errors.NON_EXISTING_REQUEST_ID.name(), Errors.NON_EXISTING_REQUEST_ID.message(), null);
        } else {
            mActivityIdentificationService.deleteActivityIdentificationUpdates(mRequests.get(requestCode))
                .addOnSuccessListener(new RemoveUpdatesSuccessListener<>(result, requestCode, mRequests))
                .addOnFailureListener(new DefaultFailureListener(result));
        }
    }

    private void deleteActivityConversionUpdates(final MethodCall call, final Result result) {
        final int requestCode = call.<Integer>arguments();
        if (!mRequests.containsKey(requestCode)) {
            result.error(Errors.NON_EXISTING_REQUEST_ID.name(), Errors.NON_EXISTING_REQUEST_ID.message(), null);
        } else {
            mActivityIdentificationService.deleteActivityConversionUpdates(mRequests.get(requestCode))
                .addOnSuccessListener(new RemoveUpdatesSuccessListener<>(result, requestCode, mRequests))
                .addOnFailureListener(new DefaultFailureListener(result));
        }
    }

    private Pair<Integer, PendingIntent> buildPendingIntent(final String action) {
        final Intent intent = new Intent();
        intent.setPackage(mActivity.getPackageName());
        intent.setAction(action);
        final PendingIntent pendingIntent = PendingIntent.getBroadcast(mActivity.getApplicationContext(),
            mRequestCode++, intent, PendingIntent.FLAG_UPDATE_CURRENT);
        mRequests.put(mRequestCode, pendingIntent);
        return Pair.create(mRequestCode, pendingIntent);
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        switch (call.method) {
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
