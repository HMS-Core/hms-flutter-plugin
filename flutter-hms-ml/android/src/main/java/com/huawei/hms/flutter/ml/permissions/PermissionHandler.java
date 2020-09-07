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

package com.huawei.hms.flutter.ml.permissions;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class PermissionHandler implements
        MethodChannel.MethodCallHandler,
        PluginRegistry.RequestPermissionsResultListener {
    private Activity activity;
    private MethodChannel.Result mResult;

    public PermissionHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "checkCameraPermission":
                result.success(checkCameraPermission());
                break;
            case "checkInternetPermission":
                result.success(checkInternetPermission());
                break;
            case "checkWriteExternalStoragePermission":
                result.success(checkWriteExternalStoragePermission());
                break;
            case "checkReadExternalStoragePermission":
                result.success(checkReadExternalStoragePermission());
                break;
            case "checkAudioPermission":
                result.success(checkAudioPermission());
                break;
            case "checkAccessNetworkStatePermission":
                result.success(checkAccessNetworkStatePermission());
                break;
            case "checkAccessWifiStatePermission":
                result.success(checkAccessWifiStatePermission());
                break;
            case "requestCameraPermission":
                requestCameraPermission();
                break;
            case "requestInternetPermission":
                requestInternetPermission();
                break;
            case "requestStoragePermission":
                requestStoragePermission();
                break;
            case "requestAudioPermission":
                requestAudioPermission();
                break;
            case "requestConnectionStatePermission":
                requestConnectionStatePermission();
                break;
            default:
                break;
        }
    }

    // CHECKING PERMISSIONS

    private boolean checkCameraPermission() {
        final int cameraPer = ActivityCompat.checkSelfPermission(activity, Manifest.permission.CAMERA);
        return cameraPer == PackageManager.PERMISSION_GRANTED;
    }

    private boolean checkInternetPermission() {
        final int internetPer = ActivityCompat.checkSelfPermission(activity, Manifest.permission.INTERNET);
        return internetPer == PackageManager.PERMISSION_GRANTED;
    }

    private boolean checkWriteExternalStoragePermission() {
        final int writeExPer = ActivityCompat.checkSelfPermission(activity, Manifest.permission.WRITE_EXTERNAL_STORAGE);
        return writeExPer == PackageManager.PERMISSION_GRANTED;
    }

    private boolean checkReadExternalStoragePermission() {
        final int readExPer = ActivityCompat.checkSelfPermission(activity, Manifest.permission.READ_EXTERNAL_STORAGE);
        return readExPer == PackageManager.PERMISSION_GRANTED;
    }

    private boolean checkAudioPermission() {
        final int audioPer = ActivityCompat.checkSelfPermission(activity, Manifest.permission.RECORD_AUDIO);
        return audioPer == PackageManager.PERMISSION_GRANTED;
    }

    private boolean checkAccessNetworkStatePermission() {
        final int networkPer = ActivityCompat.checkSelfPermission(activity, Manifest.permission.ACCESS_NETWORK_STATE);
        return networkPer == PackageManager.PERMISSION_GRANTED;
    }

    private boolean checkAccessWifiStatePermission() {
        final int wifiPer = ActivityCompat.checkSelfPermission(activity, Manifest.permission.ACCESS_WIFI_STATE);
        return wifiPer == PackageManager.PERMISSION_GRANTED;
    }

    // REQUESTING PERMISSIONS

    private void requestCameraPermission() {
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.P) {
            final String[] permissions = {Manifest.permission.CAMERA};
            ActivityCompat.requestPermissions(activity, permissions, 1);
        } else {
            final String[] permissions = {Manifest.permission.CAMERA};
            ActivityCompat.requestPermissions(activity, permissions, 2);
        }
    }

    private void requestInternetPermission() {
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.P) {
            final String[] permissions = {Manifest.permission.INTERNET};
            ActivityCompat.requestPermissions(activity, permissions, 3);
        } else {
            final String[] permissions = {Manifest.permission.INTERNET};
            ActivityCompat.requestPermissions(activity, permissions, 4);
        }
    }

    private void requestStoragePermission() {
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.P) {
            final String[] permissions = {
                    Manifest.permission.WRITE_EXTERNAL_STORAGE,
                    Manifest.permission.READ_EXTERNAL_STORAGE};
            ActivityCompat.requestPermissions(activity, permissions, 5);
        } else {
            final String[] permissions = {
                    Manifest.permission.WRITE_EXTERNAL_STORAGE,
                    Manifest.permission.READ_EXTERNAL_STORAGE};
            ActivityCompat.requestPermissions(activity, permissions, 6);
        }
    }

    private void requestAudioPermission() {
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.P) {
            final String[] permissions = {Manifest.permission.RECORD_AUDIO};
            ActivityCompat.requestPermissions(activity, permissions, 7);
        } else {
            final String[] permissions = {Manifest.permission.RECORD_AUDIO};
            ActivityCompat.requestPermissions(activity, permissions, 8);
        }
    }

    private void requestConnectionStatePermission() {
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.P) {
            final String[] permissions = {
                    Manifest.permission.ACCESS_WIFI_STATE,
                    Manifest.permission.ACCESS_NETWORK_STATE};
            ActivityCompat.requestPermissions(activity, permissions, 9);
        } else {
            final String[] permissions = {
                    Manifest.permission.ACCESS_WIFI_STATE,
                    Manifest.permission.ACCESS_NETWORK_STATE};
            ActivityCompat.requestPermissions(activity, permissions, 10);
        }
    }

    private boolean checkGrantStatus(final int[] grantResults) {
        for (final int i : grantResults) {
            return !(i == -1);
        }
        return true;
    }

    @Override
    public boolean onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        final MethodChannel.Result result = mResult;
        mResult = null;
        if (result != null) {
            if (requestCode == 1 || requestCode == 5 || requestCode == 7) {
                result.success(grantResults[0] == 0 && grantResults[1] == 0);
            } else {
                result.success(checkGrantStatus(grantResults));
            }
        }
        return true;
    }
}