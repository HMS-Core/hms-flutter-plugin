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

package com.huawei.hms.flutter.contactshield.handlers;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import com.huawei.hms.contactshield.ContactShield;
import com.huawei.hms.contactshield.ContactShieldCallback;
import com.huawei.hms.contactshield.ContactShieldEngine;
import com.huawei.hms.flutter.contactshield.constants.IntentAction;

public class ContactShieldBroadcastReceiver extends BroadcastReceiver {
    public final ContactShieldCallback callback;
    public final ContactShieldEngine engine;

    public ContactShieldBroadcastReceiver(final Context context, final ContactShieldCallback callback) {
        this.callback = callback;
        this.engine = ContactShield.getContactShieldEngine(context);
    }

    @Override
    public void onReceive(final Context context, final Intent intent) {
        if (intent != null) {
            switch (intent.getAction()) {
                case IntentAction.CHECK_CONTACT_STATUS_OLD:
                case IntentAction.CHECK_CONTACT_STATUS:
                    this.engine.handleIntent(intent, this.callback);
                    break;
                default:
                    break;
            }
        }
    }
}
