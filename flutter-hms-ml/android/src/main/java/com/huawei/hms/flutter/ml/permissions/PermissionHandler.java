/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.ml.permissions;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;

import com.huawei.hms.flutter.ml.logger.HMSLogger;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class PermissionHandler implements MethodChannel.MethodCallHandler, PluginRegistry.RequestPermissionsResultListener {
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
                HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("checkCameraPermission");
                result.success(checkCameraPermission());
                break;
            case "checkWriteExternalStoragePermission":
                HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("checkWriteExternalStoragePermission");
                result.success(checkWriteExternalStoragePermission());
                break;
            case "checkReadExternalStoragePermission":
                HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("checkReadExternalStoragePermission");
                result.success(checkReadExternalStoragePermission());
                break;
            case "checkAudioPermission":
                HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("checkAudioPermission");
                result.success(checkAudioPermission());
                break;
            case "checkAccessNetworkStatePermission":
                HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("checkAccessNetworkStatePermission");
                result.success(checkAccessNetworkStatePermission());
                break;
            case "checkAccessWifiStatePermission":
                HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("checkAccessWifiStatePermission");
                result.success(checkAccessWifiStatePermission());
                break;
            case "requestCameraPermission":
                HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("requestCameraPermission");
                requestCameraPermission();
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("requestCameraPermission");
                break;
            case "requestStoragePermission":
                HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("requestStoragePermission");
                requestStoragePermission();
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("requestStoragePermission");
                break;
            case "requestAudioPermission":
                HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("requestAudioPermission");
                requestAudioPermission();
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("requestAudioPermission");
                break;
            case "requestConnectionStatePermission":
                HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("requestConnectionStatePermission");
                requestConnectionStatePermission();
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("requestConnectionStatePermission");
                break;
            default:
                break;
        }
    }

    // CHECKING PERMISSIONS

    public boolean checkCameraPermission() {
        final int cameraPer = ActivityCompat.checkSelfPermission(activity, Manifest.permission.CAMERA);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("checkCameraPermission");
        return cameraPer == PackageManager.PERMISSION_GRANTED;
    }

    private boolean checkWriteExternalStoragePermission() {
        final int writeExPer = ActivityCompat.checkSelfPermission(activity, Manifest.permission.WRITE_EXTERNAL_STORAGE);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("checkWriteExternalStoragePermission");
        return writeExPer == PackageManager.PERMISSION_GRANTED;
    }

    private boolean checkReadExternalStoragePermission() {
        final int readExPer = ActivityCompat.checkSelfPermission(activity, Manifest.permission.READ_EXTERNAL_STORAGE);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("checkReadExternalStoragePermission");
        return readExPer == PackageManager.PERMISSION_GRANTED;
    }

    private boolean checkAudioPermission() {
        final int audioPer = ActivityCompat.checkSelfPermission(activity, Manifest.permission.RECORD_AUDIO);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("checkAudioPermission");
        return audioPer == PackageManager.PERMISSION_GRANTED;
    }

    private boolean checkAccessNetworkStatePermission() {
        final int networkPer = ActivityCompat.checkSelfPermission(activity, Manifest.permission.ACCESS_NETWORK_STATE);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("checkAccessNetworkStatePermission");
        return networkPer == PackageManager.PERMISSION_GRANTED;
    }

    private boolean checkAccessWifiStatePermission() {
        final int wifiPer = ActivityCompat.checkSelfPermission(activity, Manifest.permission.ACCESS_WIFI_STATE);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("checkAccessWifiStatePermission");
        return wifiPer == PackageManager.PERMISSION_GRANTED;
    }

    // REQUESTING PERMISSIONS

    public void requestCameraPermission() {
        final String[] permissions = {Manifest.permission.CAMERA};
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.P) {
            ActivityCompat.requestPermissions(activity, permissions, 1);
        } else {
            ActivityCompat.requestPermissions(activity, permissions, 2);
        }
    }

    private void requestStoragePermission() {
        final String[] permissions = {
                Manifest.permission.WRITE_EXTERNAL_STORAGE,
                Manifest.permission.READ_EXTERNAL_STORAGE};
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.P) {
            ActivityCompat.requestPermissions(activity, permissions, 5);
        } else {
            ActivityCompat.requestPermissions(activity, permissions, 6);
        }
    }

    private void requestAudioPermission() {
        final String[] permissions = {Manifest.permission.RECORD_AUDIO};
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.P) {
            ActivityCompat.requestPermissions(activity, permissions, 7);
        } else {
            ActivityCompat.requestPermissions(activity, permissions, 8);
        }
    }

    private void requestConnectionStatePermission() {
        final String[] permissions = {
                Manifest.permission.ACCESS_WIFI_STATE,
                Manifest.permission.ACCESS_NETWORK_STATE};
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.P) {
            ActivityCompat.requestPermissions(activity, permissions, 9);
        } else {
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