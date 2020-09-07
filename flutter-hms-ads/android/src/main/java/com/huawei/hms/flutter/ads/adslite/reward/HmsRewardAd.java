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

import android.app.Activity;
import android.util.Log;
import android.util.SparseArray;

import com.huawei.hms.ads.reward.Reward;
import com.huawei.hms.ads.reward.RewardAd;
import com.huawei.hms.ads.reward.RewardAdListener;
import com.huawei.hms.ads.reward.RewardVerifyConfig;
import com.huawei.hms.flutter.ads.factory.AdParamFactory;
import com.huawei.hms.flutter.ads.utils.FromMap;
import com.huawei.hms.flutter.ads.utils.constants.AdStatus;

import java.util.Map;

public class HmsRewardAd {
    private static final String TAG = "HmsRewardAd";
    private static SparseArray<HmsRewardAd> allRewardAds = new SparseArray<>();

    private final RewardAd rewardAdInstance;
    private RewardAdListener rewardAdListener;
    private final int id;
    private String status;


    HmsRewardAd(int id, Activity activity) {
        this.id = id;
        allRewardAds.put(id, this);
        this.rewardAdInstance = RewardAd.createRewardAdInstance(activity);
        Log.i(TAG, "Reward ad initialized");
        setStatus(AdStatus.CREATED);
    }

    void setRewardVerifyConfig(Map<String, Object> options) {
        String userId = FromMap.toString("userId", options);
        String data = FromMap.toString("data", options);
        if (userId != null && data != null) {
            rewardAdInstance.setRewardVerifyConfig(
                new RewardVerifyConfig.Builder()
                    .setUserId(userId)
                    .setData(data)
                    .build()
            );
        }
    }

    void setRewardAdListener(RewardAdListener rewardAdListener) {
        this.rewardAdListener = rewardAdListener;
    }

    void setStatus(String status) {
        this.status = status;
    }

    public boolean isCreated() {
        return this.status.equals(AdStatus.CREATED);
    }

    boolean isPreparing() {
        return this.status.equals(AdStatus.PREPARING);
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
        rewardAdInstance.setRewardAdListener(rewardAdListener != null ? rewardAdListener : new RewardAdDefaultListener(this));
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
        rewardAdInstance.show();
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

        HmsRewardAd hmsRewardAd;

        RewardAdDefaultListener(HmsRewardAd hmsRewardAd) {
            this.hmsRewardAd = hmsRewardAd;
        }

        @Override
        public void onRewardAdFailedToLoad(int errorCode) {
            Log.w(TAG, "onRewardAdFailedToLoad: " + errorCode);
            if (hmsRewardAd != null) {
                hmsRewardAd.setStatus(AdStatus.FAILED);
            }
        }

        @Override
        public void onRewardAdLoaded() {
            Log.i(TAG, "onRewardAdLoaded");
            if (hmsRewardAd == null) {
                return;
            }
            boolean wasPreparing = hmsRewardAd.isPreparing();
            hmsRewardAd.setStatus(AdStatus.LOADED);
            if (wasPreparing) {
                hmsRewardAd.show();
            }
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
