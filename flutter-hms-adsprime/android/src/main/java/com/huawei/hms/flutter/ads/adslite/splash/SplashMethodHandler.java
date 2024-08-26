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

package com.huawei.hms.flutter.ads.adslite.splash;

import android.app.Activity;
import android.content.Context;
import android.content.pm.ActivityInfo;

import androidx.annotation.NonNull;

import java.util.Map;

import com.huawei.hms.ads.BiddingInfo;
import com.huawei.hms.ads.splash.SplashView;
import com.huawei.hms.flutter.ads.factory.EventChannelFactory;
import com.huawei.hms.flutter.ads.logger.HMSLogger;
import com.huawei.hms.flutter.ads.utils.FromMap;
import com.huawei.hms.flutter.ads.utils.ToMap;
import com.huawei.hms.flutter.ads.utils.constants.Channels;
import com.huawei.hms.flutter.ads.utils.constants.ErrorCodes;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.Result;

public class SplashMethodHandler implements MethodChannel.MethodCallHandler {
    private final BinaryMessenger messenger;

    private final Activity activity;

    private final Context context;

    public SplashMethodHandler(final BinaryMessenger messenger, final Activity activity, Context context) {
        this.messenger = messenger;
        this.activity = activity;
        this.context = context;
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        switch (call.method) {
            case "resumeAd":
                resumeAd(call, result);
                break;
            case "destroyAd":
                destroyAd(call, result);
                break;
            case "preloadSplashAd":
                preloadSplashAd(activity, call, result);
                break;
            case "isAdLoaded":
                isAdLoaded(call, result);
                break;
            case "prepareSplashAd":
                prepareSplashAd(activity, call, result);
                break;
            case "isAdLoading":
                isAdLoading(call, result);
                break;
            case "loadSplashAd":
                loadSplashAd(call, result);
                break;
            case "pauseAd":
                pauseAd(call, result);
                break;
            case "getBiddingInfo":
                getBiddingInfo(call, result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void prepareSplashAd(Activity activity, MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("prepareSplashAd");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        String adSlotId = call.argument("adSlotId");

        if (id == null) {
            result.error(ErrorCodes.NULL_PARAM, "Ad id is null. Load preparation failed.", "");
            HMSLogger.getInstance(context).sendSingleEvent("prepareSplashAd", ErrorCodes.NULL_PARAM);
            return;
        }

        if (adSlotId == null || adSlotId.isEmpty()) {
            result.error(ErrorCodes.NULL_PARAM,
                "adSlotId is either null or empty. Load preparation failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("prepareSplashAd", ErrorCodes.NULL_PARAM);
            return;
        }

        Splash splash = new Splash(id, activity);
        EventChannelFactory.create(id, Channels.SPLASH_EVENT_CHANNEL, messenger);
        EventChannelFactory.setup(id, new SplashStreamHandler(context));

        if (!splash.isCreated()) {
            if (splash.isFailed()) {
                result.error(ErrorCodes.LOAD_FAILED, "Ad is failed. Load preparation failed. | Ad id : " + id, "");
                HMSLogger.getInstance(context).sendSingleEvent("prepareSplashAd", ErrorCodes.LOAD_FAILED);
            } else {
                result.success(true);
                HMSLogger.getInstance(context).sendSingleEvent("prepareSplashAd");
            }
            return;
        }

        String type = FromMap.toString("adType", call.argument("adType"));
        Map<String, Object> adParam = ToMap.fromObject(call.argument("adParam"));
        Map<String, Object> resources = ToMap.fromObject(call.argument("resources"));
        Integer orientation = FromMap.toInteger("orientation", call.argument("orientation"));
        Integer audioFocusType = FromMap.toInteger("audioFocusType", call.argument("audioFocusType"));
        Double margin = FromMap.toDouble("topMargin", call.argument("topMargin"));

        splash.prepareForLoad(adSlotId, orientation != null ? orientation : ActivityInfo.SCREEN_ORIENTATION_PORTRAIT,
            margin, type, adParam, resources, audioFocusType, result);
    }

    private void loadSplashAd(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("loadSplashAd");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        Splash splash = Splash.get(id);
        if (id == null || splash == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. Load failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("loadSplashAd", ErrorCodes.NULL_PARAM);
            return;
        }

        if (splash.isLoading()) {
            splash.loadAd();
        } else {
            result.error(ErrorCodes.LOAD_FAILED,
                "Ad is either null or not in loading state. Load failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("loadSplashAd", ErrorCodes.LOAD_FAILED);
        }
        result.success(true);
        HMSLogger.getInstance(context).sendSingleEvent("loadSplashAd");
    }

    private void preloadSplashAd(Activity activity, MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("preloadSplashAd");
        String adSlotId = call.argument("adSlotId");
        if (adSlotId == null || adSlotId.isEmpty()) {
            result.error(ErrorCodes.NULL_PARAM, "adSlotId is either null or empty. Preload failed.", "");
            HMSLogger.getInstance(context).sendSingleEvent("preloadSplashAd", ErrorCodes.NULL_PARAM);
            return;
        }

        Map<String, Object> adParam = ToMap.fromObject(call.argument("adParam"));
        Integer orientation = FromMap.toInteger("orientation", call.argument("orientation"));

        Splash.preloadAd(activity, adSlotId,
            orientation != null ? orientation : ActivityInfo.SCREEN_ORIENTATION_PORTRAIT, adParam, result);
        result.success(true);
        HMSLogger.getInstance(context).sendSingleEvent("preloadSplashAd");
    }

    private void getBiddingInfo(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("getBiddingInfo");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        Splash splash = Splash.get(id);
        SplashView splashView = splash == null ? null : splash.getSplashView();
        BiddingInfo biddingInfo = splashView == null ? null : splashView.getBiddingInfo();

        if (biddingInfo == null) {
            HMSLogger.getInstance(context).sendSingleEvent("getBiddingInfo", ErrorCodes.NOT_FOUND);
            result.error(ErrorCodes.NOT_FOUND, "Bidding Info is null", "");
        } else {
            HMSLogger.getInstance(context).sendSingleEvent("getBiddingInfo");
            result.success(ToMap.fromBiddingInfo(biddingInfo));
        }
    }

    private void isAdLoaded(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("isSplashAdLoaded");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        String adType = FromMap.toString("adType", call.argument("adType"));
        Splash splash = Splash.get(id);
        if (id == null || splash == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. isAdLoaded failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("isSplashAdLoaded", ErrorCodes.NOT_FOUND);
            return;
        }

        if (adType != null && adType.equals("Splash")) {
            SplashView adView = splash.getSplashView();
            result.success(adView != null && adView.isLoaded());
            HMSLogger.getInstance(context).sendSingleEvent("isSplashAdLoaded");
        } else {
            result.error(ErrorCodes.INVALID_PARAM, "Ad type parameter is invalid. isAdLoaded failed. | Ad id : " + id,
                "");
            HMSLogger.getInstance(context).sendSingleEvent("isSplashAdLoaded", ErrorCodes.INVALID_PARAM);
        }
    }

    private void destroyAd(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("destroySplashAd");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        Splash splash = Splash.get(id);
        if (id == null || splash == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. Destroy failed. | Ad id : " + id, null);
            HMSLogger.getInstance(context).sendSingleEvent("destroySplashAd", ErrorCodes.NOT_FOUND);
            return;
        }
        EventChannelFactory.dispose(id);
        splash.destroy();
        result.success(true);
        HMSLogger.getInstance(context).sendSingleEvent("destroySplashAd");
    }

    private void isAdLoading(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("isSplashAdLoading");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        String adType = FromMap.toString("adType", call.argument("adType"));
        Splash splash = Splash.get(id);
        if (id == null || splash == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. isAdLoading failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("isSplashAdLoading", ErrorCodes.NOT_FOUND);
            return;
        }

        if (adType != null && adType.equals("Splash")) {
            result.success(splash.getSplashView() != null && splash.getSplashView().isLoading());
            HMSLogger.getInstance(context).sendSingleEvent("isSplashAdLoading");
        } else {
            result.error(ErrorCodes.INVALID_PARAM, "Ad type parameter is invalid. isAdLoading failed. | Ad id : " + id,
                "");
            HMSLogger.getInstance(context).sendSingleEvent("isSplashAdLoading", ErrorCodes.INVALID_PARAM);
        }
    }

    private void pauseAd(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("pauseSplashAd");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        String adType = FromMap.toString("adType", call.argument("adType"));
        Splash splash = Splash.get(id);
        if (id == null || splash == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. Pause failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("pauseSplashAd", ErrorCodes.NOT_FOUND);
            return;
        }

        if (adType != null && adType.equals("Splash")) {
            splash.getSplashView().pauseView();
            result.success(true);
            HMSLogger.getInstance(context).sendSingleEvent("pauseSplashAd");
        } else {
            result.error(ErrorCodes.INVALID_PARAM, "Ad type parameter is invalid. Pause failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("pauseSplashAd", ErrorCodes.INVALID_PARAM);
        }
    }

    private void resumeAd(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("resumeSplashAd");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        String adType = FromMap.toString("adType", call.argument("adType"));
        Splash splash = Splash.get(id);
        if (id == null || splash == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. Resume failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("resumeSplashAd", ErrorCodes.NOT_FOUND);
            return;
        }

        if (adType != null && adType.equals("Splash")) {
            splash.getSplashView().resumeView();
            result.success(true);
            HMSLogger.getInstance(context).sendSingleEvent("resumeSplashAd");
        } else {
            result.error(ErrorCodes.INVALID_PARAM, "Ad type parameter is invalid. Resume failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("resumeSplashAd", ErrorCodes.INVALID_PARAM);
        }
    }
}
