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

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.contactshield.constants.Method;
import com.huawei.hms.flutter.contactshield.logger.HMSLogger;
import com.huawei.hms.flutter.contactshield.services.ContactShieldService;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class ContactShieldMethodCallHandler implements MethodCallHandler {
    private final ContactShieldService service;
    private final HMSLogger hmsLogger;

    public ContactShieldMethodCallHandler(final Activity activity) {
        this.service = new ContactShieldService(activity);
        this.hmsLogger = HMSLogger.getInstance(activity.getApplicationContext());
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        this.service.setCall(call);
        this.service.setResult(result);
        this.hmsLogger.startMethodExecutionTimer(call.method);

        switch (call.method) {
            case Method.IS_CONTACT_SHIELD_RUNNING:
                this.service.isContactShieldRunning();
                break;
            case Method.START_CONTACT_SHIELD_OLD:
                this.service.startContactShieldOld();
                break;
            case Method.START_CONTACT_SHIELD:
                this.service.startContactShield();
                break;
            case Method.START_CONTACT_SHIELD_NON_PERSISTENT:
                this.service.startContactShieldNoPersistent();
                break;
            case Method.GET_PERIODIC_KEY:
                this.service.getPeriodicKey();
                break;
            case Method.PUT_SHARED_KEY_FILES_OLD:
                this.service.putSharedKeyFilesOld();
                break;
            case Method.PUT_SHARED_KEY_FILES:
                this.service.putSharedKeyFiles();
                break;
            case Method.GET_CONTACT_DETAIL:
                this.service.getContactDetail();
                break;
            case Method.GET_CONTACT_SKETCH:
                this.service.getContactSketch();
                break;
            case Method.GET_CONTACT_WINDOW:
                this.service.getContactWindow();
                break;
            case Method.CLEAR_DATA:
                this.service.clearData();
                break;
            case Method.STOP_CONTACT_SHIELD:
                this.service.stopContactShield();
                break;
            case Method.ENABLE_LOGGER:
                this.service.enableLogger();
                break;
            case Method.DISABLE_LOGGER:
                this.service.disableLogger();
                break;
            default:
                result.notImplemented();
                break;
        }
    }
}
