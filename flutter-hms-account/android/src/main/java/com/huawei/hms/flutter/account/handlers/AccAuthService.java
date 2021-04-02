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

package com.huawei.hms.flutter.account.handlers;

import android.app.Activity;
import android.content.Intent;
import android.util.Pair;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.account.logger.HMSLogger;
import com.huawei.hms.flutter.account.util.AccountBuilder;
import com.huawei.hms.flutter.account.util.FromMap;
import com.huawei.hms.flutter.account.util.ResultSender;
import com.huawei.hms.support.account.AccountAuthManager;
import com.huawei.hms.support.account.request.AccountAuthParams;
import com.huawei.hms.support.account.request.AccountAuthParamsHelper;
import com.huawei.hms.support.account.service.AccountAuthService;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class AccAuthService implements MethodChannel.MethodCallHandler, PluginRegistry.ActivityResultListener {
    private static final String TAG = "AccAuthService";

    private final Activity activity;
    private final Map<Integer, Pair<MethodChannel.Result, Object>> mResultsForRequests;

    private AccountAuthService service;
    private int mRequestNumber = 0;

    public AccAuthService(Activity activity1) {
        this.activity = activity1;
        mResultsForRequests = new HashMap<>();
    }
    
    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer(call.method);
        switch (call.method) {
            case "signIn":
                signIn(call, result);
                break;
            case "silentSignIn":
                silent(call, result);
                break;
            case "signOut":
                signOut(call, result);
                break;
            case "cancelAuthorization":
                cancelAuth(call, result);
                break;
            case "getChannel":
                getChannel(call, result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private synchronized void signIn(@NonNull MethodCall call, MethodChannel.Result result) {
        mRequestNumber++;
        mResultsForRequests.put(mRequestNumber, Pair.create(result, null));

        Integer defaultChoice = FromMap.toInteger("defaultParam", call.argument("defaultParam"));

        AccountAuthParamsHelper helper;
        if (defaultChoice != null && defaultChoice.equals(0)) {
            helper = new AccountAuthParamsHelper(AccountAuthParams.DEFAULT_AUTH_REQUEST_PARAM);
        } else if (defaultChoice != null && defaultChoice.equals(1)) {
            helper = new AccountAuthParamsHelper(AccountAuthParams.DEFAULT_AUTH_REQUEST_PARAM_GAME);
        } else {
            helper = new AccountAuthParamsHelper();
        }

        AccountAuthParams params = AccountBuilder.buildAccountAuthParams(helper, call);
        service = AccountAuthManager.getService(activity, params);

        activity.startActivityForResult(service.getSignInIntent(), mRequestNumber);
    }

    private void silent(@NonNull MethodCall call, MethodChannel.Result result) {
        if (service == null) {
            ResultSender.noService(activity, TAG, call.method, result);
            return;
        }

        service.silentSignIn()
                .addOnSuccessListener(authAccount -> ResultSender.success(activity, call.method, result, AccountBuilder.authAccountToMap(authAccount)))
                .addOnFailureListener(e -> ResultSender.exception(activity, TAG, e, call.method, result));
    }

    private void signOut(@NonNull MethodCall call, MethodChannel.Result result) {
        if (service == null) {
            ResultSender.noService(activity, TAG, call.method, result);
            return;
        }

        service.signOut()
                .addOnSuccessListener(aVoid -> ResultSender.success(activity, call.method, result, true))
                .addOnFailureListener(e -> ResultSender.exception(activity, TAG, e, call.method, result));
    }

    private void cancelAuth(@NonNull MethodCall call, MethodChannel.Result result) {
        if (service == null) {
            ResultSender.noService(activity, TAG, call.method, result);
            return;
        }

        service.cancelAuthorization()
                .addOnSuccessListener(aVoid -> ResultSender.success(activity, call.method, result, true))
                .addOnFailureListener(e -> ResultSender.exception(activity, TAG, e, call.method, result));
    }

    private void getChannel(@NonNull MethodCall call, MethodChannel.Result result) {
        if (service == null) {
            ResultSender.noService(activity, TAG, call.method, result);
            return;
        }

        service.getChannel()
                .addOnSuccessListener(accountIcon -> ResultSender.success(activity, call.method, result, AccountBuilder.accountIconToMap(accountIcon)))
                .addOnFailureListener(e -> ResultSender.exception(activity, TAG, e, call.method, result));
    }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
        final Pair<MethodChannel.Result, Object> pair = mResultsForRequests.get(requestCode);

        if (pair == null) {
            return false;
        }

        final MethodChannel.Result result = pair.first;

        if (result != null) {
            AccountAuthManager.parseAuthResultFromIntent(data)
                    .addOnSuccessListener(authAccount -> ResultSender.success(activity, "signIn", result, AccountBuilder.authAccountToMap(authAccount)))
                    .addOnFailureListener(e -> ResultSender.exception(activity, TAG, e, "signIn", result));
        }
        return true;
    }
}
