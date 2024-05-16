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

package com.huawei.hms.flutter.ads.adslite.banner;

import android.content.Context;
import android.util.Log;

import com.huawei.hms.ads.AdListener;
import com.huawei.hms.flutter.ads.logger.HMSLogger;
import com.huawei.hms.flutter.ads.utils.ToMap;
import com.huawei.hms.flutter.ads.utils.constants.AdStatus;

import io.flutter.plugin.common.EventChannel;

public class BannerStreamHandler implements EventChannel.StreamHandler {
    private static final String TAG = "BannerStreamHandler";
    private final Context context;

    public BannerStreamHandler(Context context) {
        this.context = context;
    }

    @Override
    public void onListen(Object arg, final EventChannel.EventSink event) {
        final Integer id = (Integer) arg;
        final Banner banner = Banner.get(id);
        if (banner != null) {
            AdListener listener = new AdListenerImpl(banner, event, context);
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
        private final Context context;

        AdListenerImpl(Banner banner, EventChannel.EventSink event, Context context) {
            this.banner = banner;
            this.event = event;
            this.context = context;
        }

        @Override
        public void onAdLoaded() {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onBannerAdLoaded");
            Log.i(TAG, "onBannerAdLoaded");
            boolean wasPreparing = banner.isPreparing();
            banner.setStatus(AdStatus.LOADED);
            if (wasPreparing) {
                banner.show();
            }
            event.success(ToMap.fromArgs("event", "onAdLoaded"));
            HMSLogger.getInstance(context).sendSingleEvent("onBannerAdLoaded");
        }

        @Override
        public void onAdFailed(int errorCode) {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onBannerAdFailed");
            Log.w(TAG, "onBannerAdFailed: " + errorCode);
            banner.setStatus(AdStatus.FAILED);
            event.success(ToMap.fromArgs("event", "onAdFailed", "errorCode", errorCode));
            HMSLogger.getInstance(context).sendSingleEvent("onBannerAdFailed", String.valueOf(errorCode));
        }

        @Override
        public void onAdOpened() {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onBannerAdOpened");
            Log.i(TAG, "onBannerAdOpened");
            event.success(ToMap.fromArgs("event", "onAdOpened"));
            HMSLogger.getInstance(context).sendSingleEvent("onBannerAdOpened");
        }

        @Override
        public void onAdClicked() {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onBannerAdClicked");
            Log.i(TAG, "onBannerAdClicked");
            event.success(ToMap.fromArgs("event", "onAdClicked"));
            HMSLogger.getInstance(context).sendSingleEvent("onBannerAdClicked");
        }

        @Override
        public void onAdImpression() {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onBannerAdImpression");
            Log.i(TAG, "onBannerAdImpression");
            event.success(ToMap.fromArgs("event", "onAdImpression"));
            HMSLogger.getInstance(context).sendSingleEvent("onBannerAdImpression");
        }

        @Override
        public void onAdClosed() {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onBannerAdClosed");
            Log.i(TAG, "onBannerAdClosed");
            event.success(ToMap.fromArgs("event", "onAdClosed"));
            HMSLogger.getInstance(context).sendSingleEvent("onBannerAdClosed");
        }

        @Override
        public void onAdLeave() {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onBannerAdLeave");
            Log.i(TAG, "onBannerAdLeave");
            event.success(ToMap.fromArgs("event", "onAdLeave"));
            HMSLogger.getInstance(context).sendSingleEvent("onBannerAdLeave");
        }
    }
}
