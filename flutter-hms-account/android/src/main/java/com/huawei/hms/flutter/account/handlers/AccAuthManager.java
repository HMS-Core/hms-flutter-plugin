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
import android.os.Bundle;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.account.logger.HMSLogger;
import com.huawei.hms.flutter.account.util.AccountBuilder;
import com.huawei.hms.flutter.account.util.Commons;
import com.huawei.hms.flutter.account.util.FromMap;
import com.huawei.hms.flutter.account.util.ResultSender;
import com.huawei.hms.support.account.AccountAuthManager;
import com.huawei.hms.support.account.common.AccountAuthException;
import com.huawei.hms.support.account.request.AccountAuthExtendedParams;
import com.huawei.hms.support.account.result.AuthAccount;
import com.huawei.hms.support.api.entity.auth.Scope;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class AccAuthManager implements MethodChannel.MethodCallHandler {
    private static final String TAG = "AccAuthManager";

    private final Activity activity;

    public AccAuthManager(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer(call.method);
        switch (call.method) {
            case "enableLogger":
                enableLogger(result);
                break;
            case "disableLogger":
                disableLogger(result);
                break;
            case "getAuthResult":
                getAuthRes(call, result);
                break;
            case "getAuthResultWithScopes":
                getAuthResWithScopes(call, result);
                break;
            case "getExtendedAuthResult":
                getExtAuthRes(call, result);
                break;
            case "containScopes":
                containScp(call, result);
                break;
            case "containScopesExt":
                containScpExt(call, result);
                break;
            case "addAuthScopes":
                addAuthScp(call, result);
                break;
            case "addAuthScopesExt":
                addAuthScopesExt(call, result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void enableLogger(@NonNull MethodChannel.Result result) {
        HMSLogger.getInstance(activity.getApplicationContext()).enableLogger();
        result.success(null);
    }

    private void disableLogger(@NonNull MethodChannel.Result result) {
        HMSLogger.getInstance(activity.getApplicationContext()).disableLogger();
        result.success(null);
    }

    private void getAuthRes(MethodCall call, MethodChannel.Result result) {
        AuthAccount authAccount = AccountAuthManager.getAuthResult();

        if (authAccount == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, "-1");
            result.error(TAG, "You have to be signed in first!", null);
            return;
        }

        ResultSender.success(activity, call.method, result, AccountBuilder.authAccountToMap(authAccount, activity.getApplicationContext()));
    }

    private void getAuthResWithScopes(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        List<String> scopeList = FromMap.toStringArrayList("scopes", call.argument("scopes"));

        if (scopeList.isEmpty()) {
            ResultSender.illegal(activity, TAG, call.method, result);
            return;
        }

        List<Scope> scopes = Commons.getScopeList(scopeList);

        try {
            AuthAccount authAccount = AccountAuthManager.getAuthResultWithScopes(scopes);

            if (authAccount == null) {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, "-1");
                result.error(TAG, "You have to be signed in first!", null);
                return;
            }

            ResultSender.success(activity, call.method, result, AccountBuilder.authAccountToMap(authAccount, activity.getApplicationContext()));
        } catch (AccountAuthException e) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, e.getMessage());
            result.error(TAG, e.getMessage(), null);
        }
    }

    private void getExtAuthRes(@NonNull MethodCall call, MethodChannel.Result result) {
        Integer paramType = FromMap.toInteger("extendedParamType", call.argument("extendedParamType"));
        List<String> extScopes = FromMap.toStringArrayList("extendedScopes", call.argument("extendedScopes"));

        if (extScopes.isEmpty()) {
            ResultSender.illegal(activity, TAG, call.method, result);
            return;
        }

        List<Scope> scopes = Commons.getScopeList(extScopes);
        ExtendedImpl extended = new ExtendedImpl(paramType, scopes);

        AuthAccount account = AccountAuthManager.getExtendedAuthResult(extended);

        if (account == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, "-1");
            result.error(TAG, "You have to be signed in first!", null);
            return;
        }

        ResultSender.success(activity, call.method, result, AccountBuilder.authAccountToMap(account, activity.getApplicationContext()));
    }

    private void containScp(@NonNull MethodCall call, MethodChannel.Result result) {
        Map<String, Object> accountMap = call.argument("account");
        List<String> scopeList = FromMap.toStringArrayList("scopes", call.argument("scopes"));

        AuthAccount acc;
        if (accountMap == null || accountMap.isEmpty()) {
            acc = null;
        } else {
            acc = AccountBuilder.buildAuthAccount(accountMap);
        }

        List<Scope> scopes = Commons.getScopeList(scopeList);

        Boolean res = AccountAuthManager.containScopes(acc, scopes);
        ResultSender.success(activity, call.method, result, res);
    }

    private void containScpExt(@NonNull MethodCall call, MethodChannel.Result result) {
        AuthAccount acc1;
        Integer paramType0;
        List<String> extScopes0;
        Map<String, Object> accountMp = call.argument("account");
        Map<String, Object> extensionMp = call.argument("ext");

        if (accountMp == null || accountMp.isEmpty()) {
            acc1 = null;
        } else {
            acc1 = AccountBuilder.buildAuthAccount(accountMp);
        }

        if (extensionMp == null || extensionMp.isEmpty()) {
            paramType0 = null;
            extScopes0 = Collections.emptyList();
        } else {
            paramType0 = FromMap.toInteger("extendedParamType", extensionMp.get("extendedParamType"));
            extScopes0 = FromMap.toStringArrayList("extendedScopes", extensionMp.get("extendedScopes"));
        }

        List<Scope> scopes = Commons.getScopeList(extScopes0);
        ExtendedImpl extended = new ExtendedImpl(paramType0, scopes);

        Boolean res = AccountAuthManager.containScopes(acc1, extended);
        ResultSender.success(activity, call.method, result, res);
    }

    private void addAuthScp(@NonNull MethodCall call, MethodChannel.Result result) {
        Integer reqCode = FromMap.toInteger("reqCode", call.argument("reqCode"));
        List<String> scopeList = FromMap.toStringArrayList("scopes", call.argument("scopes"));

        if (reqCode == null || scopeList.isEmpty()) {
            ResultSender.illegal(activity, TAG, call.method, result);
            return;
        }

        List<Scope> scopes = Commons.getScopeList(scopeList);
        AccountAuthManager.addAuthScopes(activity, reqCode, scopes);
        ResultSender.success(activity, call.method, result, null);
    }

    private void addAuthScopesExt(@NonNull MethodCall call, MethodChannel.Result result) {
        Map<String, Object> extensionMap = call.argument("ext");
        Integer reqCode = FromMap.toInteger("reqCode", call.argument("reqCode"));

        if (extensionMap == null || extensionMap.isEmpty() || reqCode == null) {
            ResultSender.illegal(activity, TAG, call.method, result);
            return;
        }

        Integer paramType = FromMap.toInteger("extendedParamType", extensionMap.get("extendedParamType"));
        List<String> extScopes = FromMap.toStringArrayList("extendedScopes", extensionMap.get("extendedScopes"));

        if (extScopes.isEmpty() || paramType == null) {
            ResultSender.illegal(activity, TAG, call.method, result);
            return;
        }

        List<Scope> list = Commons.getScopeList(extScopes);
        ExtendedImpl ex = new ExtendedImpl(paramType, list);

        AccountAuthManager.addAuthScopes(activity, reqCode, ex);
        ResultSender.success(activity, call.method, result, null);
    }

    static class ExtendedImpl implements AccountAuthExtendedParams {
        final Integer type;
        final List<Scope> scopes;

        public ExtendedImpl(Integer type, List<Scope> scopes) {
            this.type = type;
            this.scopes = scopes;
        }

        @Override
        public int getExtendedParamType() {
            return this.type;
        }

        @Override
        public List<Scope> getExtendedScopes() {
            return this.scopes;
        }

        @Override
        public Bundle getExtendedBundle() {
            return null;
        }
    }
}
