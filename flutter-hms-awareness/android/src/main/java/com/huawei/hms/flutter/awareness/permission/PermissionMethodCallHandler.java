/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.awareness.permission;

import static androidx.core.content.PermissionChecker.PERMISSION_GRANTED;
import static androidx.core.content.PermissionChecker.checkSelfPermission;

import android.app.Activity;
import android.os.Build;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.awareness.constants.Method;
import com.huawei.hms.flutter.awareness.logger.HMSLogger;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.RequestPermissionsResultListener;

public class PermissionMethodCallHandler implements MethodCallHandler, RequestPermissionsResultListener {
    private static final String HUAWEI_ACTIVITY_RECOGNITION_PERMISSION = "android.permission.ACTIVITY_RECOGNITION";
    private static final String[] BG_LOC_PERMISSION_OLD = {
        android.Manifest.permission.ACCESS_COARSE_LOCATION, android.Manifest.permission.ACCESS_FINE_LOCATION
    };
    private final Activity activity;
    private final HMSLogger hmsLogger;
    private Result mResult;

    public PermissionMethodCallHandler(final Activity activity) {
        this.activity = activity;
        hmsLogger = HMSLogger.getInstance(activity.getApplicationContext());
    }

    private boolean hasLocationPermission() {
        hmsLogger.sendSingleEvent(Method.HAS_LOCATION_PERMISSION);
        return isCoarseLocGranted() && isFineLocGranted();
    }

    private boolean hasBackgroundLocationPermission() {
        hmsLogger.sendSingleEvent(Method.HAS_BACKGROUND_LOCATION_PERMISSION);
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.P) {
            return isFineLocGranted() && isBackgroundLocGranted();
        }
        return isCoarseLocGranted() || isFineLocGranted();
    }

    private boolean hasActivityRecognitionPermission() {
        hmsLogger.sendSingleEvent(Method.HAS_ACTIVITY_RECOGNITION_PERMISSION);
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.P) {
            return PERMISSION_GRANTED == checkSelfPermission(activity.getApplicationContext(),
                android.Manifest.permission.ACTIVITY_RECOGNITION);
        } else {
            return PERMISSION_GRANTED == checkSelfPermission(activity.getApplicationContext(),
                HUAWEI_ACTIVITY_RECOGNITION_PERMISSION);
        }
    }

    private void requestLocationPermission() {
        hmsLogger.sendSingleEvent(Method.REQUEST_LOCATION_PERMISSION);
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.P) {
            final String[] permissions = {
                android.Manifest.permission.ACCESS_COARSE_LOCATION, android.Manifest.permission.ACCESS_FINE_LOCATION,
                android.Manifest.permission.ACCESS_BACKGROUND_LOCATION
            };
            activity.requestPermissions(permissions, 1);
        } else {
            activity.requestPermissions(BG_LOC_PERMISSION_OLD, 2);
        }
    }

    private void requestBackgroundLocationPermission() {
        hmsLogger.sendSingleEvent(Method.REQUEST_BACKGROUND_LOCATION_PERMISSION);
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.P) {
            final String[] permissions = {
                android.Manifest.permission.ACCESS_COARSE_LOCATION, android.Manifest.permission.ACCESS_FINE_LOCATION,
                android.Manifest.permission.ACCESS_BACKGROUND_LOCATION
            };
            activity.requestPermissions(permissions, 3);
        } else {
            activity.requestPermissions(BG_LOC_PERMISSION_OLD, 4);
        }
    }

    private void requestActivityRecognitionPermission() {
        hmsLogger.sendSingleEvent(Method.REQUEST_ACTIVITY_RECOGNITION_PERMISSION);
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.P) {
            final String[] permissions = {android.Manifest.permission.ACTIVITY_RECOGNITION};
            activity.requestPermissions(permissions, 5);
        } else {
            final String[] permissions = {HUAWEI_ACTIVITY_RECOGNITION_PERMISSION};
            activity.requestPermissions(permissions, 6);
        }
    }

    private boolean isCoarseLocGranted() {
        final int coarseLoc = checkSelfPermission(activity, android.Manifest.permission.ACCESS_COARSE_LOCATION);
        return coarseLoc == PERMISSION_GRANTED;
    }

    private boolean isFineLocGranted() {
        final int fineLoc = checkSelfPermission(activity, android.Manifest.permission.ACCESS_FINE_LOCATION);
        return fineLoc == PERMISSION_GRANTED;
    }

    private boolean isBackgroundLocGranted() {
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.P) {
            final int backgroundLoc = checkSelfPermission(activity,
                android.Manifest.permission.ACCESS_BACKGROUND_LOCATION);
            return backgroundLoc == PERMISSION_GRANTED;
        }
        return true;
    }

    private boolean checkGrantStatus(final int[] grantResults) {
        for (final int i : grantResults) {
            if (i != 0) {
                return false;
            }
        }
        return true;
    }

    @Override
    public void onMethodCall(final MethodCall call, @NonNull final Result result) {
        mResult = result;
        hmsLogger.startMethodExecutionTimer(call.method);
        switch (call.method) {
            case Method.HAS_LOCATION_PERMISSION:
                mResult.success(hasLocationPermission());
                break;
            case Method.HAS_BACKGROUND_LOCATION_PERMISSION:
                mResult.success(hasBackgroundLocationPermission());
                break;
            case Method.HAS_ACTIVITY_RECOGNITION_PERMISSION:
                mResult.success(hasActivityRecognitionPermission());
                break;
            case Method.REQUEST_LOCATION_PERMISSION:
                requestLocationPermission();
                break;
            case Method.REQUEST_BACKGROUND_LOCATION_PERMISSION:
                requestBackgroundLocationPermission();
                break;
            case Method.REQUEST_ACTIVITY_RECOGNITION_PERMISSION:
                requestActivityRecognitionPermission();
                break;
            default:
                mResult.notImplemented();
        }
    }

    @Override
    public boolean onRequestPermissionsResult(final int requestCode, final String[] permissions,
        final int[] grantResults) {
        final Result incomingResult = mResult;
        mResult = null;

        if (incomingResult != null) {
            if (requestCode == 1) {
                incomingResult.success(grantResults[0] == 0 || grantResults[1] == 0);
            } else if (requestCode == 3) {
                incomingResult.success((grantResults[0] == 0 || grantResults[1] == 0) && grantResults[2] == 0);
            } else {
                incomingResult.success(checkGrantStatus(grantResults));
            }
        }
        return true;
    }
}
