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
import com.huawei.hms.flutter.ads.HmsAdsPlugin;
import com.huawei.hms.flutter.ads.adslite.interstitial.Interstitial;
import com.huawei.hms.flutter.ads.utils.ToMap;
import com.huawei.hms.flutter.ads.utils.constants.AdStatus;

import io.flutter.plugin.common.EventChannel;

public class RewardStreamHandler implements EventChannel.StreamHandler {
    private static final String TAG = "RewardStreamHandler";

    @Override
    public void onListen(Object arg, final EventChannel.EventSink event) {
        final Integer id = (Integer) arg;
        final HmsRewardAd hmsRewardAd = HmsRewardAd.get(id);
        final Interstitial interstitial = id != null ? Interstitial.get(id) : null;
        if (hmsRewardAd != null) {
            RewardAdListener rewardAdListener = new HmsRewardAdListener(event, hmsRewardAd);
            hmsRewardAd.setRewardAdListener(rewardAdListener);
        } else if (interstitial != null) {
            RewardAdListener rewardAdListener = new HmsRewardAdListener(event);
            interstitial.getInterstitialAd().setRewardAdListener(rewardAdListener);
        }
    }

    @Override
    public void onCancel(Object arg) {
        final Integer id = (Integer) arg;
        final HmsRewardAd hmsRewardAd = HmsRewardAd.get(id);
        final Interstitial interstitial = id != null ? Interstitial.get(id) : null;
        if (hmsRewardAd != null) {
            hmsRewardAd.setRewardAdListener(new HmsRewardAd.RewardAdDefaultListener(hmsRewardAd));
        } else if (interstitial != null) {
            interstitial.getInterstitialAd().setRewardAdListener(null);
        }
    }
}
