/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.drive;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.core.content.PermissionChecker;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.RequestPermissionsResultListener;

public class PermissionController implements MethodCallHandler, RequestPermissionsResultListener {

    private final Activity activity;
    private Result mResult;
    private static final int REQUEST_CODE_ALL = 1;

    public PermissionController(final Activity mActivity) {
        activity = mActivity;
    }

    private boolean checkGrantStatus(final int[] grantResults) {
        for (final int i : grantResults) {
            if (i != 0) {
                return false;
            }
        }
        return true;
    }

    // Read Permission
    private boolean isGrantedReadPermission() {
        final int result = PermissionChecker.checkSelfPermission(activity, Manifest.permission.READ_EXTERNAL_STORAGE);
        if (result == PackageManager.PERMISSION_GRANTED) {
            return true;
        } else {
            Log.e("PERMISSION", "No Read Permission", null);
            return false;
        }

    }

    private boolean isGrantedWritePermission() {
        final int result = PermissionChecker.checkSelfPermission(activity, Manifest.permission.WRITE_EXTERNAL_STORAGE);
        if (result == PackageManager.PERMISSION_GRANTED) {
            return true;
        } else {
            Log.e("PERMISSION", "No Write Permission", null);
            return false;
        }
    }

    private boolean permissionChecker() {
        return isGrantedWritePermission() && isGrantedReadPermission();
    }

    private void requestReadAndWritePermissions() {
        final String[] permissions = {
            Manifest.permission.READ_EXTERNAL_STORAGE, Manifest.permission.WRITE_EXTERNAL_STORAGE
        };
        activity.requestPermissions(permissions, REQUEST_CODE_ALL);
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        mResult = result;
        switch (call.method) {
            case "request":
                requestReadAndWritePermissions();
                break;
            case "has":
                result.success(permissionChecker());
                break;
            default:
                mResult.notImplemented();
        }
    }

    @Override
    public boolean onRequestPermissionsResult(final int requestCode, final String[] permissions,
        final int[] grantResults) {
        final Result result = mResult;
        mResult = null;
        if (result != null) {
            if (requestCode == REQUEST_CODE_ALL) {
                result.success(grantResults[0] == 0 && grantResults[1] == 0);
            } else {
                result.success(checkGrantStatus(grantResults));
            }
        }
        return true;
    }

}
