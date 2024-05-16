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

package com.huawei.hms.flutter.ads.adslite.vast;

import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.ProgressBar;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.huawei.hms.ads.vast.adapter.SdkFactory;
import com.huawei.hms.ads.vast.adapter.VastSdkConfiguration;
import com.huawei.hms.ads.vast.domain.event.VastErrorType;
import com.huawei.hms.ads.vast.player.VastApplication;
import com.huawei.hms.ads.vast.player.api.AdsRequestListener;
import com.huawei.hms.ads.vast.player.api.DefaultVideoController;
import com.huawei.hms.ads.vast.player.api.PlayerConfig;
import com.huawei.hms.ads.vast.player.api.VastAdPlayer;
import com.huawei.hms.ads.vast.player.api.VastPlayerListener;
import com.huawei.hms.ads.vast.player.base.BaseVideoController;
import com.huawei.hms.ads.vast.player.model.CreativeResource;
import com.huawei.hms.ads.vast.player.model.adslot.AdsData;
import com.huawei.hms.ads.vast.player.model.adslot.LinearAdSlot;
import com.huawei.hms.ads.vast.player.model.remote.RequestCallback;
import com.huawei.hms.flutter.ads.logger.HMSLogger;
import com.huawei.hms.flutter.ads.utils.constants.ErrorCodes;
import com.huawei.hms.flutter.ads.utils.constants.ViewTypes;

import java.util.Arrays;
import java.util.Locale;
import java.util.Map;
import java.util.Objects;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class FlutterVastView implements PlatformView, MethodChannel.MethodCallHandler {
    private final Context context;
    private final MethodChannel methodChannel;

    private final View vastView;
    private final FrameLayout linearAdView;
    private final ProgressBar progressBar;

    private final LinearAdSlot linearAdSlot;
    private AdsData adsData;

    final BaseVideoController videoController;

    public FlutterVastView(Context context, BinaryMessenger messenger, int viewId, Map<String, Object> creationParams) {
        this.context = context;
        this.methodChannel = new MethodChannel(messenger, ViewTypes.VAST_VIEW + "/" + viewId);
        this.methodChannel.setMethodCallHandler(this);

        this.vastView = LayoutInflater.from(context).inflate(getResourceId("vast_template", "layout"), null);
        this.linearAdView = vastView.findViewById(getResourceId("fl_linear_ad", "id"));
        this.progressBar = vastView.findViewById(getResourceId("progress", "id"));

        this.linearAdSlot = VastUtils.linearAdSlotFromMap((Map<String, Object>) Objects.requireNonNull(creationParams.get("linearAdSlot")));

        final VastSdkConfiguration configuration = SdkFactory.getConfiguration();
        VastApplication.init(context, configuration.isTest());
        VastAdPlayer.getInstance().setAdViewStrategy((i, i1, i2, i3) -> true);

        final Boolean isCustomVideoPlayer = (Boolean) Objects.requireNonNull(creationParams.get("isCustomVideoPlayer"));
        if (isCustomVideoPlayer) {
            this.videoController = new CustomVideoController((Activity) context, new VastPlayerListener() {
                @Override
                public void onPlayStateChanged(int i) {
                    methodChannel.invokeMethod("VastPlayerListener.onPlayStateChanged", i);
                }

                @Override
                public void onVolumeChanged(float v) {
                    methodChannel.invokeMethod("VastPlayerListener.onVolumeChanged", v);
                }

                @Override
                public void onScreenViewChanged(int i) {
                    methodChannel.invokeMethod("VastPlayerListener.onScreenViewChanged", i);
                }

                @Override
                public void onProgressChanged(long l, long l1, long l2) {
                    methodChannel.invokeMethod("VastPlayerListener.onProgressChanged", Arrays.asList(l, l1, l2));
                }
            });
        } else {
            this.videoController = new DefaultVideoController((Activity) context);
        }
        VastAdPlayer.getInstance().registerLinearAdView(linearAdView, videoController);
    }

    @Nullable
    @Override
    public View getView() {
        return vastView;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer(call.method);
        switch (call.method) {
            case "loadLinearAd": {
                VastAdPlayer.getInstance().loadLinearAd(linearAdSlot, new RequestCallback() {
                    @Override
                    public void onAdsLoadedSuccess(AdsData data) {
                        adsData = data;
                        result.success(true);
                    }

                    @Override
                    public void onAdsLoadFailed() {
                        adsData = null;
                        result.success(false);
                    }
                });
                break;
            }
            case "playLinearAds": {
                if (adsData == null) {
                    result.error(ErrorCodes.LOAD_FAILED, "Load linear ad first!", null);
                }
                VastAdPlayer.getInstance().playLinearAds(linearAdSlot, adsData, getAdsRequestListener());
                result.success(true);
                break;
            }
            case "startLinearAd": {
                VastAdPlayer.getInstance().startLinearAd(linearAdSlot, getAdsRequestListener());
                result.success(true);
                break;
            }
            case "startAdPods": {
                VastAdPlayer.getInstance().startAdPods(linearAdSlot, getAdsRequestListener());
                result.success(true);
                break;
            }
            case "changeLocalLanguage": {
                final String languageCode = call.argument("languageCode");
                final String countryCode = call.argument("countryCode");
                if (languageCode != null) {
                    if (countryCode != null) {
                        VastAdPlayer.getInstance().changeLocalLanguage(context, new Locale(languageCode, countryCode));
                    } else {
                        VastAdPlayer.getInstance().changeLocalLanguage(context, new Locale(languageCode));
                    }
                }
                result.success(true);
                break;
            }
            case "resume": {
                VastAdPlayer.getInstance().resume();
                result.success(true);
                break;
            }
            case "pause": {
                VastAdPlayer.getInstance().pause();
                result.success(true);
                break;
            }
            case "release": {
                if (linearAdView != null){
                    VastAdPlayer.getInstance().unregisterLinearAdView(linearAdView);
                    linearAdView.setVisibility(View.INVISIBLE);
                }
                VastAdPlayer.getInstance().release();
                progressBar.setVisibility(View.INVISIBLE);
                result.success(true);
                break;
            }
            case "getConfig": {
                final PlayerConfig playerConfig = VastAdPlayer.getInstance().getConfig();
                final Map<String, Object> playerConfigMap = VastUtils.playerConfigToMap(playerConfig);
                result.success(playerConfigMap);
                break;
            }
            case "setConfig": {
                final Map<String, Object> playerConfigMap = call.argument("playerConfig");
                if (playerConfigMap != null) {
                    final PlayerConfig playerConfig = VastUtils.playerConfigFromMap(playerConfigMap);
                    VastAdPlayer.getInstance().setConfig(playerConfig);
                }
                result.success(true);
                break;
            }
            case "isLinearAdShown": {
                result.success(VastAdPlayer.getInstance().isLinearAdShown());
                break;
            }
            case "isLinearPlaying": {
                result.success(VastAdPlayer.getInstance().isLinearPlaying());
                break;
            }
            case "startOrPause": {
                this.videoController.startOrPause();
                result.success(true);
                break;
            }
            case "toggleMuteState": {
                final Boolean isMute = call.argument("isMute");
                if (isMute != null) {
                    this.videoController.toggleMuteState(isMute);
                }
                result.success(true);
                break;
            }
            default: {
                result.notImplemented();
                break;
            }
        }
        HMSLogger.getInstance(context).sendSingleEvent(call.method);
    }

    @Override
    public void dispose() {
        if (linearAdView != null){
            VastAdPlayer.getInstance().unregisterLinearAdView(linearAdView);
        }
        VastAdPlayer.getInstance().release();
    }

    private AdsRequestListener getAdsRequestListener() {
        return new AdsRequestListener() {
            @Override
            public void onSuccess(View view, int i) {
                methodChannel.invokeMethod("AdsRequestListener.onSuccess", i);
            }

            @Override
            public void onFailed(View view, int i) {
                methodChannel.invokeMethod("AdsRequestListener.onFailed", i);
            }

            @Override
            public void playAdReady() {
                methodChannel.invokeMethod("AdsRequestListener.playAdReady", null);
                linearAdView.setVisibility(View.VISIBLE);
            }

            @Override
            public void playAdFinish() {
                methodChannel.invokeMethod("AdsRequestListener.playAdFinish", null);
                linearAdView.setVisibility(View.INVISIBLE);
            }

            @Override
            public void playAdError(VastErrorType vastErrorType, CreativeResource creativeResource) {
                methodChannel.invokeMethod("AdsRequestListener.playAdError", vastErrorType.getErrorCode());
            }

            @Override
            public void onBufferStart() {
                methodChannel.invokeMethod("AdsRequestListener.onBufferStart", null);
                progressBar.setVisibility(View.VISIBLE);
            }

            @Override
            public void onBufferEnd() {
                methodChannel.invokeMethod("AdsRequestListener.onBufferEnd", null);
                progressBar.setVisibility(View.INVISIBLE);
            }
        };
    }

    private int getResourceId(String name, String defType) {
        return context.getResources().getIdentifier(name, defType, context.getPackageName());
    }
}
