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
import android.content.Intent;

import androidx.annotation.NonNull;

import com.huawei.hmf.tasks.Task;
import com.huawei.hms.common.ApiException;
import com.huawei.hms.flutter.account.util.Constant;
import com.huawei.hms.flutter.account.logger.HMSLogger;
import com.huawei.hms.flutter.account.util.HwIdBuilder;
import com.huawei.hms.flutter.account.util.AuthParamsBuilder;
import com.huawei.hms.support.hwid.HuaweiIdAuthManager;
import com.huawei.hms.support.hwid.request.HuaweiIdAuthParams;
import com.huawei.hms.support.hwid.request.HuaweiIdAuthParamsHelper;
import com.huawei.hms.support.hwid.result.AuthHuaweiId;
import com.huawei.hms.support.hwid.service.HuaweiIdAuthService;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class AuthServiceMethodHandler implements MethodChannel.MethodCallHandler, PluginRegistry.ActivityResultListener {
    private Activity activity;
    private MethodChannel.Result mResult;

    private HuaweiIdAuthParamsHelper authParamsHelper;
    private HuaweiIdAuthParams mAuthParam;
    private HuaweiIdAuthService mAuthManager;

    private int rCode;

    public AuthServiceMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "signIn":
                signIn(call);
                break;
            case "silentSignIn":
                signInSilent(call);
                break;
            case "signOut":
                signOut();
                break;
            case "revokeAuthorization":
                revokeAuthorization();
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    /**
     * Obtains the intent of the HUAWEI ID sign-in authorization page.
     *
     * @param call the customizable request from application
     */
    private void signIn(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("signIn");
        Map<String, Object> signInMap = call.arguments();
        rCode = (int) signInMap.get("requestCode");
        int defaultChoice = (int) signInMap.get("defaultParam");

        if (defaultChoice == 0) {
            authParamsHelper = new HuaweiIdAuthParamsHelper(HuaweiIdAuthParams.DEFAULT_AUTH_REQUEST_PARAM);
        } else {
            authParamsHelper = new HuaweiIdAuthParamsHelper(HuaweiIdAuthParams.DEFAULT_AUTH_REQUEST_PARAM_GAME);
        }

        mAuthParam = AuthParamsBuilder.buildAuthParams(signInMap, authParamsHelper, call);
        mAuthManager = HuaweiIdAuthManager.getService(activity, mAuthParam);
        activity.startActivityForResult(mAuthManager.getSignInIntent(), rCode);
    }

    /**
     * Obtains the sign-in information (or error information) about the HUAWEI ID that has been used to sign in to the app.
     * In this process, the authorization page is not displayed to the HUAWEI ID user.
     *
     * @param call the customizable request from application
     */
    private void signInSilent(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("silentSignIn");
        Map<String, Object> silentSignInMap = call.arguments();
        int defaultParamChoice = (int) silentSignInMap.get("defaultParam");

        if (defaultParamChoice == 1) {
            authParamsHelper = new HuaweiIdAuthParamsHelper(HuaweiIdAuthParams.DEFAULT_AUTH_REQUEST_PARAM_GAME);
        } else {
            authParamsHelper = new HuaweiIdAuthParamsHelper(HuaweiIdAuthParams.DEFAULT_AUTH_REQUEST_PARAM);
        }

        mAuthParam = AuthParamsBuilder.buildAuthParams(silentSignInMap, authParamsHelper, call);
        mAuthManager = HuaweiIdAuthManager.getService(activity, mAuthParam);

        Task<AuthHuaweiId> task = mAuthManager.silentSignIn();
        task.addOnSuccessListener(id -> {
            HashMap<String, Object> resultMap = HwIdBuilder.createHwId(id);
            Account account = id.getHuaweiAccount();
            if (account != null) {
                resultMap.put("account", HwIdBuilder.createAccount(account));
            }
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("silentSignIn");
            mResult.success(resultMap);
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("silentSignIn", String.valueOf(((ApiException) task.getException()).getStatusCode()));
            mResult.error(Constant.SILENT_SIGN_IN_FAILURE, String.valueOf(((ApiException) task.getException()).getStatusCode()), e.getMessage());
        });
    }

    /**
     * Signs out of the HUAWEI ID. The HMS Core Account SDK deletes the cached HUAWEI ID information.
     */
    private void signOut() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("signOut");
        if (mAuthManager == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("signOut", Constant.NULL_AUTH_SERVICE);
            mResult.error(Constant.SIGN_OUT_FAILURE, Constant.NULL_AUTH_SERVICE, "You have to be signed in before you use this api");
            return;
        }

        Task<Void> signOutTask = mAuthManager.signOut();

        signOutTask.addOnCompleteListener(task -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("signOut");
            mResult.success(true);
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("signOut", String.valueOf(((ApiException) signOutTask.getException()).getStatusCode()));
            mResult.error(Constant.SIGN_OUT_FAILURE, String.valueOf(((ApiException) signOutTask.getException()).getStatusCode()), e.getMessage());
        });
    }

    /**
     * Cancels the authorization from the HUAWEI ID user.
     */
    private void revokeAuthorization() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("revokeAuthorization");
        if (mAuthManager == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("signOut", Constant.NULL_AUTH_SERVICE);
            mResult.error(Constant.REVOKE_AUTHORIZATION_FAILURE, Constant.NULL_AUTH_SERVICE, "You have to be signed in before you use this api");
            return;
        }
        Task<Void> revokeAuthTask = mAuthManager.cancelAuthorization();
        revokeAuthTask.addOnSuccessListener(aVoid -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("revokeAuthorization");
            mResult.success(true);
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("revokeAuthorization", String.valueOf(((ApiException) revokeAuthTask.getException()).getStatusCode()));
            mResult.error(Constant.REVOKE_AUTHORIZATION_FAILURE, String.valueOf(((ApiException) revokeAuthTask.getException()).getStatusCode()), e.getMessage());
        });
    }

    /**
     * @param requestCode code specified while signing in
     * @param resultCode  callback result code
     * @param data        signing intent used while signing in
     * @return true
     */
    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
        Task<AuthHuaweiId> authIdTask = HuaweiIdAuthManager.parseAuthResultFromIntent(data);
        if (requestCode == rCode) {
            authIdTask.addOnSuccessListener(authId -> {

                HashMap<String, Object> resultMap = HwIdBuilder.createHwId(authId);
                Account account = authId.getHuaweiAccount();
                if (account != null) {
                    resultMap.put("account", HwIdBuilder.createAccount(account));
                }
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("signIn");
                mResult.success(resultMap);
            }).addOnFailureListener(e -> {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("signIn", String.valueOf(((ApiException) authIdTask.getException()).getStatusCode()));
                mResult.error(Constant.SIGN_IN_FAILURE, String.valueOf(((ApiException) authIdTask.getException()).getStatusCode()), e.getMessage());
            });
        }
        return true;
    }
}
