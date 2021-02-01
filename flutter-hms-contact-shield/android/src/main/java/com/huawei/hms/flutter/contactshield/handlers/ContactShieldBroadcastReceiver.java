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

package com.huawei.hms.flutter.contactshield.handlers;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import com.huawei.hms.contactshield.ContactShield;
import com.huawei.hms.contactshield.ContactShieldCallback;
import com.huawei.hms.contactshield.ContactShieldEngine;
import com.huawei.hms.flutter.contactshield.constants.IntentAction;

public class ContactShieldBroadcastReceiver extends BroadcastReceiver {
    private final ContactShieldCallback callback;
    private final ContactShieldEngine engine;

    public ContactShieldBroadcastReceiver(final Context context, final ContactShieldCallback callback) {
        this.callback = callback;
        engine = ContactShield.getContactShieldEngine(context);
    }

    @Override
    public void onReceive(final Context context, final Intent intent) {
        if (intent != null) {
            switch (intent.getAction()) {
                case IntentAction.START_CONTACT_SHIELD_CB:
                case IntentAction.PUT_SHARED_KEY_FILES_CB:
                case IntentAction.PUT_SHARED_KEY_FILES_CB_WITH_PROVIDER:
                case IntentAction.PUT_SHARED_KEY_FILES_CB_WITH_KEYS:
                    engine.handleIntent(intent, callback);
                    break;
                default:
                    break;
            }
        }
    }
}
