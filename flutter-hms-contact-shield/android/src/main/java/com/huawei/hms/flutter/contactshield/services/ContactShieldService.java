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

package com.huawei.hms.flutter.contactshield.services;

import android.app.Activity;
import android.app.PendingIntent;
import android.content.Context;

import com.huawei.hms.common.ApiException;
import com.huawei.hms.contactshield.ContactShield;
import com.huawei.hms.contactshield.ContactShieldEngine;
import com.huawei.hms.contactshield.ContactShieldSetting;
import com.huawei.hms.contactshield.DailySketchConfiguration;
import com.huawei.hms.contactshield.DiagnosisConfiguration;
import com.huawei.hms.contactshield.SharedKeyFileProvider;
import com.huawei.hms.contactshield.SharedKeysDataMapping;
import com.huawei.hms.flutter.contactshield.constants.IntentAction;
import com.huawei.hms.flutter.contactshield.constants.Method;
import com.huawei.hms.flutter.contactshield.constants.RequestCode;
import com.huawei.hms.flutter.contactshield.logger.HMSLogger;
import com.huawei.hms.flutter.contactshield.utils.ObjectProvider;
import com.huawei.hms.flutter.contactshield.utils.ObjectSerializer;

import java.io.File;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

public class ContactShieldService {
    private final Context context;
    private final ContactShieldEngine engine;
    private final HMSLogger hmsLogger;

    private MethodCall call;
    private Result result;

    public ContactShieldService(final Activity activity) {
        context = activity.getApplicationContext();
        engine = ContactShield.getContactShieldEngine(activity);
        hmsLogger = HMSLogger.getInstance(activity.getApplicationContext());
    }

    public void setCall(final MethodCall call) {
        this.call = call;
    }

    public void setResult(final Result result) {
        this.result = result;
    }

    public void isContactShieldRunning() {
        engine.isContactShieldRunning()
            .addOnSuccessListener(aBoolean -> returnSuccess(Method.IS_CONTACT_SHIELD_RUNNING, aBoolean))
            .addOnFailureListener(e -> returnError(Method.IS_CONTACT_SHIELD_RUNNING, e));
    }

    public void startContactShieldCb() {
        final ContactShieldSetting setting = ObjectProvider.getContactShieldSetting(call);

        final PendingIntent pendingIntent = ObjectProvider.getPendingIntent(context,
            IntentAction.START_CONTACT_SHIELD_CB, RequestCode.START_CONTACT_SHIELD_CB);

        engine.startContactShield(pendingIntent, setting)
            .addOnSuccessListener(aVoid -> returnSuccess(Method.START_CONTACT_SHIELD_CB, null))
            .addOnFailureListener(e -> returnError(Method.START_CONTACT_SHIELD_CB, e));
    }

    public void startContactShield() {
        final ContactShieldSetting setting = ObjectProvider.getContactShieldSetting(call);

        engine.startContactShield(setting)
            .addOnSuccessListener(aVoid -> returnSuccess(Method.START_CONTACT_SHIELD, null))
            .addOnFailureListener(e -> returnError(Method.START_CONTACT_SHIELD, e));
    }

    public void startContactShieldNoPersistent() {
        final ContactShieldSetting setting = ObjectProvider.getContactShieldSetting(call);

        engine.startContactShieldNoPersistent(setting)
            .addOnSuccessListener(aVoid -> returnSuccess(Method.START_CONTACT_SHIELD_NON_PERSISTENT, null))
            .addOnFailureListener(e -> returnError(Method.START_CONTACT_SHIELD_NON_PERSISTENT, e));
    }

    public void getPeriodicKey() {
        engine.getPeriodicKey()
            .addOnSuccessListener(
                periodicKeys ->
                    returnSuccess(Method.GET_PERIODIC_KEY, ObjectSerializer.INSTANCE.toJson(periodicKeys)))
            .addOnFailureListener(e -> returnError(Method.GET_PERIODIC_KEY, e));
    }

    public void putSharedKeyFiles() {
        final List<File> files = ObjectProvider.getFileList(call);
        final DiagnosisConfiguration diagnosisConfig = ObjectProvider.getDiagnosisConfiguration(call);
        final String token = call.argument("token");

        engine.putSharedKeyFiles(files, diagnosisConfig, token)
            .addOnSuccessListener(aVoid -> returnSuccess(Method.PUT_SHARED_KEY_FILES, null))
            .addOnFailureListener(e -> returnError(Method.PUT_SHARED_KEY_FILES, e));
    }

    public void putSharedKeyFilesCb() {
        final List<File> files = ObjectProvider.getFileList(call);
        final DiagnosisConfiguration diagnosisConfig = ObjectProvider.getDiagnosisConfiguration(call);
        final String token = call.argument("token");

        final PendingIntent pendingIntent = ObjectProvider.getPendingIntent(context,
            IntentAction.PUT_SHARED_KEY_FILES_CB, RequestCode.PUT_SHARED_KEY_FILES_CB);

        engine.putSharedKeyFiles(pendingIntent, files, diagnosisConfig, token)
            .addOnSuccessListener(aVoid -> returnSuccess(Method.PUT_SHARED_KEY_FILES_CB, null))
            .addOnFailureListener(e -> returnError(Method.PUT_SHARED_KEY_FILES_CB, e));
    }

    public void putSharedKeyFilesCbWithProvider() {
        final SharedKeyFileProvider sharedKeyFileProvider = ObjectProvider.getSharedKeyFileProvider(call);

        final PendingIntent pendingIntent = ObjectProvider.getPendingIntent(context,
            IntentAction.PUT_SHARED_KEY_FILES_CB_WITH_PROVIDER, RequestCode.PUT_SHARED_KEY_FILES_CB_WITH_PROVIDER);

        engine.putSharedKeyFiles(pendingIntent, sharedKeyFileProvider).addOnSuccessListener(aVoid ->
            returnSuccess(Method.PUT_SHARED_KEY_FILES_CB_WITH_PROVIDER, null))
            .addOnFailureListener(e ->
                returnError(Method.PUT_SHARED_KEY_FILES_CB_WITH_PROVIDER, e));
    }

    public void putSharedKeyFilesCbWithKeys() {
        final List<File> files = ObjectProvider.getFileList(call);
        final List<String> publicKeys = call.argument("publicKeys");
        final DiagnosisConfiguration diagnosisConfig = ObjectProvider.getDiagnosisConfiguration(call);
        final String token = call.argument("token");

        final PendingIntent pendingIntent = ObjectProvider.getPendingIntent(context,
            IntentAction.PUT_SHARED_KEY_FILES_CB_WITH_KEYS, RequestCode.PUT_SHARED_KEY_FILES_CB_WITH_KEYS);

        engine.putSharedKeyFiles(pendingIntent, files, publicKeys, diagnosisConfig, token).addOnSuccessListener(aVoid ->
            returnSuccess(Method.PUT_SHARED_KEY_FILES_CB_WITH_KEYS, null))
            .addOnFailureListener(e ->
                returnError(Method.PUT_SHARED_KEY_FILES_CB_WITH_KEYS, e));
    }

    public void getContactDetail() {
        final String token = call.arguments();

        engine.getContactDetail(token)
            .addOnSuccessListener(
                contactDetails ->
                    returnSuccess(Method.GET_CONTACT_DETAIL, ObjectSerializer.INSTANCE.toJson(contactDetails)))
            .addOnFailureListener(e -> returnError(Method.GET_CONTACT_DETAIL, e));
    }

    public void getContactSketch() {
        final String token = call.arguments();

        engine.getContactSketch(token)
            .addOnSuccessListener(
                contactSketch ->
                    returnSuccess(Method.GET_CONTACT_SKETCH, ObjectSerializer.INSTANCE.toJson(contactSketch)))
            .addOnFailureListener(e -> returnError(Method.GET_CONTACT_SKETCH, e));
    }

    public void getContactWindow() {
        final String token = call.arguments();

        engine.getContactWindow(token)
            .addOnSuccessListener(
                contactWindows ->
                    returnSuccess(Method.GET_CONTACT_WINDOW, ObjectSerializer.INSTANCE.toJson(contactWindows)))
            .addOnFailureListener(e -> returnError(Method.GET_CONTACT_WINDOW, e));
    }

    public void setSharedKeysDataMapping() {
        final SharedKeysDataMapping sharedKeysDataMapping = ObjectProvider.getSharedKeysDataMapping(call);

        engine.setSharedKeysDataMapping(sharedKeysDataMapping).addOnSuccessListener(aVoid ->
            returnSuccess(Method.SET_SHARED_KEYS_DATA_MAPPING, null))
            .addOnFailureListener(e ->
                returnError(Method.SET_SHARED_KEYS_DATA_MAPPING, e));
    }

    public void getSharedKeysDataMapping() {
        engine.getSharedKeysDataMapping().addOnSuccessListener(
            sharedKeysDataMapping ->
                returnSuccess(Method.GET_SHARED_KEYS_DATA_MAPPING,
                    ObjectSerializer.INSTANCE.toJson(sharedKeysDataMapping)))
            .addOnFailureListener(e -> returnError(Method.GET_SHARED_KEYS_DATA_MAPPING, e));
    }

    public void getDailySketch() {
        final String dailySketchConfigurationJson = call.arguments();
        final DailySketchConfiguration config = ObjectSerializer.INSTANCE
            .fromJson(dailySketchConfigurationJson, DailySketchConfiguration.class);

        engine.getDailySketch(config).addOnSuccessListener(
            dailySketches -> returnSuccess(Method.GET_DAILY_SKETCH, ObjectSerializer.INSTANCE.toJson(dailySketches)))
            .addOnFailureListener(e -> returnError(Method.GET_DAILY_SKETCH, e));
    }

    public void getContactShieldVersion() {
        engine.getContactShieldVersion()
            .addOnSuccessListener(version -> returnSuccess(Method.GET_CONTACT_SHIELD_VERSION, version))
            .addOnFailureListener(e -> returnError(Method.GET_CONTACT_SHIELD_VERSION, e));
    }

    public void getDeviceCalibrationConfidence() {
        engine.getDeviceCalibrationConfidence()
            .addOnSuccessListener(confidence -> returnSuccess(Method.GET_DEVICE_CALIBRATION_CONFIDENCE, confidence))
            .addOnFailureListener(e -> returnError(Method.GET_DEVICE_CALIBRATION_CONFIDENCE, e));
    }

    public void isSupportScanningWithoutLocation() {
        final boolean isSupported = engine.isSupportScanningWithoutLocation();
        returnSuccess(Method.IS_SUPPORT_SCANNING_WITHOUT_LOCATION, isSupported);
    }

    public void getStatus() {
        engine.getStatus().addOnSuccessListener(
            status -> returnSuccess(Method.GET_STATUS, ObjectSerializer.INSTANCE.toJson(status)))
            .addOnFailureListener(e -> returnError(Method.GET_STATUS, e));
    }

    public void clearData() {
        engine.clearData()
            .addOnSuccessListener(aVoid -> returnSuccess(Method.CLEAR_DATA, null))
            .addOnFailureListener(e -> returnError(Method.CLEAR_DATA, e));
    }

    public void stopContactShield() {
        engine.stopContactShield()
            .addOnSuccessListener(aVoid -> returnSuccess(Method.STOP_CONTACT_SHIELD, null))
            .addOnFailureListener(e -> returnError(Method.STOP_CONTACT_SHIELD, e));
    }

    public void enableLogger() {
        hmsLogger.enableLogger();
        result.success(null);
    }

    public void disableLogger() {
        hmsLogger.disableLogger();
        result.success(null);
    }

    private <T> void returnSuccess(final String methodName, final T response) {
        result.success(response);
        hmsLogger.sendSingleEvent(methodName);
    }

    private void returnError(final String methodName, final Exception e) {
        final int statusCode;
        final String statusMessage;

        if (e instanceof ApiException) {
            final ApiException exception = ((ApiException) e);
            statusCode = exception.getStatusCode();
            statusMessage = exception.getStatusMessage();
        } else {
            statusCode = -1;
            statusMessage = "Unknown error";
        }

        result.error(String.valueOf(statusCode), statusMessage, null);
        hmsLogger.sendSingleEvent(methodName, String.valueOf(statusCode));
    }
}
