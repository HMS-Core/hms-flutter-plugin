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

package com.huawei.hms.flutter.scan.scanpermissions;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.core.content.PermissionChecker;

import com.huawei.hms.flutter.scan.utils.Errors;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.RequestPermissionsResultListener;

public class PermissionMethodCallHandler implements MethodCallHandler, RequestPermissionsResultListener {

    private final Activity mActivity;

    private Result mResult;

    //Camera Permission
    private boolean isGrantedCameraPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            int result = PermissionChecker.checkSelfPermission(mActivity, Manifest.permission.CAMERA);
            if (result == PackageManager.PERMISSION_GRANTED) {
                return true;
            } else {
                Log.e("Error code: " + Errors.scanUtilNoCameraPermission.getErrorCode(),
                    Errors.scanUtilNoCameraPermission.getErrorMessage(), null);
                return false;
            }
        } else {
            return true;
        }
    }

    //Read Permission
    private boolean isGrantedReadStoragePermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            int result = PermissionChecker.checkSelfPermission(mActivity, Manifest.permission.READ_EXTERNAL_STORAGE);
            if (result == PackageManager.PERMISSION_GRANTED) {
                return true;
            } else {
                Log.e("Error code: " + Errors.scanUtilNoReadPermission.getErrorCode(),
                    Errors.scanUtilNoReadPermission.getErrorMessage(), null);
                return false;
            }
        } else {
            return true;
        }
    }

    //Check Permissions
    private boolean checkGrantStatus(final int[] grantResults) {
        for (final int i : grantResults) {
            return !(i == -1);
        }
        return true;
    }

    //Permission Control
    private boolean hasCameraAndStoragePermission() {
        return isGrantedCameraPermission() && isGrantedReadStoragePermission();
    }

    private int requestCodeAll = 1;

    //Request Permissions
    private void requestCameraAndStoragePermissions() {
        String[] permissions = {Manifest.permission.CAMERA, Manifest.permission.READ_EXTERNAL_STORAGE};
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            mActivity.requestPermissions(permissions, requestCodeAll);
        }
    }

    public PermissionMethodCallHandler(final Activity activity) {
        mActivity = activity;
    }

    @Override
    public void onMethodCall(final MethodCall call, @NonNull final MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "hasCameraAndStoragePermission":
                result.success(hasCameraAndStoragePermission());
                break;
            case "requestCameraAndStoragePermissions":
                requestCameraAndStoragePermissions();
                break;
            default:
                result.notImplemented();
        }
    }

    @Override
    public boolean onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        final Result result = mResult;
        mResult = null;
        if (result != null) {
            if (requestCode == requestCodeAll) {
                result.success(grantResults[0] == 0 && grantResults[1] == 0);
            } else {
                result.success(checkGrantStatus(grantResults));
            }
        }
        return true;
    }
}