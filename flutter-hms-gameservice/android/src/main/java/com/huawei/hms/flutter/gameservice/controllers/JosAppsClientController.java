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

package com.huawei.hms.flutter.gameservice.controllers;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.util.Pair;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.gameservice.common.Constants;
import com.huawei.hms.flutter.gameservice.common.listener.DefaultListResultListener;
import com.huawei.hms.flutter.gameservice.common.listener.DefaultResultListener;
import com.huawei.hms.flutter.gameservice.common.utils.Converter;
import com.huawei.hms.flutter.gameservice.common.utils.HMSLogger;
import com.huawei.hms.flutter.gameservice.common.utils.ValueGetter;
import com.huawei.hms.jos.AppUpdateClient;
import com.huawei.hms.jos.JosApps;
import com.huawei.hms.jos.JosAppsClient;
import com.huawei.hms.jos.product.ProductClient;
import com.huawei.hms.jos.product.ProductOrderInfo;
import com.huawei.updatesdk.service.appmgr.bean.ApkUpgradeInfo;
import com.huawei.updatesdk.service.otaupdate.CheckUpdateCallBack;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class JosAppsClientController implements MethodChannel.MethodCallHandler {
    private static final String TAG = "HuaweiGameServicePlugin";

    private final Context context;

    private final Activity activity;

    private final MethodChannel channel;

    JosAppsClient appsClient;

    AppUpdateClient appUpdateClient;

    ProductClient productClient;

    public JosAppsClientController(Activity activity, final @NonNull MethodChannel channel) {
        this.activity = activity;
        this.context = activity.getApplicationContext();
        this.channel = channel;
        this.appsClient = JosApps.getJosAppsClient(activity);
        this.appUpdateClient = JosApps.getAppUpdateClient(activity);
        this.productClient = JosApps.getProductClient(activity);
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        final Pair<String, String> methodNamePair = ValueGetter.methodNameExtractor(call);
        HMSLogger.getInstance(context).startMethodExecutionTimer(call.method);
        switch (Constants.JosAppsClientMethods.getEnum(methodNamePair.second)) {
            case INIT:
                init(call.method, result);
                break;
            case GET_APP_ID:
                getAppId(call, result);
                break;
            case CHECK_APP_UPDATE:
                checkAppUpdate(call.method, result);
                break;
            case SHOW_UPDATE_DIALOG:
                showUpdateDialog(call, result);
                break;
            case RELEASE_CALLBACK:
                releaseCallback(call.method, result);
                break;
            case GET_MISS_PRODUCT_ORDER:
                getMissProductOrder(call, result);
                break;
        }
    }

    private void init(String methodName, MethodChannel.Result result) {
        appsClient.init();
        HMSLogger.getInstance(context).sendSingleEvent(methodName);
        result.success(true);
        Log.i(TAG, "init success");
    }

    private void getAppId(MethodCall call, MethodChannel.Result result) {
        DefaultResultListener<String> listener = new DefaultResultListener<>(result, activity, call.method);
        appsClient.getAppId().addOnSuccessListener(listener).addOnFailureListener(listener);
    }

    private void checkAppUpdate(String methodName, MethodChannel.Result result) {
        CheckUpdateCallBack updateCallBack = new CheckUpdateCallBack() {
            @Override
            public void onUpdateInfo(Intent intent) {
                if (intent != null) {
                    channel.invokeMethod("onUpdateInfo", Converter.updateInfoToMap(intent));
                }
            }

            @Override
            public void onMarketInstallInfo(Intent intent) {
                Log.i(TAG, "onMarketInstallInfo");
                // Reserved method. No handling is required.
            }

            @Override
            public void onMarketStoreError(int i) {
                Log.i(TAG, "onMarketStoreError - Response Code: " + i);
                channel.invokeMethod("onMarketStoreError", i);
                // Reserved method. No handling is required.
            }

            @Override
            public void onUpdateStoreError(int i) {
                Log.i(TAG, "onUpdateStoreError - Response Code: " + i);
                channel.invokeMethod("onUpdateStoreError", i);
                // Reserved method. No handling is required.
            }
        };

        appUpdateClient.checkAppUpdate(context, updateCallBack);
        HMSLogger.getInstance(context).sendSingleEvent(methodName);
        result.success(true);
    }

    private void showUpdateDialog(MethodCall call, MethodChannel.Result result) {
        ApkUpgradeInfo apkUpgradeInfo = Converter.apkUpgradeInfoFromMap(
            ValueGetter.getMap(call.argument("apkUpgradeInfo")));
        boolean forceUpdate = ValueGetter.getBoolean("forceUpdate", call);
        appUpdateClient.showUpdateDialog(context, apkUpgradeInfo, forceUpdate);
        HMSLogger.getInstance(context).sendSingleEvent(call.method);
        result.success(true);
    }

    private void releaseCallback(String methodName, MethodChannel.Result result) {
        appUpdateClient.releaseCallBack();
        HMSLogger.getInstance(context).sendSingleEvent(methodName);
        result.success(true);
    }

    private void getMissProductOrder(MethodCall call, MethodChannel.Result result) {
        DefaultListResultListener<ProductOrderInfo> listener = new DefaultListResultListener<>(result,
            ProductOrderInfo.class, context, call.method);
        productClient.getMissProductOrder(context).addOnSuccessListener(listener).addOnFailureListener(listener);
    }
}
