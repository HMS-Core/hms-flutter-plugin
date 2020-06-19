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

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.RequestPermissionsResultListener;

public class PermissionHandler implements MethodCallHandler, RequestPermissionsResultListener {
    private final Activity mActivity;

    private Result mResult;

    public PermissionHandler(final Activity activity) {
        mActivity = activity;
    }

    private boolean hasLocationPermission() {
        return isCoarseLocGranted() && isFineLocGranted();
    }

    private boolean hasBackgroundLocationPermission() {
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.P) {
            return isFineLocGranted() && isBackgroundLocGranted();
        }
        return isFineLocGranted();
    }

    private boolean hasActivityRecognitionPermission() {
        return (Build.VERSION.SDK_INT > Build.VERSION_CODES.P
            && ActivityCompat.checkSelfPermission(mActivity, "android.permission.ACTIVITY_RECOGNITION")
            == PackageManager.PERMISSION_GRANTED) || (Build.VERSION.SDK_INT <= Build.VERSION_CODES.P
            && ActivityCompat.checkSelfPermission(mActivity, "com.huawei.hms.permission.ACTIVITY_RECOGNITION")
            == PackageManager.PERMISSION_GRANTED);
    }

    private void requestLocationPermission() {
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.P) {
            final String[] permissions = {
                Manifest.permission.ACCESS_COARSE_LOCATION, Manifest.permission.ACCESS_FINE_LOCATION,
                "android.permission.ACCESS_BACKGROUND_LOCATION"
            };
            ActivityCompat.requestPermissions(mActivity, permissions, 1);
        } else {
            final String[] permissions = {
                Manifest.permission.ACCESS_COARSE_LOCATION, Manifest.permission.ACCESS_FINE_LOCATION
            };
            ActivityCompat.requestPermissions(mActivity, permissions, 2);
        }
    }

    private void requestBackgroundLocationPermission() {
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.P) {
            final String[] permissions = {
                Manifest.permission.ACCESS_FINE_LOCATION, "android.permission.ACCESS_BACKGROUND_LOCATION"
            };
            ActivityCompat.requestPermissions(mActivity, permissions, 3);
        } else {
            final String[] permissions = {
                Manifest.permission.ACCESS_FINE_LOCATION
            };
            ActivityCompat.requestPermissions(mActivity, permissions, 4);
        }
    }

    private void requestActivityRecognitionPermission() {
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.P) {
            final String[] permissions = {"android.permission.ACTIVITY_RECOGNITION"};
            ActivityCompat.requestPermissions(mActivity, permissions, 5);
        } else {
            final String[] permissions = {"com.huawei.hms.permission.ACTIVITY_RECOGNITION"};
            ActivityCompat.requestPermissions(mActivity, permissions, 6);
        }
    }

    private boolean isCoarseLocGranted() {
        final int coarseLoc = ActivityCompat.checkSelfPermission(mActivity, Manifest.permission.ACCESS_COARSE_LOCATION);
        return coarseLoc == PackageManager.PERMISSION_GRANTED;
    }

    private boolean isFineLocGranted() {
        final int fineLoc = ActivityCompat.checkSelfPermission(mActivity, Manifest.permission.ACCESS_FINE_LOCATION);
        return fineLoc == PackageManager.PERMISSION_GRANTED;
    }

    private boolean isBackgroundLocGranted() {
        final int backgroundLoc = ActivityCompat.checkSelfPermission(mActivity,
            "android.permission.ACCESS_BACKGROUND_LOCATION");
        return backgroundLoc == PackageManager.PERMISSION_GRANTED;
    }

    private boolean checkGrantStatus(final int[] grantResults) {
        for (final int i : grantResults) {
            return !(i == -1);
        }
        return true;
    }

    @Override
    public void onMethodCall(final MethodCall call, @NonNull final Result result) {
        mResult = result;
        switch (call.method) {
            case "hasLocationPermission":
                result.success(hasLocationPermission());
                break;
            case "hasBackgroundLocationPermission":
                result.success(hasBackgroundLocationPermission());
                break;
            case "hasActivityRecognitionPermission":
                result.success(hasActivityRecognitionPermission());
                break;
            case "requestLocationPermission":
                requestLocationPermission();
                break;
            case "requestBackgroundLocationPermission":
                requestBackgroundLocationPermission();
                break;
            case "requestActivityRecognitionPermission":
                requestActivityRecognitionPermission();
                break;
            default:
                break;
        }
    }

    @Override
    public boolean onRequestPermissionsResult(final int requestCode, final String[] permissions,
        final int[] grantResults) {
        final Result result = mResult;
        mResult = null;

        if (result != null) {
            if (requestCode == 1 || requestCode == 3) {
                result.success(grantResults[0] == 0 && grantResults[1] == 0);
            } else {
                result.success(checkGrantStatus(grantResults));
            }
        }

        return true;
    }
}
