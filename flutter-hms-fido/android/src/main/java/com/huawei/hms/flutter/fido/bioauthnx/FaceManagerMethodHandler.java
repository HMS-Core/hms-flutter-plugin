/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.fido.bioauthnx;

import android.app.Activity;
import android.os.CancellationSignal;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.fido.factory.BioAuthnCipherFactory;
import com.huawei.hms.flutter.fido.factory.EventChannelFactory;
import com.huawei.hms.flutter.fido.logger.HMSLogger;
import com.huawei.hms.flutter.fido.utils.Constants;
import com.huawei.hms.support.api.fido.bioauthn.CryptoObject;
import com.huawei.hms.support.api.fido.bioauthn.FaceManager;

import javax.crypto.Cipher;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class FaceManagerMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = FaceManagerMethodHandler.class.getSimpleName();

    private final Activity activity;
    private final BinaryMessenger messenger;
    private MethodChannel.Result mResult;

    private FaceManager faceManager;

    public FaceManagerMethodHandler(Activity activity, BinaryMessenger messenger) {
        this.activity = activity;
        this.messenger = messenger;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "init":
                init(call);
                break;
            case "canAuth":
                checkAuth();
                break;
            case "isHardwareDetected":
                checkHardware();
                break;
            case "hasEnrolledTemplates":
                checkEnrolledTemplates();
                break;
            case "authenticateWithoutCryptoObject":
                authenticateWithoutCryptoObject();
                break;
            case "authenticateWithCryptoObject":
                authenticateWithCryptoObject(call);
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    /**
     * Initializes the FaceManager and it's event channel
     *
     * @param call Configurations for this API.
     */
    private void init(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext())
                .startMethodExecutionTimer("initFaceManager");

        faceManager = new FaceManager(activity.getApplicationContext());
        Integer id = call.argument("id");

        if (id == null) {
            HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent("initFaceManager", "-1");
            mResult.error(TAG, "Failed to get event id", "");
            return;
        }

        EventChannelFactory.create(id, "com.huawei.hms.flutter.fido/face_manager", messenger);
        EventChannelFactory.setup(id, new BioAuthnStreamHandler());

        HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent("initFaceManager");
        mResult.success(true);
    }

    /**
     * Checks whether 3D facial authentication can be used.
     */
    private void checkAuth() {
        HMSLogger.getInstance(activity.getApplicationContext())
                .startMethodExecutionTimer("faceManagerCanAuth");
        FaceManager manager = new FaceManager(activity.getApplicationContext());
        HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent("faceManagerCanAuth");
        mResult.success(manager.canAuth());
    }

    /**
     * Checks whether 3D facial authentication hardware exists and works properly.
     */
    private void checkHardware() {
        HMSLogger.getInstance(activity.getApplicationContext())
                .startMethodExecutionTimer("faceManagerisHardwareDetected");
        FaceManager manager = new FaceManager(activity.getApplicationContext());
        HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent("faceManagerisHardwareDetected");
        mResult.success(manager.isHardwareDetected());
    }

    /**
     * Checks whether at least one 3D facial authentication template has been registered in the system.
     */
    private void checkEnrolledTemplates() {
        HMSLogger.getInstance(activity.getApplicationContext())
                .startMethodExecutionTimer("faceManagerHasEnrolledTemplates");
        FaceManager manager = new FaceManager(activity.getApplicationContext());
        HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent("faceManagerHasEnrolledTemplates");
        mResult.success(manager.hasEnrolledTemplates());
    }

    /**
     * Authenticates without configurations.
     */
    private void authenticateWithoutCryptoObject() {
        HMSLogger.getInstance(activity.getApplicationContext())
                .startMethodExecutionTimer("faceManagerAuthWithoutCryptoObject");

        if (faceManager == null) {
            HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent("faceManagerAuthWithoutCryptoObject", Constants.UNINITIALIZED_OBJECT);
            mResult.error(TAG, "Face manager must be initialized first!", Constants.UNINITIALIZED_OBJECT);
            return;
        }

        CancellationSignal cancellationSignal = new CancellationSignal();
        faceManager.auth(null, cancellationSignal, 0, new BioAuthEvent(activity), null);
    }

    /**
     * Authenticates with configurations.
     *
     * @param call Configurations for this API.
     */
    private void authenticateWithCryptoObject(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext())
                .startMethodExecutionTimer("faceManagerAuthWithCryptoObject");

        if (faceManager == null) {
            HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent("faceManagerAuthWithCryptoObject", Constants.UNINITIALIZED_OBJECT);
            mResult.error(TAG, "Face manager must be initialized first!", Constants.UNINITIALIZED_OBJECT);
            return;
        }

        String storeKey = call.argument("storeKey");
        String password = call.argument("password");
        Boolean authRequired = call.argument("userAuthenticationRequired");

        Cipher cipher = new BioAuthnCipherFactory(storeKey, password, authRequired != null ? authRequired : true).getCipher();
        CryptoObject cryptoObject = new CryptoObject(cipher);
        CancellationSignal cancellationSignal = new CancellationSignal();

        faceManager.auth(cryptoObject, cancellationSignal, 0, new BioAuthEvent(activity), null);
    }
}
