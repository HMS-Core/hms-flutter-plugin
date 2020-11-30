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

package com.huawei.hms.flutter.account.handlers;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.util.Base64;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.agconnect.config.AGConnectServicesConfig;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.common.ApiException;
import com.huawei.hms.flutter.account.util.Constant;
import com.huawei.hms.flutter.account.listeners.SmsReceiver;
import com.huawei.hms.flutter.account.logger.HMSLogger;
import com.huawei.hms.support.sms.common.ReadSmsConstant;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class SmsManagerMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = SmsManagerMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel smsMethodChannel;
    private MethodChannel.Result mResult;
    private SmsReceiver smsReceiver;

    public SmsManagerMethodHandler(Activity activity, MethodChannel channel) {
        this.activity = activity;
        this.smsMethodChannel = channel;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "smsVerification":
                startSmsVerification();
                break;
            case "obtainHashcode":
                obtainHashCode();
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    /**
     * Creates an SmsReceiver object which is a broadcast receiver
     * to listen upcoming sms messages.
     */
    private void startSmsVerification() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("smsVerification");
        Task<Void> task = com.huawei.hms.support.sms.ReadSmsManager.start(activity);
        task.addOnCompleteListener(task1 -> {
            if (task1.isSuccessful()) {
                if (smsReceiver != null) {
                    activity.unregisterReceiver(smsReceiver);
                }
                smsReceiver = new SmsReceiver(smsMethodChannel);
                IntentFilter intentFilter =
                        new IntentFilter(ReadSmsConstant.READ_SMS_BROADCAST_ACTION);
                activity.registerReceiver(smsReceiver, intentFilter);
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("smsVerification");
                mResult.success(true);
            }
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("smsVerification", String.valueOf(((ApiException) task.getException()).getStatusCode()));
            mResult.error(Constant.SMS_VERIFICATION_FAILURE, String.valueOf(((ApiException) task.getException()).getStatusCode()), null);
        });
    }

    /**
     * Gets the hashcode value of application which is unique in each app
     */
    private void obtainHashCode() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("obtainHashcode");
        String packageName = AGConnectServicesConfig.fromContext(activity.getApplicationContext()).getString("client/package_name");
        if (packageName != null) {
            MessageDigest messageDigest = createMessageDigest();
            String signature = getSignature(activity.getApplicationContext(), packageName);
            String hashCode = getHashcode(packageName, messageDigest, signature);
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("obtainHashcode");
            mResult.success(hashCode);
        } else {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("obtainHashcode", "-1");
            mResult.error(
                    Constant.OBTAIN_HASHCODE_VALUE_FAILURE,
                    "Package name might be incorrect",
                    "");
        }
    }

    private MessageDigest createMessageDigest() {
        MessageDigest messageDigest = null;
        try {
            messageDigest = MessageDigest.getInstance("SHA-256");
        } catch (NoSuchAlgorithmException e) {
            Log.e(TAG, "No Such Algorithm.", e);
        }
        return messageDigest;
    }

    @SuppressLint("PackageManagerGetSignatures")
    private String getSignature(@NonNull Context context, @NonNull String packageName) {
        PackageManager packageManager = context.getPackageManager();
        Signature[] signatureArgs;
        try {
            signatureArgs = packageManager.getPackageInfo(packageName, PackageManager.GET_SIGNATURES).signatures;
        } catch (PackageManager.NameNotFoundException e) {
            Log.e(TAG, "Package name inexistent.");
            return "";
        }
        if (null == signatureArgs || 0 == signatureArgs.length) {
            Log.e(TAG, "signature is null.");
            return "";
        }
        return signatureArgs[0].toCharsString();
    }

    private String getHashcode(@NonNull String packageName, @NonNull MessageDigest messageDigest, @NonNull String signature) {
        String appInfo = packageName + " " + signature;
        messageDigest.update(appInfo.getBytes(StandardCharsets.UTF_8));
        byte[] hashSignature = messageDigest.digest();
        hashSignature = Arrays.copyOfRange(hashSignature, 0, 9);
        String base64Hash = Base64.encodeToString(
                hashSignature,
                Base64.NO_PADDING | Base64.NO_WRAP);
        if (base64Hash.length() > 0) {
            base64Hash = base64Hash.substring(0, 11);
        }
        return base64Hash;
    }
}
