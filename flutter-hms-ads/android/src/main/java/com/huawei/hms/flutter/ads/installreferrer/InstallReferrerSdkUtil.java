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
import android.os.RemoteException;
import android.util.Log;
import android.util.SparseArray;

import com.huawei.hms.ads.installreferrer.api.InstallReferrerClient;
import com.huawei.hms.ads.installreferrer.api.InstallReferrerStateListener;
import com.huawei.hms.ads.installreferrer.api.ReferrerDetails;
import com.huawei.hms.flutter.ads.logger.HMSLogger;
import com.huawei.hms.flutter.ads.utils.ToMap;
import com.huawei.hms.flutter.ads.utils.constants.ErrorCodes;
import com.huawei.hms.flutter.ads.utils.constants.ReferrerStatus;

import java.io.IOException;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class InstallReferrerSdkUtil extends HmsInstallReferrer {
    private static SparseArray<InstallReferrerSdkUtil> allSdkReferrers = new SparseArray<>();
    private static final String TAG = "InstallReferrerSdkUtil";
    private Context context;
    private MethodChannel channel;
    private InstallReferrerClient referrerClient;

    InstallReferrerSdkUtil(Integer id, Context context, MethodChannel channel) {
        super(id);
        this.context = context;
        this.channel = channel;
        allSdkReferrers.put(id, this);
    }

    public void startConnection(boolean isTest) {
        if (null == context) {
            Log.e(TAG, "connect context is null");
            return;
        }

        if (isConnected()) {
            Log.i(TAG, "Referrer client already connected");
            return;
        }

        Log.i(TAG, "startConnection");
        Log.i(TAG, "Test mode : " + isTest);
        referrerClient = InstallReferrerClient.newBuilder(context).setTest(isTest).build();
        Log.i(TAG, "referrerClient built from context");
        referrerClient.startConnection(new InstallReferrerStateListener() {
            @Override
            public void onInstallReferrerSetupFinished(final int responseCode) {
                switch (responseCode) {
                    case InstallReferrerClient.InstallReferrerResponse.OK:
                        Log.i(TAG, "connect ads kit ok");
                        break;
                    case InstallReferrerClient.InstallReferrerResponse.FEATURE_NOT_SUPPORTED:
                        Log.i(TAG, "FEATURE_NOT_SUPPORTED");
                        break;
                    case InstallReferrerClient.InstallReferrerResponse.SERVICE_UNAVAILABLE:
                        Log.i(TAG, "SERVICE_UNAVAILABLE");
                        break;
                    case InstallReferrerClient.InstallReferrerResponse.SERVICE_DISCONNECTED:
                        Log.i(TAG, "SERVICE_DISCONNECTED");
                        break;
                    case InstallReferrerClient.InstallReferrerResponse.DEVELOPER_ERROR:
                        Log.i(TAG, "DEVELOPER_ERROR");
                        break;
                    default:
                        Log.i(TAG, "responseCode: " + responseCode);
                        break;
                }
                setStatus(ReferrerStatus.CONNECTED);
                new Handler(Looper.getMainLooper()).post(new Runnable() {
                    @Override
                    public void run() {
                        HMSLogger.getInstance(context).startMethodExecutionTimer("onInstallReferrerSetupFinished");
                        channel.invokeMethod("onInstallReferrerSetupFinished", ToMap.fromArgs(id, "responseCode", responseCode));
                        HMSLogger.getInstance(context).sendSingleEvent("onInstallReferrerSetupFinished");
                    }
                });
            }

            @Override
            public void onInstallReferrerServiceDisconnected() {
                Log.i(TAG, "onInstallReferrerServiceDisconnected");
                setStatus(ReferrerStatus.DISCONNECTED);
                new Handler(Looper.getMainLooper()).post(new Runnable() {
                    @Override
                    public void run() {
                        HMSLogger.getInstance(context).startMethodExecutionTimer("onInstallReferrerServiceDisconnected");
                        channel.invokeMethod("onInstallReferrerSetupDisconnected", ToMap.fromArgs(id));
                        HMSLogger.getInstance(context).sendSingleEvent("onInstallReferrerServiceDisconnected");
                    }
                });
            }
        });
    }

    public boolean isReady() {
        if (referrerClient != null) {
            return referrerClient.isReady();
        }
        return false;
    }

    public void endConnection() {
        Log.i(TAG, "endConnection");
        if (null != referrerClient && isConnected()) {
            referrerClient.endConnection();
            referrerClient = null;
            setStatus(ReferrerStatus.DISCONNECTED);
            new Handler(Looper.getMainLooper()).post(new Runnable() {
                @Override
                public void run() {
                    HMSLogger.getInstance(context).startMethodExecutionTimer("onInstallReferrerSetupConnectionEnded");
                    channel.invokeMethod("onInstallReferrerSetupConnectionEnded", ToMap.fromArgs(id));
                    HMSLogger.getInstance(context).sendSingleEvent("onInstallReferrerSetupConnectionEnded");
                }
            });
        }
    }

    public void getReferrerDetails(final MethodChannel.Result result, String installChannel) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("getReferrerDetails");
        if (referrerClient != null) {
            try {
                ReferrerDetails referrerDetails = referrerClient.getInstallReferrer();
                referrerDetails.setInstallChannel(installChannel);
                Log.i(TAG, "Referrer details retrieved successfully");
                final Map<String, Object> response =
                ToMap.fromArgs(
                    ReferrerDetails.KEY_INSTALL_REFERRER, referrerDetails.getInstallReferrer(),
                    ReferrerDetails.KEY_REFERRER_CLICK_TIMESTAMP, referrerDetails.getReferrerClickTimestampMillisecond(),
                    ReferrerDetails.KEY_INSTALL_BEGIN_TIMESTAMP, referrerDetails.getInstallBeginTimestampMillisecond(),
                    "install_channel", referrerDetails.getInstallChannel());
                new ReferrerDetailsHandler(Looper.getMainLooper(), response, result).backToMain();
                HMSLogger.getInstance(context).sendSingleEvent("getReferrerDetails");
            } catch (RemoteException | IOException e) {
                Log.e(TAG, "getInstallReferrer exception: " + e.getClass() + " | " + e.getMessage());
                HMSLogger.getInstance(context).sendSingleEvent("getReferrerDetails", ErrorCodes.NOT_FOUND);
            }
        }
    }

    @Override
    void destroy() {
        if (isConnected()) {
            endConnection();
        }
        allSdkReferrers.remove(id);
        super.destroy();
    }
}
