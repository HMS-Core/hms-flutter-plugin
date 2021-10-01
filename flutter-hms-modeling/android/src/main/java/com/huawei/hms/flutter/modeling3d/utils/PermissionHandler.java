/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.modeling3d.utils;

import android.Manifest;
import android.app.Activity;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.core.content.PermissionChecker;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

import java.util.ArrayList;
import java.util.List;

public class PermissionHandler
    implements MethodChannel.MethodCallHandler, PluginRegistry.RequestPermissionsResultListener {

    private final Activity activity;

    private MethodChannel.Result mResult;

    public PermissionHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "requestStoragePermission":
                requestStoragePermission();
                break;
            case "hasStoragePermission":
                mResult.success(hasStoragePermission());
                break;
            case "disableLogger":
                HMSLogger.getInstance(activity.getApplicationContext()).disableLogger();
                result.success(true);
                break;
            case "enableLogger":
                HMSLogger.getInstance(activity.getApplicationContext()).enableLogger();
                result.success(true);
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    private boolean hasStoragePermission() {
        return hasPermission(Manifest.permission.READ_EXTERNAL_STORAGE) && hasPermission(
            Manifest.permission.WRITE_EXTERNAL_STORAGE);
    }

    private boolean hasPermission(String permission) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            int granted = PermissionChecker.checkSelfPermission(activity, permission);
            return granted == PermissionChecker.PERMISSION_GRANTED;
        }
        return true;
    }

    private void requestStoragePermission() {
        if (hasStoragePermission() && mResult != null) {
            mResult.success(true);
            return;
        }
        List<String> permissions = new ArrayList<>();
        permissions.add(Manifest.permission.READ_EXTERNAL_STORAGE);
        permissions.add(Manifest.permission.WRITE_EXTERNAL_STORAGE);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            activity.requestPermissions(permissions.toArray(new String[0]), 1881);
        }
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

    @Override
    public boolean onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        final MethodChannel.Result incomingResult = mResult;
        mResult = null;

        if (incomingResult != null) {
            incomingResult.success(checkGrantStatus(grantResults));
        }
        return true;
    }

}
