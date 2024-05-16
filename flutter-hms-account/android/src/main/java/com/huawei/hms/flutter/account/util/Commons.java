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

import com.huawei.hms.support.api.entity.auth.Scope;
import com.huawei.hms.support.hwid.result.AuthHuaweiId;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class Commons {
    public static List<Scope> getScopeList(List<String> list) {
        List<Scope> scopes = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            Scope sc = new Scope(list.get(i));
            scopes.add(sc);
        }
        return scopes;
    }

    public static Set<Scope> getScopeSet(List<String> list) {
        List<Scope> scopes = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            Scope scope = new Scope(list.get(i));
            scopes.add(scope);
        }
        return new HashSet<>(scopes);
    }
}
