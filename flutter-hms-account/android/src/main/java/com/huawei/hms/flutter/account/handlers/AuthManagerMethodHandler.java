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

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.account.util.Constant;
import com.huawei.hms.flutter.account.logger.HMSLogger;
import com.huawei.hms.flutter.account.util.AccountUtils;
import com.huawei.hms.flutter.account.util.HwIdBuilder;
import com.huawei.hms.support.api.entity.auth.Scope;
import com.huawei.hms.support.hwid.HuaweiIdAuthManager;
import com.huawei.hms.support.hwid.common.HuaweiIdAuthException;
import com.huawei.hms.support.hwid.result.AuthHuaweiId;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class AuthManagerMethodHandler implements MethodChannel.MethodCallHandler {
    private Activity activity;
    private MethodChannel.Result mResult;

    public AuthManagerMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "getAuthResult":
                getAResult();
                break;
            case "getAuthResultWithScopes":
                getAResultWithScopes(call);
                break;
            case "addAuthScopes":
                addAuthScopes(call);
                break;
            case "containScopes":
                containScopes(call);
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    /**
     * Obtains the information about the HUAWEI ID in the latest sign-in.
     */
    private void getAResult() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getAuthResult");
        AuthHuaweiId hwId = HuaweiIdAuthManager.getAuthResult();
        HashMap<String, Object> hwIdMap = HwIdBuilder.createHwId(hwId);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getAuthResult");
        mResult.success(hwIdMap);
    }

    /**
     * Obtains an AuthHuaweiId instance.
     *
     * @param call customizable request data
     */
    private void getAResultWithScopes(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getAuthResultWithScopes");
        List<String> scopeArgs = call.argument("scopes");

        if (scopeArgs == null || scopeArgs.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getAuthResultWithScopes", Constant.ILLEGAL_PARAMETER);
            mResult.error(Constant.GET_AUTH_RESULT_WITH_SCOPES_FAILURE, Constant.ILLEGAL_PARAMETER, null);
            return;
        }

        List<Scope> scopes = AccountUtils.getScopeList(scopeArgs);
        try {
            AuthHuaweiId hwId2 = HuaweiIdAuthManager.getAuthResultWithScopes(scopes);
            HashMap<String, Object> hwId2Map = HwIdBuilder.createHwId(hwId2);
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getAuthResultWithScopes");
            mResult.success(hwId2Map);
        } catch (HuaweiIdAuthException e) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getAuthResultWithScopes", "-1");
            mResult.error(Constant.GET_AUTH_RESULT_WITH_SCOPES_FAILURE, e.getMessage(), null);
        }
    }

    /**
     * Requests the permission specified by scopeList from a HUAWEI ID.
     *
     * @param call customizable request data that contains scopeList
     */
    private void addAuthScopes(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("addAuthScopes");
        Map<String, Object> authScopeMap = call.arguments();
        int rCode = (int) authScopeMap.get("requestCode");
        List<String> scopeList = call.argument("scopes");

        if (scopeList == null || scopeList.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("addAuthScopes", Constant.ILLEGAL_PARAMETER);
            mResult.error(Constant.ADD_AUTH_SCOPES_FAILURE, Constant.ILLEGAL_PARAMETER, null);
            return;
        }

        List<Scope> scopes = AccountUtils.getScopeList(scopeList);
        HuaweiIdAuthManager.addAuthScopes(activity, rCode, scopes);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("addAuthScopes");
        mResult.success(true);
    }

    /**
     * Checks whether a specified HUAWEI ID has been assigned all permission specified by scopeList.
     *
     * @param call customizable request data that contains scopeList
     */
    private void containScopes(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("containScopes");
        Map<String, Object> idMap = call.argument("id");
        List<String> scopeList = call.argument("scopeList");

        if (idMap == null || scopeList == null || idMap.isEmpty() || scopeList.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("containScopes", Constant.ILLEGAL_PARAMETER);
            mResult.error(Constant.CONTAIN_SCOPES_FAILURE, Constant.ILLEGAL_PARAMETER, null);
            return;
        }

        List<Scope> scopes = AccountUtils.getScopeList(scopeList);
        AuthHuaweiId id = AccountUtils.buildHwId(idMap, call);

        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("containScopes");
        mResult.success(HuaweiIdAuthManager.containScopes(id, scopes));
    }
}
