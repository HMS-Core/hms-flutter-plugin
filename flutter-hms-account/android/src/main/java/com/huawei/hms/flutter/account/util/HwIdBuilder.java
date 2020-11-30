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

package com.huawei.hms.flutter.account.util;

import android.accounts.Account;

import com.huawei.hms.support.api.entity.auth.Scope;
import com.huawei.hms.support.hwid.result.AuthHuaweiId;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

public class HwIdBuilder {
    public static HashMap<String, Object> createHwId(AuthHuaweiId authHuaweiId) {
        HashMap<String, Object> hwId = new HashMap<>();
        hwId.put("accessToken", authHuaweiId.getAccessToken());
        hwId.put("displayName", authHuaweiId.getDisplayName());
        hwId.put("email", authHuaweiId.getEmail());
        hwId.put("familyName", authHuaweiId.getFamilyName());
        hwId.put("givenName", authHuaweiId.getGivenName());
        hwId.put("authorizedScopes", addResultScopes(authHuaweiId.getAuthorizedScopes()));
        hwId.put("idToken", authHuaweiId.getIdToken());
        hwId.put("avatarUriString", authHuaweiId.getAvatarUriString());
        hwId.put("authorizationCode", authHuaweiId.getAuthorizationCode());
        hwId.put("unionId", authHuaweiId.getUnionId());
        hwId.put("openId", authHuaweiId.getOpenId());
        return hwId;
    }

    private static List<String> addResultScopes(Set<Scope> authorizedScopes) {
        List<String> arrayListAuthorizedScopes = new ArrayList<>();
        for (Scope authorizedScope : authorizedScopes) {
            String f = authorizedScope.toString();
            arrayListAuthorizedScopes.add(f);
        }
        return arrayListAuthorizedScopes;
    }

    public static HashMap<String, Object> createAccount(Account account) {
        HashMap<String, Object> accountMap = new HashMap<>();
        accountMap.put("type", account.type);
        accountMap.put("name", account.name);
        return accountMap;
    }
}