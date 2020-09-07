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
package com.huawei.hms.flutter.ads.adslite.splash;

import android.util.Log;

import com.huawei.hms.ads.splash.SplashAdDisplayListener;
import com.huawei.hms.ads.splash.SplashView;
import com.huawei.hms.flutter.ads.utils.ToMap;
import com.huawei.hms.flutter.ads.utils.constants.AdStatus;

import io.flutter.plugin.common.EventChannel;

public class SplashStreamHandler implements EventChannel.StreamHandler {
    private static final String TAG = "SplashStreamHandler";

    @Override
    public void onListen(Object arg, final EventChannel.EventSink event) {
        final Integer id = (Integer) arg;
        final Splash splash = Splash.get(id);
        if (splash != null && splash.isLoading()) {
            SplashAdDisplayListener displayListener = new SplashAdDisplayListenerImpl(event);
            SplashView.SplashAdLoadListener loadListener = new SplashAdLoadListenerImpl(splash, event);
            splash.setDisplayListener(displayListener);
            splash.setLoadListener(loadListener);
        }
        Log.w(TAG, "Splash ad is either null or not in loading state");
    }

    @Override
    public void onCancel(Object arg) {
        final Integer id = (Integer) arg;
        final Splash splash = Splash.get(id);
        if (splash != null) {
            splash.setDisplayListener(null);
            splash.setLoadListener(new Splash.SplashDefaultLoadListener(splash));
        }
    }

    static class SplashAdDisplayListenerImpl extends SplashAdDisplayListener {

        private EventChannel.EventSink event;

        SplashAdDisplayListenerImpl(EventChannel.EventSink event) {
            this.event = event;
        }

        @Override
        public void onAdShowed() {
            Log.i(TAG, "onSplashAdShowed");
            event.success(ToMap.fromArgs("event", "onSplashAdShowed"));
        }

        @Override
        public void onAdClick() {
            Log.i(TAG, "onSplashAdClick");
            event.success(ToMap.fromArgs("event", "onSplashAdClick"));
        }
    }

    static class SplashAdLoadListenerImpl extends SplashView.SplashAdLoadListener {

        private EventChannel.EventSink event;
        private Splash splash;

        SplashAdLoadListenerImpl(Splash splash, EventChannel.EventSink event) {
            this.splash = splash;
            this.event = event;
        }

        @Override
        public void onAdFailedToLoad(int errorCode) {
            Log.w(TAG, "onSplashAdFailed: " + errorCode);
            splash.setStatus(AdStatus.FAILED);
            event.success(ToMap.fromArgs("event", "onSplashAdFailed", "errorCode", errorCode));
        }

        @Override
        public void onAdLoaded() {
            Log.i(TAG, "onSplashAdLoaded");
            splash.setStatus(AdStatus.LOADED);
            splash.show();
            event.success(ToMap.fromArgs("event", "onSplashAdLoaded"));
        }

        @Override
        public void onAdDismissed() {
            Log.i(TAG, "onSplashAdDismissed");
            event.success(ToMap.fromArgs("event", "onSplashAdDismissed"));
        }
    }
}
