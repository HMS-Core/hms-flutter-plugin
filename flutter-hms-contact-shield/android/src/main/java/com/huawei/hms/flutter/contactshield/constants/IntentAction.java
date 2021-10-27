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

package com.huawei.hms.flutter.contactshield.constants;

public final class IntentAction {
    public static final String START_CONTACT_SHIELD_CB = "com.huawei.hms.flutter.contactshield." +
        "startContactShieldCb";
    public static final String PUT_SHARED_KEY_FILES_CB = "com.huawei.hms.flutter.contactshield." +
        "putSharedKeyFilesCb";
    public static final String PUT_SHARED_KEY_FILES_CB_WITH_PROVIDER = "com.huawei.hms.flutter.contactshield." +
        "putSharedKeyFilesCbWithProvider";
    public static final String PUT_SHARED_KEY_FILES_CB_WITH_KEYS = "com.huawei.hms.flutter.contactshield." +
        "putSharedKeyFilesCbWithKeys";
    public static final String PUT_SHARED_KEY_FILES_CB_PROVIDER_KEYS = "com.huawei.hms.flutter.contactshield." +
            "putSharedKeyFilesCbProviderKeys";

    private IntentAction() {
    }
}
