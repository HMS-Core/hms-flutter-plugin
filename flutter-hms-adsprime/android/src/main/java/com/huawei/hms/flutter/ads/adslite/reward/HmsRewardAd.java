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

import android.app.Activity;
import android.content.Context;
import android.util.Log;
import android.util.SparseArray;

import com.huawei.hms.ads.BiddingInfo;
import com.huawei.hms.ads.reward.Reward;
import com.huawei.hms.ads.reward.RewardAd;
import com.huawei.hms.ads.reward.RewardAdListener;
import com.huawei.hms.ads.reward.RewardVerifyConfig;
import com.huawei.hms.flutter.ads.factory.AdParamFactory;
import com.huawei.hms.flutter.ads.logger.HMSLogger;
import com.huawei.hms.flutter.ads.utils.FromMap;
import com.huawei.hms.flutter.ads.utils.constants.AdStatus;

import java.util.Map;

import io.flutter.plugin.common.EventChannel;

public class HmsRewardAd {
    private static final String TAG = "HmsRewardAd";

    private static SparseArray<HmsRewardAd> allRewardAds = new SparseArray<>();

    private final RewardAd rewardAdInstance;

    private RewardAdListener rewardAdListener;

    private final int id;

    private String status;

    private EventChannel.EventSink event;

    private final boolean openInHmsCore;

    private final Activity activity;

    private final Context context;

    HmsRewardAd(int id, boolean openInHmsCore, Activity activity, Context context) {
        this.activity = activity;
        this.id = id;
        this.openInHmsCore = openInHmsCore;
        this.context = context;
        allRewardAds.put(id, this);
        this.rewardAdInstance = RewardAd.createRewardAdInstance(activity);
        Log.i(TAG, "Reward ad initialized");
        setStatus(AdStatus.CREATED);
    }

    public void setEvent(EventChannel.EventSink event) {
        this.event = event;
    }

    void setRewardVerifyConfig(Map<String, Object> options) {
        String userId = FromMap.toString("userId", options);
        String data = FromMap.toString("data", options);
        if (userId != null && data != null) {
            rewardAdInstance.setRewardVerifyConfig(
                new RewardVerifyConfig.Builder().setUserId(userId).setData(data).build());
        }
    }

    void setRewardAdListener(RewardAdListener rewardAdListener) {
        this.rewardAdListener = rewardAdListener;
    }

    void setMobileDataAlertSwitch(boolean alertSwitch) {
        this.rewardAdInstance.setMobileDataAlertSwitch(alertSwitch);
    }

    public BiddingInfo getBiddingInfo() {
        return rewardAdInstance.getBiddingInfo();
    }

    boolean isPreparing() {
        return this.status.equals(AdStatus.PREPARING);
    }

    public boolean isCreated() {
        return this.status.equals(AdStatus.CREATED);
    }

    void setStatus(String status) {
        this.status = status;
    }

    private boolean isLoading() {
        return this.status.equals(AdStatus.LOADING);
    }

    boolean isLoaded() {
        return rewardAdInstance != null && rewardAdInstance.isLoaded();
    }

    public boolean isFailed() {
        return this.status.equals(AdStatus.FAILED);
    }

    Reward getReward() {
        return rewardAdInstance.getReward();
    }

    void setUserId(String userId) {
        rewardAdInstance.setUserId(userId);
    }

    void setData(String data) {
        rewardAdInstance.setData(data);
    }

    public static HmsRewardAd get(Integer id) {
        if (id == null) {
            Log.e(TAG, "Ad id is null.");
            return null;
        }
        return allRewardAds.get(id);
    }

    void loadAd(String adSlotId, Map<String, Object> adParam) {
        setStatus(AdStatus.LOADING);
        rewardAdInstance.setRewardAdListener(
            rewardAdListener != null ? rewardAdListener : new RewardAdDefaultListener(context, this));
        AdParamFactory factory = new AdParamFactory(adParam);
        rewardAdInstance.loadAd(adSlotId, factory.createAdParam());
    }

    void show() {
        if (isLoading()) {
            Log.i(TAG, "Reward ad is being prepared.");
            setStatus(AdStatus.PREPARING);
            return;
        }
        if (!rewardAdInstance.isLoaded()) {
            Log.e(TAG, "Reward ad is not loaded!");
            return;
        }
        if (openInHmsCore) {
            rewardAdInstance.show();
        } else {
            HmsRewardAdStatusListener rewardAdStatusListener = new HmsRewardAdStatusListener(this, event, context);
            rewardAdInstance.show(activity, rewardAdStatusListener);
        }
    }

    void pause() {
        if (rewardAdInstance != null && rewardAdInstance.isLoaded()) {
            rewardAdInstance.pause();
        }
    }

    void resume() {
        if (rewardAdInstance != null && rewardAdInstance.isLoaded()) {
            rewardAdInstance.resume();
        }
    }

    void destroy() {
        allRewardAds.remove(id);
    }

    public static void destroyAll() {
        for (int i = 0; i < allRewardAds.size(); i++) {
            allRewardAds.valueAt(i).destroy();
        }
        allRewardAds.clear();
    }

    static class RewardAdDefaultListener implements RewardAdListener {
        private final Context context;

        HmsRewardAd hmsRewardAd;

        RewardAdDefaultListener(Context context, HmsRewardAd hmsRewardAd) {
            this.context = context;
            this.hmsRewardAd = hmsRewardAd;
        }

        @Override
        public void onRewardAdFailedToLoad(int errorCode) {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onRewardAdFailedToLoad");
            Log.w(TAG, "onRewardAdFailedToLoad: " + errorCode);
            if (hmsRewardAd != null) {
                hmsRewardAd.setStatus(AdStatus.FAILED);
            }
            HMSLogger.getInstance(context).sendSingleEvent("onRewardAdFailedToLoad", String.valueOf(errorCode));
        }

        @Override
        public void onRewardAdLoaded() {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onRewardAdLoaded");
            Log.i(TAG, "onRewardAdLoaded");
            if (hmsRewardAd == null) {
                return;
            }
            boolean wasPreparing = hmsRewardAd.isPreparing();
            hmsRewardAd.setStatus(AdStatus.LOADED);
            if (wasPreparing) {
                hmsRewardAd.show();
            }
            HMSLogger.getInstance(context).sendSingleEvent("onRewardAdLoaded");
        }

        @Override
        public void onRewarded(Reward reward) {
        }

        @Override
        public void onRewardAdClosed() {
        }

        @Override
        public void onRewardAdLeftApp() {
        }

        @Override
        public void onRewardAdOpened() {
        }

        @Override
        public void onRewardAdCompleted() {
        }

        @Override
        public void onRewardAdStarted() {
        }
    }
}
