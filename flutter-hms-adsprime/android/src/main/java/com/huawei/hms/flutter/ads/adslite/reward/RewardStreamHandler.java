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

import com.huawei.hms.ads.reward.RewardAdListener;
import com.huawei.hms.flutter.ads.adslite.interstitial.Interstitial;

import io.flutter.plugin.common.EventChannel;

public class RewardStreamHandler implements EventChannel.StreamHandler {
    private static final String TAG = "RewardStreamHandler";
    private final Context context;

    public RewardStreamHandler(Context context) {
        this.context = context;
    }

    @Override
    public void onListen(Object arg, final EventChannel.EventSink event) {
        final Integer id = (Integer) arg;
        final HmsRewardAd hmsRewardAd = HmsRewardAd.get(id);
        final Interstitial interstitial = id != null ? Interstitial.get(id) : null;
        if (hmsRewardAd != null) {
            RewardAdListener rewardAdListener = new HmsRewardAdListener(event, hmsRewardAd, context);
            hmsRewardAd.setRewardAdListener(rewardAdListener);
            hmsRewardAd.setEvent(event);
        } else if (interstitial != null) {
            RewardAdListener rewardAdListener = new HmsRewardAdListener(event, context);
            interstitial.getInterstitialAd().setRewardAdListener(rewardAdListener);
        }
    }

    @Override
    public void onCancel(Object arg) {
        final Integer id = (Integer) arg;
        final HmsRewardAd hmsRewardAd = HmsRewardAd.get(id);
        final Interstitial interstitial = id != null ? Interstitial.get(id) : null;
        if (hmsRewardAd != null) {
            hmsRewardAd.setRewardAdListener(new HmsRewardAd.RewardAdDefaultListener(context, hmsRewardAd));
        } else if (interstitial != null) {
            interstitial.getInterstitialAd().setRewardAdListener(null);
        }
    }
}
