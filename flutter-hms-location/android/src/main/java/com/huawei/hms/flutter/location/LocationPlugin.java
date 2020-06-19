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
import com.huawei.hms.flutter.location.handlers.PermissionHandler;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class LocationPlugin implements FlutterPlugin, ActivityAware {
    private MethodChannel mPermissionMethodChannel;

    private MethodChannel mFusedLocationMethodChannel;

    private MethodChannel mGeofenceMethodChannel;

    private MethodChannel mActivityIdentificationMethodChannel;

    private EventChannel mFusedLocationEventChannel;

    private EventChannel mGeofenceEventChannel;

    private EventChannel mActivityIdentificationEventChannel;

    private EventChannel mActivityConversionEventChannel;

    private PermissionHandler mPermissionHandler;

    private EventChannel.StreamHandler mFusedLocationStreamHandler;

    private EventChannel.StreamHandler mGeofenceStreamHandler;

    private EventChannel.StreamHandler mActivityIdentificationStreamHandler;

    private EventChannel.StreamHandler mActivityConversionStreamHandler;

    private FusedLocationMethodHandler mFusedLocationMethodHandler;

    private GeofenceMethodHandler mGeofenceMethodHandler;

    private ActivityIdentificationMethodHandler mActivityIdentificationMethodHandler;

    public static void registerWith(final Registrar registrar) {
        final LocationPlugin instance = new LocationPlugin();
        final Activity activity = registrar.activity();
        final Context context = activity.getApplicationContext();
        final BinaryMessenger messenger = registrar.messenger();

        instance.onAttachedToEngine(context, messenger);
        instance.mPermissionHandler = new PermissionHandler(activity);
        instance.mPermissionMethodChannel.setMethodCallHandler(instance.mPermissionHandler);
        instance.mFusedLocationMethodHandler = new FusedLocationMethodHandler(activity,
            instance.mFusedLocationMethodChannel);
        instance.mFusedLocationMethodChannel.setMethodCallHandler(instance.mFusedLocationMethodHandler);
        instance.mGeofenceMethodHandler = new GeofenceMethodHandler(activity);
        instance.mGeofenceMethodChannel.setMethodCallHandler(instance.mGeofenceMethodHandler);
        instance.mActivityIdentificationMethodHandler = new ActivityIdentificationMethodHandler(activity);
        instance.mActivityIdentificationMethodChannel.setMethodCallHandler(
            instance.mActivityIdentificationMethodHandler);
        registrar.addRequestPermissionsResultListener(instance.mPermissionHandler);
        registrar.addActivityResultListener(instance.mFusedLocationMethodHandler);
    }

    private void initChannels(final BinaryMessenger messenger) {
        mPermissionMethodChannel = new MethodChannel(messenger, Channel.PERMISSON_METHOD.id());
        mFusedLocationMethodChannel = new MethodChannel(messenger, Channel.FUSED_LOCATION_METHOD.id());
        mGeofenceMethodChannel = new MethodChannel(messenger, Channel.GEOFENCE_METHOD.id());
        mActivityIdentificationMethodChannel = new MethodChannel(messenger,
            Channel.ACTIVITY_IDENTIFICATION_METHOD.id());
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
        mPermissionMethodChannel = null;
        mFusedLocationMethodChannel = null;
        mGeofenceMethodChannel = null;
        mActivityIdentificationMethodChannel = null;
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

        mPermissionHandler = new PermissionHandler(activity);
        mFusedLocationMethodHandler = new FusedLocationMethodHandler(activity, mFusedLocationMethodChannel);
        mGeofenceMethodHandler = new GeofenceMethodHandler(activity);
        mActivityIdentificationMethodHandler = new ActivityIdentificationMethodHandler(activity);

        binding.addRequestPermissionsResultListener(mPermissionHandler);
        binding.addActivityResultListener(mFusedLocationMethodHandler);

        mPermissionMethodChannel.setMethodCallHandler(mPermissionHandler);
        mFusedLocationMethodChannel.setMethodCallHandler(mFusedLocationMethodHandler);
        mGeofenceMethodChannel.setMethodCallHandler(mGeofenceMethodHandler);
        mActivityIdentificationMethodChannel.setMethodCallHandler(mActivityIdentificationMethodHandler);
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
        mActivityIdentificationMethodChannel.setMethodCallHandler(null);
        mGeofenceMethodChannel.setMethodCallHandler(null);
        mFusedLocationMethodChannel.setMethodCallHandler(null);
        mActivityIdentificationMethodHandler = null;
        mGeofenceMethodHandler = null;
        mFusedLocationMethodHandler = null;
        mPermissionHandler = null;
    }
}
