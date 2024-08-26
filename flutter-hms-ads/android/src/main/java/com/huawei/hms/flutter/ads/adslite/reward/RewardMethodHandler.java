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

package com.huawei.hms.flutter.ads.adslite.reward;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;

import com.huawei.hms.ads.BiddingInfo;
import com.huawei.hms.ads.reward.Reward;
import com.huawei.hms.flutter.ads.factory.EventChannelFactory;
import com.huawei.hms.flutter.ads.logger.HMSLogger;
import com.huawei.hms.flutter.ads.utils.FromMap;
import com.huawei.hms.flutter.ads.utils.ToMap;
import com.huawei.hms.flutter.ads.utils.constants.Channels;
import com.huawei.hms.flutter.ads.utils.constants.ErrorCodes;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.Result;

public class RewardMethodHandler implements MethodChannel.MethodCallHandler {
    private final BinaryMessenger messenger;

    private final Activity activity;

    private final Context context;

    public RewardMethodHandler(BinaryMessenger messenger, Activity activity, Context context) {
        this.messenger = messenger;
        this.activity = activity;
        this.context = context;
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        switch (call.method) {
            case "initRewardAd":
                initRewardAd(call, result);
                break;
            case "loadRewardAd":
                loadRewardAd(call, result);
                break;
            case "showRewardAd":
                showRewardAd(call, result);
                break;
            case "getRewardAdReward":
                getRewardAdReward(call, result);
                break;
            case "isAdLoaded":
                isAdLoaded(call, result);
                break;
            case "pauseAd":
                pauseAd(call, result);
                break;
            case "resumeAd":
                resumeAd(call, result);
                break;
            case "destroyAd":
                destroyAd(call, result);
                break;
            case "getBiddingInfo":
                getBiddingInfo(call, result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void initRewardAd(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("initRewardAd");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        boolean openInHmsCore = FromMap.toBoolean("openInHmsCore", call.argument("openInHmsCore"));

        if (id == null) {
            result.error(ErrorCodes.NULL_PARAM, "Ad id is null. Reward ad init failed.", "");
            HMSLogger.getInstance(context).sendSingleEvent("initRewardAd", ErrorCodes.NULL_PARAM);
            return;
        }

        EventChannelFactory.create(id, Channels.REWARD_EVENT_CHANNEL, messenger);
        EventChannelFactory.setup(id, new RewardStreamHandler(context));
        result.success(true);

        new HmsRewardAd(id, openInHmsCore, activity, context);
        HMSLogger.getInstance(context).sendSingleEvent("initRewardAd");
    }

    private void getBiddingInfo(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("getBiddingInfo");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        HmsRewardAd hmsRewardAd = HmsRewardAd.get(id);
        BiddingInfo biddingInfo = hmsRewardAd == null ? null : hmsRewardAd.getBiddingInfo();
        if (biddingInfo == null) {
            HMSLogger.getInstance(context).sendSingleEvent("getBiddingInfo", ErrorCodes.NOT_FOUND);
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id", "");
        } else {
            HMSLogger.getInstance(context).sendSingleEvent("getBiddingInfo");
            result.success(ToMap.fromBiddingInfo(biddingInfo));
        }
    }

    private void loadRewardAd(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("loadRewardAd");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        HmsRewardAd hmsRewardAd = HmsRewardAd.get(id);
        if (hmsRewardAd == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. Load failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("loadRewardAd", ErrorCodes.NOT_FOUND);
            return;
        }

        if (!hmsRewardAd.isCreated() && !hmsRewardAd.isFailed()) {
            result.success(true);
            return;
        }

        String adSlotId = call.argument("adSlotId");
        if (adSlotId == null || adSlotId.isEmpty()) {
            result.error(ErrorCodes.NULL_PARAM, "adSlotId is either null or empty. Load failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("loadRewardAd", ErrorCodes.NULL_PARAM);
            return;
        }

        Map<String, Object> adParam = ToMap.fromObject(call.argument("adParam"));
        if (call.argument("adParam") == null) {
            result.error(ErrorCodes.NULL_PARAM, "Ad param is null. Load failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("loadRewardAd", ErrorCodes.NULL_PARAM);
            return;
        }

        String userId = FromMap.toString("userId", call.argument("userId"));
        if (userId != null) {
            hmsRewardAd.setUserId(userId);
        }

        String data = FromMap.toString("data", call.argument("data"));
        if (data != null) {
            hmsRewardAd.setData(data);
        }

        Map<String, Object> rewardVerifyConfig = ToMap.fromObject(call.argument("rewardVerifyConfig"));
        if (!rewardVerifyConfig.isEmpty()) {
            hmsRewardAd.setRewardVerifyConfig(rewardVerifyConfig);
        }

        boolean setMobileDataAlertSwitch = FromMap.toBoolean("setMobileDataAlertSwitch",
            call.argument("setMobileDataAlertSwitch"));
        hmsRewardAd.setMobileDataAlertSwitch(setMobileDataAlertSwitch);

        hmsRewardAd.loadAd(adSlotId, adParam);
        result.success(true);
        HMSLogger.getInstance(context).sendSingleEvent("loadRewardAd");
    }

    private void showRewardAd(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("showRewardAd");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        HmsRewardAd hmsRewardAd = HmsRewardAd.get(id);
        if (hmsRewardAd == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. Show failed. | Ad id : " + id, null);
            HMSLogger.getInstance(context).sendSingleEvent("showRewardAd", ErrorCodes.NOT_FOUND);
            return;
        }
        hmsRewardAd.show();
        result.success(true);
        HMSLogger.getInstance(context).sendSingleEvent("showRewardAd");
    }

    private void getRewardAdReward(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("getRewardAdReward");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        HmsRewardAd hmsRewardAd = HmsRewardAd.get(id);
        if (hmsRewardAd != null) {
            Reward reward = hmsRewardAd.getReward();
            Map<String, Object> arguments = new HashMap<>();
            arguments.put("name", reward.getName());
            arguments.put("amount", reward.getAmount());
            result.success(arguments);
            HMSLogger.getInstance(context).sendSingleEvent("getRewardAdReward");
        } else {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. getReward failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("getRewardAdReward", ErrorCodes.NOT_FOUND);
        }
    }

    private void isAdLoaded(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("isRewardAdLoaded");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        HmsRewardAd hmsRewardAd = HmsRewardAd.get(id);
        String adType = FromMap.toString("adType", call.argument("adType"));

        if (hmsRewardAd == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. isAdLoaded failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("isRewardAdLoaded", ErrorCodes.NOT_FOUND);
            return;
        }

        if (adType != null && adType.equals("Reward")) {
            result.success(hmsRewardAd.isLoaded());
            HMSLogger.getInstance(context).sendSingleEvent("isRewardAdLoaded");
        } else {
            result.error(ErrorCodes.NULL_PARAM, "Ad type parameter is invalid. isAdLoaded failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("isRewardAdLoaded", ErrorCodes.NULL_PARAM);
        }

    }

    private void pauseAd(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("pauseRewardAd");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        HmsRewardAd hmsRewardAd = HmsRewardAd.get(id);
        String adType = FromMap.toString("adType", call.argument("adType"));

        if (hmsRewardAd == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. Pause failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("pauseRewardAd", ErrorCodes.NOT_FOUND);
            return;
        }

        if (adType != null && adType.equals("Reward")) {
            hmsRewardAd.pause();
            result.success(true);
            HMSLogger.getInstance(context).sendSingleEvent("pauseRewardAd");
        } else {
            result.error(ErrorCodes.INVALID_PARAM, "Ad type parameter is invalid. Pause failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("pauseRewardAd", ErrorCodes.INVALID_PARAM);
        }
    }

    private void resumeAd(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("resumeRewardAd");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        HmsRewardAd hmsRewardAd = HmsRewardAd.get(id);
        String adType = FromMap.toString("adType", call.argument("adType"));

        if (hmsRewardAd == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. Resume failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("resumeRewardAd", ErrorCodes.NOT_FOUND);
            return;
        }

        if (adType != null && adType.equals("Reward")) {
            hmsRewardAd.resume();
            result.success(true);
            HMSLogger.getInstance(context).sendSingleEvent("resumeRewardAd");
        } else {
            result.error(ErrorCodes.INVALID_PARAM, "Ad type parameter is invalid. Resume failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("resumeRewardAd", ErrorCodes.INVALID_PARAM);
        }
    }

    private void destroyAd(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("destroyRewardAd");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        HmsRewardAd hmsRewardAd = HmsRewardAd.get(id);
        String adType = FromMap.toString("adType", call.argument("adType"));

        if (id == null || hmsRewardAd == null) {
            result.error(ErrorCodes.NOT_FOUND, "No ad for given id. Destroy failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("destroyRewardAd", ErrorCodes.NOT_FOUND);
            return;
        }

        if (adType != null && adType.equals("Reward")) {
            EventChannelFactory.dispose(id);
            hmsRewardAd.destroy();
            result.success(true);
            HMSLogger.getInstance(context).sendSingleEvent("destroyRewardAd");
        } else {
            result.error(ErrorCodes.INVALID_PARAM, "Ad type parameter is invalid. Destroy failed. | Ad id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("destroyRewardAd", ErrorCodes.INVALID_PARAM);
        }
    }
}
