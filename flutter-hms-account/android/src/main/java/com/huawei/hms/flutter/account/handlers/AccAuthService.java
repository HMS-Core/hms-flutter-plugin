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

package com.huawei.hms.flutter.account.handlers;

import android.app.Activity;
import android.content.Intent;

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
    private final Map<Integer, MethodChannel.Result> resultChannels = new HashMap<>();

    public AccAuthService(Activity activity) {
        this.activity = activity;
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
            case "independentSignIn":
                independent(call, result);
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
        AccountAuthService service = getAccountAuthService(call);
        int requestCode = getAvailableActivityRequestCode(result);
        activity.startActivityForResult(service.getSignInIntent(), requestCode);
    }

    private void independent(@NonNull MethodCall call, MethodChannel.Result result) {
        String accessToken = FromMap.toString("accessToken", call.argument("accessToken"), false);
        if (accessToken == null) {
            ResultSender.illegal(activity, TAG, call.method, result);
            return;
        }
        AccountAuthService service = getAccountAuthService(call);
        int requestCode = getAvailableActivityRequestCode(result);
        activity.startActivityForResult(service.getIndependentSignInIntent(accessToken), requestCode);
    }

    private void silent(@NonNull MethodCall call, MethodChannel.Result result) {
        getAccountAuthService(call).silentSignIn()
                .addOnSuccessListener(authAccount -> ResultSender.success(activity, call.method, result, AccountBuilder.authAccountToMap(authAccount, activity.getApplicationContext())))
                .addOnFailureListener(e -> ResultSender.exception(activity, TAG, e, call.method, result));
    }

    private void signOut(@NonNull MethodCall call, MethodChannel.Result result) {
        getAccountAuthService(call).signOut()
                .addOnSuccessListener(aVoid -> ResultSender.success(activity, call.method, result, true))
                .addOnFailureListener(e -> ResultSender.exception(activity, TAG, e, call.method, result));
    }

    private void cancelAuth(@NonNull MethodCall call, MethodChannel.Result result) {
        getAccountAuthService(call).cancelAuthorization()
                .addOnSuccessListener(aVoid -> ResultSender.success(activity, call.method, result, true))
                .addOnFailureListener(e -> ResultSender.exception(activity, TAG, e, call.method, result));
    }

    private void getChannel(@NonNull MethodCall call, MethodChannel.Result result) {
        getAccountAuthService(call).getChannel()
                .addOnSuccessListener(accountIcon -> ResultSender.success(activity, call.method, result, AccountBuilder.accountIconToMap(accountIcon)))
                .addOnFailureListener(e -> ResultSender.exception(activity, TAG, e, call.method, result));
    }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
        final MethodChannel.Result resultChannel = resultChannels.get(requestCode);
        if (resultChannel != null) {
            resultChannels.remove(requestCode);
            AccountAuthManager.parseAuthResultFromIntent(data)
                    .addOnSuccessListener(authAccount -> ResultSender.success(activity, "signIn", resultChannel, AccountBuilder.authAccountToMap(authAccount, activity.getApplicationContext())))
                    .addOnFailureListener(e -> ResultSender.exception(activity, TAG, e, "signIn", resultChannel));
            return true;
        }
        return false;
    }

    private int getAvailableActivityRequestCode(MethodChannel.Result result) {
        int requestCode = 8888;
        while (true) {
            if (!resultChannels.containsKey(requestCode)) {
                resultChannels.put(requestCode, result);
                return requestCode;
            }
            requestCode++;
        }
    }

    private AccountAuthService getAccountAuthService(@NonNull MethodCall call) {
        final Integer defaultChoice = FromMap.toInteger("defaultParam", call.argument("defaultParam"));

        AccountAuthParamsHelper helper;
        if (defaultChoice != null && defaultChoice.equals(0)) {
            helper = new AccountAuthParamsHelper(AccountAuthParams.DEFAULT_AUTH_REQUEST_PARAM);
        } else if (defaultChoice != null && defaultChoice.equals(1)) {
            helper = new AccountAuthParamsHelper(AccountAuthParams.DEFAULT_AUTH_REQUEST_PARAM_GAME);
        } else {
            helper = new AccountAuthParamsHelper();
        }

        AccountAuthParams params = AccountBuilder.buildAccountAuthParams(helper, call);
        return AccountAuthManager.getService(activity, params);
    }
}
