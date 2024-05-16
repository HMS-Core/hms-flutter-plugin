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

package com.huawei.hms.flutter.account.util;

import android.accounts.Account;
import android.content.Context;
import android.graphics.Bitmap;
import android.util.Log;

import com.huawei.hms.support.account.request.AccountAuthParams;
import com.huawei.hms.support.account.request.AccountAuthParamsHelper;
import com.huawei.hms.support.account.result.AccountIcon;
import com.huawei.hms.support.account.result.AuthAccount;
import com.huawei.hms.support.api.entity.auth.Scope;

import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import io.flutter.plugin.common.MethodCall;

public class AccountBuilder {
    private static final String TAG = "AccUtil";

    public static AccountAuthParams buildAccountAuthParams(AccountAuthParamsHelper helper, MethodCall call) {
        Boolean uidSet = FromMap.toBoolean("setUid", call.argument("setUid"));
        if (uidSet) {
            helper.setUid();
        }
        Boolean authCodeSet = FromMap.toBoolean("setAuthorizationCode", call.argument("setAuthorizationCode"));
        if (authCodeSet) {
            helper.setAuthorizationCode();
        }
        Boolean accTokenSet = FromMap.toBoolean("setAccessToken", call.argument("setAccessToken"));
        if (accTokenSet) {
            helper.setAccessToken();
        }
        Boolean emailSet = FromMap.toBoolean("setEmail", call.argument("setEmail"));
        if (emailSet) {
            helper.setEmail();
        }
        Boolean idSet = FromMap.toBoolean("setId", call.argument("setId"));
        if (idSet) {
            helper.setId();
        }
        Boolean idTokenSet = FromMap.toBoolean("setIdToken", call.argument("setIdToken"));
        if (idTokenSet) {
            helper.setIdToken();
        }
        Boolean profileSet = FromMap.toBoolean("setProfile", call.argument("setProfile"));
        if (profileSet) {
            helper.setProfile();
        }
        Boolean mobileNumberSet = FromMap.toBoolean("setMobileNumber", call.argument("setMobileNumber"));
        if (mobileNumberSet) {
            helper.setMobileNumber();
        }
        Boolean forceLogoutSet = FromMap.toBoolean("setForceLogout", call.argument("setForceLogout"));
        if (forceLogoutSet) {
            helper.setForceLogout();
        }
        Boolean assistTokenSet = FromMap.toBoolean("setAssistToken", call.argument("setAssistToken"));
        if (assistTokenSet) {
            helper.setAssistToken();
        }
        Boolean dialogAuthSet = FromMap.toBoolean("setDialogAuth", call.argument("setDialogAuth"));
        if (dialogAuthSet) {
            helper.setDialogAuth();
        }
        Boolean carrierIdSet = FromMap.toBoolean("setCarrierId", call.argument("setCarrierId"));
        if (carrierIdSet) {
            helper.setCarrierId();
        }
        Integer idTokenSignAlg = FromMap.toInteger("setIdTokenSignAlg", call.argument("setIdTokenSignAlg"));
        if (idTokenSignAlg != null) {
            helper.setIdTokenSignAlg(idTokenSignAlg + 1);
        }
        List<String> scopeList = FromMap.toStringArrayList("scopeList", call.argument("scopeList"));
        if (!scopeList.isEmpty()) {
            List<Scope> scopes = new ArrayList<>();

            for (int i = 0; i < scopeList.size(); i++) {
                Scope element = new Scope(scopeList.get(i));
                scopes.add(element);
            }

            helper.setScopeList(scopes);
            Log.i(TAG, "Scope list is set");
        }
        return helper.createParams();
    }

    public static Map<String, Object> authAccountToMap(AuthAccount authAccount, Context context) {
        Map<String, Object> acc = new HashMap<>();
        acc.put("accessToken", authAccount.getAccessToken());
        acc.put("serviceCountryCode", authAccount.getServiceCountryCode());
        acc.put("displayName", authAccount.getDisplayName());
        acc.put("email", authAccount.getEmail());
        acc.put("familyName", authAccount.getFamilyName());
        acc.put("givenName", authAccount.getGivenName());
        acc.put("gender", authAccount.getGender());
        acc.put("authorizedScopes", authScopesToMap(authAccount.getAuthorizedScopes()));
        acc.put("idToken", authAccount.getIdToken());
        acc.put("avatarUri", authAccount.getAvatarUriString());
        acc.put("authorizationCode", authAccount.getAuthorizationCode());
        acc.put("unionId", authAccount.getUnionId());
        acc.put("openId", authAccount.getOpenId());
        acc.put("accountFlag", authAccount.getAccountFlag());
        acc.put("carrierId", authAccount.getCarrierId());
        if (authAccount.getAccount(context) != null) {
            acc.put("account", androidAccountToMap(authAccount.getAccount(context)));
        }
        return acc;
    }

    public static AuthAccount buildAuthAccount(Map<String, Object> map) {
        String openId = FromMap.toString("openId", map.get("openId"), false);
        String displayName = FromMap.toString("displayName", map.get("displayName"), false);
        String photoUri = FromMap.toString("avatarUri", map.get("avatarUri"), false);
        String accessToken = FromMap.toString("accessToken", map.get("accessToken"), false);
        String serviceCountryCode = FromMap.toString("serviceCountryCode", map.get("serviceCountryCode"), false);
        Integer gender = FromMap.toInteger("gender", map.get("gender"));
        List<String> scopeList = FromMap.toStringArrayList("authorizedScopes", map.get("authorizedScopes"));
        String authorizationCode = FromMap.toString("authorizationCode", map.get("authorizationCode"), false);
        String unionId = FromMap.toString("unionId", map.get("unionId"), false);
        Integer carrierId = FromMap.toInteger("carrierId", map.get("carrierId"));

        return AuthAccount.build(
                openId,
                null,
                displayName,
                photoUri,
                accessToken,
                serviceCountryCode,
                0,
                gender != null ? gender : -1,
                Commons.getScopeSet(scopeList),
                authorizationCode,
                unionId,
                null, carrierId);
    }

    public static Map<String, Object> accountIconToMap(AccountIcon icon) {
        Map<String, Object> map = new HashMap<>();
        map.put("description", icon.getDescription());
        map.put("describeContents", icon.describeContents());
        if (icon.getIcon() != null) {
            map.put("bytes", bitmapToByteArray(icon.getIcon()));
        }
        return map;
    }

    public static Map<String, Object> androidAccountToMap(Account account) {
        Map<String, Object> accountMap = new HashMap<>();
        accountMap.put("type", account.type);
        accountMap.put("name", account.name);
        return accountMap;
    }

    private static List<String> authScopesToMap(Set<Scope> authorizedScopes) {
        List<String> arrayListAuthorizedScopes = new ArrayList<>();
        for (Scope authorizedScope : authorizedScopes) {
            String f = authorizedScope.toString();
            arrayListAuthorizedScopes.add(f);
        }
        return arrayListAuthorizedScopes;
    }

    public static byte[] bitmapToByteArray(Bitmap bitmap) {
        ByteArrayOutputStream stream = new ByteArrayOutputStream();
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream);
        byte[] byteArray = stream.toByteArray();
        bitmap.recycle();
        return byteArray;
    }
}
