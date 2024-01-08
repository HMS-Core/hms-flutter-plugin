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

package com.huawei.hms.flutter.health.modules.autorecorder.service;

import static com.huawei.hms.flutter.health.modules.autorecorder.utils.AutoRecorderConstants.BACKGROUND_SERVICE;
import static com.huawei.hms.flutter.health.modules.autorecorder.utils.AutoRecorderConstants.START_BACKGROUND_SERVICE_ACTION;
import static com.huawei.hms.flutter.health.modules.autorecorder.utils.AutoRecorderConstants.STOP_BACKGROUND_SERVICE_ACTION;

import android.Manifest;
import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.os.Bundle;

import androidx.annotation.Nullable;
import androidx.core.content.ContextCompat;

import com.huawei.hms.flutter.health.foundation.utils.Utils;
import com.huawei.hms.flutter.health.modules.activityrecord.utils.ActivityRecordUtils;
import com.huawei.hms.flutter.health.modules.autorecorder.listener.VoidOnCompleteListener;
import com.huawei.hms.flutter.health.modules.autorecorder.utils.AutoRecorderConstants;
import com.huawei.hms.hihealth.AutoRecorderController;
import com.huawei.hms.hihealth.data.DataType;
import com.huawei.hms.hihealth.data.SamplePoint;
import com.huawei.hms.hihealth.options.OnSamplePointListener;

import com.google.gson.Gson;

import io.flutter.Log;

import java.util.Map;

public class DefaultAutoRecorderService implements AutoRecorderService {
    private static final String TAG = AutoRecorderConstants.AUTO_RECORDER_MODULE;

    // Broadcast receiver for getting data from service
    private AutoRecorderReceiver receiver;

    // Intent for background service
    private Intent serviceIntent;

    private Activity activity;

    public DefaultAutoRecorderService(Activity activity) {
        this.activity = activity;
    }

    /**
     * Record data via DataType supported by Huawei.
     *
     * @param autoRecorderController AutoRecorderController instance.
     * @param dataType DataType instance.
     * @param listener AutoRecorderTaskResultListener instance.
     */
    @Override
    public void startRecord(final AutoRecorderController autoRecorderController, final DataType dataType,
        final Map<String, Object> notificationProperties, final VoidOnCompleteListener listener) {
        Log.i(TAG, "call startRecordByType");

        startForegroundService(dataType, notificationProperties);
        OnSamplePointListener onSamplePointListener = samplePoint -> {
            Log.i(TAG, samplePoint.toString());
            String jsonStr;
            Gson gson = new Gson();
            jsonStr = gson.toJson(ActivityRecordUtils.samplePointToMap(samplePoint));
            sendEventToFlutter(jsonStr);
        };

        // Calling the autoRecorderController to startRecord by DataType is an asynchronous operation.
        autoRecorderController.startRecord(dataType, onSamplePointListener).addOnCompleteListener(taskResult -> {
            // The fail reason includes:
            //  1.the app hasn't been granted the scopes
            //  2.this type is not supported so far
            if (taskResult.getException() != null) {
                Log.i(TAG, "startRecord onComplete Exception: " + taskResult.getException().getLocalizedMessage());
            }
            Log.i(TAG, "startRecord onComplete");
            listener.onComplete(taskResult);
        }).addOnSuccessListener(result -> {
            Log.i(TAG, "startRecord success");
            listener.onSuccess(result);
        }).addOnFailureListener(error -> {
            Log.i(TAG, "startRecord error");
            listener.onFail(error);
        });
    }

    /**
     * Stop recording by specifying the data type.
     *
     * @param autoRecorderController AutoRecorderController instance.
     * @param dataType DataType instance.
     * @param listener AutoRecorderTaskResultListener instance.
     */
    @Override
    public void stopRecord(final AutoRecorderController autoRecorderController, final DataType dataType,
        final VoidOnCompleteListener listener) {
        stopForegroundService();
        Log.i(TAG, "call stopRecord");
        OnSamplePointListener onSamplePointListener = samplePoint -> {
            // Nothing will happen here
        };
        // Calling the autoRecorderController to stopRecord by DataType is an asynchronous operation.
        autoRecorderController.stopRecord(dataType, onSamplePointListener).addOnCompleteListener(taskResult -> {
            // The fail reason includes:
            //  1.the app hasn't been granted the scopes
            //  2.this type is not supported so far
            Log.i(TAG, "stopRecord onComplete");
            listener.onComplete(taskResult);
        }).addOnSuccessListener(result -> {
            Log.i(TAG, "stopRecord success");
            listener.onSuccess(result);
        }).addOnFailureListener(error -> {
            Log.i(TAG, "stopRecord error");
            listener.onFail(error);
        });
    }

    /**
     * Sends event with requested ON_COMPLETE_EVENT_TYPE.
     */
    private void startForegroundService(final DataType dataType, final @Nullable Map<String, Object> notification) {
        if (ContextCompat.checkSelfPermission(activity.getApplicationContext(), "android.permission.FOREGROUND_SERVICE")
            == PackageManager.PERMISSION_GRANTED) {
            serviceIntent = new Intent(activity, AutoRecorderBackgroundService.class);
            serviceIntent.setAction(START_BACKGROUND_SERVICE_ACTION);
            if (notification != null) {
                serviceIntent.putExtra("title", (String) notification.get("title"));
                serviceIntent.putExtra("text", (String) notification.get("text"));
                serviceIntent.putExtra("subText", (String) notification.get("subText"));
                serviceIntent.putExtra("ticker", (String) notification.get("ticker"));
                serviceIntent.putExtra("chronometer", Utils.getBoolOrDefault(notification, "chronometer"));
            }
            serviceIntent.putExtra("DataType", dataType);
            activity.startService(serviceIntent);
            // Register local receiver.
            receiver = new AutoRecorderReceiver();
            IntentFilter filter = new IntentFilter();
            filter.addAction(BACKGROUND_SERVICE);
            activity.registerReceiver(receiver, filter);
        } else {
            throw new SecurityException("The Foreground Service Permission is not granted.");
        }
    }

    private void stopForegroundService() {
        Intent intent = new Intent(activity, AutoRecorderBackgroundService.class);
        intent.setAction(STOP_BACKGROUND_SERVICE_ACTION);
        activity.stopService(intent);
        if (receiver != null) {
            activity.unregisterReceiver(receiver);
        }
    }

    public void sendEventToFlutter(final String json) {
        Intent intent = new Intent();
        intent.setAction(AutoRecorderConstants.AUTO_RECORDER_INTENT_ACTION);
        intent.putExtra("SamplePoint", json);
        activity.sendBroadcast(intent, Manifest.permission.FOREGROUND_SERVICE);
    }

    public void unregisterReceiver() {
        if (activity != null && receiver != null) {
            try {
                activity.unregisterReceiver(receiver);
                activity.stopService(serviceIntent);
            } catch (IllegalArgumentException e) {
                Log.i(TAG, "Receivers are already unregistered.");
            }
        }
    }

    /**
     * Broadcast receiver
     */
    public class AutoRecorderReceiver extends BroadcastReceiver {
        @Override
        public void onReceive(Context context, Intent intent) {
            Bundle bundle = intent.getExtras();
            String jsonStr = "";
            if (bundle != null) {
                SamplePoint samplePoint = (SamplePoint) bundle.get("SamplePoint");
                Gson gson = new Gson();
                jsonStr = gson.toJson(ActivityRecordUtils.samplePointToMap(samplePoint));
            }
            sendEventToFlutter(jsonStr);
        }
    }
}
