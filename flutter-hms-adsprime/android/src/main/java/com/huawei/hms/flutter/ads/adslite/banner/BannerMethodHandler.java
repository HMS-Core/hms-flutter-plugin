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

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;

import com.huawei.hms.ads.BannerAdSize;
import com.huawei.hms.ads.BiddingInfo;
import com.huawei.hms.flutter.ads.factory.EventChannelFactory;
import com.huawei.hms.flutter.ads.logger.HMSLogger;
import com.huawei.hms.flutter.ads.utils.FromMap;
import com.huawei.hms.flutter.ads.utils.ToMap;
import com.huawei.hms.flutter.ads.utils.constants.AdGravity;
import com.huawei.hms.flutter.ads.utils.constants.Channels;
import com.huawei.hms.flutter.ads.utils.constants.ErrorCodes;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.Result;

public class BannerMethodHandler implements MethodChannel.MethodCallHandler {
    private final BinaryMessenger messenger;

    private final Activity activity;

    private final Context context;

    public BannerMethodHandler(final BinaryMessenger messenger, final Activity activity, final Context context) {
        this.messenger = messenger;
        this.activity = activity;
        this.context = context;
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        switch (call.method) {
            case "initBannerAd":
                initBannerAd(activity, call, result);
                break;
            case "loadBannerAd":
                loadBannerAd(call, result);
                break;
            case "showBannerAd":
                showBannerAd(call, result);
                break;
            case "destroyAd":
                destroyAd(call, result);
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
            case "getBiddingInfo":
                getBiddingInfo(call, result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void initBannerAd(Activity activity, MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("initBannerAd");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        final Integer width = FromMap.toInteger("width", call.argument("width"));
        final Integer height = FromMap.toInteger("height", call.argument("height"));
        final Long bannerRefresh = FromMap.toLong("refreshTime", call.argument("refreshTime"));

        if (id == null) {
            result.error(ErrorCodes.NULL_PARAM, "Ad id is null. Init failed.", "");
            HMSLogger.getInstance(context).sendSingleEvent("initBannerAd", ErrorCodes.NULL_PARAM);
            return;
        }

        if ((width == null || height == null) || (width == 0 || height == 0)) {
            result.error(ErrorCodes.INVALID_PARAM, "BannerAdSize is invalid. Init failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("initBannerAd", ErrorCodes.INVALID_PARAM);
            return;
        }

        EventChannelFactory.create(id, Channels.BANNER_EVENT_CHANNEL, messenger);
        EventChannelFactory.setup(id, new BannerStreamHandler(context));

        BannerAdSize adSize;
        if (width == BannerAdSize.BANNER_SIZE_SMART.getWidth()
            && height == BannerAdSize.BANNER_SIZE_SMART.getHeight()) {
            adSize = BannerAdSize.BANNER_SIZE_SMART;
        } else if (width == BannerAdSize.BANNER_SIZE_DYNAMIC.getWidth()
            && height == BannerAdSize.BANNER_SIZE_DYNAMIC.getHeight()) {
            adSize = BannerAdSize.BANNER_SIZE_DYNAMIC;
        } else if (width == BannerAdSize.BANNER_SIZE_ADVANCED.getWidth()
            && height == BannerAdSize.BANNER_SIZE_ADVANCED.getHeight()) {
            adSize = BannerAdSize.BANNER_SIZE_ADVANCED;
        } else {
            adSize = new BannerAdSize(width, height);
        }

        new Banner(id, adSize, bannerRefresh, activity);
        result.success(true);
        HMSLogger.getInstance(context).sendSingleEvent("initBannerAd");
    }

    private void loadBannerAd(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("loadBannerAd");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        String adSlotId = call.argument("adSlotId");
        if (adSlotId == null || adSlotId.isEmpty()) {
            result.error(ErrorCodes.NULL_PARAM, "adSlotId is either null or empty. Load failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("loadBannerAd", ErrorCodes.NULL_PARAM);
            return;
        }

        Banner banner = Banner.get(id);
        if (banner == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. Load failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("loadBannerAd", ErrorCodes.NOT_FOUND);
            return;
        }

        if (!banner.isCreated()) {
            if (banner.isFailed()) {
                result.error(ErrorCodes.LOAD_FAILED, "Failed ad. Load failed. | Ad id : " + id, "");
                HMSLogger.getInstance(context).sendSingleEvent("loadBannerAd", ErrorCodes.LOAD_FAILED);
            } else {
                result.success(true);
                HMSLogger.getInstance(context).sendSingleEvent("loadBannerAd");
            }
            return;
        }

        Map<String, Object> adParam = ToMap.fromObject(call.argument("adParam"));
        banner.loadAd(adSlotId, adParam);
        result.success(true);
        HMSLogger.getInstance(context).sendSingleEvent("loadBannerAd");
    }

    private void getBiddingInfo(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("getBiddingInfo");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        Banner bannerAd = Banner.get(id);

        BiddingInfo biddingInfo = bannerAd != null ? bannerAd.getBannerView().getBiddingInfo() : null;
        if (biddingInfo == null) {
            result.error(ErrorCodes.NOT_FOUND, "Bidding Info is null", "");
            HMSLogger.getInstance(context).sendSingleEvent("getBiddingInfo", ErrorCodes.NOT_FOUND);
        } else {
            HMSLogger.getInstance(context).sendSingleEvent("getBiddingInfo");
            result.success(ToMap.fromBiddingInfo(biddingInfo));
        }
    }

    private void showBannerAd(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("showBannerAd");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        Banner bannerAd = Banner.get(id);
        if (bannerAd == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. Show failed. | Ad id: " + id, null);
            HMSLogger.getInstance(context).sendSingleEvent("showBannerAd", ErrorCodes.NOT_FOUND);
            return;
        }
        String offset = FromMap.toString("offset", call.argument("offset"));
        String gravity = FromMap.toString("gravity", call.argument("gravity"));
        if (offset != null) {
            bannerAd.setOffset(Double.parseDouble(offset));
        }
        if (gravity != null) {
            bannerAd.setGravity(AdGravity.valueOf(gravity).getValue());
        }
        bannerAd.show();
        result.success(true);
        HMSLogger.getInstance(context).sendSingleEvent("showBannerAd");
    }

    private void destroyAd(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("destroyBannerAd");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        Banner banner = Banner.get(id);
        if (id == null || banner == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. Destroy failed. | Ad id : " + id, null);
            HMSLogger.getInstance(context).sendSingleEvent("destroyBannerAd", ErrorCodes.NOT_FOUND);
            return;
        }
        EventChannelFactory.dispose(id);
        banner.destroy();
        result.success(true);
        HMSLogger.getInstance(context).sendSingleEvent("destroyBannerAd");
    }

    private void isAdLoading(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("isBannerAdLoading");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        String adType = FromMap.toString("adType", call.argument("adType"));
        Banner banner = Banner.get(id);
        if (id == null || banner == null) {
            result.error(ErrorCodes.NULL_PARAM,
                "Null parameter provided for the method. isAdLoading failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("isBannerAdLoading", ErrorCodes.NULL_PARAM);
            return;
        }

        if (adType != null && adType.equals("Banner")) {
            result.success(banner.isLoading());
            HMSLogger.getInstance(context).sendSingleEvent("isBannerAdLoading");
        } else {
            result.error(ErrorCodes.INVALID_PARAM, "Ad type parameter is invalid. isAdLoading failed. | Ad id : " + id,
                "");
            HMSLogger.getInstance(context).sendSingleEvent("isBannerAdLoading", ErrorCodes.INVALID_PARAM);
        }
    }

    private void pauseAd(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("pauseBannerAd");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        String adType = FromMap.toString("adType", call.argument("adType"));
        Banner banner = Banner.get(id);
        if (id == null || banner == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. Pause failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("pauseBannerAd", ErrorCodes.NULL_PARAM);
            return;
        }

        if (adType != null && adType.equals("Banner")) {
            banner.getBannerView().pause();
            result.success(true);
            HMSLogger.getInstance(context).sendSingleEvent("pauseBannerAd");
        } else {
            result.error(ErrorCodes.INVALID_PARAM, "Ad type parameter is invalid. Pause failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("pauseBannerAd", ErrorCodes.INVALID_PARAM);
        }
    }

    private void resumeAd(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("resumeBannerAd");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        String adType = FromMap.toString("adType", call.argument("adType"));
        Banner banner = Banner.get(id);

        if (id == null || banner == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. Resume failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("resumeBannerAd", ErrorCodes.NULL_PARAM);
            return;
        }

        if (adType != null && adType.equals("Banner")) {
            banner.getBannerView().resume();
            result.success(true);
            HMSLogger.getInstance(context).sendSingleEvent("resumeBannerAd");
        } else {
            result.error(ErrorCodes.INVALID_PARAM, "Ad type parameter is invalid. Pause failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("resumeBannerAd", ErrorCodes.INVALID_PARAM);
        }
    }
}
