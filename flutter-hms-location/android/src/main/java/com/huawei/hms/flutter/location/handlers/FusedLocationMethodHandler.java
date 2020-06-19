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
import android.location.Location;
import android.os.Looper;
import android.util.Pair;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.location.constants.Action;
import com.huawei.hms.flutter.location.constants.Errors;
import com.huawei.hms.flutter.location.listeners.DefaultFailureListener;
import com.huawei.hms.flutter.location.listeners.DefaultSuccessListener;
import com.huawei.hms.flutter.location.listeners.LocationSettingsFailureListener;
import com.huawei.hms.flutter.location.listeners.RemoveUpdatesSuccessListener;
import com.huawei.hms.flutter.location.listeners.RequestUpdatesFailureListener;
import com.huawei.hms.flutter.location.listeners.RequestUpdatesSuccessListener;
import com.huawei.hms.flutter.location.utils.LocationUtils;
import com.huawei.hms.location.FusedLocationProviderClient;
import com.huawei.hms.location.HWLocation;
import com.huawei.hms.location.LocationAvailability;
import com.huawei.hms.location.LocationRequest;
import com.huawei.hms.location.LocationServices;
import com.huawei.hms.location.LocationSettingsRequest;
import com.huawei.hms.location.LocationSettingsResponse;
import com.huawei.hms.location.LocationSettingsStates;
import com.huawei.hms.location.SettingsClient;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener;

import java.util.HashMap;
import java.util.Map;

public class FusedLocationMethodHandler implements MethodChannel.MethodCallHandler, ActivityResultListener {
    private final Activity mActivity;

    private final MethodChannel mChannel;

    private final FusedLocationProviderClient mFusedLocationProviderClient;

    private final Map<Integer, LocationCallbackHandler> mCallbacks;

    private final Map<Integer, PendingIntent> mRequests;

    private final SettingsClient mSettingsClient;

    private int mRequestCode = 0;

    private MethodChannel.Result mResult;

    public FusedLocationMethodHandler(final Activity activity, final MethodChannel channel) {
        mChannel = channel;
        mActivity = activity;
        mCallbacks = new HashMap<>();
        mRequests = new HashMap<>();
        mSettingsClient = LocationServices.getSettingsClient(mActivity);
        mFusedLocationProviderClient = LocationServices.getFusedLocationProviderClient(activity);
    }

    private void checkLocationSettings(final MethodCall call, final MethodChannel.Result result) {
        mResult = result;

        final LocationSettingsRequest request = LocationUtils.fromMapToLocationSettingsRequest(
            call.<Map<String, Object>>arguments());
        mSettingsClient.checkLocationSettings(request)
            .addOnSuccessListener(new DefaultSuccessListener<LocationSettingsResponse>(result))
            .addOnFailureListener(new LocationSettingsFailureListener(result, mActivity));
    }

    private void getLastLocation(final MethodChannel.Result result) {
        mFusedLocationProviderClient.getLastLocation()
            .addOnSuccessListener(new DefaultSuccessListener<Location>(result))
            .addOnFailureListener(new DefaultFailureListener(result));
    }

    private void getLastLocationWithAddress(final MethodCall call, final MethodChannel.Result result) {
        mFusedLocationProviderClient.getLastLocationWithAddress(
            LocationUtils.fromMapToLocationRequest(call.<Map<String, Object>>arguments()))
            .addOnSuccessListener(new DefaultSuccessListener<HWLocation>(result))
            .addOnFailureListener(new DefaultFailureListener(result));
    }

    private void getLocationAvailability(final MethodChannel.Result result) {
        mFusedLocationProviderClient.getLocationAvailability()
            .addOnSuccessListener(new DefaultSuccessListener<LocationAvailability>(result))
            .addOnFailureListener(new DefaultFailureListener(result));
    }

    private void setMockMode(final MethodCall call, final MethodChannel.Result result) {
        mFusedLocationProviderClient.setMockMode(call.<Boolean>arguments())
            .addOnSuccessListener(new DefaultSuccessListener<Void>(result))
            .addOnFailureListener(new DefaultFailureListener(result));
    }

    private void setMockLocation(final MethodCall call, final MethodChannel.Result result) {
        mFusedLocationProviderClient.setMockLocation(
            LocationUtils.fromMapToLocation(call.<Map<String, Object>>arguments()))
            .addOnSuccessListener(new DefaultSuccessListener<Void>(result))
            .addOnFailureListener(new DefaultFailureListener(result));
    }

    private void requestLocationUpdates(final MethodCall call, final MethodChannel.Result result) {
        final Pair<Integer, PendingIntent> intentData = buildPendingIntent();
        final LocationRequest request = LocationUtils.fromMapToLocationRequest(call.<Map<String, Object>>arguments());
        mFusedLocationProviderClient.requestLocationUpdates(request, intentData.second)
            .addOnSuccessListener(new RequestUpdatesSuccessListener(result, intentData.first))
            .addOnFailureListener(new RequestUpdatesFailureListener<>(result, intentData.first, mRequests));
    }

    private void requestLocationUpdatesCb(final MethodCall call, final MethodChannel.Result result) {
        final LocationRequest request = LocationUtils.fromMapToLocationRequest(call.<Map<String, Object>>arguments());
        final Pair<Integer, LocationCallbackHandler> callbackData = buildCallback();
        mFusedLocationProviderClient.requestLocationUpdates(request, callbackData.second, Looper.getMainLooper())
            .addOnSuccessListener(new RequestUpdatesSuccessListener(result, callbackData.first))
            .addOnFailureListener(new RequestUpdatesFailureListener<>(result, callbackData.first, mCallbacks));
    }

    private void requestLocationUpdatesExCb(final MethodCall call, final MethodChannel.Result result) {
        final LocationRequest request = LocationUtils.fromMapToLocationRequest(call.<Map<String, Object>>arguments());
        final Pair<Integer, LocationCallbackHandler> callbackData = buildCallback();

        mFusedLocationProviderClient.requestLocationUpdatesEx(request, callbackData.second, Looper.getMainLooper())
            .addOnSuccessListener(new RequestUpdatesSuccessListener(result, callbackData.first))
            .addOnFailureListener(new RequestUpdatesFailureListener<>(result, callbackData.first, mCallbacks));
    }

    private void removeLocationUpdates(final MethodCall call, final MethodChannel.Result result) {
        final int requestCode = call.<Integer>arguments();
        if (!mRequests.containsKey(requestCode)) {
            result.error(Errors.NON_EXISTING_REQUEST_ID.name(), Errors.NON_EXISTING_REQUEST_ID.message(), null);
        } else {
            mFusedLocationProviderClient.removeLocationUpdates(mRequests.get(requestCode))
                .addOnSuccessListener(new RemoveUpdatesSuccessListener<>(result, requestCode, mRequests))
                .addOnFailureListener(new DefaultFailureListener(result));
        }
    }

    private void removeLocationUpdatesCb(final MethodCall call, final MethodChannel.Result result) {
        final int callbackId = call.<Integer>arguments();
        if (!mCallbacks.containsKey(callbackId)) {
            result.error(Errors.NON_EXISTING_REQUEST_ID.name(), Errors.NON_EXISTING_REQUEST_ID.message(), null);
        } else {
            mFusedLocationProviderClient.removeLocationUpdates(mCallbacks.get(callbackId))
                .addOnSuccessListener(new RemoveUpdatesSuccessListener<>(result, callbackId, mCallbacks))
                .addOnFailureListener(new DefaultFailureListener(result));
        }
    }

    private Pair<Integer, LocationCallbackHandler> buildCallback() {
        mRequestCode++;
        final LocationCallbackHandler callBack = new LocationCallbackHandler(mRequestCode, mChannel);
        mCallbacks.put(mRequestCode, callBack);
        return Pair.create(mRequestCode, callBack);
    }

    private Pair<Integer, PendingIntent> buildPendingIntent() {
        final Intent intent = new Intent();
        intent.setPackage(mActivity.getPackageName());
        intent.setAction(Action.PROCESS_LOCATION.id());
        final PendingIntent pendingIntent = PendingIntent.getBroadcast(mActivity.getApplicationContext(),
            mRequestCode++, intent, PendingIntent.FLAG_UPDATE_CURRENT);
        mRequests.put(mRequestCode, pendingIntent);
        return Pair.create(mRequestCode, pendingIntent);
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final MethodChannel.Result result) {
        switch (call.method) {
            case "checkLocationSettings":
                checkLocationSettings(call, result);
                break;
            case "getLastLocation":
                getLastLocation(result);
                break;
            case "getLastLocationWithAddress":
                getLastLocationWithAddress(call, result);
                break;
            case "getLocationAvailability":
                getLocationAvailability(result);
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
            default:
                result.notImplemented();
                break;
        }
    }

    @Override
    public boolean onActivityResult(final int requestCode, final int resultCode, final Intent data) {
        final MethodChannel.Result result = mResult;
        mResult = null;

        if (result != null && requestCode == 0) {
            if (resultCode == Activity.RESULT_OK) {
                final LocationSettingsStates states = LocationSettingsStates.fromIntent(data);
                result.success(LocationUtils.fromLocationSettingsStatesToMap(states));
            } else {
                result.error(Errors.LOCATION_SETTINGS_NOT_AVAILABLE.name(),
                    Errors.LOCATION_SETTINGS_NOT_AVAILABLE.message(), null);
            }
        }

        return true;
    }
}
