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

package com.huawei.hms.flutter.account.handlers;

import android.accounts.Account;
import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hmf.tasks.Tasks;

import com.huawei.hms.flutter.account.util.Constant;
import com.huawei.hms.flutter.account.logger.HMSLogger;
import com.huawei.hms.flutter.account.util.AccountUtils;
import com.huawei.hms.support.api.entity.auth.Scope;
import com.huawei.hms.support.hwid.tools.HuaweiIdAuthTool;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class AuthToolMethodHandler implements MethodChannel.MethodCallHandler {
    private Activity activity;
    private MethodChannel.Result mResult;

    public AuthToolMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "requestUnionId":
                requestUnionId(call);
                break;
            case "requestAccessToken":
                requestAccessToken(call);
                break;
            case "deleteAuthInfo":
                deleteAuthInfo(call);
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    /**
     * Obtains a union id.
     *
     * @param call contains the account name which is necessary to
     *             get the union id.
     */
    private void requestUnionId(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("requestUnionId");
        Map<String, Object> objectMap = call.arguments();
        String name = (String) objectMap.get("accountName");

        Tasks.callInBackground(() -> HuaweiIdAuthTool.requestUnionId(activity, name))
                .addOnSuccessListener(s -> {
                    HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("requestUnionId");
                    mResult.success(s);
                })
                .addOnFailureListener(e -> {
                    HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("requestUnionId", "-1");
                    mResult.error(Constant.REQUEST_UNION_ID_FAILURE, e.toString(), null);
                });
    }

    /**
     * Obtains a token.
     *
     * @param call contains scopeList, account name, account type properties
     *             which are necessary to get the token.
     */
    private void requestAccessToken(@NonNull MethodCall call) {
        final List<String> emptyList = new ArrayList<>();
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("requestAccessToken");
        List<String> scopeList = call.argument("scopeList");
        String name = call.argument("name");
        String type = call.argument("type");

        Account account = new Account(name, type);
        List<Scope> scopes = AccountUtils.getScopeList(scopeList == null ? emptyList : scopeList);

        Tasks.callInBackground(() -> HuaweiIdAuthTool.requestAccessToken(activity, account, scopes))
                .addOnSuccessListener(s -> {
                    HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("requestAccessToken");
                    mResult.success(s);
                }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("requestAccessToken", "-1");
            mResult.error(Constant.REQUEST_ACCESS_TOKEN_FAILURE, e.getMessage(), null);
        });
    }

    /**
     * Clears the local cache.
     *
     * @param call contains an access token to get cache cleared
     */
    private void deleteAuthInfo(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("deleteAuthInfo");
        Map<String, Object> map = call.arguments();

        String accessToken = (String) map.get("accessToken");

        if (accessToken == null || accessToken.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("deleteAuthInfo", Constant.ILLEGAL_PARAMETER);
            mResult.error(Constant.DELETE_AUTH_INFO_FAILURE, Constant.ILLEGAL_PARAMETER, "Access token is missing");
            return;
        }

        Tasks.callInBackground((Callable<Void>) () -> {
            HuaweiIdAuthTool.deleteAuthInfo(activity, accessToken);
            return null;
        }).addOnSuccessListener(aVoid -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("deleteAuthInfo");
            mResult.success(true);
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("deleteAuthInfo", "-1");
            mResult.error(Constant.DELETE_AUTH_INFO_FAILURE, e.getMessage(), null);
        });
    }
}
