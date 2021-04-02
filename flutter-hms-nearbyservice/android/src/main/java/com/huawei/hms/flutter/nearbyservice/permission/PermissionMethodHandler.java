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

package com.huawei.hms.flutter.nearbyservice.permission;

import android.Manifest;
import android.app.Activity;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.core.content.PermissionChecker;

import com.huawei.hms.flutter.nearbyservice.logger.HMSLogger;
import com.huawei.hms.flutter.nearbyservice.utils.FromMap;
import com.huawei.hms.flutter.nearbyservice.utils.constants.ErrorCodes;

import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class PermissionMethodHandler implements MethodChannel.MethodCallHandler, PluginRegistry.RequestPermissionsResultListener {
    private static final String TAG = "PermissionMethodHandler";

    private final Activity activity;
    MethodChannel.Result result;

    public PermissionMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer(call.method);
        this.result = result;
        switch (call.method) {
            case "requestPermission":
                requestPermission(call);
                break;
            case "hasLocationPermission":
                result.success(hasLocationPermission());
                break;
            case "hasExternalStoragePermission":
                result.success(hasExternalStoragePermission());
                break;
            default:
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NOT_FOUND);
                result.notImplemented();
                return;
        }

        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
    }

    void requestPermission(MethodCall call) {
        List<String> permList = FromMap.toStringArrayList("permissions", call.argument("permissions"));
        List<String> permissions = new ArrayList<>();

        for (String perm : permList) {
            switch (perm) {
                case "location":
                    permissions.add(Manifest.permission.ACCESS_COARSE_LOCATION);
                    permissions.add(Manifest.permission.ACCESS_FINE_LOCATION);
                    break;
                case "externalStorage":
                    permissions.add(Manifest.permission.READ_EXTERNAL_STORAGE);
                    permissions.add(Manifest.permission.WRITE_EXTERNAL_STORAGE);
                    break;
                default:
                    Log.w(TAG, "Unsupported permission.");
                    break;
            }
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            activity.requestPermissions(permissions.toArray(new String[0]), 1);
        }
    }

    boolean hasLocationPermission() {
        Log.i(TAG, "hasLocationPermission");
        return hasPermission(Manifest.permission.ACCESS_FINE_LOCATION) && hasPermission(Manifest.permission.ACCESS_COARSE_LOCATION);
    }

    boolean hasExternalStoragePermission() {
        Log.i(TAG, "hasExternalStoragePermission");
        return hasPermission(Manifest.permission.READ_EXTERNAL_STORAGE) && hasPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE);
    }

    boolean hasPermission(String permission) {
        Log.i(TAG, "hasPermission");
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            int granted = PermissionChecker.checkSelfPermission(activity, permission);
            return granted == PermissionChecker.PERMISSION_GRANTED;
        }
        return true;
    }

    @Override
    public boolean onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        final MethodChannel.Result incomingResult = result;
        result = null;

        if (incomingResult != null) {
            incomingResult.success(checkGrantStatus(grantResults));
        }
        return true;
    }

    private boolean checkGrantStatus(final int[] grantResults) {
        boolean res = true;
        for (int grantResult : grantResults) {
            boolean granted = grantResult == 0;
            if (!granted) {
                res = false;
                break;
            }
        }
        return res;
    }
}
