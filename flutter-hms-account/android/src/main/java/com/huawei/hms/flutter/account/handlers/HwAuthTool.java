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

import android.accounts.Account;
import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hmf.tasks.Tasks;

import com.huawei.hms.flutter.account.logger.HMSLogger;
import com.huawei.hms.flutter.account.util.Commons;
import com.huawei.hms.flutter.account.util.FromMap;
import com.huawei.hms.flutter.account.util.ResultSender;
import com.huawei.hms.support.api.entity.auth.Scope;
import com.huawei.hms.support.hwid.tools.HuaweiIdAuthTool;

import java.util.List;
import java.util.concurrent.Callable;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class HwAuthTool implements MethodChannel.MethodCallHandler {
    private static final String TAG = "HwAuthTool";

    private final Activity activity;

    public HwAuthTool(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer(call.method);
        switch (call.method) {
            case "requestUnionId":
                requestUnionId(call, result);
                break;
            case "requestAccessToken":
                requestAccessToken(call, result);
                break;
            case "deleteAuthInfo":
                deleteAuthInfo(call, result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void requestUnionId(MethodCall call, MethodChannel.Result result) {
        String name = FromMap.toString("accountName", call.argument("accountName"), false);

        Tasks.callInBackground(() -> HuaweiIdAuthTool.requestUnionId(activity, name))
                .addOnSuccessListener(s -> ResultSender.success(activity, call.method, result, s))
                .addOnFailureListener(e -> ResultSender.exception(activity, TAG, e, call.method, result));
    }

    private void requestAccessToken(@NonNull MethodCall call, MethodChannel.Result result) {
        List<String> scopeList = FromMap.toStringArrayList("scopeList", call.argument("scopeList"));
        String name = FromMap.toString("name", call.argument("name"), false);
        String type = FromMap.toString("type", call.argument("type"), false);

        Account account = new Account(name, type);
        List<Scope> scopes = Commons.getScopeList(scopeList);

        Tasks.callInBackground(() -> HuaweiIdAuthTool.requestAccessToken(activity.getApplicationContext(), account, scopes))
                .addOnSuccessListener(s -> ResultSender.success(activity, call.method, result, s))
                .addOnFailureListener(e -> ResultSender.exception(activity, TAG, e, call.method, result));
    }

    private void deleteAuthInfo(@NonNull MethodCall call, MethodChannel.Result result) {
        String accessToken = FromMap.toString("accessToken", call.argument("accessToken"), false);

        Tasks.callInBackground((Callable<Void>) () -> {
            HuaweiIdAuthTool.deleteAuthInfo(activity, accessToken);
            return null;
        }).addOnSuccessListener(aVoid -> ResultSender.success(activity, call.method, result, true))
                .addOnFailureListener(e -> ResultSender.exception(activity, TAG, e, call.method, result));
    }
}
