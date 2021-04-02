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

package com.huawei.hms.flutter.ml.permissions;

import android.Manifest;
import android.app.Activity;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.core.content.PermissionChecker;

import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class PermissionHandler implements MethodChannel.MethodCallHandler, PluginRegistry.RequestPermissionsResultListener {
    private static final String TAG = PermissionHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;

    public PermissionHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "requestPermission":
                requestPermission(call);
                break;
            case "hasCameraPermission":
                mResult.success(hasCameraPermission());
                break;
            case "hasRecordAudioPermission":
                mResult.success(hasRecordAudioPermission());
                break;
            case "hasStoragePermission":
                mResult.success(hasStoragePermission());
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    private boolean hasCameraPermission() {
        return hasPermission(Manifest.permission.CAMERA);
    }

    private boolean hasRecordAudioPermission() {
        return hasPermission(Manifest.permission.RECORD_AUDIO);
    }

    private boolean hasStoragePermission() {
        return hasPermission(Manifest.permission.READ_EXTERNAL_STORAGE) && hasPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE);
    }

    private boolean hasPermission(String permission) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            int granted = PermissionChecker.checkSelfPermission(activity, permission);
            return granted == PermissionChecker.PERMISSION_GRANTED;
        }
        return true;
    }

    private void requestPermission(MethodCall call) {
        List<String> list = call.argument("list");
        List<String> permissions = new ArrayList<>();

        for (String p : list) {
            switch (p) {
                case "camera":
                    permissions.add(Manifest.permission.CAMERA);
                    break;
                case "audio":
                    permissions.add(Manifest.permission.RECORD_AUDIO);
                    break;
                case "storage":
                    permissions.add(Manifest.permission.WRITE_EXTERNAL_STORAGE);
                    permissions.add(Manifest.permission.READ_EXTERNAL_STORAGE);
                    break;
                case "connectionState":
                    permissions.add(Manifest.permission.ACCESS_NETWORK_STATE);
                    permissions.add(Manifest.permission.ACCESS_WIFI_STATE);
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