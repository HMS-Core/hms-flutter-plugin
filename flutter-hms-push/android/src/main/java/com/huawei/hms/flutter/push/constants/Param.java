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

package com.huawei.hms.flutter.push.constants;

public enum Param {

    TOPIC("topic"),
    ENABLED("enabled"),
    SCOPE("scope"),
    MESSAGE("msg"),
    SUBJECT_ID("subjectId");

    private String code;

    Param(String code) {
        this.code = code;
    }

    public String code() {
        return code;
    }

    public static Param fromString(String text) {
        for (Param b : Param.values()) {
            if (b.code.equalsIgnoreCase(text)) {
                return b;
            }
        }
        return null;
    }
}
