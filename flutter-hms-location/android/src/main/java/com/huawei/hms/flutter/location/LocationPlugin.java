/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.location;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.location.constants.Channel;
import com.huawei.hms.flutter.location.handlers.ActivityConversionStreamHandler;
import com.huawei.hms.flutter.location.handlers.ActivityIdentificationMethodHandler;
import com.huawei.hms.flutter.location.handlers.ActivityIdentificationStreamHandler;
import com.huawei.hms.flutter.location.handlers.FusedLocationMethodHandler;
import com.huawei.hms.flutter.location.handlers.FusedLocationStreamHandler;
import com.huawei.hms.flutter.location.handlers.GeofenceMethodHandler;
import com.huawei.hms.flutter.location.handlers.GeofenceStreamHandler;
import com.huawei.hms.flutter.location.handlers.HMSLoggerMethodHandler;
import com.huawei.hms.flutter.location.handlers.PermissionHandler;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class LocationPlugin implements FlutterPlugin, ActivityAware {
    private MethodChannel permissionMethodChannel;
    private MethodChannel fusedLocationMethodChannel;
    private MethodChannel geofenceMethodChannel;
    private MethodChannel activityIdentificationMethodChannel;
    private MethodChannel locationEnhanceMethodChannel;
    private MethodChannel hmsLoggerMethodChannel;
    private EventChannel mFusedLocationEventChannel;
    private EventChannel mGeofenceEventChannel;
    private EventChannel mActivityIdentificationEventChannel;
    private EventChannel mActivityConversionEventChannel;
    private PermissionHandler permissionHandler;
    private EventChannel.StreamHandler mFusedLocationStreamHandler;
    private EventChannel.StreamHandler mGeofenceStreamHandler;
    private EventChannel.StreamHandler mActivityIdentificationStreamHandler;
    private EventChannel.StreamHandler mActivityConversionStreamHandler;
    private FusedLocationMethodHandler fusedLocationMethodHandler;
    private GeofenceMethodHandler geofenceMethodHandler;
    private ActivityIdentificationMethodHandler activityIdentificationMethodHandler;
    private HMSLoggerMethodHandler hmsLoggerMethodHandler;

    public static void registerWith(final Registrar registrar) {
        final LocationPlugin instance = new LocationPlugin();
        final Activity activity = registrar.activity();
        final Context context = activity.getApplicationContext();
        final BinaryMessenger messenger = registrar.messenger();

        instance.onAttachedToEngine(context, messenger);
        instance.permissionHandler = new PermissionHandler(activity);
        instance.permissionMethodChannel.setMethodCallHandler(instance.permissionHandler);
        instance.fusedLocationMethodHandler = new FusedLocationMethodHandler(activity,
            instance.fusedLocationMethodChannel);
        instance.fusedLocationMethodChannel.setMethodCallHandler(instance.fusedLocationMethodHandler);
        instance.geofenceMethodHandler = new GeofenceMethodHandler(activity);
        instance.geofenceMethodChannel.setMethodCallHandler(instance.geofenceMethodHandler);
        instance.activityIdentificationMethodHandler = new ActivityIdentificationMethodHandler(activity);
        instance.activityIdentificationMethodChannel.setMethodCallHandler(instance.activityIdentificationMethodHandler);
        instance.hmsLoggerMethodHandler = new HMSLoggerMethodHandler(context);
        instance.hmsLoggerMethodChannel.setMethodCallHandler(instance.hmsLoggerMethodHandler);
        registrar.addRequestPermissionsResultListener(instance.permissionHandler);
        registrar.addActivityResultListener(instance.fusedLocationMethodHandler);
    }

    private void initChannels(final BinaryMessenger messenger) {
        permissionMethodChannel = new MethodChannel(messenger, Channel.PERMISSON_METHOD.id());
        fusedLocationMethodChannel = new MethodChannel(messenger, Channel.FUSED_LOCATION_METHOD.id());
        geofenceMethodChannel = new MethodChannel(messenger, Channel.GEOFENCE_METHOD.id());
        activityIdentificationMethodChannel = new MethodChannel(messenger, Channel.ACTIVITY_IDENTIFICATION_METHOD.id());
        locationEnhanceMethodChannel = new MethodChannel(messenger, Channel.LOCATION_ENHANCE_METHOD.id());
        hmsLoggerMethodChannel = new MethodChannel(messenger, Channel.HMSLOGGER_METHOD.id());
        mFusedLocationEventChannel = new EventChannel(messenger, Channel.FUSED_LOCATION_EVENT.id());
        mGeofenceEventChannel = new EventChannel(messenger, Channel.GEOFENCE_EVENT.id());
        mActivityIdentificationEventChannel = new EventChannel(messenger, Channel.ACTIVITY_IDENTIFICATION_EVENT.id());
        mActivityConversionEventChannel = new EventChannel(messenger, Channel.ACTIVITY_CONVERSION_EVENT.id());
    }

    private void initStreamHandlers(final Context context) {
        mFusedLocationStreamHandler = new FusedLocationStreamHandler(context);
        mGeofenceStreamHandler = new GeofenceStreamHandler(context);
        mActivityIdentificationStreamHandler = new ActivityIdentificationStreamHandler(context);
        mActivityConversionStreamHandler = new ActivityConversionStreamHandler(context);
    }

    private void setStreamHandlers() {
        mFusedLocationEventChannel.setStreamHandler(mFusedLocationStreamHandler);
        mGeofenceEventChannel.setStreamHandler(mGeofenceStreamHandler);
        mActivityIdentificationEventChannel.setStreamHandler(mActivityIdentificationStreamHandler);
        mActivityConversionEventChannel.setStreamHandler(mActivityConversionStreamHandler);
    }

    private void resetStreamHandlers() {
        mFusedLocationEventChannel.setStreamHandler(null);
        mGeofenceEventChannel.setStreamHandler(null);
        mActivityIdentificationEventChannel.setStreamHandler(null);
        mActivityConversionEventChannel.setStreamHandler(null);
    }

    private void removeStreamHandlers() {
        mFusedLocationStreamHandler = null;
        mGeofenceStreamHandler = null;
        mActivityIdentificationStreamHandler = null;
        mActivityConversionStreamHandler = null;
    }

    private void removeChannels() {
        permissionMethodChannel = null;
        fusedLocationMethodChannel = null;
        geofenceMethodChannel = null;
        activityIdentificationMethodChannel = null;
        locationEnhanceMethodChannel = null;
        hmsLoggerMethodChannel = null;
        mFusedLocationEventChannel = null;
        mGeofenceEventChannel = null;
        mActivityIdentificationEventChannel = null;
        mActivityConversionEventChannel = null;
    }

    private void onAttachedToEngine(final Context context, final BinaryMessenger messenger) {
        initChannels(messenger);
        initStreamHandlers(context);
        setStreamHandlers();
    }

    @Override
    public void onAttachedToEngine(@NonNull final FlutterPluginBinding binding) {
        onAttachedToEngine(binding.getApplicationContext(), binding.getBinaryMessenger());
    }

    @Override
    public void onDetachedFromEngine(@NonNull final FlutterPluginBinding binding) {
        resetStreamHandlers();
        removeStreamHandlers();
        removeChannels();
    }

    @Override
    public void onAttachedToActivity(@NonNull final ActivityPluginBinding binding) {
        final Activity activity = binding.getActivity();

        permissionHandler = new PermissionHandler(activity);
        fusedLocationMethodHandler = new FusedLocationMethodHandler(activity, fusedLocationMethodChannel);
        geofenceMethodHandler = new GeofenceMethodHandler(activity);
        activityIdentificationMethodHandler = new ActivityIdentificationMethodHandler(activity);
        hmsLoggerMethodHandler = new HMSLoggerMethodHandler(activity.getApplicationContext());

        binding.addRequestPermissionsResultListener(permissionHandler);
        binding.addActivityResultListener(fusedLocationMethodHandler);

        permissionMethodChannel.setMethodCallHandler(permissionHandler);
        fusedLocationMethodChannel.setMethodCallHandler(fusedLocationMethodHandler);
        geofenceMethodChannel.setMethodCallHandler(geofenceMethodHandler);
        activityIdentificationMethodChannel.setMethodCallHandler(activityIdentificationMethodHandler);
        hmsLoggerMethodChannel.setMethodCallHandler(hmsLoggerMethodHandler);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull final ActivityPluginBinding binding) {
        onAttachedToActivity(binding);
    }

    @Override
    public void onDetachedFromActivity() {
        activityIdentificationMethodChannel.setMethodCallHandler(null);
        geofenceMethodChannel.setMethodCallHandler(null);
        fusedLocationMethodChannel.setMethodCallHandler(null);
        locationEnhanceMethodChannel.setMethodCallHandler(null);
        hmsLoggerMethodChannel.setMethodCallHandler(null);
        activityIdentificationMethodHandler = null;
        geofenceMethodHandler = null;
        fusedLocationMethodHandler = null;
        permissionHandler = null;
        hmsLoggerMethodHandler = null;
    }
}
