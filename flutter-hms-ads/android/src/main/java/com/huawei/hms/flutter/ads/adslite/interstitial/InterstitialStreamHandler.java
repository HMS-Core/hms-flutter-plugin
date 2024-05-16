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

package com.huawei.hms.flutter.ads.adslite.interstitial;

import android.content.Context;
import android.util.Log;

import com.huawei.hms.ads.AdListener;
import com.huawei.hms.flutter.ads.logger.HMSLogger;
import com.huawei.hms.flutter.ads.utils.ToMap;
import com.huawei.hms.flutter.ads.utils.constants.AdStatus;

import io.flutter.plugin.common.EventChannel;

public class InterstitialStreamHandler implements EventChannel.StreamHandler {
    private static final String TAG = "BannerStreamHandler";
    private final Context context;

    public InterstitialStreamHandler(Context context) {
        this.context = context;
    }

    @Override
    public void onListen(Object arg, final EventChannel.EventSink event) {
        final Integer id = (Integer) arg;
        final Interstitial interstitial = Interstitial.get(id);
        if (interstitial != null) {
            AdListener listener = new AdListenerImpl(interstitial, event, context);
            interstitial.setAdListener(listener);
        }
    }

    @Override
    public void onCancel(Object arg) {
        final Integer id = (Integer) arg;
        final Interstitial interstitial = Interstitial.get(id);
        if (interstitial != null) {
            interstitial.setAdListener(new Interstitial.InterstitialDefaultListener(interstitial));
        }
    }

    static class AdListenerImpl extends AdListener {
        private EventChannel.EventSink event;
        private Interstitial interstitial;
        private final Context context;

        AdListenerImpl(Interstitial banner, EventChannel.EventSink event, Context context) {
            this.interstitial = banner;
            this.event = event;
            this.context = context;
        }

        @Override
        public void onAdLoaded() {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onInterstitialAdLoaded");
            Log.i(TAG, "onInterstitialAdLoaded");
            boolean wasPreparing = interstitial.isPreparing();
            interstitial.setStatus(AdStatus.LOADED);
            if (wasPreparing) {
                interstitial.show();
            }
            event.success(ToMap.fromArgs("event", "onAdLoaded"));
            HMSLogger.getInstance(context).sendSingleEvent("onInterstitialAdLoaded");
        }

        @Override
        public void onAdFailed(int errorCode) {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onInterstitialAdFailed");
            Log.w(TAG, "onInterstitialAdFailed: " + errorCode);
            interstitial.setStatus(AdStatus.FAILED);
            event.success(ToMap.fromArgs("event", "onAdFailed", "errorCode", errorCode));
            HMSLogger.getInstance(context).sendSingleEvent("onInterstitialAdFailed", String.valueOf(errorCode));
        }

        @Override
        public void onAdOpened() {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onInterstitialAdOpened");
            Log.i(TAG, "onInterstitialAdOpened");
            event.success(ToMap.fromArgs("event", "onAdOpened"));
            HMSLogger.getInstance(context).sendSingleEvent("onInterstitialAdOpened");
        }

        @Override
        public void onAdClicked() {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onInterstitialAdClicked");
            Log.i(TAG, "onInterstitialAdClicked");
            event.success(ToMap.fromArgs("event", "onAdClicked"));
            HMSLogger.getInstance(context).sendSingleEvent("onInterstitialAdClicked");
        }

        @Override
        public void onAdImpression() {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onInterstitialAdImpression");
            Log.i(TAG, "onInterstitialAdImpression");
            event.success(ToMap.fromArgs("event", "onAdImpression"));
            HMSLogger.getInstance(context).sendSingleEvent("onInterstitialAdImpression");
        }

        @Override
        public void onAdClosed() {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onInterstitialAdClosed");
            Log.i(TAG, "onInterstitialAdClosed");
            event.success(ToMap.fromArgs("event", "onAdClosed"));
            HMSLogger.getInstance(context).sendSingleEvent("onInterstitialAdClosed");
        }

        @Override
        public void onAdLeave() {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onInterstitialAdLeave");
            Log.i(TAG, "onInterstitialAdLeave");
            event.success(ToMap.fromArgs("event", "onAdLeave"));
            HMSLogger.getInstance(context).sendSingleEvent("onInterstitialAdLeave");
        }
    }
}
