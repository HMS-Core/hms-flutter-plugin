/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.hmsavailability.handlers;

import android.app.Activity;
import android.app.PendingIntent;
import android.content.DialogInterface;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.api.HuaweiApiAvailability;
import com.huawei.hms.flutter.hmsavailability.utils.Constants;
import com.huawei.hms.flutter.hmsavailability.utils.FromMap;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class HmsAvailabilityHandler implements MethodChannel.MethodCallHandler, PluginRegistry.ActivityResultListener, DialogInterface.OnCancelListener, EventChannel.StreamHandler {
    private static final String TAG = "HmsAvailabilityHandler";

    private final Activity activity;
    private final BinaryMessenger messenger;

    private EventChannel eventChannel;
    private EventChannel.EventSink eventSink;

    public HmsAvailabilityHandler(Activity act, BinaryMessenger msg) {
        this.activity = act;
        this.messenger = msg;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "initStreams":
                init(result);
                break;
            case "getApiMap":
                gApiMap(result);
                break;
            case "getServicesVersionCode":
                servicesVersionCode(result);
                break;
            case "isHmsAvailable":
                isHmsAvailable(result);
                break;
            case "isHmsAvailableMinApk":
                isHmsAvailable(call, result);
                break;
            case "isHuaweiMobileNoticeAvailable":
                isNoticeAvailable(result);
                break;
            case "isUserResolvableError":
                userResolvableError(call, result);
                break;
            case "resolveError":
                resolve(call, result);
                break;
            case "getErrorDialog":
                getErrorDialog(call, result);
                break;
            case "getErrorString":
                getErrorString(call, result);
                break;
            case "showErrorDialogFragment":
                showErrorDialogFragment(call, result);
                break;
            case "showErrorNotification":
                showErrorNotification(call, result);
                break;
            case "dispose":
                dispose(result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void init(@NonNull MethodChannel.Result result) {
        eventChannel = new EventChannel(messenger, Constants.HMS_EVENT);
        eventChannel.setStreamHandler(this);
        Log.i(TAG, "Event channel has been created.");
        result.success(null);
    }

    private void gApiMap(@NonNull MethodChannel.Result result) {
        result.success(HuaweiApiAvailability.getApiMap());
    }

    private void servicesVersionCode(@NonNull MethodChannel.Result result) {
        result.success(HuaweiApiAvailability.getServicesVersionCode());
    }

    private void isHmsAvailable(@NonNull MethodChannel.Result result) {
        result.success(HuaweiApiAvailability.getInstance().isHuaweiMobileServicesAvailable(activity.getApplicationContext()));
    }

    private void isHmsAvailable(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Integer minApkVersion = FromMap.toInteger("minApkVersion", call.argument("minApkVersion"));

        if (minApkVersion == null) {
            result.error(TAG, "Apk version must not be null!", Constants.NULL_PARAMETER);
            return;
        }

        result.success(HuaweiApiAvailability.getInstance().isHuaweiMobileServicesAvailable(activity.getApplicationContext(), minApkVersion));
    }

    private void isNoticeAvailable(@NonNull MethodChannel.Result result) {
        result.success(HuaweiApiAvailability.getInstance().isHuaweiMobileNoticeAvailable(activity.getApplicationContext()));
    }

    private void userResolvableError(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Integer errorCode = FromMap.toInteger("errorCode", call.argument("errorCode"));
        Boolean usePendingIntent = call.argument("usePendingIntent");

        if (errorCode == null) {
            result.error(TAG, "Error code must not be null!", Constants.NULL_PARAMETER);
            return;
        }

        if (usePendingIntent == null) {
            usePendingIntent = false;
        }

        PendingIntent pendingIntent = HuaweiApiAvailability.getInstance().getResolveErrorPendingIntent(activity, errorCode);
        result.success(HuaweiApiAvailability.getInstance().isUserResolvableError(errorCode, !usePendingIntent ? null : pendingIntent));
    }

    private void resolve(@NonNull MethodCall call, MethodChannel.Result result) {
        Integer errCode = FromMap.toInteger("errCode", call.argument("errCode"));
        Integer reqCode = FromMap.toInteger("reqCode", call.argument("reqCode"));
        Boolean usePendingIntent = call.argument("usePendingIntent");

        if (errCode == null || reqCode == null) {
            result.error(TAG, "Error and request codes must not be null!", Constants.NULL_PARAMETER);
            return;
        }

        if (usePendingIntent == null) {
            usePendingIntent = false;
        }

        PendingIntent pendingIntent = HuaweiApiAvailability.getInstance().getResolveErrorPendingIntent(activity, errCode);
        HuaweiApiAvailability.getInstance().resolveError(activity, errCode, reqCode, !usePendingIntent ? null : pendingIntent);
    }

    private void getErrorDialog(@NonNull MethodCall call, MethodChannel.Result res) {
        Integer errC = FromMap.toInteger("errCode", call.argument("errCode"));
        Integer reqC = FromMap.toInteger("reqCode", call.argument("reqCode"));
        Boolean useCancelLis = call.argument("useCancelListener");

        if (errC == null || reqC == null) {
            res.error(TAG, "Error and request codes must not be null!", Constants.NULL_PARAMETER);
            return;
        }

        if (useCancelLis == null) {
            useCancelLis = false;
        }

        HuaweiApiAvailability.getInstance().getErrorDialog(activity, errC, reqC, !useCancelLis ? null : this).show();
    }

    private void getErrorString(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Integer errCode1 = FromMap.toInteger("errCode", call.argument("errCode"));

        if (errCode1 == null) {
            result.error(TAG, "Error code is null!", Constants.NULL_PARAMETER);
            return;
        }

        result.success(HuaweiApiAvailability.getInstance().getErrorString(errCode1));
    }

    private void showErrorDialogFragment(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Integer errCode2 = FromMap.toInteger("errCode", call.argument("errCode"));
        Integer reqCode2 = FromMap.toInteger("reqCode", call.argument("reqCode"));
        Boolean useCancelListener = call.argument("useCancelListener");

        if (errCode2 == null || reqCode2 == null) {
            result.error(TAG, "Error and request codes must not be null!!", Constants.NULL_PARAMETER);
            return;
        }

        if (useCancelListener == null) {
            useCancelListener = false;
        }

        result.success(HuaweiApiAvailability.getInstance().showErrorDialogFragment(activity, errCode2, reqCode2, !useCancelListener ? null : this));
    }

    private void showErrorNotification(@NonNull MethodCall call, MethodChannel.Result result) {
        Integer errCode3 = FromMap.toInteger("errCode", call.argument("errCode"));

        if (errCode3 == null) {
            result.error(TAG, "Error and request codes must not be null.", Constants.NULL_PARAMETER);
            return;
        }

        HuaweiApiAvailability.getInstance().showErrorNotification(activity, errCode3);
    }

    private void dispose(MethodChannel.Result result) {
        if (eventChannel == null) {
            Log.e(TAG, "Event channel is not initialized!");
            result.error(TAG, "Event channel is not initialized!", Constants.OBJECT_NOT_INITIALIZED);
            return;
        }

        eventChannel.setStreamHandler(null);
        eventChannel = null;
        Log.i(TAG, "Availability stream is destroyed");
        result.success(true);
    }

    @Override
    public void onCancel(DialogInterface dialog) {
        if (eventSink != null) {
            eventSink.success("onDialogCanceled");
        }
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        eventSink = events;
    }

    @Override
    public void onCancel(Object arguments) {
        eventSink = null;
    }

    @Override
    public boolean onActivityResult(int requestCode1, int resultCode, Intent data) {
        if (eventSink != null) {
            eventSink.success(String.valueOf(resultCode));
        }
        return true;
    }
}