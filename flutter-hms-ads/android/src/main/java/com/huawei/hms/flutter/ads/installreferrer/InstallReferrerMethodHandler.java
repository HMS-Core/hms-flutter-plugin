/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.huawei.hms.flutter.ads.installreferrer;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ads.logger.HMSLogger;
import com.huawei.hms.flutter.ads.utils.FromMap;
import com.huawei.hms.flutter.ads.utils.constants.ErrorCodes;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class InstallReferrerMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = "ReferrerMethodHandler";
    private final Context context;
    private final MethodChannel methodChannel;

    public InstallReferrerMethodHandler(final Context context, final MethodChannel methodChannel) {
        this.context = context;
        this.methodChannel = methodChannel;
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final MethodChannel.Result result) {
        switch (call.method) {
            case "referrerStartConnection":
                referrerStartConnection(call, result);
                break;
            case "getInstallReferrer":
                getInstallReferrer(call, result);
                break;
            case "referrerEndConnection":
                referrerEndConnection(call, result);
                break;
            case "referrerIsReady":
                referrerIsReady(call, result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void referrerStartConnection(MethodCall call, MethodChannel.Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("referrerStartConnection");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        String callMode = FromMap.toString("callMode", call.argument("callMode"));
        if (callMode != null) {
            new StartConnectionThread(id, callMode, call).start();
        } else {
            result.error(ErrorCodes.NULL_PARAM, "Call mode is null. Start connection failed. | Referrer id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("referrerStartConnection", ErrorCodes.NULL_PARAM);
        }
    }

    private void referrerEndConnection(MethodCall call, MethodChannel.Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("referrerEndConnection");
        final Integer id = FromMap.toInteger("id", call.argument("id"));
        String callMode = FromMap.toString("callMode", call.argument("callMode"));
        final HmsInstallReferrer referrer = HmsInstallReferrer.get(id);
        if (referrer != null && callMode != null) {
            if (referrer.isConnected()) {
                new EndConnectionThread(referrer, context).start();
            } else {
                Log.i(TAG, "Referrer already disconnected.");
            }
        } else {
            result.error(ErrorCodes.NULL_PARAM, "Referrer or callMode is null. End connection failed. | Referrer id : " + id + " - Call mode : " + callMode, "");
            HMSLogger.getInstance(context).sendSingleEvent("referrerEndConnection", ErrorCodes.NULL_PARAM);
        }
    }

    private void getInstallReferrer(MethodCall call, final MethodChannel.Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("getInstallReferrer");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        String callMode = FromMap.toString("callMode", call.argument("callMode"));
        final HmsInstallReferrer referrer = HmsInstallReferrer.get(id);
        if (referrer != null && callMode != null) {
            if (referrer.isConnected()) {
                new ReferrerDetailsThread(referrer, result, context, call).start();
            } else {
                Log.i(TAG, "Referrer already is not connected");
            }
        } else {
            result.error(ErrorCodes.NULL_PARAM, "Referrer or callMode is null. getInstallReferrer failed. | Referrer id : " + id + " - Call mode : " + callMode, "");
            HMSLogger.getInstance(context).sendSingleEvent("getInstallReferrer", ErrorCodes.NULL_PARAM);
        }
    }

    private void referrerIsReady(MethodCall call, final MethodChannel.Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("referrerIsReady");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        String callMode = FromMap.toString("callMode", call.argument("callMode"));
        final HmsInstallReferrer referrer = HmsInstallReferrer.get(id);
        if (referrer == null || callMode == null) {
            result.error(ErrorCodes.NULL_PARAM, "Referrer or callMode is null. isReady failed. | Referrer id : " + id + " - Call mode : " + callMode, "");
            HMSLogger.getInstance(context).sendSingleEvent("referrerIsReady", ErrorCodes.NULL_PARAM);
            return;
        }

        if (callMode.equals("sdk")) {
            new IsReadyThread(referrer, result, context).start();
        } else {
            result.error(ErrorCodes.INVALID_PARAM, "Call mode parameter is invalid. isReady failed. | Referrer id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("referrerIsReady", ErrorCodes.INVALID_PARAM);
        }
    }

    class StartConnectionThread extends Thread {
        private final Integer id;
        private final String callMode;
        private MethodCall call;

        StartConnectionThread(final Integer id, final String callMode, MethodCall call) {
            super("startConnection");
            this.id = id;
            this.callMode = callMode;
            this.call = call;
        }

        @Override
        public void run() {
            final Boolean isTest = FromMap.toBoolean("isTest", call.argument("isTest"));
            if (callMode.equals("sdk")) {
                InstallReferrerSdkUtil sdkUtil = HmsInstallReferrer.createSdkReferrer(id, context, methodChannel);
                if (sdkUtil.isCreated() || sdkUtil.isDisconnected()) {
                    sdkUtil.startConnection(isTest);
                    HMSLogger.getInstance(context).sendSingleEvent("referrerStartConnection");
                } else {
                    Log.i(TAG, "Referrer client already connected.");
                    HMSLogger.getInstance(context).sendSingleEvent("referrerStartConnection", ErrorCodes.LOAD_FAILED);
                }
            } else {
                Log.e(TAG, "Call mode parameter is invalid. Start connection failed. | Referrer id : " + id);
                HMSLogger.getInstance(context).sendSingleEvent("referrerStartConnection", ErrorCodes.INVALID_PARAM);
            }
        }
    }

    static class EndConnectionThread extends Thread {
        private final HmsInstallReferrer referrer;
        private final Context context;

        EndConnectionThread(HmsInstallReferrer referrer, Context context) {
            super("endConnection");
            this.referrer = referrer;
            this.context = context;
        }

        @Override
        public void run() {
            referrer.endConnection();
            HMSLogger.getInstance(context).sendSingleEvent("referrerEndConnection");
        }
    }

    static class ReferrerDetailsThread extends Thread {
        private final HmsInstallReferrer referrer;
        private final MethodChannel.Result result;
        private final Context context;
        private MethodCall call;

        ReferrerDetailsThread(HmsInstallReferrer referrer, MethodChannel.Result result, Context context,  MethodCall call) {
            super("getReferrerDetails");
            this.referrer = referrer;
            this.result = result;
            this.context = context;
            this.call = call;
        }

        @Override
        public void run() {
            final String installChannel = FromMap.toString("installChannel", call.argument("installChannel"));
            referrer.getReferrerDetails(result, installChannel);
            HMSLogger.getInstance(context).sendSingleEvent("getInstallReferrer");
        }
    }

    static class IsReadyThread extends Thread {
        private final HmsInstallReferrer referrer;
        private final MethodChannel.Result result;
        private final Context context;

        IsReadyThread(HmsInstallReferrer referrer, MethodChannel.Result result, Context context) {
            super("isReady");
            this.referrer = referrer;
            this.result = result;
            this.context = context;
        }

        @Override
        public void run() {
            final boolean isReady = referrer.isReady();
            new Handler(Looper.getMainLooper()).post(new Runnable() {
                @Override
                public void run() {
                    result.success(isReady);
                    HMSLogger.getInstance(context).sendSingleEvent("referrerIsReady");
                }
            });
        }
    }
}
