/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.contactshield.utils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public enum ObjectSerializer {
    INSTANCE;

    private final Gson gson;

    ObjectSerializer() {
        gson = new GsonBuilder().serializeNulls().create();
    }

    public final <T> String toJson(final T obj) {
        return gson.toJson(obj);
    }

    public final <T> T fromJson(final String json, final Class<T> cls) {
        return gson.fromJson(json, cls);
    }
}
