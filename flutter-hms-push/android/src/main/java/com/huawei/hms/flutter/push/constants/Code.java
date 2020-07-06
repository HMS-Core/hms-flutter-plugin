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

package com.huawei.hms.flutter.push.constants;

public enum Code {

    RESULT_SUCCESS("0"),
    RESULT_FAIL("907122045"),
    PARAMETER_IS_EMPTY("907122042"),
    OPERATION_IN_MAIN_THREAD_PROHIBITED("907122050");

    private String code;

    Code(String code) {
        this.code = code;
    }

    public String code() {
        return code;
    }

    public static Code fromString(String text) {
        for (Code b : Code.values()) {
            if (b.code.equalsIgnoreCase(text)) {
                return b;
            }
        }
        return null;
    }

}
