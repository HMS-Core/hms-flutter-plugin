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

package com.huawei.hms.flutter.ads.adslite.nativead;

import android.content.Context;
import android.util.Log;

import com.huawei.hms.ads.AdListener;
import com.huawei.hms.ads.VideoConfiguration;
import com.huawei.hms.ads.VideoOperator;
import com.huawei.hms.ads.nativead.DislikeAdListener;
import com.huawei.hms.ads.nativead.NativeAd;
import com.huawei.hms.flutter.ads.factory.VideoConfigurationFactory;
import com.huawei.hms.flutter.ads.logger.HMSLogger;
import com.huawei.hms.flutter.ads.utils.ToMap;

import io.flutter.plugin.common.EventChannel;

import java.util.Map;

public class NativeAdStreamHandler implements EventChannel.StreamHandler {
    private static final String TAG = "NativeAdStreamHandler";

    private final Context context;

    public NativeAdStreamHandler(Context context) {
        this.context = context;
    }

    @Override
    public void onListen(Object arg, final EventChannel.EventSink event) {
        final Integer id = (Integer) arg;
        final NativeAdController controller = NativeAdControllerFactory.get(id);
        if (controller != null) {
            NativeAd.NativeAdLoadedListener loadedListener = new NativeAdLoadedListenerImpl(controller, event, context);
            AdListener listener = new AdListenerImpl(context, event);
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

        private final Context context;

        NativeAdLoadedListenerImpl(NativeAdController controller, EventChannel.EventSink event, Context context) {
            this.controller = controller;
            this.event = event;
            this.context = context;
        }

        @Override
        public void onNativeAdLoaded(NativeAd nativeAd) {
            Log.i(TAG, "onNativeAdLoaded");

            Map<String, Object> videoConfigurationMap = NativeAdController.videoConfigurationMap;
            if (!videoConfigurationMap.isEmpty()) {
                VideoConfigurationFactory videoConFactory = new VideoConfigurationFactory(videoConfigurationMap);
                VideoConfiguration videoConfiguration = videoConFactory.createVideoConfiguration();
                nativeAd.setVideoConfiguration(videoConfiguration);
                Log.i(TAG, "video configuration set");
            }
            nativeAd.setDislikeAdListener(new DislikeAdListener() {
                @Override
                public void onAdDisliked() {
                    HMSLogger.getInstance(context).startMethodExecutionTimer("onNativeAdDisliked");
                    Log.i(TAG, "onNativeAdDisliked");
                    event.success(ToMap.fromArgs("event", "onAdDisliked"));
                    HMSLogger.getInstance(context).sendSingleEvent("onNativeAdDisliked");
                }
            });

            VideoOperator videoOperator = nativeAd.getVideoOperator();
            if (videoOperator != null && videoOperator.hasVideo()) {
                videoOperator.setVideoLifecycleListener(new VideoOperator.VideoLifecycleListener() {
                    @Override
                    public void onVideoStart() {
                        HMSLogger.getInstance(context).startMethodExecutionTimer("onVideoStart");
                        Log.i(TAG, "onVideoStart");
                        event.success(ToMap.fromArgs("event", "onVideoStart"));
                        HMSLogger.getInstance(context).sendSingleEvent("onVideoStart");
                    }

                    @Override
                    public void onVideoPlay() {
                        HMSLogger.getInstance(context).startMethodExecutionTimer("onVideoPlay");
                        Log.i(TAG, "onVideoPlay");
                        event.success(ToMap.fromArgs("event", "onVideoPlay"));
                        HMSLogger.getInstance(context).sendSingleEvent("onVideoPlay");
                    }

                    @Override
                    public void onVideoPause() {
                        HMSLogger.getInstance(context).startMethodExecutionTimer("onVideoPause");
                        Log.i(TAG, "onVideoPause");
                        event.success(ToMap.fromArgs("event", "onVideoPause"));
                        HMSLogger.getInstance(context).sendSingleEvent("onVideoPause");
                    }

                    @Override
                    public void onVideoEnd() {
                        HMSLogger.getInstance(context).startMethodExecutionTimer("onVideoEnd");
                        Log.i(TAG, "onVideoEnd");
                        event.success(ToMap.fromArgs("event", "onVideoEnd"));
                        HMSLogger.getInstance(context).sendSingleEvent("onVideoEnd");
                    }

                    @Override
                    public void onVideoMute(boolean isMuted) {
                        HMSLogger.getInstance(context).startMethodExecutionTimer("onVideoMute");
                        Log.i(TAG, "onVideoMute");
                        event.success(ToMap.fromArgs("event", "onVideoMute", "isMuted", isMuted));
                        HMSLogger.getInstance(context).sendSingleEvent("onVideoMute");
                    }
                });
            }
            HMSLogger.getInstance(context).startMethodExecutionTimer("onNativeAdLoaded");
            controller.setNativeAd(nativeAd);
            event.success(ToMap.fromArgs("event", "onAdLoaded"));
            HMSLogger.getInstance(context).sendSingleEvent("onNativeAdLoaded");
        }
    }

    static class AdListenerImpl extends AdListener {
        private final Context context;

        private EventChannel.EventSink event;

        AdListenerImpl(Context context, EventChannel.EventSink event) {
            this.context = context;
            this.event = event;
        }

        @Override
        public void onAdOpened() {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onNativeAdOpened");
            Log.i(TAG, "onNativeAdOpened");
            event.success(ToMap.fromArgs("event", "onAdOpened"));
            HMSLogger.getInstance(context).sendSingleEvent("onNativeAdOpened");
        }

        @Override
        public void onAdClicked() {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onNativeAdClicked");
            Log.i(TAG, "onNativeAdClicked");
            event.success(ToMap.fromArgs("event", "onAdClicked"));
            HMSLogger.getInstance(context).sendSingleEvent("onNativeAdClicked");
        }

        @Override
        public void onAdImpression() {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onNativeAdImpression");
            Log.i(TAG, "onNativeAdImpression");
            event.success(ToMap.fromArgs("event", "onAdImpression"));
            HMSLogger.getInstance(context).sendSingleEvent("onNativeAdImpression");
        }

        @Override
        public void onAdClosed() {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onNativeAdClosed");
            Log.i(TAG, "onNativeAdClosed");
            event.success(ToMap.fromArgs("event", "onAdClosed"));
            HMSLogger.getInstance(context).sendSingleEvent("onNativeAdClosed");
        }

        @Override
        public void onAdLeave() {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onNativeAdLeave");
            Log.i(TAG, "onNativeAdLeave");
            event.success(ToMap.fromArgs("event", "onAdLeave"));
            HMSLogger.getInstance(context).sendSingleEvent("onNativeAdLeave");
        }

        @Override
        public void onAdFailed(int errorCode) {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onNativeAdFailed");
            Log.e(TAG, "onNativeAdFailed with error code: " + errorCode);
            event.success(ToMap.fromArgs("event", "onAdFailed", "errorCode", errorCode));
            HMSLogger.getInstance(context).sendSingleEvent("onNativeAdFailed", String.valueOf(errorCode));
        }
    }
}
