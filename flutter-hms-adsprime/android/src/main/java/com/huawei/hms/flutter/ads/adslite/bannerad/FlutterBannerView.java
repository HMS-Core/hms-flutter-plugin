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

package com.huawei.hms.flutter.ads.adslite.bannerad;

import android.content.Context;
import android.graphics.Color;
import android.view.View;

import com.huawei.hms.ads.AdParam;
import com.huawei.hms.ads.BannerAdSize;
import com.huawei.hms.ads.BiddingInfo;
import com.huawei.hms.ads.banner.BannerView;
import com.huawei.hms.flutter.ads.factory.AdParamFactory;
import com.huawei.hms.flutter.ads.logger.HMSLogger;
import com.huawei.hms.flutter.ads.utils.FromMap;
import com.huawei.hms.flutter.ads.utils.ToMap;
import com.huawei.hms.flutter.ads.utils.constants.ErrorCodes;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

import static com.huawei.hms.flutter.ads.utils.constants.ViewTypes.BANNER_VIEW;
import static io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import static io.flutter.plugin.common.MethodChannel.Result;

public class FlutterBannerView implements PlatformView, MethodCallHandler {
    private final MethodChannel methodChannel;

    private BannerView bannerView;

    private Map<String, Object> adParamMap;

    private final Context context;

    FlutterBannerView(Context context, BinaryMessenger messenger, int id, HashMap<String, Object> creationParams) {
        this.context = context;
        methodChannel = new MethodChannel(messenger, BANNER_VIEW + "_" + id);
        methodChannel.setMethodCallHandler(this);

        FlutterBannerAdListener adListener = new FlutterBannerAdListener(context, methodChannel);

        String adId = FromMap.toString("adSlotId", creationParams.get("adSlotId"));
        BannerAdSize bannerAdSize = getBannerAdSize(FromMap.toString("bannerSize", creationParams.get("bannerSize")));
        String color = FromMap.toString("backgroundColor", creationParams.get("backgroundColor"));
        Integer refreshTime = FromMap.toInteger("refreshTime", creationParams.get("refreshTime"));
        boolean loadOnStart = FromMap.toBoolean("loadOnStart", creationParams.get("loadOnStart"));
        adParamMap = ToMap.fromObject(creationParams.get("adParam"));

        bannerView = new BannerView(context);
        bannerView.setAdListener(adListener);
        bannerView.setVisibility(View.VISIBLE);
        bannerView.setAdId(adId);
        bannerView.setBannerAdSize(bannerAdSize);
        if (refreshTime != null) {
            bannerView.setBannerRefresh(refreshTime);
        }
        if (color != null) {
            bannerView.setBackgroundColor(Color.parseColor(color));
        }
        if (loadOnStart) {
            loadAd();
        }
    }

    private BannerAdSize getBannerAdSize(String adSizeText) {
        switch (adSizeText) {
            case "size_320_100":
                return BannerAdSize.BANNER_SIZE_320_100;
            case "size_300_250":
                return BannerAdSize.BANNER_SIZE_300_250;
            case "size_360_57":
                return BannerAdSize.BANNER_SIZE_360_57;
            case "size_160_600":
                return BannerAdSize.BANNER_SIZE_160_600;
            case "size_468_60":
                return BannerAdSize.BANNER_SIZE_468_60;
            case "size_360_144":
                return BannerAdSize.BANNER_SIZE_360_144;
            case "size_728_90":
                return BannerAdSize.BANNER_SIZE_728_90;
            case "size_advanced":
                return BannerAdSize.BANNER_SIZE_ADVANCED;
            case "size_smart":
                return BannerAdSize.BANNER_SIZE_SMART;
            case "size_dynamic":
                return BannerAdSize.BANNER_SIZE_DYNAMIC;
            case "size_invalid":
                return BannerAdSize.BANNER_SIZE_INVALID;
            default:
                return BannerAdSize.BANNER_SIZE_320_50;
        }
    }

    private void loadAd() {
        if (bannerView == null) {
            return;
        }
        AdParamFactory factory = new AdParamFactory(adParamMap);
        AdParam adParam = factory.createAdParam();
        bannerView.loadAd(adParam);
    }

    @Override
    public View getView() {
        return bannerView;
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer(call.method);
        if (bannerView == null) {
            result.error(ErrorCodes.NULL_VIEW, "BannerView isn't created yet.", "");
            HMSLogger.getInstance(context).sendSingleEvent(call.method, ErrorCodes.NULL_VIEW);
            return;
        }
        switch (call.method) {
            case "pause":
                bannerView.pause();
                result.success(true);
                break;
            case "resume":
                bannerView.resume();
                result.success(true);
                break;
            case "loadAd":
                loadAd();
                result.success(true);
                break;
            case "isLoading":
                result.success(bannerView.isLoading());
                break;
            case "getBiddingInfo":
                HMSLogger.getInstance(context).startMethodExecutionTimer("getBiddingInfo");
                BiddingInfo biddingInfo = bannerView.getBiddingInfo();
                if (biddingInfo == null) {
                    HMSLogger.getInstance(context).sendSingleEvent("getBiddingInfo", "-1");
                    result.error("-1", "BiddingInfo is null.", "");
                } else {
                    HMSLogger.getInstance(context).sendSingleEvent("getBiddingInfo");
                    result.success(ToMap.fromBiddingInfo(biddingInfo));
                }
                break;
            default:
                result.notImplemented();
        }
        HMSLogger.getInstance(context).sendSingleEvent(call.method);
    }

    @Override
    public void dispose() {
        if (bannerView == null) {
            return;
        }
        bannerView.destroy();
    }
}