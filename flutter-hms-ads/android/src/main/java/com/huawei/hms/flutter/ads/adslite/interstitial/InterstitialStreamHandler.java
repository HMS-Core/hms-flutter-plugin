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
package com.huawei.hms.flutter.ads.adslite.interstitial;

import android.util.Log;

import com.huawei.hms.ads.AdListener;
import com.huawei.hms.flutter.ads.utils.ToMap;
import com.huawei.hms.flutter.ads.utils.constants.AdStatus;

import io.flutter.plugin.common.EventChannel;

public class InterstitialStreamHandler implements EventChannel.StreamHandler {
    private static final String TAG = "BannerStreamHandler";


    @Override
    public void onListen(Object arg, final EventChannel.EventSink event) {
        final Integer id = (Integer) arg;
        final Interstitial interstitial = Interstitial.get(id);
        if (interstitial != null) {
            AdListener listener = new AdListenerImpl(interstitial, event);
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

        AdListenerImpl(Interstitial banner, EventChannel.EventSink event) {
            this.interstitial = banner;
            this.event = event;
        }

        @Override
        public void onAdLoaded() {
            Log.i(TAG, "onInterstitialAdLoaded");
            boolean wasPreparing = interstitial.isPreparing();
            interstitial.setStatus(AdStatus.LOADED);
            if (wasPreparing) {
                interstitial.show();
            }
            event.success(ToMap.fromArgs("event", "onAdLoaded"));
        }

        @Override
        public void onAdFailed(int errorCode) {
            Log.w(TAG, "onInterstitialAdFailed: " + errorCode);
            interstitial.setStatus(AdStatus.FAILED);
            event.success(ToMap.fromArgs("event", "onAdFailed", "errorCode", errorCode));
        }

        @Override
        public void onAdOpened() {
            Log.i(TAG, "onInterstitialAdOpened");
            event.success(ToMap.fromArgs("event", "onAdOpened"));
        }

        @Override
        public void onAdClicked() {
            Log.i(TAG, "onInterstitialAdClicked");
            event.success(ToMap.fromArgs("event", "onAdClicked"));
        }

        @Override
        public void onAdImpression() {
            Log.i(TAG, "onInterstitialAdImpression");
            event.success(ToMap.fromArgs("event", "onAdImpression"));
        }

        @Override
        public void onAdClosed() {
            Log.i(TAG, "onInterstitialAdClosed");
            event.success(ToMap.fromArgs("event", "onAdClosed"));
        }

        @Override
        public void onAdLeave() {
            Log.i(TAG, "onInterstitialAdLeave");
            event.success(ToMap.fromArgs("event", "onAdLeave"));
        }
    }
}
