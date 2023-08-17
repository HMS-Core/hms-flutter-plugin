/*
 * Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.health.modules.auth;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.huawei.hmf.tasks.Task;
import com.huawei.hms.common.ApiException;
import com.huawei.hms.flutter.health.foundation.constants.Constants;
import com.huawei.hms.flutter.health.foundation.logger.HMSLogger;
import com.huawei.hms.flutter.health.foundation.utils.ExceptionHandler;
import com.huawei.hms.flutter.health.modules.auth.listener.HealthAuthResultListener;
import com.huawei.hms.flutter.health.modules.auth.service.HealthAuthService;
import com.huawei.hms.hihealth.HiHealthStatusCodes;
import com.huawei.hms.support.api.entity.auth.Scope;
import com.huawei.hms.support.hwid.HuaweiIdAuthAPIManager;
import com.huawei.hms.support.hwid.HuaweiIdAuthManager;
import com.huawei.hms.support.hwid.request.HuaweiIdAuthParams;
import com.huawei.hms.support.hwid.request.HuaweiIdAuthParamsHelper;
import com.huawei.hms.support.hwid.result.AuthHuaweiId;
import com.huawei.hms.support.hwid.result.HuaweiIdAuthResult;
import com.huawei.hms.support.hwid.service.HuaweiIdAuthService;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class HealthAuthMethodHandler implements MethodCallHandler, PluginRegistry.ActivityResultListener {
    /**
     * Request code for displaying the sign in authorization screen using the startActivityForResult method. The value
     * can be defined by developers.
     */
    public static final int REQUEST_SIGN_IN_LOGIN = 1002;

    private static final String TAG = "HMSHealthAuth";

    // Silent sign-in. If authorization has been granted by the current account,
    // the authorization screen will not display. This is an asynchronous method.
    private final HealthAuthService healthAuthService = this::silentSignIn;

    private @Nullable
    Activity mActivity;

    private Result mResult;

    private HMSLogger hmsLogger;

    private boolean replied = false;

    public HealthAuthMethodHandler(@Nullable Activity activity) {
        mActivity = activity;
    }

    private static List<Scope> getScopeArgs(final MethodCall call) {
        List<Scope> scopes = new ArrayList<>();
        List<String> requestedScopes = call.argument("scopes");
        if (requestedScopes != null) {
            for (String scopeStr : requestedScopes) {
                scopes.add(new Scope(scopeStr));
            }
            return scopes;
        }
        return new ArrayList<>();
    }

    public void setActivity(@Nullable Activity activity) {
        mActivity = activity;
        initLogger();
    }

    private void initLogger() {
        if (hmsLogger == null && mActivity != null) {
            this.hmsLogger = HMSLogger.getInstance(mActivity.getApplicationContext());
        }
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("signIn")) {
            mResult = result;
            signIn(call);
        } else {
            result.notImplemented();
        }
    }

    private void signIn(final MethodCall call) {
        initLogger();
        hmsLogger.startMethodExecutionTimer(call.method);
        List<Scope> scopes = getScopeArgs(call);
        if (scopes.isEmpty() || mActivity == null) {
            hmsLogger.sendSingleEvent(call.method, String.valueOf(HiHealthStatusCodes.INPUT_PARAM_MISSING));
            mResult.error(Constants.UNKNOWN_ERROR_CODE, "Parameters are wrong or empty", "");
            return;
        }

        // Configure authorization parameters.
        HuaweiIdAuthParamsHelper authParamsHelper = new HuaweiIdAuthParamsHelper(
            HuaweiIdAuthParams.DEFAULT_AUTH_REQUEST_PARAM);
        HuaweiIdAuthParams authParams = authParamsHelper.setIdToken()
            .setAccessToken()
            .setScopeList(scopes)
            .createParams();

        // Initialize the HuaweiIdAuthService object.
        final HuaweiIdAuthService authService = HuaweiIdAuthManager.getService(mActivity, authParams);
        healthAuthService.signIn(authService, new HealthAuthResultListener() {
            @Override
            public void onSilentSignInFail() {
                Log.i(TAG, "Silent SignIn Failed, begin sign in by intent");
                Intent signInIntent = authService.getSignInIntent();
                mActivity.startActivityForResult(signInIntent, REQUEST_SIGN_IN_LOGIN);
            }

            @Override
            public void onSuccess(AuthHuaweiId huaweiId) {
                try {
                    if (!replied) {
                        // Prevent sending the reply twice.
                        hmsLogger.sendSingleEvent(call.method);
                        mResult.success(huaweiId.toJson());
                        replied = true;
                    }
                } catch (JSONException e) {
                    // Prevent sending the reply twice.
                    hmsLogger.sendSingleEvent(call.method, Constants.UNKNOWN_ERROR_CODE);
                    Log.e(TAG, "Authorized successfully, parsing of huaweiId is failed.");
                    mResult.success(new JSONObject());
                    replied = true;
                }
            }

            @Override
            public void onFail(Exception exception) {
                hmsLogger.sendSingleEvent(call.method, Constants.UNKNOWN_ERROR_CODE);
                ExceptionHandler.fail(exception, mResult);
            }
        });
        replied = false;
    }

    private void silentSignIn(HuaweiIdAuthService authService, HealthAuthResultListener healthAuthResultListener) {
        Log.i(TAG, "call signIn");
        Task<AuthHuaweiId> authHuaweiIdTask = authService.silentSignIn();
        authHuaweiIdTask.addOnSuccessListener(huaweiId -> {
            /* The silent sign-in is successful. */
            Log.i(TAG, "silentSignIn success");
            healthAuthResultListener.onSuccess(huaweiId);
        }).addOnFailureListener(exception -> {
            if (exception instanceof ApiException) {
                ApiException apiException = (ApiException) exception;
                Log.i(TAG, "sign failed status:" + apiException.getStatusCode());
                /* The silent sign-in fails. */
                /* This indicates that the authorization has not been granted by the current account. */
                healthAuthResultListener.onSilentSignInFail();
            } else {
                healthAuthResultListener.onFail(exception);
            }
        });
    }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == REQUEST_SIGN_IN_LOGIN) {
            if (data == null) {
                Log.e(TAG, "intent is null");
                return false;
            }
            // Obtain the authorization response from the intent.
            HuaweiIdAuthResult result = HuaweiIdAuthAPIManager.HuaweiIdAuthAPIService.parseHuaweiIdFromIntent(data);
            if (result != null) {
                Log.d(TAG, "handleSignInResult status = " + result.getStatus() + ", result = " + result.isSuccess());
                if (result.isSuccess()) {
                    Log.d(TAG, "sign in is success");
                    // Obtain the authorization result.
                    HuaweiIdAuthResult authResult
                        = HuaweiIdAuthAPIManager.HuaweiIdAuthAPIService.parseHuaweiIdFromIntent(data);
                    try {
                        mResult.success(authResult.getHuaweiId().toJson());
                    } catch (JSONException e) {
                        ExceptionHandler.fail(e, mResult);
                    }
                } else {
                    mResult.error(Constants.UNKNOWN_ERROR_CODE, "Activity Result is not successful.", "");
                }
            } else {
                mResult.error(Constants.UNKNOWN_ERROR_CODE, "Activity Result is null", "");
            }
        }
        return true;
    }
}
