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
        service = new ContactShieldService(activity);
        hmsLogger = HMSLogger.getInstance(activity.getApplicationContext());
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        service.setCall(call);
        service.setResult(result);
        hmsLogger.startMethodExecutionTimer(call.method);

        switch (call.method) {
            case Method.IS_CONTACT_SHIELD_RUNNING:
                service.isContactShieldRunning();
                break;
            case Method.START_CONTACT_SHIELD_CB:
                service.startContactShieldCb();
                break;
            case Method.START_CONTACT_SHIELD:
                service.startContactShield();
                break;
            case Method.START_CONTACT_SHIELD_NON_PERSISTENT:
                service.startContactShieldNoPersistent();
                break;
            case Method.GET_PERIODIC_KEY:
                service.getPeriodicKey();
                break;
            case Method.PUT_SHARED_KEY_FILES:
                service.putSharedKeyFiles();
                break;
            case Method.PUT_SHARED_KEY_FILES_CB:
                service.putSharedKeyFilesCb();
                break;
            case Method.PUT_SHARED_KEY_FILES_CB_WITH_PROVIDER:
                service.putSharedKeyFilesCbWithProvider();
                break;
            case Method.PUT_SHARED_KEY_FILES_CB_WITH_KEYS:
                service.putSharedKeyFilesCbWithKeys();
                break;
            case Method.GET_CONTACT_DETAIL:
                service.getContactDetail();
                break;
            case Method.GET_CONTACT_SKETCH:
                service.getContactSketch();
                break;
            case Method.GET_CONTACT_WINDOW:
                service.getContactWindow();
                break;
            case Method.SET_SHARED_KEYS_DATA_MAPPING:
                service.setSharedKeysDataMapping();
                break;
            case Method.GET_SHARED_KEYS_DATA_MAPPING:
                service.getSharedKeysDataMapping();
                break;
            case Method.GET_DAILY_SKETCH:
                service.getDailySketch();
                break;
            case Method.GET_CONTACT_SHIELD_VERSION:
                service.getContactShieldVersion();
                break;
            case Method.GET_DEVICE_CALIBRATION_CONFIDENCE:
                service.getDeviceCalibrationConfidence();
                break;
            case Method.IS_SUPPORT_SCANNING_WITHOUT_LOCATION:
                service.isSupportScanningWithoutLocation();
                break;
            case Method.GET_STATUS:
                service.getStatus();
                break;
            case Method.CLEAR_DATA:
                service.clearData();
                break;
            case Method.STOP_CONTACT_SHIELD:
                service.stopContactShield();
                break;
            case Method.ENABLE_LOGGER:
                service.enableLogger();
                break;
            case Method.DISABLE_LOGGER:
                service.disableLogger();
                break;
            default:
                result.notImplemented();
                break;
        }
    }
}
