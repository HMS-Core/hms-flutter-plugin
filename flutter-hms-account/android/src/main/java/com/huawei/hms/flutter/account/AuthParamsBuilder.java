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

import com.huawei.hms.support.api.entity.auth.Scope;
import com.huawei.hms.support.hwid.request.HuaweiIdAuthParams;
import com.huawei.hms.support.hwid.request.HuaweiIdAuthParamsHelper;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

class AuthParamsBuilder {
    static HuaweiIdAuthParams buildAuthParams(
            JSONObject params,
            HuaweiIdAuthParamsHelper authParamsHelper) throws JSONException {
        if (params.optBoolean("setIdToken", false)) {
            authParamsHelper.setIdToken();
        }

        if (params.optBoolean("setProfile", false)) {
            authParamsHelper.setProfile();
        }

        if (params.optBoolean("setAccessToken", false)) {
            authParamsHelper.setAccessToken();
        }

        if (params.optBoolean("setAuthorizationCode", false)) {
            authParamsHelper.setAuthorizationCode();
        }

        if (params.optBoolean("setMobileNumber", false)) {
            authParamsHelper.setMobileNumber();
        }

        if (params.optBoolean("setEmail", false)) {
            authParamsHelper.setEmail();
        }

        if (params.optBoolean("setShippingAddress", false)) {
            authParamsHelper.setShippingAddress();
        }

        if (params.optBoolean("setUid", false)) {
            authParamsHelper.setUid();
        }

        if (params.optBoolean("setId", false)) {
            authParamsHelper.setId();
        }

        if (params.has("scopeList")) {
            JSONArray scopeList = params.getJSONArray("scopeList");
            List<Scope> scopes = new ArrayList<>();
            for (int i = 0; i < scopeList.length(); ++i) {
                Scope element = new Scope(scopeList.getString(i));
                scopes.add(element);
            }
            authParamsHelper.setScopeList(scopes);
        }
        return authParamsHelper.createParams();
    }
}
