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

package com.huawei.hms.flutter.fido.fidoclient;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.fido.logger.HMSLogger;
import com.huawei.hms.flutter.fido.utils.Constants;
import com.huawei.hms.flutter.fido.utils.FidoBuilder;
import com.huawei.hms.support.api.fido.fido2.AuthenticatorMetadata;
import com.huawei.hms.support.api.fido.fido2.Fido2;
import com.huawei.hms.support.api.fido.fido2.Fido2AuthenticationRequest;
import com.huawei.hms.support.api.fido.fido2.Fido2AuthenticationResponse;
import com.huawei.hms.support.api.fido.fido2.Fido2Client;
import com.huawei.hms.support.api.fido.fido2.Fido2Intent;
import com.huawei.hms.support.api.fido.fido2.Fido2IntentCallback;
import com.huawei.hms.support.api.fido.fido2.Fido2RegistrationRequest;
import com.huawei.hms.support.api.fido.fido2.Fido2RegistrationResponse;
import com.huawei.hms.support.api.fido.fido2.NativeFido2AuthenticationOptions;
import com.huawei.hms.support.api.fido.fido2.NativeFido2RegistrationOptions;
import com.huawei.hms.support.api.fido.fido2.PublicKeyCredentialCreationOptions;
import com.huawei.hms.support.api.fido.fido2.PublicKeyCredentialRequestOptions;
import com.huawei.hms.support.api.fido.fido2.TokenBinding;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class FidoClientMethodHandler implements MethodChannel.MethodCallHandler, PluginRegistry.ActivityResultListener {
    private static final String TAG = FidoClientMethodHandler.class.getSimpleName();

    private final Activity activity;

    private MethodChannel.Result mResult;
    private Fido2Client fido2Client;
    private String loggerKey;

    public FidoClientMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "isSupported":
                checkSupport();
                break;
            case "hasPlatformAuthenticators":
                checkPlatformAuthenticators();
                break;
            case "getPlatformAuthenticators":
                getAuthenticators();
                break;
            case "getRegistrationIntent":
                loggerKey = "getRegistrationIntent";
                getRegisterIntent(call);
                break;
            case "getAuthenticationIntent":
                loggerKey = "getAuthenticationIntent";
                getAuthIntent(call);
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    private void checkSupport() {
        HMSLogger.getInstance(activity.getApplicationContext())
                .startMethodExecutionTimer("fidoIsSupported");
        fido2Client = Fido2.getFido2Client(activity);
        HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent("fidoIsSupported");
        mResult.success(fido2Client.isSupported());
    }

    private void checkPlatformAuthenticators() {
        HMSLogger.getInstance(activity.getApplicationContext())
                .startMethodExecutionTimer("fidoHasPlatformAuthenticators");
        fido2Client = Fido2.getFido2Client(activity);
        HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent("fidoHasPlatformAuthenticators");
        mResult.success(fido2Client.hasPlatformAuthenticators());
    }

    private void getAuthenticators() {
        HMSLogger.getInstance(activity.getApplicationContext())
                .startMethodExecutionTimer("fidoGetPlatformAuthenticators");
        fido2Client = Fido2.getFido2Client(activity);
        Collection<AuthenticatorMetadata> collection = fido2Client.getPlatformAuthenticators();
        List<AuthenticatorMetadata> arrayList = new ArrayList<>(collection);
        HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent("fidoGetPlatformAuthenticators");
        mResult.success(FidoBuilder.authMetadataToMap(arrayList).toString());
    }

    private void getRegisterIntent(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext())
                .startMethodExecutionTimer(loggerKey);
        fido2Client = Fido2.getFido2Client(activity);

        PublicKeyCredentialCreationOptions options = null;
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.N) {
            options = FidoBuilder.buildCredentialCreationOptions(call);
        }
        NativeFido2RegistrationOptions registrationOptions = FidoBuilder.createNativeRegOptions(call);
        TokenBinding tokenBinding = FidoBuilder.createTokenBinding(call);

        Fido2RegistrationRequest registrationRequest = new Fido2RegistrationRequest(options, tokenBinding);

        fido2Client.getRegistrationIntent(registrationRequest, registrationOptions, new Fido2IntentCallback() {
            @Override
            public void onSuccess(Fido2Intent fido2Intent) {
                if (!fido2Intent.canLaunch()) {
                    HMSLogger.getInstance(activity.getApplicationContext())
                            .sendSingleEvent(loggerKey, "-1");
                    mResult.error(TAG, "Can not launch Fido2Intent", "");
                    return;
                }
                Log.i(TAG, "Registration intent success");
                fido2Intent.launchFido2Activity(activity, Fido2Client.REGISTRATION_REQUEST);
            }

            @Override
            public void onFailure(int i, CharSequence charSequence) {
                HMSLogger.getInstance(activity.getApplicationContext())
                        .sendSingleEvent(loggerKey, String.valueOf(i));
                mResult.error(TAG, String.valueOf(i), charSequence);
            }
        });
    }
    
    private void getAuthIntent(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext())
                .startMethodExecutionTimer(loggerKey);

        if (fido2Client == null) {
            HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent(loggerKey, Constants.UNINITIALIZED_OBJECT);
            mResult.error(TAG, "Fifo2Client must be initialized", Constants.UNINITIALIZED_OBJECT);
            return;
        }

        PublicKeyCredentialRequestOptions options = null;
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.N) {
            options = FidoBuilder.buildCredentialRequestOptions(call);
        }
        NativeFido2AuthenticationOptions authenticationOptions = FidoBuilder.createNativeAuthOptions(call);
        TokenBinding tokenBinding = FidoBuilder.createTokenBinding(call);

        Fido2AuthenticationRequest authenticationRequest =
                new Fido2AuthenticationRequest(options, tokenBinding);

        fido2Client.getAuthenticationIntent(authenticationRequest, authenticationOptions, new Fido2IntentCallback() {
            @Override
            public void onSuccess(Fido2Intent intent) {
                if (!intent.canLaunch()) {
                    HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(loggerKey, "-1");
                    mResult.error(TAG, "Can not launch Fido2Intent", "");
                    return;
                }
                Log.i(TAG, "Authentication intent success");
                intent.launchFido2Activity(activity, Fido2Client.AUTHENTICATION_REQUEST);
            }

            @Override
            public void onFailure(int i, CharSequence charSequence) {
                HMSLogger.getInstance(activity.getApplicationContext())
                        .sendSingleEvent(loggerKey, String.valueOf(i));
                mResult.error(TAG, String.valueOf(i), charSequence);
            }
        });
    }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
        if (resultCode != Activity.RESULT_OK) {
            HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent(loggerKey, String.valueOf(resultCode));
            mResult.error(TAG, String.valueOf(resultCode), "");
            return false;
        }

        switch (requestCode) {
            case Fido2Client.REGISTRATION_REQUEST:
                Fido2RegistrationResponse regResponse = fido2Client.getFido2RegistrationResponse(data);
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(loggerKey);
                mResult.success(FidoBuilder.getRegistrationResponse(regResponse));
                break;
            case Fido2Client.AUTHENTICATION_REQUEST:
                Fido2AuthenticationResponse authResponse = fido2Client.getFido2AuthenticationResponse(data);
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(loggerKey);
                mResult.success(FidoBuilder.getAuthenticationResponse(authResponse));
                break;
            default:
                break;
        }

        return true;
    }
}
