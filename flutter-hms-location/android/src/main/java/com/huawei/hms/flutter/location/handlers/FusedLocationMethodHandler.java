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

import static androidx.core.content.PermissionChecker.checkSelfPermission;

import android.app.Activity;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Looper;
import android.util.Log;
import android.util.Pair;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.location.constants.Action;
import com.huawei.hms.flutter.location.constants.Error;
import com.huawei.hms.flutter.location.listeners.DefaultFailureListener;
import com.huawei.hms.flutter.location.listeners.DefaultSuccessListener;
import com.huawei.hms.flutter.location.listeners.LocationSettingsFailureListener;
import com.huawei.hms.flutter.location.listeners.RemoveUpdatesSuccessListener;
import com.huawei.hms.flutter.location.listeners.RequestUpdatesFailureListener;
import com.huawei.hms.flutter.location.listeners.RequestUpdatesSuccessListener;
import com.huawei.hms.flutter.location.logger.HMSLogger;
import com.huawei.hms.flutter.location.utils.LocationUtils;
import com.huawei.hms.flutter.location.utils.ValueGetter;
import com.huawei.hms.location.FusedLocationProviderClient;
import com.huawei.hms.location.LocationEnhanceService;
import com.huawei.hms.location.LocationRequest;
import com.huawei.hms.location.LocationServices;
import com.huawei.hms.location.LocationSettingsRequest;
import com.huawei.hms.location.LocationSettingsStates;
import com.huawei.hms.location.LogConfig;
import com.huawei.hms.location.NavigationRequest;
import com.huawei.hms.location.SettingsClient;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

public class FusedLocationMethodHandler implements MethodChannel.MethodCallHandler, ActivityResultListener {
    private static final String TAG = FusedLocationMethodHandler.class.getSimpleName();

    private final Activity activity;

    private final MethodChannel channel;

    private final Map<Integer, LocationCallbackHandler> callbacks;

    private final Map<Integer, PendingIntent> requests;

    private SettingsClient settingsClient;

    private FusedLocationProviderClient service;

    private LocationEnhanceService enhanceService;

    private LogConfig logConfig;

    private int requestCode = 0;

    private MethodChannel.Result result;

    public FusedLocationMethodHandler(final Activity activity, final MethodChannel channel) {
        this.activity = activity;
        this.channel = channel;
        callbacks = new HashMap<>();
        requests = new HashMap<>();
    }

    private void initFusedLocationService(final MethodChannel.Result result) {
        settingsClient = LocationServices.getSettingsClient(activity);
        service = LocationServices.getFusedLocationProviderClient(activity);
        enhanceService = LocationServices.getLocationEnhanceService(activity);
        Log.i(TAG, "Fused Location Service has been initialized.");
        result.success(null);
    }

    private void checkLocationSettings(final MethodCall call, final MethodChannel.Result result) {
        final LocationSettingsRequest request = LocationUtils.fromMapToLocationSettingsRequest(call.arguments());
        this.result = result;

        if (settingsClient == null) {
            result.error("-1", Error.FUSED_LOCATION_NOT_INITIALIZED.message(), null);
            return;
        }

        settingsClient.checkLocationSettings(request)
            .addOnSuccessListener(new DefaultSuccessListener<>(call.method, activity, result))
            .addOnFailureListener(new LocationSettingsFailureListener(result, activity));

    }

    private void getLastLocation(final MethodCall call, final MethodChannel.Result result) {
        if (service == null) {
            result.error("-1", Error.FUSED_LOCATION_NOT_INITIALIZED.message(), null);
            return;
        }

        service.getLastLocation()
            .addOnSuccessListener(new DefaultSuccessListener<>(call.method, activity, result))
            .addOnFailureListener(new DefaultFailureListener(call.method, activity, result));

    }

    private void getLastLocationWithAddress(final MethodCall call, final MethodChannel.Result result) {
        if (service == null) {
            result.error("-1", Error.FUSED_LOCATION_NOT_INITIALIZED.message(), null);
            return;
        }

        service.getLastLocationWithAddress(
                LocationUtils.fromMapToLocationRequest(call.<Map<String, Object>>arguments()))
            .addOnSuccessListener(new DefaultSuccessListener<>(call.method, activity, result))
            .addOnFailureListener(new DefaultFailureListener(call.method, activity, result));

    }

    private void getLocationAvailability(final MethodCall call, final MethodChannel.Result result) {
        if (service == null) {
            result.error("-1", Error.FUSED_LOCATION_NOT_INITIALIZED.message(), null);
            return;
        }

        service.getLocationAvailability()
            .addOnSuccessListener(new DefaultSuccessListener<>(call.method, activity, result))
            .addOnFailureListener(new DefaultFailureListener(call.method, activity, result));

    }

    private void setMockMode(final MethodCall call, final MethodChannel.Result result) {
        if (service == null) {
            result.error("-1", Error.FUSED_LOCATION_NOT_INITIALIZED.message(), null);
            return;
        }

        service.setMockMode(call.<Boolean>arguments())
            .addOnSuccessListener(new DefaultSuccessListener<>(call.method, activity, result))
            .addOnFailureListener(new DefaultFailureListener(call.method, activity, result));
    }

    private void setMockLocation(final MethodCall call, final MethodChannel.Result result) {
        if (service == null) {
            result.error("-1", Error.FUSED_LOCATION_NOT_INITIALIZED.message(), null);
            return;
        }

        service.setMockLocation(LocationUtils.fromMapToLocation(call.arguments()))
            .addOnSuccessListener(new DefaultSuccessListener<>(call.method, activity, result))
            .addOnFailureListener(new DefaultFailureListener(call.method, activity, result));

    }

    private void requestLocationUpdates(final MethodCall call, final MethodChannel.Result result) {
        final Pair<Integer, PendingIntent> intentData = buildLocationIntent();
        final LocationRequest request = LocationUtils.fromMapToLocationRequest(call.<Map<String, Object>>arguments());

        if (service == null) {
            result.error("-1", Error.FUSED_LOCATION_NOT_INITIALIZED.message(), null);
            return;
        }

        service.requestLocationUpdates(request, intentData.second)
            .addOnSuccessListener(new RequestUpdatesSuccessListener(call.method, activity, result, intentData.first))
            .addOnFailureListener(
                new RequestUpdatesFailureListener<>(call.method, activity, result, intentData.first, requests));

    }

    private void requestLocationUpdatesCb(final MethodCall call, final MethodChannel.Result result) {
        final LocationRequest request = LocationUtils.fromMapToLocationRequest(call.<Map<String, Object>>arguments());
        final Pair<Integer, LocationCallbackHandler> callbackData = buildCallback(call.method);

        if (service == null) {
            result.error("-1", Error.FUSED_LOCATION_NOT_INITIALIZED.message(), null);
            return;
        }

        service.requestLocationUpdates(request, callbackData.second, Looper.getMainLooper())
            .addOnSuccessListener(new RequestUpdatesSuccessListener(call.method, activity, result, callbackData.first))
            .addOnFailureListener(
                new RequestUpdatesFailureListener<>(call.method, activity, result, callbackData.first, callbacks));

    }

    private void requestLocationUpdatesExCb(final MethodCall call, final MethodChannel.Result result) {
        final LocationRequest request = LocationUtils.fromMapToLocationRequest(call.<Map<String, Object>>arguments());
        final Pair<Integer, LocationCallbackHandler> callbackData = buildCallback(call.method);

        if (service == null) {
            result.error("-1", Error.FUSED_LOCATION_NOT_INITIALIZED.message(), null);
            return;
        }

        service.requestLocationUpdatesEx(request, callbackData.second, Looper.getMainLooper())
            .addOnSuccessListener(new RequestUpdatesSuccessListener(call.method, activity, result, callbackData.first))
            .addOnFailureListener(
                new RequestUpdatesFailureListener<>(call.method, activity, result, callbackData.first, callbacks));

    }

    private void removeLocationUpdates(final MethodCall call, final MethodChannel.Result result) {
        final int incomingRequestCode = call.<Integer>arguments();

        if (!requests.containsKey(incomingRequestCode)) {
            result.error(Error.NON_EXISTING_REQUEST_ID.name(), Error.NON_EXISTING_REQUEST_ID.message(), null);
        } else {
            if (service == null) {
                result.error("-1", Error.FUSED_LOCATION_NOT_INITIALIZED.message(), null);
                return;
            }

            service.removeLocationUpdates(requests.get(incomingRequestCode))
                .addOnSuccessListener(
                    new RemoveUpdatesSuccessListener<>(call.method, activity, result, incomingRequestCode, requests))
                .addOnFailureListener(new DefaultFailureListener(call.method, activity, result));

        }
    }

    private void removeLocationUpdatesCb(final MethodCall call, final MethodChannel.Result result) {
        final int callbackId = call.<Integer>arguments();

        if (!callbacks.containsKey(callbackId)) {
            result.error(Error.NON_EXISTING_REQUEST_ID.name(), Error.NON_EXISTING_REQUEST_ID.message(), null);
        } else {
            if (service == null) {
                result.error("-1", "FusedLocationService is not initialized.", null);
                return;
            }

            service.removeLocationUpdates(callbacks.get(callbackId))
                .addOnSuccessListener(
                    new RemoveUpdatesSuccessListener<>(call.method, activity, result, callbackId, callbacks))
                .addOnFailureListener(new DefaultFailureListener(call.method, activity, result));

        }
    }

    private void getNavigationContextState(final MethodCall call, final MethodChannel.Result result) {
        final NavigationRequest request = LocationUtils.fromMapToNavigationRequest(call.arguments());
        if (enhanceService == null) {
            result.error("-1", Error.FUSED_LOCATION_NOT_INITIALIZED.message(), null);
            return;
        }
        enhanceService.getNavigationState(request)
            .addOnSuccessListener(new DefaultSuccessListener<>(call.method, activity, result))
            .addOnFailureListener(new DefaultFailureListener(call.method, activity, result));

    }

    private void enableBackgroundLocation(final MethodCall call, final MethodChannel.Result result) {
        int hasPermission = checkSelfPermission(activity.getApplicationContext(),
            android.Manifest.permission.FOREGROUND_SERVICE);
        if (hasPermission == -1) {
            result.error("NO_PERMISSION", "App does not have FOREGROUND_SERVICE permission.", null);
        }

        Notification.Builder builder;
        Notification mNotification;
        Map notification = call.argument("notification");
        String channelName = ValueGetter.getString("channelName", notification);
        int priority = ValueGetter.getInt("priority", notification);
        int notificationId = call.argument("notificationId");
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationManager notificationManager = (NotificationManager) activity.getApplicationContext()
                .getSystemService(Context.NOTIFICATION_SERVICE);
            String channelId = "com.huawei.hms.location.flutter.LOCATION_NOTIFICATION";
            NotificationChannel notificationChannel = new NotificationChannel(channelId, channelName, priority);
            notificationManager.createNotificationChannel(notificationChannel);
            builder = new Notification.Builder(activity.getApplicationContext(), channelId);
        } else {
            builder = new Notification.Builder(activity.getApplicationContext());
        }
        LocationUtils.fillNotificationBuilder(activity.getApplicationContext(), builder, notification);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
            mNotification = builder.build();
        } else {
            mNotification = builder.getNotification();
        }

        if (service == null) {
            result.error("-1", Error.FUSED_LOCATION_NOT_INITIALIZED.message(), null);
            return;
        }

        service.enableBackgroundLocation(notificationId, mNotification)
            .addOnSuccessListener(new DefaultSuccessListener<>(call.method, activity, result))
            .addOnFailureListener(e -> Log.e(TAG, e.getMessage()));

    }

    private void disableBackgroundLocation(final MethodCall call, final MethodChannel.Result result) {
        if (service == null) {
            result.error("-1", Error.FUSED_LOCATION_NOT_INITIALIZED.message(), null);
            return;
        }

        service.disableBackgroundLocation()
            .addOnSuccessListener(new DefaultSuccessListener<>(call.method, activity, result))
            .addOnFailureListener(new DefaultFailureListener(call.method, activity, result));
    }

    private void setLogConfig(final MethodCall call, final MethodChannel.Result result) {
        int readStorage = checkSelfPermission(activity.getApplicationContext(),
            android.Manifest.permission.READ_EXTERNAL_STORAGE);
        int writeStorage = checkSelfPermission(activity.getApplicationContext(),
            android.Manifest.permission.WRITE_EXTERNAL_STORAGE);
        if (readStorage == -1 && writeStorage == -1) {
            result.error("NO_PERMISSION", "App does not have storage permission.", null);
        }

        logConfig = LocationUtils.fromMapToLogConfig(call.arguments());

        if (settingsClient == null) {
            result.error("-1", Error.FUSED_LOCATION_NOT_INITIALIZED.message(), null);
            return;
        }

        settingsClient.setLogConfig(logConfig).addOnFailureListener(e -> Log.e(TAG, e.getMessage()));
        if (isLogFilePath(logConfig.getLogPath())) {
            result.success("success");
        }
    }

    private boolean isLogFilePath(String logPath) {
        File folder = new File(logPath);
        return folder.exists();
    }

    private void getLogConfig(final MethodCall call, final MethodChannel.Result result) {
        if (logConfig == null) {
            result.error("Error", "LogConfig is null", null);
            return;
        }
        result.success(LocationUtils.fromLogConfigToMap(logConfig));
    }

    private Pair<Integer, LocationCallbackHandler> buildCallback(final String methodName) {
        final LocationCallbackHandler callBack = new LocationCallbackHandler(activity.getApplicationContext(),
            methodName, ++requestCode, channel);
        callbacks.put(requestCode, callBack);
        return Pair.create(requestCode, callBack);
    }

    private Pair<Integer, PendingIntent> buildLocationIntent() {
        final Intent intent = new Intent();
        intent.setPackage(activity.getPackageName());
        intent.setAction(Action.PROCESS_LOCATION);
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
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final MethodChannel.Result result) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer(call.method);

        switch (call.method) {
            case "initFusedLocationService":
                initFusedLocationService(result);
                break;
            case "checkLocationSettings":
                checkLocationSettings(call, result);
                break;
            case "getLastLocation":
                getLastLocation(call, result);
                break;
            case "getLastLocationWithAddress":
                getLastLocationWithAddress(call, result);
                break;
            case "getLocationAvailability":
                getLocationAvailability(call, result);
                break;
            case "setMockMode":
                setMockMode(call, result);
                break;
            case "setMockLocation":
                setMockLocation(call, result);
                break;
            case "requestLocationUpdates":
                requestLocationUpdates(call, result);
                break;
            case "requestLocationUpdatesCb":
                requestLocationUpdatesCb(call, result);
                break;
            case "requestLocationUpdatesExCb":
                requestLocationUpdatesExCb(call, result);
                break;
            case "removeLocationUpdates":
                removeLocationUpdates(call, result);
                break;
            case "removeLocationUpdatesCb":
                removeLocationUpdatesCb(call, result);
                break;
            case "getNavigationContextState":
                getNavigationContextState(call, result);
                break;
            case "enableBackgroundLocation":
                enableBackgroundLocation(call, result);
                break;
            case "disableBackgroundLocation":
                disableBackgroundLocation(call, result);
                break;
            case "setLogConfig":
                setLogConfig(call, result);
                break;
            case "getLogConfig":
                getLogConfig(call, result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    @Override
    public boolean onActivityResult(final int requestCode, final int resultCode, final Intent intent) {
        final MethodChannel.Result incomingResult = result;
        result = null;

        if (incomingResult != null && requestCode == 0) {
            if (resultCode == Activity.RESULT_OK) {
                final LocationSettingsStates states = LocationSettingsStates.fromIntent(intent);
                HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent("checkLocationSettings.onActivityResult");
                incomingResult.success(LocationUtils.fromLocationSettingsStatesToMap(states));
            } else {
                HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent("checkLocationSettings" + ".onActivityResult", "-1");
                incomingResult.error(Error.LOCATION_SETTINGS_NOT_AVAILABLE.name(),
                    Error.LOCATION_SETTINGS_NOT_AVAILABLE.message(), null);
            }
        }

        return true;
    }
}
