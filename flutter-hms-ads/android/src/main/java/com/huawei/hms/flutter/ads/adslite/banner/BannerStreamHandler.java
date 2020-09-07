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
package com.huawei.hms.flutter.ads.adslite.banner;

import android.util.Log;

import com.huawei.hms.ads.AdListener;
import com.huawei.hms.flutter.ads.utils.ToMap;
import com.huawei.hms.flutter.ads.utils.constants.AdStatus;

import io.flutter.plugin.common.EventChannel;

public class BannerStreamHandler implements EventChannel.StreamHandler {
    private static final String TAG = "BannerStreamHandler";

    @Override
    public void onListen(Object arg, final EventChannel.EventSink event) {
        final Integer id = (Integer) arg;
        final Banner banner = Banner.get(id);
        if (banner != null) {
            AdListener listener = new AdListenerImpl(banner, event);
            banner.setAdListener(listener);
        }
    }

    @Override
    public void onCancel(Object arg) {
        final Integer id = (Integer) arg;
        final Banner banner = Banner.get(id);
        if (banner != null) {
            banner.setAdListener(new Banner.BannerDefaultListener(banner));
        }
    }

    static class AdListenerImpl extends AdListener {

        private EventChannel.EventSink event;
        private Banner banner;

        AdListenerImpl(Banner banner, EventChannel.EventSink event) {
            this.banner = banner;
            this.event = event;
        }

        @Override
        public void onAdLoaded() {
            Log.i(TAG, "onBannerAdLoaded");
            boolean wasPreparing = banner.isPreparing();
            banner.setStatus(AdStatus.LOADED);
            if (wasPreparing) {
                banner.show();
            }
            event.success(ToMap.fromArgs("event", "onAdLoaded"));
        }

        @Override
        public void onAdFailed(int errorCode) {
            Log.w(TAG, "onBannerAdFailed: " + errorCode);
            banner.setStatus(AdStatus.FAILED);
            event.success(ToMap.fromArgs("event", "onAdFailed", "errorCode", errorCode));
        }

        @Override
        public void onAdOpened() {
            Log.i(TAG, "onBannerAdOpened");
            event.success(ToMap.fromArgs("event", "onAdOpened"));
        }

        @Override
        public void onAdClicked() {
            Log.i(TAG, "onBannerAdClicked");
            event.success(ToMap.fromArgs("event", "onAdClicked"));
        }

        @Override
        public void onAdImpression() {
            Log.i(TAG, "onBannerAdImpression");
            event.success(ToMap.fromArgs("event", "onAdImpression"));
        }

        @Override
        public void onAdClosed() {
            Log.i(TAG, "onBannerAdClosed");
            event.success(ToMap.fromArgs("event", "onAdClosed"));
        }

        @Override
        public void onAdLeave() {
            Log.i(TAG, "onBannerAdLeave");
            event.success(ToMap.fromArgs("event", "onAdLeave"));
        }
    }

    ;
}
