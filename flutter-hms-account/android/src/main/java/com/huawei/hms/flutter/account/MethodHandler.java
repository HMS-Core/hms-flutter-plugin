/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.account;

import android.accounts.Account;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.os.Handler;
import android.os.Looper;
import android.util.Base64;
import android.util.Log;

import androidx.annotation.NonNull;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

import com.huawei.agconnect.config.AGConnectServicesConfig;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.common.ApiException;
import com.huawei.hms.support.api.entity.auth.Scope;
import com.huawei.hms.support.hwid.HuaweiIdAuthManager;
import com.huawei.hms.support.hwid.common.HuaweiIdAuthException;
import com.huawei.hms.support.hwid.request.HuaweiIdAuthParams;
import com.huawei.hms.support.hwid.request.HuaweiIdAuthParamsHelper;
import com.huawei.hms.support.hwid.result.AuthHuaweiId;
import com.huawei.hms.support.hwid.service.HuaweiIdAuthService;
import com.huawei.hms.support.hwid.tools.HuaweiIdAuthTool;
import com.huawei.hms.support.hwid.tools.NetworkTool;
import com.huawei.hms.support.sms.ReadSmsManager;
import com.huawei.hms.support.sms.common.ReadSmsConstant;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Objects;
import java.util.Set;

public class MethodHandler implements MethodChannel.MethodCallHandler, PluginRegistry.ActivityResultListener {
    private static final String TAG = "MethodHandler";

    private MethodChannel mChannel;
    private int signInRequestCode;
    private int signInCodeRequestCode;
    private final Activity activity;
    private HuaweiIdAuthService mAuthManager;
    private HuaweiIdAuthParams mAuthParam;
    private HuaweiIdAuthParamsHelper authParamsHelper;
    private MethodChannel.Result mResult;
    private SmsReceiver smsReceiver;
    private Handler handler = new Handler(Looper.getMainLooper());

    MethodHandler(Activity activity, MethodChannel channel) {
        this.activity = activity;
        this.mChannel = channel;
    }

    @Override
    public void onMethodCall(MethodCall methodCall, @NonNull MethodChannel.Result result) {
        mResult = result;
        if (methodCall.method.equals("signIn")) {
            signIn(methodCall);
        } else if (methodCall.method.equals("signInWithAuthorizationCode")) {
            signInWithAuthorizationCode(methodCall);
        } else {
            performSecondaryCalls(methodCall, result);
        }
    }

    private void performSecondaryCalls(MethodCall methodCall, @NonNull MethodChannel.Result result) {
        mResult = result;
        if (methodCall.method.equals("smsVerification")) {
            handleSmsVerification();
        } else if (methodCall.method.equals("obtainHashCode")) {
            obtainHashCode();
        } else {
            performTertiaryCalls(methodCall, result);
        }
    }

    private void performTertiaryCalls(MethodCall methodCall, @NonNull MethodChannel.Result result) {
        mResult = result;
        if (methodCall.method.equals("silentSignIn")) {
            silentSignIn(methodCall);
        } else if (methodCall.method.equals("signOut")) {
            signOut();
        } else {
            performQuaternaryCalls(methodCall, result);
        }
    }

    private void performQuaternaryCalls(MethodCall methodCall, @NonNull MethodChannel.Result result) {
        mResult = result;
        if (methodCall.method.equals("buildNetworkUrl")) {
            buildNetworkUrl(methodCall);
        } else if (methodCall.method.equals("buildNetworkCookie")) {
            buildNetworkCookie(methodCall);
        } else {
            performQuinaryCalls(methodCall, result);
        }
    }

    private void performQuinaryCalls(MethodCall methodCall, @NonNull MethodChannel.Result result) {
        mResult = result;
        if (methodCall.method.equals("addAuthScopes")) {
            addAuthScopes(methodCall);
        } else if (methodCall.method.equals("getAuthResultWithScopes")) {
            getAuthResultWithScopes(methodCall);
        } else {
            performSextCalls(methodCall, result);
        }
    }

    private void performSextCalls(MethodCall methodCall, @NonNull MethodChannel.Result result) {
        mResult = result;
        if (methodCall.method.equals("getAuthResult")) {
            getAuthResult();
        } else if (methodCall.method.equals("containScopes")) {
            containScopes(methodCall);
        } else {
            performHeptCalls(methodCall, result);
        }
    }

    private void performHeptCalls(MethodCall methodCall, @NonNull MethodChannel.Result result) {
        mResult = result;
        if (methodCall.method.equals("deleteAuthInfo")) {
            deleteAuthInfo(methodCall);
        } else if (methodCall.method.equals("requestUnionId")) {
            requestUnionId(methodCall);
        } else {
            performEighthCalls(methodCall, result);
        }
    }

    private void performEighthCalls(MethodCall methodCall, @NonNull MethodChannel.Result result) {
        mResult = result;
        if (methodCall.method.equals("requestAccessToken")) {
            requestAccessToken(methodCall);
        } else if (methodCall.method.equals("revokeAuthorization")) {
            revokeAuthorization();
        } else {
            mResult.notImplemented();
        }
    }

    private void signIn(MethodCall methodCall) {
        String authParamsJsonString = Objects.requireNonNull(methodCall.argument("authData")).toString();
        try {
            JSONObject jsonObject = new JSONObject(authParamsJsonString);
            signInRequestCode = jsonObject.getInt("requestCode");
            if (jsonObject.optInt("defaultParam") == 0) {
                authParamsHelper = new HuaweiIdAuthParamsHelper(HuaweiIdAuthParams.DEFAULT_AUTH_REQUEST_PARAM);
            } else {
                authParamsHelper = new HuaweiIdAuthParamsHelper(HuaweiIdAuthParams.DEFAULT_AUTH_REQUEST_PARAM_GAME);
            }
            mAuthParam = AuthParamsBuilder.buildAuthParams(jsonObject, authParamsHelper);
            mAuthManager = HuaweiIdAuthManager.getService(activity, mAuthParam);
            activity.startActivityForResult(mAuthManager.getSignInIntent(), signInRequestCode);
        } catch (JSONException e) {
            e.printStackTrace();
            mResult.error(Constant.SIGN_IN_FAIL, e.getMessage(), "");
        }
    }

    private void signInWithAuthorizationCode(MethodCall methodCall) {
        String jsonString = Objects.requireNonNull(methodCall.argument("authData")).toString();
        try {
            JSONObject obj = new JSONObject(jsonString);
            signInCodeRequestCode = obj.getInt("requestCode");
            if (obj.optInt("defaultParam") == 0) {
                authParamsHelper = new HuaweiIdAuthParamsHelper(HuaweiIdAuthParams.DEFAULT_AUTH_REQUEST_PARAM);
            } else {
                authParamsHelper = new HuaweiIdAuthParamsHelper(HuaweiIdAuthParams.DEFAULT_AUTH_REQUEST_PARAM_GAME);
            }
            mAuthParam = AuthParamsBuilder.buildAuthParams(obj, authParamsHelper);
            mAuthManager = HuaweiIdAuthManager.getService(activity, mAuthParam);
            activity.startActivityForResult(mAuthManager.getSignInIntent(), signInCodeRequestCode);

        } catch (JSONException e) {
            e.printStackTrace();
            mResult.error(Constant.SIGN_IN_WITH_AUTHORIZATION_CODE_FAIL, e.getMessage(), "");
        }
    }

    private void signOut() {
        Task<Void> signOutTask = mAuthManager.signOut();
        signOutTask
                .addOnSuccessListener(aVoid -> mResult.success(Constant.successResponse))
                .addOnFailureListener(e -> mResult.error(Constant.SIGN_OUT_FAIL, e.getMessage(), ""));
    }

    private void revokeAuthorization() {
        Task<Void> revokeAuthTask = mAuthManager.cancelAuthorization();
        revokeAuthTask.addOnCompleteListener(task -> {
            if (task.isSuccessful()) {
                mResult.success(Constant.successResponse);
            } else {
                Exception exception = task.getException();
                if (exception instanceof ApiException) {
                    int statusCode = ((ApiException) exception).getStatusCode();
                    Log.i(TAG, "onFailure: " + statusCode);
                }
                mResult.error(Constant.REVOKE_AUTHORIZATION_FAIL, exception.getMessage(), "");
            }
        });
    }

    private void silentSignIn(MethodCall methodCall) {
        String authParamsJsonString = Objects.requireNonNull(methodCall.argument("authData")).toString();
        try {
            JSONObject obj = new JSONObject(authParamsJsonString);
            if (obj.optInt("defaultParam") == 0) {
                authParamsHelper = new HuaweiIdAuthParamsHelper(HuaweiIdAuthParams.DEFAULT_AUTH_REQUEST_PARAM);
            } else {
                authParamsHelper = new HuaweiIdAuthParamsHelper(HuaweiIdAuthParams.DEFAULT_AUTH_REQUEST_PARAM_GAME);
            }
            mAuthParam = AuthParamsBuilder.buildAuthParams(obj, authParamsHelper);
            mAuthManager = HuaweiIdAuthManager.getService(activity, mAuthParam);
            Task<AuthHuaweiId> task = mAuthManager.silentSignIn();

            task.addOnSuccessListener(authHuaweiId -> {
                try {
                    JSONObject isSignedIn = AccountBuilder.createAccountJsonObject(authHuaweiId);
                    Account account = authHuaweiId.getHuaweiAccount();
                    if (account != null) {
                        isSignedIn.put("account", AccountBuilder.addAccount(account));
                    } else {
                        Log.i(TAG, "object is null");
                    }
                    mResult.success(isSignedIn.toString());

                } catch (JSONException e) {
                    mResult.error(Constant.SILENT_SIGN_IN_FAIL, e.getMessage(), "");
                }
            });

            task.addOnFailureListener(e -> mResult.error(Constant.SILENT_SIGN_IN_FAIL, e.getMessage(), ""));

        } catch (JSONException e) {
            e.printStackTrace();
            mResult.error(Constant.SILENT_SIGN_IN_FAIL, e.getMessage(), "");
        }
    }

    private void handleSmsVerification() {
        Task<Void> task = ReadSmsManager.start(activity);
        task.addOnCompleteListener(task1 -> {
            if (task1.isSuccessful()) {
                if (smsReceiver != null) {
                    activity.unregisterReceiver(smsReceiver);
                    smsReceiver = new SmsReceiver(mChannel);
                } else {
                    smsReceiver = new SmsReceiver(mChannel);
                }
                IntentFilter intentFilter = new IntentFilter(ReadSmsConstant.READ_SMS_BROADCAST_ACTION);
                activity.registerReceiver(smsReceiver, intentFilter);
                mResult.success(true);
            }
        });
        task.addOnFailureListener(e -> {
            Log.i(TAG, "ERROR MESSAGE : " + e.getMessage());
            mResult.error(Constant.SMS_VERIFICATION_FAIL, e.getMessage(), "");
        });
    }

    private void obtainHashCode() {
        String packageName = AGConnectServicesConfig.fromContext(
                activity.getApplicationContext())
                .getString("client/package_name");
        if (packageName != null) {
            MessageDigest messageDigest = getMessageDigest();
            String signature = getSignature(activity.getApplicationContext(), packageName);
            String hashCode = getHashCode(packageName, messageDigest, signature);
            mResult.success(hashCode);
        } else {
            mResult.error(Constant.OBTAIN_HASH_CODE_FAIL, "Package name is null", "");
        }
    }

    private void buildNetworkUrl(MethodCall methodCall) {
        String domainName = methodCall.argument("domainName");
        Boolean isHttps = methodCall.argument("isHttps");

        if (domainName != null && isHttps != null) {
            String cookie = NetworkTool.buildNetworkUrl(domainName, isHttps);
            mResult.success(cookie);
        } else {
            mResult.error(Constant.BUILD_NETWORK_URL_FAIL, "Null parameters", "");
        }
    }

    private void buildNetworkCookie(MethodCall methodCall) {
        String cookieName = methodCall.argument("cookieName");
        String cookieValue = methodCall.argument("cookieValue");
        String domain = methodCall.argument("domain");
        String path = methodCall.argument("path");
        Boolean isHttpOnly = methodCall.argument("isHttpOnly");
        Boolean isSecure = methodCall.argument("isSecure");
        Double maxAge = methodCall.argument("maxAge");

        if (cookieName != null && cookieValue != null && domain != null
        && path != null && isHttpOnly != null
        && isSecure != null && maxAge != null) {
            String combinedCookieData = NetworkTool.buildNetworkCookie(
                    cookieName, cookieValue, domain, path,
                    isHttpOnly, isSecure, maxAge.longValue());
            mResult.success(combinedCookieData);
        } else {
            mResult.error(Constant.BUILD_NETWORK_COOKIE_FAIL, "Null parameters", "");
        }
    }

    private void addAuthScopes(MethodCall methodCall) {
        String authScopesJsonString = methodCall.argument("authScopes");
        try {
            JSONObject authScopeObject = new JSONObject(authScopesJsonString);
            JSONObject obj = authScopeObject.getJSONObject("authScopeData");
            int requestCode = obj.getInt("requestCode");
            JSONArray scopes = obj.getJSONArray("scopes");
            List<Scope> scope = buildScopeList(scopes);
            HuaweiIdAuthManager.addAuthScopes(activity, requestCode, scope);
            mResult.success(Constant.successResponse);
        } catch (JSONException e) {
            e.printStackTrace();
            mResult.error(Constant.ADD_AUTH_SCOPES_FAIL, e.getMessage(), "");
        }
    }

    private void getAuthResultWithScopes(MethodCall methodCall) {
        String authScopesJsonString = methodCall.argument("requestParams");
        try {
            JSONObject obj = new JSONObject(authScopesJsonString);
            JSONArray scopes = obj.getJSONArray("scopeList");
            List<Scope> scope = buildScopeList(scopes);
            AuthHuaweiId authResult = HuaweiIdAuthManager.getAuthResultWithScopes(scope);
            JSONObject authJson = AccountBuilder.createAccountJsonObject(authResult);
            mResult.success(authJson.toString());
        } catch (HuaweiIdAuthException | JSONException e) {
            mResult.error(Constant.GET_AUTH_RESULT_WITH_SCOPES_FAIL, e.getMessage(), "");
        }
    }

    private void getAuthResult() {
        try {
            AuthHuaweiId huaweiId = HuaweiIdAuthManager.getAuthResult();
            JSONObject object = AccountBuilder.createAccountJsonObject(huaweiId);
            mResult.success(object.toString());
        } catch (JSONException e) {
            mResult.error(Constant.GET_AUTH_RESULT_FAIL, e.getMessage(), "");
        }
    }

    private void containScopes(MethodCall methodCall) {
        String jsonString = Objects.requireNonNull(methodCall.argument("authInfo")).toString();
        try {
            JSONObject obj = new JSONObject(jsonString);
            JSONObject authObject = obj.getJSONObject("authData");
            JSONArray scopes = obj.getJSONArray("scopeList");
            AuthHuaweiId authHuaweiId = buildHuaweiId(authObject);
            List<Scope> scopeList = buildScopeList(scopes);
            Boolean response = HuaweiIdAuthManager.containScopes(authHuaweiId, scopeList);
            mResult.success(response);
        } catch (JSONException e) {
            mResult.error(Constant.CONTAIN_SCOPES_FAIL, e.getMessage(), "");
        }
    }

    private List<Scope> buildScopeList(JSONArray scopeList) throws JSONException {
        List<Scope> list = new ArrayList<>();
        for (int i = 0; i < scopeList.length(); ++i) {
            Scope element = new Scope(scopeList.getString(i));
            list.add(element);
        }
        return list;
    }

    private static AuthHuaweiId buildHuaweiId(JSONObject obj) throws JSONException {
        JSONArray authorizedScopes = obj.getJSONArray("authorizedScopes");

        String openId = obj.getString("openId");
        String uid = obj.getString("unionId");
        String displayName = obj.getString("displayName");
        String photoUrl = obj.getString("avatarUriString");
        String accessToken = obj.getString("accessToken");
        String serviceCountryCode = obj.getString("serviceCountryCode");
        int status = obj.getInt("status");
        int gender = obj.getInt("gender");
        String serverAuthCode = obj.getString("authorizationCode");
        String unionId = obj.getString("unionId");
        String countryCode = obj.getString("countryCode");
        Set<Scope> scope = new HashSet<>();

        for (int i = 0; i < authorizedScopes.length(); i++) {
            String val = authorizedScopes.getString(i);
            Scope element = new Scope(val);
            scope.add(element);
        }
        return AuthHuaweiId.build(
                openId, uid, displayName, photoUrl,
                accessToken, serviceCountryCode, status,
                gender, scope, serverAuthCode, unionId, countryCode);
    }

    private void deleteAuthInfo(MethodCall methodCall) {
        String accessToken = methodCall.argument("accessToken");
        new Thread(() -> {
            try {
                HuaweiIdAuthTool.deleteAuthInfo(activity, accessToken);
                handler.post(() -> mResult.success(Constant.successResponse));
            } catch (HuaweiIdAuthException e) {
                handler.post(() -> mResult.error(Constant.DELETE_AUTH_INFO_FAIL, e.getMessage(), ""));
            }
        }).start();
    }

    private void requestUnionId(MethodCall methodCall) {
        String huaweiAccountName = methodCall.argument("huaweiAccountName");
        new Thread(() -> {
            try {
                String unionId = HuaweiIdAuthTool.requestUnionId(activity, huaweiAccountName);
                handler.post(() -> mResult.success(unionId));
            } catch (HuaweiIdAuthException e) {
                Log.i(TAG, e.getMessage());
                handler.post(() -> mResult.error(Constant.REQUEST_UNION_ID_FAIL, e.getMessage(), ""));
            }
        }).start();
    }

    private void requestAccessToken(MethodCall methodCall) {
        String jsonString = Objects.requireNonNull(methodCall.argument("accountData")).toString();
        new Thread(() -> {
            try {
                JSONObject obj = new JSONObject(jsonString);
                Account account = new Account(obj.getString("accountName"), obj.getString("accountType"));
                JSONArray scopeJsonArray = obj.getJSONArray("scopeList");
                List<Scope> scopes = buildScopeList(scopeJsonArray);
                String accessToken = HuaweiIdAuthTool.requestAccessToken(activity, account, scopes);
                handler.post(() -> mResult.success(accessToken));
            } catch (JSONException | HuaweiIdAuthException e) {
                handler.post(() -> mResult.error(Constant.REQUEST_ACCESS_TOKEN_FAIL, e.getMessage(), ""));
            }
        }).start();
    }

    // TO GET HASHCODE
    private MessageDigest getMessageDigest() {
        MessageDigest messageDigest = null;
        try {
            messageDigest = MessageDigest.getInstance("SHA-256");
        } catch (NoSuchAlgorithmException e) {
            Log.e(TAG, "No Such Algorithm.", e);
        }
        return messageDigest;
    }

    // TO GET HASHCODE
    @SuppressLint("PackageManagerGetSignatures")
    private String getSignature(Context context, String packageName) {
        PackageManager packageManager = context.getPackageManager();
        Signature[] signatureArrs;
        try {
            signatureArrs = packageManager.getPackageInfo(packageName, PackageManager.GET_SIGNATURES).signatures;
        } catch (PackageManager.NameNotFoundException e) {
            Log.e(TAG, "Package name inexistent.");
            return "";
        }
        if (null == signatureArrs || 0 == signatureArrs.length) {
            Log.e(TAG, "signature is null.");
            return "";
        }
        return signatureArrs[0].toCharsString();
    }

    // GETTING HASHCODE
    private String getHashCode(String packageName, MessageDigest messageDigest, String signature) {
        String appInfo = packageName + " " + signature;
        messageDigest.update(appInfo.getBytes(StandardCharsets.UTF_8));
        byte[] hashSignature = messageDigest.digest();
        hashSignature = Arrays.copyOfRange(hashSignature, 0, 9);
        String base64Hash = Base64.encodeToString(hashSignature, Base64.NO_PADDING | Base64.NO_WRAP);
        base64Hash = base64Hash.substring(0, 11);
        return base64Hash;
    }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
        // HANDLING SIGN IN RESPONSE
        if (requestCode == signInRequestCode) {
            Task<AuthHuaweiId> authHuaweiIdTask = HuaweiIdAuthManager.parseAuthResultFromIntent(data);

            authHuaweiIdTask.addOnSuccessListener(authHuaweiId -> {
                try {
                    JSONObject hwid = AccountBuilder.createAccountJsonObject(authHuaweiId);
                    Account account = authHuaweiId.getHuaweiAccount();
                    if (account != null) {
                        hwid.put("account", AccountBuilder.addAccount(account));
                    } else {
                        Log.i(TAG, "no account data");
                    }
                    mResult.success(hwid.toString());
                } catch (JSONException e) {
                    e.printStackTrace();
                    Log.i(TAG, e.getMessage());
                    mResult.error(Constant.SIGN_IN_FAIL, e.getMessage(), "");
                }
            });

            authHuaweiIdTask.addOnFailureListener(e -> mResult.error(Constant.SIGN_IN_FAIL, e.getMessage(), ""));
        } else if (requestCode == signInCodeRequestCode) {
            Task<AuthHuaweiId> authHuaweiIdTask = HuaweiIdAuthManager.parseAuthResultFromIntent(data);

            authHuaweiIdTask.addOnSuccessListener(authHuaweiId -> {
                try {
                    JSONObject authResponse = AccountBuilder.createAccountJsonObject(authHuaweiId);
                    Account user = authHuaweiId.getHuaweiAccount();

                    if (user != null) {
                        authResponse.put("account", AccountBuilder.addAccount(user));
                    } else {
                        Log.i(TAG, "no account data");
                    }
                    mResult.success(authResponse.toString());
                } catch (JSONException e) {
                    e.printStackTrace();
                    Log.i(TAG, Objects.requireNonNull(e.getMessage()));
                    mResult.error(Constant.SIGN_IN_WITH_AUTHORIZATION_CODE_FAIL, e.getMessage(), "");
                }
            });

            authHuaweiIdTask.addOnFailureListener(e -> mResult.error(
                    Constant.SIGN_IN_WITH_AUTHORIZATION_CODE_FAIL,
                    e.getMessage(), ""));
        } else {
            Log.i(TAG, "No request code found");
        }
        return true;
    }
}
