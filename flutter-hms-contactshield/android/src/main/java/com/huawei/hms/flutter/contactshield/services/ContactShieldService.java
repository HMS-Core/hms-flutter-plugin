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

package com.huawei.hms.flutter.contactshield.services;

import android.app.Activity;
import android.app.PendingIntent;
import android.content.Context;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.huawei.hms.contactshield.ContactShield;
import com.huawei.hms.contactshield.ContactShieldEngine;
import com.huawei.hms.contactshield.ContactShieldSetting;
import com.huawei.hms.contactshield.DiagnosisConfiguration;
import com.huawei.hms.flutter.contactshield.constants.IntentAction;
import com.huawei.hms.flutter.contactshield.constants.Method;
import com.huawei.hms.flutter.contactshield.constants.RequestCode;
import com.huawei.hms.flutter.contactshield.logger.HMSLogger;
import com.huawei.hms.flutter.contactshield.utils.ErrorProvider;
import com.huawei.hms.flutter.contactshield.utils.ObjectProvider;

import java.io.File;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

public class ContactShieldService {
    private final Context context;
    private final ContactShieldEngine engine;
    private final Gson gson;
    private final HMSLogger hmsLogger;

    private MethodCall call;
    private Result result;

    public ContactShieldService(final Activity activity) {
        this.context = activity.getApplicationContext();
        this.engine = ContactShield.getContactShieldEngine(activity);
        this.gson = new GsonBuilder().serializeNulls().create();
        this.hmsLogger = HMSLogger.getInstance(activity.getApplicationContext());
    }

    public void setCall(final MethodCall call) {
        this.call = call;
    }

    public void setResult(final Result result) {
        this.result = result;
    }

    public void isContactShieldRunning() {
        this.engine.isContactShieldRunning()
            .addOnSuccessListener(aBoolean -> handleSuccess(Method.IS_CONTACT_SHIELD_RUNNING, aBoolean))
            .addOnFailureListener(e -> handleError(Method.IS_CONTACT_SHIELD_RUNNING, e));
    }

    @Deprecated
    public void startContactShieldOld() {
        final PendingIntent pendingIntent = ObjectProvider.getPendingIntent(this.context,
            IntentAction.CHECK_CONTACT_STATUS_OLD, RequestCode.START_CONTACT_SHIELD_OLD);
        final ContactShieldSetting setting = ObjectProvider.getContactShieldSetting(this.call);

        this.engine.startContactShield(pendingIntent, setting)
            .addOnSuccessListener(aVoid -> handleVoidSuccess(Method.START_CONTACT_SHIELD_OLD))
            .addOnFailureListener(e -> handleError(Method.START_CONTACT_SHIELD_OLD, e));
    }

    public void startContactShield() {
        final ContactShieldSetting setting = ObjectProvider.getContactShieldSetting(this.call);

        this.engine.startContactShield(setting)
            .addOnSuccessListener(aVoid -> handleVoidSuccess(Method.START_CONTACT_SHIELD))
            .addOnFailureListener(e -> handleError(Method.START_CONTACT_SHIELD, e));
    }

    public void startContactShieldNoPersistent() {
        final ContactShieldSetting setting = ObjectProvider.getContactShieldSetting(this.call);

        this.engine.startContactShieldNoPersistent(setting)
            .addOnSuccessListener(aVoid -> handleVoidSuccess(Method.START_CONTACT_SHIELD_NON_PERSISTENT))
            .addOnFailureListener(e -> handleError(Method.START_CONTACT_SHIELD_NON_PERSISTENT, e));
    }

    public void getPeriodicKey() {
        this.engine.getPeriodicKey()
            .addOnSuccessListener(
                periodicKeys -> handleSuccess(Method.GET_PERIODIC_KEY, this.gson.toJson(periodicKeys)))
            .addOnFailureListener(e -> handleError(Method.GET_PERIODIC_KEY, e));
    }

    @Deprecated
    public void putSharedKeyFilesOld() {
        final List<File> files = ObjectProvider.getFileList(this.call);
        final DiagnosisConfiguration diagnosisConfig = ObjectProvider.getDiagnosisConfiguration(this.call, this.gson);
        final String token = this.call.argument("token");

        this.engine.putSharedKeyFiles(files, diagnosisConfig, token)
            .addOnSuccessListener(aVoid -> handleVoidSuccess(Method.PUT_SHARED_KEY_FILES_OLD))
            .addOnFailureListener(e -> handleError(Method.PUT_SHARED_KEY_FILES_OLD, e));
    }

    public void putSharedKeyFiles() {
        final PendingIntent pendingIntent = ObjectProvider.getPendingIntent(this.context,
            IntentAction.CHECK_CONTACT_STATUS, RequestCode.PUT_SHARED_KEY_FILES);

        final List<File> files = ObjectProvider.getFileList(this.call);
        final DiagnosisConfiguration diagnosisConfig = ObjectProvider.getDiagnosisConfiguration(this.call, this.gson);
        final String token = this.call.argument("token");

        this.engine.putSharedKeyFiles(pendingIntent, files, diagnosisConfig, token)
            .addOnSuccessListener(aVoid -> handleVoidSuccess(Method.PUT_SHARED_KEY_FILES))
            .addOnFailureListener(e -> handleError(Method.PUT_SHARED_KEY_FILES, e));
    }

    @Deprecated
    public void getContactDetail() {
        final String token = this.call.arguments();

        this.engine.getContactDetail(token)
            .addOnSuccessListener(
                contactDetails -> handleSuccess(Method.GET_CONTACT_DETAIL, this.gson.toJson(contactDetails)))
            .addOnFailureListener(e -> handleError(Method.GET_CONTACT_DETAIL, e));
    }

    public void getContactSketch() {
        final String token = this.call.arguments();

        this.engine.getContactSketch(token)
            .addOnSuccessListener(
                contactSketch -> handleSuccess(Method.GET_CONTACT_SKETCH, this.gson.toJson(contactSketch)))
            .addOnFailureListener(e -> handleError(Method.GET_CONTACT_SKETCH, e));
    }

    public void getContactWindow() {
        final String token = this.call.arguments();

        this.engine.getContactWindow(token)
            .addOnSuccessListener(
                contactWindows -> handleSuccess(Method.GET_CONTACT_WINDOW, this.gson.toJson(contactWindows)))
            .addOnFailureListener(e -> handleError(Method.GET_CONTACT_WINDOW, e));
    }

    public void clearData() {
        this.engine.clearData()
            .addOnSuccessListener(aVoid -> handleVoidSuccess(Method.CLEAR_DATA))
            .addOnFailureListener(e -> handleError(Method.CLEAR_DATA, e));
    }

    public void stopContactShield() {
        this.engine.stopContactShield()
            .addOnSuccessListener(aVoid -> handleVoidSuccess(Method.STOP_CONTACT_SHIELD))
            .addOnFailureListener(e -> handleError(Method.STOP_CONTACT_SHIELD, e));
    }

    public void enableLogger() {
        this.hmsLogger.enableLogger();
        this.result.success(null);
    }

    public void disableLogger() {
        this.hmsLogger.disableLogger();
        this.result.success(null);
    }

    private <T> void handleSuccess(final String methodName, final T response) {
        this.result.success(response);
        this.hmsLogger.sendSingleEvent(methodName);
    }

    private void handleVoidSuccess(final String methodName) {
        this.result.success(null);
        this.hmsLogger.sendSingleEvent(methodName);
    }

    private void handleError(final String methodName, final Exception e) {
        final String errorCode = ErrorProvider.getErrorCode(methodName);
        this.result.error(errorCode, e.toString(), null);
        this.hmsLogger.sendSingleEvent(methodName, "-1");
    }
}
