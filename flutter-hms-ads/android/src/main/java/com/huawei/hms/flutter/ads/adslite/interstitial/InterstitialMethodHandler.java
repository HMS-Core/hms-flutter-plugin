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

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ads.adslite.reward.RewardStreamHandler;
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

public class InterstitialMethodHandler implements MethodChannel.MethodCallHandler {
    private final BinaryMessenger messenger;
    private final Activity activity;

    public InterstitialMethodHandler(final BinaryMessenger messenger, final Activity activity) {
        this.messenger = messenger;
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        switch (call.method) {
            case "initInterstitialAd":
                initInterstitialAd(call, result);
                break;
            case "loadInterstitialAd":
                loadInterstitialAd(call, result);
                break;
            case "showInterstitialAd":
                showInterstitialAd(call, result);
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
            default:
                result.notImplemented();
        }
    }

    private void initInterstitialAd(MethodCall call, Result result) {
        Integer id = FromMap.toInteger("id", call.argument("id"));
        Integer rId = FromMap.toInteger("rId", call.argument("rId"));

        if (id == null || rId == null) {
            result.error(ErrorCodes.NULL_PARAM, "Ad id or rId is null. Init failed. | Ad id : " + id, "");
            return;
        }

        EventChannelFactory.create(id, Channels.INTERSTITIAL_EVENT_CHANNEL, messenger);
        EventChannelFactory.setup(id, new InterstitialStreamHandler());

        EventChannelFactory.create(rId, Channels.REWARD_EVENT_CHANNEL, messenger);
        EventChannelFactory.setup(rId, new RewardStreamHandler());

        new Interstitial(id, activity);
        result.success(true);
    }

    private void loadInterstitialAd(MethodCall call, Result result) {
        Integer id = FromMap.toInteger("id", call.argument("id"));
        Interstitial interstitialAd = Interstitial.get(id);

        if (interstitialAd == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. Load failed. | Ad id : " + id, "");
            return;
        }

        if (!interstitialAd.isCreated()) {
            if (interstitialAd.isFailed()) {
                result.error(ErrorCodes.LOAD_FAILED, "Failed ad. Load failed. | Ad id : " + id, "");
            } else {
                result.success(true);
            }
            return;
        }

        String adSlotId = call.argument("adSlotId");
        if (adSlotId == null || adSlotId.isEmpty()) {
            result.error(ErrorCodes.NULL_PARAM, "adSlotId is either null or empty. Load failed. | Ad id : " + id, "");
            return;
        }

        Map<String, Object> adParam = ToMap.fromObject(call.argument("adParam"));
        interstitialAd.loadAd(adSlotId, adParam);
        result.success(true);
    }

    private void showInterstitialAd(MethodCall call, Result result) {
        Integer id = FromMap.toInteger("id", call.argument("id"));
        Interstitial interstitialAd = Interstitial.get(id);
        if (interstitialAd == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. Show failed. | Ad id: " + id, null);
            return;
        }
        interstitialAd.show();
        result.success(true);
    }

    private void isAdLoaded(MethodCall call, Result result) {
        Integer id = FromMap.toInteger("id", call.argument("id"));
        String adType = FromMap.toString("adType", call.argument("adType"));
        Interstitial interstitial = Interstitial.get(id);
        if (id == null || interstitial == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. Load failed. | Ad id : " + id, "");
            return;
        }

        if (adType != null && adType.equals("Interstitial")) {
            result.success(interstitial.isLoaded());
        } else {
            result.error(ErrorCodes.INVALID_PARAM, "Ad type parameter is invalid. isAdLoaded failed. | Ad id : " + id, "");
        }
    }

    private void destroyAd(MethodCall call, Result result) {
        Integer id = FromMap.toInteger("id", call.argument("id"));
        Integer rId = FromMap.toInteger("rId", call.argument("rId"));
        String adType = FromMap.toString("adType", call.argument("adType"));
        Interstitial interstitialAd = Interstitial.get(id);
        if (id == null || rId == null || interstitialAd == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. Destroy failed. | Ad id : " + id, null);
            return;
        }
        if (adType != null && adType.equals("Interstitial")) {
            EventChannelFactory.dispose(id);
            EventChannelFactory.dispose(rId);
            interstitialAd.destroy();
            result.success(true);
        } else {
            result.error(ErrorCodes.INVALID_PARAM, "Ad type parameter is invalid. Destroy failed. | Ad id : " + id, "");
        }
    }

    private void isAdLoading(MethodCall call, Result result) {
        Integer id = FromMap.toInteger("id", call.argument("id"));
        String adType = FromMap.toString("adType", call.argument("adType"));
        Interstitial interstitial = Interstitial.get(id);
        if (id == null || interstitial == null) {
            result.error(ErrorCodes.NULL_PARAM, "Null parameter provided for the method. isAdLoading failed. | Ad id : " + id, "");
            return;
        }

        if (adType != null && adType.equals("Interstitial")) {
            result.success(interstitial.isLoading());
        } else {
            result.error(ErrorCodes.INVALID_PARAM, "Ad type parameter is invalid. isAdLoading failed. | Ad id : " + id, "");
        }
    }
}
