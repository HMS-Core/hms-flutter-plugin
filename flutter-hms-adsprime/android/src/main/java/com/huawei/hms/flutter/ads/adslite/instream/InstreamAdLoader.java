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

package com.huawei.hms.flutter.ads.adslite.instream;

import android.content.Context;

import androidx.annotation.NonNull;

import com.huawei.hms.ads.AdParam;
import com.huawei.hms.ads.instreamad.InstreamAd;
import com.huawei.hms.ads.instreamad.InstreamAdLoadListener;
import com.huawei.hms.flutter.ads.factory.AdParamFactory;
import com.huawei.hms.flutter.ads.logger.HMSLogger;
import com.huawei.hms.flutter.ads.utils.ToMap;
import com.huawei.hms.flutter.ads.utils.constants.Channels;
import com.huawei.hms.flutter.ads.utils.constants.ErrorCodes;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class InstreamAdLoader implements MethodChannel.MethodCallHandler {
    final com.huawei.hms.ads.instreamad.InstreamAdLoader adLoader;
    private final BinaryMessenger messenger;
    private final Context context;
    private final MethodChannel methodChannel;

    public InstreamAdLoader(Context context, BinaryMessenger messenger, Integer id, String adId, Integer totalDuration, Integer maxCount) {
        this.messenger = messenger;
        this.context = context;
        this.methodChannel = new MethodChannel(messenger, Channels.INSTREAM_METHOD_CHANNEL + "/LOADER/" + id);
        this.methodChannel.setMethodCallHandler(this);
        com.huawei.hms.ads.instreamad.InstreamAdLoader.Builder builder = new com.huawei.hms.ads.instreamad.InstreamAdLoader.Builder(context, adId);

        if(totalDuration != null){
            builder.setTotalDuration(totalDuration);
        }
        if(maxCount != null){
            builder.setMaxCount(maxCount);
        }
        this.adLoader = builder.setInstreamAdLoadListener(instreamAdLoadListener)
                .build();
    }

    private InstreamAdLoadListener instreamAdLoadListener = new InstreamAdLoadListener() {
        @Override
        public void onAdLoaded(final List<InstreamAd> ads) {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onInstreamAdLoaded");
            ArrayList<Integer> adIds = new ArrayList<>();
            for (InstreamAd ad : ads) {
                adIds.add(ad.hashCode());
                new HmsInstreamAd(ad.hashCode(), context, messenger, ad);
            }
            HashMap<String, Object> args = new HashMap<>();
            args.put("ads", adIds);
            methodChannel.invokeMethod("onAdLoaded", args);
            HMSLogger.getInstance(context).sendSingleEvent("onInstreamAdLoaded");
        }

        @Override
        public void onAdFailed(int errorCode) {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onInstreamAdFailed");
            HashMap<String, Integer> args = new HashMap<>();
            args.put("error_code", errorCode);
            methodChannel.invokeMethod("onAdFailed", args);
            HMSLogger.getInstance(context).sendSingleEvent("onInstreamAdFailed", String.valueOf(errorCode));
        }
    };

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "loadAd":
                loadInstreamAd(call, result);
                break;
            case "isLoading":
                isLoading(call, result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void loadInstreamAd(MethodCall call, MethodChannel.Result result){
        HMSLogger.getInstance(context).startMethodExecutionTimer("loadInstreamAd");
        if(adLoader == null) {
            result.error(ErrorCodes.NOT_READY,"AdLoader is not ready yet.","");
            HMSLogger.getInstance(context).sendSingleEvent("loadInstreamAd", ErrorCodes.NOT_READY);
            return;
        }
        Map<String, Object> adParamMap = ToMap.fromObject(call.argument("adParam"));
        AdParamFactory factory = new AdParamFactory(adParamMap);
        AdParam adParam = factory.createAdParam();
        adLoader.loadAd(adParam);
        result.success(true);
        HMSLogger.getInstance(context).sendSingleEvent("loadInstreamAd");
    }

    private void isLoading(MethodCall call, MethodChannel.Result result){
        HMSLogger.getInstance(context).startMethodExecutionTimer("isInstreamAdLoading");
        if(adLoader == null) {
            result.error(ErrorCodes.NOT_READY,"AdLoader is not ready yet.","");
            HMSLogger.getInstance(context).sendSingleEvent("isInstreamAdLoading", ErrorCodes.NOT_READY);
            return;
        }
        result.success(adLoader.isLoading());
        HMSLogger.getInstance(context).sendSingleEvent("isInstreamAdLoading");
    }
}
