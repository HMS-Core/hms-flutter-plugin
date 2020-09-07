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
package com.huawei.hms.flutter.ads.adslite.nativead;

import android.util.Log;

import com.huawei.hms.ads.AdListener;
import com.huawei.hms.ads.VideoOperator;
import com.huawei.hms.ads.nativead.DislikeAdListener;
import com.huawei.hms.ads.nativead.NativeAd;
import com.huawei.hms.flutter.ads.utils.ToMap;

import io.flutter.plugin.common.EventChannel;

public class NativeAdStreamHandler implements EventChannel.StreamHandler {
    private static final String TAG = "NativeAdStreamHandler";

    @Override
    public void onListen(Object arg, final EventChannel.EventSink event) {
        final Integer id = (Integer) arg;
        final NativeAdController controller = NativeAdControllerFactory.get(id);
        if (controller != null) {
            NativeAd.NativeAdLoadedListener loadedListener = new NativeAdLoadedListenerImpl(controller, event);
            AdListener listener = new AdListenerImpl(event);
            controller.setNativeAdLoadedListener(loadedListener);
            controller.setAdListener(listener);
        }
    }

    @Override
    public void onCancel(Object arguments) {

    }

    static class NativeAdLoadedListenerImpl implements NativeAd.NativeAdLoadedListener {

        private EventChannel.EventSink event;
        private NativeAdController controller;

        NativeAdLoadedListenerImpl(NativeAdController controller, EventChannel.EventSink event) {
            this.controller = controller;
            this.event = event;
        }

        @Override
        public void onNativeAdLoaded(NativeAd nativeAd) {
            Log.i(TAG, "onNativeAdLoaded");
            nativeAd.setDislikeAdListener(new DislikeAdListener() {
                @Override
                public void onAdDisliked() {
                    Log.i(TAG, "onNativeAdDisliked");
                    event.success(ToMap.fromArgs("event", "onAdDisliked"));
                }
            });

            VideoOperator videoOperator = nativeAd.getVideoOperator();
            if (videoOperator != null && videoOperator.hasVideo()) {
                videoOperator.setVideoLifecycleListener(new VideoOperator.VideoLifecycleListener() {
                    @Override
                    public void onVideoStart() {
                        Log.i(TAG, "onVideoStart");
                        event.success(ToMap.fromArgs("event", "onVideoStart"));
                    }

                    @Override
                    public void onVideoPlay() {
                        Log.i(TAG, "onVideoPlay");
                        event.success(ToMap.fromArgs("event", "onVideoPlay"));
                    }

                    @Override
                    public void onVideoPause() {
                        Log.i(TAG, "onVideoPause");
                        event.success(ToMap.fromArgs("event", "onVideoPause"));
                    }

                    @Override
                    public void onVideoEnd() {
                        Log.i(TAG, "onVideoEnd");
                        event.success(ToMap.fromArgs("event", "onVideoEnd"));
                    }

                    @Override
                    public void onVideoMute(boolean isMuted) {
                        Log.i(TAG, "onVideoMute");
                        event.success(ToMap.fromArgs("event", "onVideoMute", "isMuted", isMuted));
                    }
                });
            }
            controller.setNativeAd(nativeAd);
            event.success(ToMap.fromArgs("event", "onAdLoaded"));
        }
    }

    static class AdListenerImpl extends AdListener {

        private EventChannel.EventSink event;

        AdListenerImpl(EventChannel.EventSink event) {
            this.event = event;
        }

        @Override
        public void onAdOpened() {
            Log.i(TAG, "onNativeAdOpened");
            event.success(ToMap.fromArgs("event", "onAdOpened"));
        }

        @Override
        public void onAdClicked() {
            Log.i(TAG, "onNativeAdClicked");
            event.success(ToMap.fromArgs("event", "onAdClicked"));
        }

        @Override
        public void onAdImpression() {
            Log.i(TAG, "onNativeAdImpression");
            event.success(ToMap.fromArgs("event", "onAdImpression"));
        }

        @Override
        public void onAdClosed() {
            Log.i(TAG, "onNativeAdClosed");
            event.success(ToMap.fromArgs("event", "onAdClosed"));
        }

        @Override
        public void onAdLeave() {
            Log.i(TAG, "onNativeAdLeave");
            event.success(ToMap.fromArgs("event", "onAdLeave"));
        }

        @Override
        public void onAdFailed(int errorCode) {
            Log.e(TAG, "onNativeAdFailed with error code: " + errorCode);
            event.success(ToMap.fromArgs("event", "onAdFailed", "errorCode", errorCode));
        }
    }
}
