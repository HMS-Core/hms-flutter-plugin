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

import androidx.annotation.NonNull;
import androidx.core.content.ContextCompat;
import androidx.fragment.app.FragmentActivity;

import com.huawei.hms.flutter.fido.factory.BioAuthnCipherFactory;
import com.huawei.hms.flutter.fido.factory.EventChannelFactory;
import com.huawei.hms.flutter.fido.logger.HMSLogger;
import com.huawei.hms.flutter.fido.utils.Constants;
import com.huawei.hms.support.api.fido.bioauthn.BioAuthnPrompt;
import com.huawei.hms.support.api.fido.bioauthn.CryptoObject;

import javax.crypto.Cipher;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class BioAuthnPromptMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = BioAuthnPromptMethodHandler.class.getSimpleName();

    private final Activity activity;
    private MethodChannel.Result mResult;
    private final BinaryMessenger messenger;
    private BioAuthnPrompt prompt;

    private String title;
    private String subtitle;
    private String desc;
    private String negativeButtonText;
    private Boolean credentialsAllowed;
    private Boolean confirmationRequired;
    private Integer id;

    public BioAuthnPromptMethodHandler(Activity act, BinaryMessenger msg) {
        this.activity = act;
        this.messenger = msg;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "initPrompt":
                initPrompt(call);
                break;
            case "authenticateWithoutCryptoObject":
                authenticateWithoutCryptoObject();
                break;
            case "authenticateWithCryptoObject":
                authenticateWithCryptoObject(call);
                break;
            case "cancel":
                cancel();
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    /**
     * Configures the auth parameters
     *
     * @param call Configurations for this API.
     */
    private void initPrompt(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext())
                .startMethodExecutionTimer("bioAuthnPromptInit");
        title = call.argument("title");
        subtitle = call.argument("subtitle");
        desc = call.argument("description");
        negativeButtonText = call.argument("navigateButtonText");
        credentialsAllowed = call.argument("isDeviceCredentialAllowed");
        confirmationRequired = call.argument("isConfirmationRequired");
        id = call.argument("id");

        if (title == null || title.isEmpty() || id == null) {
            HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent("bioAuthnPromptInit", Constants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Title or event id must not be null", Constants.ILLEGAL_PARAMETER);
            return;
        }

        EventChannelFactory.create(id, "com.huawei.hms.flutter.fido/bio_authn_prompt", messenger);
        EventChannelFactory.setup(id, new BioAuthnStreamHandler());

        HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent("bioAuthnPromptInit");
        mResult.success(true);
    }

    /**
     * Authenticates without crypto object.
     */
    private void authenticateWithoutCryptoObject() {
        HMSLogger.getInstance(activity.getApplicationContext())
                .startMethodExecutionTimer("bioAuthnAuthWithoutCryptoObject");

        if (!(activity instanceof FragmentActivity)) {
            HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent("bioAuthnAuthWithoutCryptoObject");
            mResult.error(TAG, "huawei_fido plugin requires activity to be a FragmentActivity", Constants.NOT_A_FRAGMENT_ACTIVITY);
            return;
        }

        BioAuthnPrompt.PromptInfo.Builder builder = new BioAuthnPrompt.PromptInfo.Builder();
        builder.setTitle(title)
                .setSubtitle(subtitle)
                .setDescription(desc)
                .setConfirmationRequired(confirmationRequired);

        if (credentialsAllowed != null && credentialsAllowed) {
            builder.setDeviceCredentialAllowed(credentialsAllowed);
        }

        if (credentialsAllowed == null || !credentialsAllowed) {
            builder.setNegativeButtonText(negativeButtonText);
        }

        BioAuthnPrompt.PromptInfo info = builder.build();

        prompt = new BioAuthnPrompt((FragmentActivity) activity, ContextCompat.getMainExecutor(activity), new BioAuthEvent(activity));
        prompt.auth(info);
    }

    /**
     * Authenticates with crypto object
     *
     * @param call Configurations for this API.
     */
    private void authenticateWithCryptoObject(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext())
                .startMethodExecutionTimer("bioAuthnAuthWithCryptoObject");

        if (!(activity instanceof FragmentActivity)) {
            HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent("bioAuthnAuthWithCryptoObject", Constants.NOT_A_FRAGMENT_ACTIVITY);
            mResult.error(TAG, "huawei_fido plugin requires activity to be a FragmentActivity", Constants.NOT_A_FRAGMENT_ACTIVITY);
            return;
        }

        String storeKey = call.argument("storeKey");
        String password = call.argument("password");
        Boolean authRequired = call.argument("userAuthenticationRequired");

        BioAuthnPrompt.PromptInfo.Builder builder = new BioAuthnPrompt.PromptInfo.Builder();
        builder.setTitle(title)
                .setSubtitle(subtitle)
                .setDescription(desc)
                .setConfirmationRequired(confirmationRequired);

        if (credentialsAllowed != null && credentialsAllowed) {
            builder.setDeviceCredentialAllowed(true);
        }

        if (credentialsAllowed == null || !credentialsAllowed) {
            builder.setNegativeButtonText(negativeButtonText);
        }

        BioAuthnPrompt.PromptInfo info = builder.build();

        Cipher cipher = new BioAuthnCipherFactory(storeKey, password, authRequired != null ? authRequired : true).getCipher();
        CryptoObject cryptoObject = new CryptoObject(cipher);

        prompt = new BioAuthnPrompt((FragmentActivity) activity, ContextCompat.getMainExecutor(activity), new BioAuthEvent(activity));
        prompt.auth(info, cryptoObject);
    }

    /**
     * Cancels the authentication and stream subscription
     */
    private void cancel() {
        HMSLogger.getInstance(activity.getApplicationContext())
                .startMethodExecutionTimer("cancelBioAuthnAuthentication");
        
        if (prompt == null) {
            HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent("cancelBioAuthnAuthentication", Constants.UNINITIALIZED_OBJECT);
            mResult.error(TAG, "BioAuthnPromt must be initialized first", Constants.UNINITIALIZED_OBJECT);
            return;
        }

        EventChannelFactory.dispose(id);
        EventChannelFactory.destroy();
        prompt.cancelAuth();
        
        HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent("cancelBioAuthnAuthentication");
        mResult.success(true);
    }
}
