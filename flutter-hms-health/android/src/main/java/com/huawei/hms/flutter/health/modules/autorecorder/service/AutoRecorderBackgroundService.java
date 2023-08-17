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
import static com.huawei.hms.flutter.health.modules.autorecorder.utils.AutoRecorderConstants.CHRONOMETER;
import static com.huawei.hms.flutter.health.modules.autorecorder.utils.AutoRecorderConstants.MIPMAP;
import static com.huawei.hms.flutter.health.modules.autorecorder.utils.AutoRecorderConstants.START_BACKGROUND_SERVICE_ACTION;
import static com.huawei.hms.flutter.health.modules.autorecorder.utils.AutoRecorderConstants.STOP_BACKGROUND_SERVICE_ACTION;
import static com.huawei.hms.flutter.health.modules.autorecorder.utils.AutoRecorderConstants.SUB_TEXT;
import static com.huawei.hms.flutter.health.modules.autorecorder.utils.AutoRecorderConstants.TEXT;
import static com.huawei.hms.flutter.health.modules.autorecorder.utils.AutoRecorderConstants.TICKER;
import static com.huawei.hms.flutter.health.modules.autorecorder.utils.AutoRecorderConstants.TITLE;

import android.Manifest;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.res.Resources;
import android.os.Build;
import android.os.Bundle;
import android.os.IBinder;

import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;

import com.huawei.hms.hihealth.AutoRecorderController;
import com.huawei.hms.hihealth.HuaweiHiHealth;
import com.huawei.hms.hihealth.data.DataType;

import io.flutter.Log;

public class AutoRecorderBackgroundService extends Service {
    private static final String TAG = "HMSAutoRecorder";

    private static final String NOTIFICATION_CHANNEL_ID = "hms-health";

    // HMS Health AutoRecorderController
    private AutoRecorderController autoRecorderController;

    private Context context;

    private static int configSmallIcon(Bundle bundle, Context context) {
        Resources res = context.getResources();
        String packageName = context.getPackageName();

        int resourceId;
        String value = null;
        if (bundle != null) {
            value = bundle.getString("smallIcon");
        }
        resourceId = value != null
            ? res.getIdentifier(value, MIPMAP, packageName)
            : res.getIdentifier("ic_notification", MIPMAP, packageName);

        if (resourceId == 0) {
            resourceId = res.getIdentifier("ic_launcher", MIPMAP, packageName);

            if (resourceId == 0) {
                resourceId = android.R.drawable.ic_dialog_info;
            }
        }
        return resourceId;
    }

    private static boolean hasValue(Bundle bundle, String key) {
        if (bundle != null) {
            String val = bundle.getString(key);
            if (val != null) {
                return !val.isEmpty();
            }
        }
        return false;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        context = getApplicationContext();
        initAutoRecorderController();
        Log.i(TAG, "Background service created.");
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        if (intent.getAction() != null) {
            if (intent.getAction().equals(START_BACKGROUND_SERVICE_ACTION)) {
                // Invoke the real-time callback interface of the HealthKit.
                getRemoteService(intent.getParcelableExtra("DataType"));
                // Binding a notification bar
                Bundle bundle = intent.getExtras();
                getNotification(bundle);
                return super.onStartCommand(intent, flags, startId);
            } else if (intent.getAction().equals(STOP_BACKGROUND_SERVICE_ACTION)) {
                stopForeground(true);
                stopSelf();
            }
        }
        return START_STICKY;
    }

    /**
     * init AutoRecorderController
     */
    private void initAutoRecorderController() {
        autoRecorderController = HuaweiHiHealth.getAutoRecorderController(context);
    }

    /**
     * Bind the service to the notification bar so that the service can be changed to a foreground service.
     */
    private void getNotification(Bundle bundle) {
        NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel channel = new NotificationChannel(NOTIFICATION_CHANNEL_ID, "HmsHealth",
                NotificationManager.IMPORTANCE_DEFAULT);
            notificationManager.createNotificationChannel(channel);
        }
        PackageManager pm = context.getPackageManager();
        Intent notificationIntent = pm.getLaunchIntentForPackage(context.getPackageName());
        PendingIntent pendingIntent = PendingIntent.getActivity(context, 0, notificationIntent, 0);
        NotificationCompat.Builder notificationBuilder = new NotificationCompat.Builder(context,
            NOTIFICATION_CHANNEL_ID).setWhen(System.currentTimeMillis())
            .setPriority(NotificationCompat.PRIORITY_MAX)
            .setSmallIcon(configSmallIcon(bundle, context))
            .setContentTitle(getBundleString(bundle, TITLE))
            .setContentText(getBundleString(bundle, TEXT))
            .setContentIntent(pendingIntent)
            .setUsesChronometer(getBundleBoolean(bundle, CHRONOMETER))
            .setCategory(NotificationCompat.CATEGORY_SERVICE)
            .setOngoing(true);
        if (hasValue(bundle, TICKER)) {
            notificationBuilder.setTicker(bundle.getString(TICKER));
        }
        if (hasValue(bundle, SUB_TEXT)) {
            notificationBuilder.setSubText(bundle.getString(SUB_TEXT));
        }
        Notification notification = notificationBuilder.build();
        notification.flags = Notification.FLAG_ONGOING_EVENT;
        startForeground(1, notification);
    }

    /**
     * Callback Interface for Starting the Total Step Count
     */
    private void getRemoteService(DataType datatype) {
        if (autoRecorderController == null) {
            initAutoRecorderController();
        }
        // Start recording real-time steps.
        Log.i(TAG, "getRemoteService");
        autoRecorderController.startRecord(datatype, samplePoint -> {
                // The step count, time, and type data reported by the pedometer is called back to the app through
                // samplePoint.
                Intent intent = new Intent();
                intent.putExtra("SamplePoint", samplePoint);
                intent.setAction(BACKGROUND_SERVICE);
                // Transmits service data to activities through broadcast.
                sendBroadcast(intent, Manifest.permission.FOREGROUND_SERVICE);
            })
            .addOnSuccessListener(aVoid -> Log.i(TAG, "record steps success."))
            .addOnFailureListener(e -> Log.i(TAG, "report steps failed."));
    }

    private String getBundleString(Bundle bundle, String key) {
        String value = null;
        if (bundle != null) {
            value = bundle.getString(key);
        }
        return value != null ? value : "";
    }

    private boolean getBundleBoolean(Bundle bundle, String key) {
        boolean boolValue = false;
        if (bundle != null) {
            boolValue = bundle.getBoolean(key);
        }
        return boolValue;
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        stopForeground(true);
        stopSelf();
    }
}
