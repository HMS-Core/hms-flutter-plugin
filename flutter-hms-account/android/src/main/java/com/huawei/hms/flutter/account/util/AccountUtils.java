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

import com.huawei.hms.support.api.entity.auth.Scope;
import com.huawei.hms.support.hwid.result.AuthHuaweiId;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import io.flutter.plugin.common.MethodCall;

public class AccountUtils {
    private static List<String> EMPTY_SCOPE_LIST = new ArrayList<>();

    public static List<Scope> getScopeList(List<String> list) {
        List<Scope> scopes = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            Scope sc = new Scope(list.get(i));
            scopes.add(sc);
        }
        return scopes;
    }

    private static Set<Scope> getScopeSet(List<String> list) {
        List<Scope> scopes = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            Scope scope = new Scope(list.get(i));
            scopes.add(scope);
        }
        return new HashSet<>(scopes);
    }

    public static AuthHuaweiId buildHwId(Map<String, Object> map, MethodCall call) {
        String openId = call.argument("openId");
        String uId = call.argument("uid");
        String displayName = call.argument("displayName");
        String photoUri = call.argument("avatarUriString");
        String accessToken = call.argument("accessToken");
        String serviceCountryCode = call.argument("serviceCountryCode");
        int status = map.containsKey("status") ? (int) map.get("status") : 0;
        int gender = map.containsKey("gender") ? (int) map.get("gender") : -1;
        List<String> scopeList = call.argument("authorizedScopes");
        String serverAuthCode = call.argument("authorizationCode");
        String unionId = call.argument("unionId");
        String countryCode = call.argument("countryCode");

        return AuthHuaweiId.build(
                openId,
                uId,
                displayName,
                photoUri,
                accessToken,
                serviceCountryCode,
                status,
                gender,
                getScopeSet(scopeList != null ? scopeList : EMPTY_SCOPE_LIST),
                serverAuthCode,
                unionId,
                countryCode);
    }
}
