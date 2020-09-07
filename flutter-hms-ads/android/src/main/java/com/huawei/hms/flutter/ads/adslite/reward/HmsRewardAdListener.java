/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/
package com.huawei.hms.flutter.ads.adslite.reward;

import android.util.Log;

import com.huawei.hms.ads.reward.Reward;
import com.huawei.hms.ads.reward.RewardAdListener;
import com.huawei.hms.flutter.ads.utils.ToMap;
import com.huawei.hms.flutter.ads.utils.constants.AdStatus;

import io.flutter.plugin.common.EventChannel;

public class HmsRewardAdListener implements RewardAdListener {
    private static final String TAG = "HmsRewardAdListener";
    private EventChannel.EventSink event;
    private HmsRewardAd instance;

    HmsRewardAdListener(EventChannel.EventSink event) {
        this.event = event;
    }

    HmsRewardAdListener(EventChannel.EventSink event, HmsRewardAd instance) {
        this.event = event;
        this.instance = instance;
    }

    @Override
    public void onRewarded(Reward reward) {
        Log.i(TAG, "onRewarded");
        event.success(ToMap.fromArgs("event", "onRewarded", "name", reward.getName(), "amount", reward.getAmount()));
    }

    @Override
    public void onRewardAdClosed() {
        Log.i(TAG, "onRewardAdClosed");
        event.success(ToMap.fromArgs("event", "onRewardAdClosed"));
    }

    @Override
    public void onRewardAdFailedToLoad(int errorCode) {
        Log.w(TAG, "onRewardAdFailedToLoad: " + errorCode);
        if (instance != null) {
            instance.setStatus(AdStatus.FAILED);
        }
        event.success(ToMap.fromArgs("event", "onRewardAdFailedToLoad", "errorCode", errorCode));
    }

    @Override
    public void onRewardAdLeftApp() {
        Log.i(TAG, "onRewardAdLeftApp");
        event.success(ToMap.fromArgs("event", "onRewardAdLeftApp"));
    }

    @Override
    public void onRewardAdLoaded() {
        Log.i(TAG, "onRewardAdLoaded");
        if (instance != null) {
            boolean wasPreparing = instance.isPreparing();
            instance.setStatus(AdStatus.LOADED);
            if (wasPreparing) {
                instance.show();
            }
        }
        event.success(ToMap.fromArgs("event", "onRewardAdLoaded"));
    }

    @Override
    public void onRewardAdOpened() {
        Log.i(TAG, "onRewardAdOpened");
        event.success(ToMap.fromArgs("event", "onRewardAdOpened"));
    }

    @Override
    public void onRewardAdCompleted() {
        Log.i(TAG, "onRewardAdCompleted");
        event.success(ToMap.fromArgs("event", "onRewardAdCompleted"));
    }

    @Override
    public void onRewardAdStarted() {
        Log.i(TAG, "onRewardAdStarted");
        event.success(ToMap.fromArgs("event", "onRewardAdStarted"));
    }
}
