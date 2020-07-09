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
import com.huawei.hms.support.api.entity.auth.Scope;
import com.huawei.hms.support.hwid.result.AuthHuaweiId;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import java.util.Set;

class AccountBuilder {
    static JSONObject createAccountJsonObject(AuthHuaweiId authHuaweiId) throws JSONException {
        JSONObject account = new JSONObject();
        account.put("accessToken", authHuaweiId.getAccessToken());
        account.put("displayName", authHuaweiId.getDisplayName());
        account.put("email", authHuaweiId.getEmail());
        account.put("familyName", authHuaweiId.getFamilyName());
        account.put("givenName", authHuaweiId.getGivenName());
        account.put("idToken", authHuaweiId.getIdToken());
        account.put("authorizationCode", authHuaweiId.getAuthorizationCode());
        account.put("unionId", authHuaweiId.getUnionId());
        account.put("avatarUriString", authHuaweiId.getAvatarUriString());
        account.put("openId", authHuaweiId.getOpenId());
        account.put("countryCode", authHuaweiId.getCountryCode());
        account.put("serviceCountryCode", authHuaweiId.getServiceCountryCode());
        account.put("gender", authHuaweiId.getGender());
        account.put("status", authHuaweiId.getStatus());
        account.put("uid", authHuaweiId.getUid());
        account.put("authorizedScopes", addAuthorizedScopes(authHuaweiId.getAuthorizedScopes()));
        return account;
    }

    private static JSONArray addAuthorizedScopes(Set<Scope> authorizedScopes) {
        JSONArray arrayListAuthorizedScopes = new JSONArray();
        for (Scope authorizedScope : authorizedScopes) {
            String f = authorizedScope.toString();
            arrayListAuthorizedScopes.put(f);
        }
        return arrayListAuthorizedScopes;
    }

    static JSONObject addAccount(Account account) throws JSONException {
        JSONObject accountJsonObject = new JSONObject();
        accountJsonObject.put("type", account.type);
        accountJsonObject.put("name", account.name);
        return accountJsonObject;
    }
}