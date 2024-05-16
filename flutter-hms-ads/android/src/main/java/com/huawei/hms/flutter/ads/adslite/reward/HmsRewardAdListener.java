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

package com.huawei.hms.flutter.ads.adslite.reward;

import android.content.Context;
import android.util.Log;

import com.huawei.hms.ads.reward.Reward;
import com.huawei.hms.ads.reward.RewardAdListener;
import com.huawei.hms.flutter.ads.logger.HMSLogger;
import com.huawei.hms.flutter.ads.utils.ToMap;
import com.huawei.hms.flutter.ads.utils.constants.AdStatus;

import io.flutter.plugin.common.EventChannel;

public class HmsRewardAdListener implements RewardAdListener {
    private static final String TAG = "HmsRewardAdListener";
    private EventChannel.EventSink event;
    private HmsRewardAd instance;
    private final Context context;

    HmsRewardAdListener(EventChannel.EventSink event, Context context) {
        this.event = event;
        this.context = context;
    }

    HmsRewardAdListener(EventChannel.EventSink event, HmsRewardAd instance, Context context) {
        this.event = event;
        this.instance = instance;
        this.context = context;
    }

    @Override
    public void onRewarded(Reward reward) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("onRewarded");
        Log.i(TAG, "onRewarded");
        event.success(ToMap.fromArgs("event", "onRewarded", "name", reward.getName(), "amount", reward.getAmount()));
        HMSLogger.getInstance(context).sendSingleEvent("onRewarded");
    }

    @Override
    public void onRewardAdClosed() {
        HMSLogger.getInstance(context).startMethodExecutionTimer("onRewardAdClosed");
        Log.i(TAG, "onRewardAdClosed");
        event.success(ToMap.fromArgs("event", "onRewardAdClosed"));
        HMSLogger.getInstance(context).sendSingleEvent("onRewardAdClosed");
    }

    @Override
    public void onRewardAdFailedToLoad(int errorCode) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("onRewardAdFailedToLoad");
        Log.w(TAG, "onRewardAdFailedToLoad: " + errorCode);
        if (instance != null) {
            instance.setStatus(AdStatus.FAILED);
        }
        event.success(ToMap.fromArgs("event", "onRewardAdFailedToLoad", "errorCode", errorCode));
        HMSLogger.getInstance(context).sendSingleEvent("onRewardAdFailedToLoad", String.valueOf(errorCode));
    }

    @Override
    public void onRewardAdLeftApp() {
        HMSLogger.getInstance(context).startMethodExecutionTimer("onRewardAdLeftApp");
        Log.i(TAG, "onRewardAdLeftApp");
        event.success(ToMap.fromArgs("event", "onRewardAdLeftApp"));
        HMSLogger.getInstance(context).sendSingleEvent("onRewardAdLeftApp");
    }

    @Override
    public void onRewardAdLoaded() {
        HMSLogger.getInstance(context).startMethodExecutionTimer("onRewardAdLoaded");
        Log.i(TAG, "onRewardAdLoaded");
        if (instance != null) {
            boolean wasPreparing = instance.isPreparing();
            instance.setStatus(AdStatus.LOADED);
            if (wasPreparing) {
                instance.show();
            }
        }
        event.success(ToMap.fromArgs("event", "onRewardAdLoaded"));
        HMSLogger.getInstance(context).sendSingleEvent("onRewardAdLoaded");
    }

    @Override
    public void onRewardAdOpened() {
        HMSLogger.getInstance(context).startMethodExecutionTimer("onRewardAdOpened");
        Log.i(TAG, "onRewardAdOpened");
        event.success(ToMap.fromArgs("event", "onRewardAdOpened"));
        HMSLogger.getInstance(context).sendSingleEvent("onRewardAdOpened");
    }

    @Override
    public void onRewardAdCompleted() {
        HMSLogger.getInstance(context).startMethodExecutionTimer("onRewardAdCompleted");
        Log.i(TAG, "onRewardAdCompleted");
        event.success(ToMap.fromArgs("event", "onRewardAdCompleted"));
        HMSLogger.getInstance(context).sendSingleEvent("onRewardAdCompleted");
    }

    @Override
    public void onRewardAdStarted() {
        HMSLogger.getInstance(context).startMethodExecutionTimer("onRewardAdStarted");
        Log.i(TAG, "onRewardAdStarted");
        event.success(ToMap.fromArgs("event", "onRewardAdStarted"));
        HMSLogger.getInstance(context).sendSingleEvent("onRewardAdStarted");
    }
}
