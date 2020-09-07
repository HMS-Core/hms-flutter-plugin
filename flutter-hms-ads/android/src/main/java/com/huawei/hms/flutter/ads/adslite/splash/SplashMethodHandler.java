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

import android.app.Activity;
import android.content.pm.ActivityInfo;

import androidx.annotation.NonNull;

import com.huawei.hms.ads.splash.SplashView;
import com.huawei.hms.flutter.ads.factory.EventChannelFactory;
import com.huawei.hms.flutter.ads.utils.FromMap;
import com.huawei.hms.flutter.ads.utils.ToMap;
import com.huawei.hms.flutter.ads.utils.constants.Channels;
import com.huawei.hms.flutter.ads.utils.constants.ErrorCodes;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.Result;

public class SplashMethodHandler implements MethodChannel.MethodCallHandler {
    private final BinaryMessenger messenger;
    private final Activity activity;

    public SplashMethodHandler(final BinaryMessenger messenger, final Activity activity) {
        this.messenger = messenger;
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        switch (call.method) {
            case "preloadSplashAd":
                preloadSplashAd(activity, call, result);
                break;
            case "prepareSplashAd":
                prepareSplashAd(activity, call, result);
                break;
            case "loadSplashAd":
                loadSplashAd(call, result);
                break;
            case "destroyAd":
                destroyAd(call, result);
                break;
            case "isAdLoaded":
                isAdLoaded(call, result);
                break;
            case "isAdLoading":
                isAdLoading(call, result);
                break;
            case "pauseAd":
                pauseAd(call, result);
                break;
            case "resumeAd":
                resumeAd(call, result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void prepareSplashAd(Activity activity, MethodCall call, Result result) {
        Integer id = FromMap.toInteger("id", call.argument("id"));
        String adSlotId = call.argument("adSlotId");

        if (id == null) {
            result.error(ErrorCodes.NULL_PARAM, "Ad id is null. Load preparation failed.", "");
            return;
        }

        if (adSlotId == null || adSlotId.isEmpty()) {
            result.error(ErrorCodes.NULL_PARAM, "adSlotId is either null or empty. Load preparation failed. | Ad id : " + id, "");
            return;
        }

        Splash splash = new Splash(id, activity);
        EventChannelFactory.create(id, Channels.SPLASH_EVENT_CHANNEL, messenger);
        EventChannelFactory.setup(id, new SplashStreamHandler());

        if (!splash.isCreated()) {
            if (splash.isFailed()) {
                result.error(ErrorCodes.LOAD_FAILED, "Ad is failed. Load preparation failed. | Ad id : " + id, "");
            } else {
                result.success(true);
            }
            return;
        }

        String type = FromMap.toString("adType", call.argument("adType"));
        Map<String, Object> adParam = ToMap.fromObject(call.argument("adParam"));
        Map<String, Object> resources = ToMap.fromObject(call.argument("resources"));
        Integer orientation = FromMap.toInteger("orientation", call.argument("orientation"));
        Integer audioFocusType = FromMap.toInteger("audioFocusType", call.argument("audioFocusType"));
        Double margin = FromMap.toDouble("topMargin", call.argument("topMargin"));

        splash.prepareForLoad(
            adSlotId,
            orientation != null ? orientation : ActivityInfo.SCREEN_ORIENTATION_PORTRAIT,
            margin,
            type,
            adParam,
            resources,
            audioFocusType,
            result);
    }

    private void loadSplashAd(MethodCall call, Result result) {
        Integer id = FromMap.toInteger("id", call.argument("id"));
        Splash splash = Splash.get(id);
        if (id == null || splash == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. Load failed. | Ad id : " + id, "");
            return;
        }

        if (splash.isLoading()) {
            splash.loadAd();
        } else {
            result.error(ErrorCodes.LOAD_FAILED, "Ad is either null or not in loading state. Load failed. | Ad id : " + id, "");
        }
        result.success(true);
    }

    private void preloadSplashAd(Activity activity, MethodCall call, Result result) {
        String adSlotId = call.argument("adSlotId");
        if (adSlotId == null || adSlotId.isEmpty()) {
            result.error(ErrorCodes.NULL_PARAM, "adSlotId is either null or empty. Preload failed.", "");
            return;
        }

        Map<String, Object> adParam = ToMap.fromObject(call.argument("adParam"));
        Integer orientation = FromMap.toInteger("orientation", call.argument("orientation"));

        Splash.preloadAd(
            activity,
            adSlotId,
            orientation != null ? orientation : ActivityInfo.SCREEN_ORIENTATION_PORTRAIT,
            adParam,
            result);
    }

    private void isAdLoaded(MethodCall call, Result result) {
        Integer id = FromMap.toInteger("id", call.argument("id"));
        String adType = FromMap.toString("adType", call.argument("adType"));
        Splash splash = Splash.get(id);
        if (id == null || splash == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. isAdLoaded failed. | Ad id : " + id, "");
            return;
        }

        if (adType != null && adType.equals("Splash")) {
            SplashView adView = splash.getSplashView();
            result.success(adView != null && adView.isLoaded());
        } else {
            result.error(ErrorCodes.INVALID_PARAM, "Ad type parameter is invalid. isAdLoaded failed. | Ad id : " + id, "");
        }
    }

    private void destroyAd(MethodCall call, Result result) {
        Integer id = FromMap.toInteger("id", call.argument("id"));
        Splash splash = Splash.get(id);
        if (id == null || splash == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. Destroy failed. | Ad id : " + id, null);
            return;
        }
        EventChannelFactory.dispose(id);
        splash.destroy();
        result.success(true);
    }

    private void isAdLoading(MethodCall call, Result result) {
        Integer id = FromMap.toInteger("id", call.argument("id"));
        String adType = FromMap.toString("adType", call.argument("adType"));
        Splash splash = Splash.get(id);
        if (id == null || splash == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. isAdLoading failed. | Ad id : " + id, "");
            return;
        }

        if (adType != null && adType.equals("Splash")) {
            result.success(splash.getSplashView() != null && splash.getSplashView().isLoaded());
        } else {
            result.error(ErrorCodes.INVALID_PARAM, "Ad type parameter is invalid. isAdLoading failed. | Ad id : " + id, "");
        }
    }

    private void pauseAd(MethodCall call, Result result) {
        Integer id = FromMap.toInteger("id", call.argument("id"));
        String adType = FromMap.toString("adType", call.argument("adType"));
        Splash splash = Splash.get(id);
        if (id == null || splash == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. Pause failed. | Ad id : " + id, "");
            return;
        }

        if (adType != null && adType.equals("Splash")) {
            splash.getSplashView().pauseView();
            result.success(true);
        } else {
            result.error(ErrorCodes.INVALID_PARAM, "Ad type parameter is invalid. Pause failed. | Ad id : " + id, "");
        }
    }

    private void resumeAd(MethodCall call, Result result) {
        Integer id = FromMap.toInteger("id", call.argument("id"));
        String adType = FromMap.toString("adType", call.argument("adType"));
        Splash splash = Splash.get(id);
        if (id == null || splash == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. Resume failed. | Ad id : " + id, "");
            return;
        }

        if (adType != null && adType.equals("Splash")) {
            splash.getSplashView().resumeView();
            result.success(true);
        } else {
            result.error(ErrorCodes.INVALID_PARAM, "Ad type parameter is invalid. Resume failed. | Ad id : " + id, "");
        }
    }
}
