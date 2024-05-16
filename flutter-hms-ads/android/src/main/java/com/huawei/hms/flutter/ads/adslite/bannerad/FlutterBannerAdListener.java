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

import com.huawei.hms.ads.AdListener;
import com.huawei.hms.flutter.ads.logger.HMSLogger;

import java.util.HashMap;

import io.flutter.Log;
import io.flutter.plugin.common.MethodChannel;

public class FlutterBannerAdListener extends AdListener {
    private static final String TAG = "BannerAdListener";
    private final Context context;
    MethodChannel methodChannel;

    FlutterBannerAdListener(Context context, MethodChannel methodChannel){
        this.context = context;
        this.methodChannel = methodChannel;
    }

    @Override
    public void onAdLoaded() {
        HMSLogger.getInstance(context).startMethodExecutionTimer("onBannerAdLoaded");
        Log.i(TAG,"onBannerAdLoaded");
        methodChannel.invokeMethod("onAdLoaded", null, null);
        HMSLogger.getInstance(context).sendSingleEvent("onBannerAdLoaded");
    }

    @Override
    public void onAdFailed(int errorCode) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("onBannerAdFailed");
        Log.i(TAG,"onBannerAdFailed: " + errorCode);
        HashMap<String, Integer> args = new HashMap<>();
        args.put("error_code", errorCode);
        methodChannel.invokeMethod("onAdFailed", args, null);
        HMSLogger.getInstance(context).sendSingleEvent("onBannerAdFailed", String.valueOf(errorCode));
    }

    @Override
    public void onAdOpened() {
        HMSLogger.getInstance(context).startMethodExecutionTimer("onBannerAdOpened");
        Log.i(TAG,"onBannerAdOpened");
        methodChannel.invokeMethod("onAdOpened", null, null);
        HMSLogger.getInstance(context).sendSingleEvent("onBannerAdOpened");
    }

    @Override
    public void onAdClicked() {
        HMSLogger.getInstance(context).startMethodExecutionTimer("onBannerAdClicked");
        Log.i(TAG,"onBannerAdClicked");
        methodChannel.invokeMethod("onAdClicked", null, null);
        HMSLogger.getInstance(context).sendSingleEvent("onBannerAdClicked");
    }

    @Override
    public void onAdLeave() {
        HMSLogger.getInstance(context).startMethodExecutionTimer("onBannerAdLeave");
        Log.i(TAG,"onBannerAdLeave");
        methodChannel.invokeMethod("onAdLeave", null, null);
        HMSLogger.getInstance(context).sendSingleEvent("onBannerAdLeave");
    }

    @Override
    public void onAdClosed() {
        HMSLogger.getInstance(context).startMethodExecutionTimer("onBannerAdClosed");
        Log.i(TAG,"onBannerAdClosed");
        methodChannel.invokeMethod("onAdClosed", null, null);
        HMSLogger.getInstance(context).sendSingleEvent("onBannerAdClosed");
    }
}
