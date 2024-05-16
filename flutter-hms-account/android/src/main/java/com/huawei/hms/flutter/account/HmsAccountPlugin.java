/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.huawei.hms.flutter.account;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.account.handlers.AccAuthManager;
import com.huawei.hms.flutter.account.handlers.AccAuthService;
import com.huawei.hms.flutter.account.handlers.HwAuthTool;
import com.huawei.hms.flutter.account.handlers.HwNetworkTool;
import com.huawei.hms.flutter.account.handlers.HwSmsManager;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

public class HmsAccountPlugin implements FlutterPlugin, ActivityAware {
    private FlutterPluginBinding mFlutterPluginBinding;
    private ActivityPluginBinding mActivityPluginBinding;
    
    private MethodChannel hwAuthTool;
    private MethodChannel hwNetworkTool;
    private MethodChannel hwSmsManager;
    private MethodChannel accAuthService;
    private MethodChannel accAuthManager;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        this.mFlutterPluginBinding = flutterPluginBinding;
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding activityPluginBinding) {
        mActivityPluginBinding = activityPluginBinding;
        if (mFlutterPluginBinding != null) {
            onAttachedToEngine(mFlutterPluginBinding.getBinaryMessenger(), activityPluginBinding.getActivity());
        }
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding activityPluginBinding) {
        mActivityPluginBinding = activityPluginBinding;
        if (mFlutterPluginBinding != null) {
            onAttachedToEngine(mFlutterPluginBinding.getBinaryMessenger(), activityPluginBinding.getActivity());
        }
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onDetachedFromActivity() {
        hwAuthTool.setMethodCallHandler(null);
        hwNetworkTool.setMethodCallHandler(null);
        hwSmsManager.setMethodCallHandler(null);
        accAuthService.setMethodCallHandler(null);
        accAuthManager.setMethodCallHandler(null);
        mActivityPluginBinding = null;
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        this.mFlutterPluginBinding = null;
        this.hwAuthTool = null;
        this.hwNetworkTool = null;
        this.hwSmsManager = null;
        this.accAuthService = null;
        this.accAuthManager = null;
    }

    private void onAttachedToEngine(final BinaryMessenger messenger, final Activity activity) {
        hwAuthTool = new MethodChannel(messenger, "com.huawei.hms.flutter.account/hwid/auth");
        hwNetworkTool = new MethodChannel(messenger, "com.huawei.hms.flutter.account/hwid/network");
        hwSmsManager = new MethodChannel(messenger, "com.huawei.hms.flutter.account/hwid/sms");
        accAuthService = new MethodChannel(messenger, "com.huawei.hms.flutter.account/acc");
        accAuthManager = new MethodChannel(messenger, "com.huawei.hms.flutter.account/acc/manager");

        AccAuthService accService = new AccAuthService(activity);
        if (mActivityPluginBinding != null) {
            mActivityPluginBinding.addActivityResultListener(accService);
        }
        accAuthService.setMethodCallHandler(accService);
        accAuthManager.setMethodCallHandler(new AccAuthManager(activity));
        hwAuthTool.setMethodCallHandler(new HwAuthTool(activity));
        hwNetworkTool.setMethodCallHandler(new HwNetworkTool(activity));
        hwSmsManager.setMethodCallHandler(new HwSmsManager(activity, hwSmsManager));
    }
}
