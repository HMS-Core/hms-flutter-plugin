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
import com.huawei.hms.support.hwid.request.HuaweiIdAuthExtendedParams;
import com.huawei.hms.support.hwid.request.HuaweiIdAuthParams;
import com.huawei.hms.support.hwid.request.HuaweiIdAuthParamsHelper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import io.flutter.plugin.common.MethodCall;

public class AuthParamsBuilder {
    public static HuaweiIdAuthParams buildAuthParams(Map<String, Object> map, HuaweiIdAuthParamsHelper authParamsHelper, MethodCall call) {
        List<Scope> scopes = new ArrayList<>();
        final boolean authorizationCodeSet = Objects.equals(map.get("setAuthorizationCode"), true);
        if (authorizationCodeSet) authParamsHelper.setAuthorizationCode();

        final boolean accessTokenSet = Objects.equals(map.get("setAccessToken"), true);
        if (accessTokenSet) authParamsHelper.setAccessToken();

        final boolean emailSet = Objects.equals(map.get("setEmail"), true);
        if (emailSet) authParamsHelper.setEmail();

        final boolean idSet = Objects.equals(map.get("setId"), true);
        if (idSet) authParamsHelper.setId();

        final boolean idTokenSet = Objects.equals(map.get("setIdToken"), true);
        if (idTokenSet) authParamsHelper.setIdToken();

        final boolean profileSet = Objects.equals(map.get("setProfile"), true);
        if (profileSet) authParamsHelper.setProfile();

        List<String> scopeList = call.argument("scopeList");
        if (scopeList != null && !scopeList.isEmpty()) {
            for (int i = 0; i < scopeList.size(); i++) {
                Scope element = new Scope(scopeList.get(i));
                scopes.add(element);
            }
            authParamsHelper.setScopeList(scopes);
        }

        return authParamsHelper.createParams();
    }
}
