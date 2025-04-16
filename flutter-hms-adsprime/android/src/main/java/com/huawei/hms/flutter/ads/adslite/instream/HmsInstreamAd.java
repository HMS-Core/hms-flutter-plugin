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
import android.content.Intent;
import android.net.Uri;
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.huawei.hms.ads.BiddingInfo;
import com.huawei.hms.ads.instreamad.InstreamAd;
import com.huawei.hms.flutter.ads.logger.HMSLogger;
import com.huawei.hms.flutter.ads.utils.ToMap;
import com.huawei.hms.flutter.ads.utils.constants.Channels;
import com.huawei.hms.flutter.ads.utils.constants.ErrorCodes;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import static androidx.core.content.ContextCompat.startActivity;

public class HmsInstreamAd implements MethodChannel.MethodCallHandler {
    private static SparseArray<HmsInstreamAd> allInstreamAds = new SparseArray<>();

    private static final String TAG = "Instream";

    private InstreamAd instreamAd;

    private Context context;

    private MethodChannel methodChannel;

    HmsInstreamAd(int id, Context context, BinaryMessenger messenger, InstreamAd instreamAd) {
        this.instreamAd = instreamAd;
        this.context = context;
        this.methodChannel = new MethodChannel(messenger, Channels.INSTREAM_METHOD_CHANNEL + "/AD/" + id);
        this.methodChannel.setMethodCallHandler(this);
        allInstreamAds.put(id, this);
    }

    public static InstreamAd getInstreamAd(int id) {
        HmsInstreamAd hmsInstreamAd = allInstreamAds.get(id);
        if (hmsInstreamAd == null) {
            return null;
        }
        return hmsInstreamAd.instreamAd;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer(call.method);
        if (instreamAd == null) {
            result.error(ErrorCodes.NULL_AD, "InstreamAd object is null.", "");
            HMSLogger.getInstance(context).sendSingleEvent(call.method, ErrorCodes.NULL_AD);
            return;
        }
        switch (call.method) {
            case "getAdSource":
                result.success(instreamAd.getAdSource());
                break;
            case "getCallToAction":
                result.success(instreamAd.getCallToAction());
                break;
            case "getDuration":
                result.success(instreamAd.getDuration());
                break;
            case "getWhyThisAd":
                result.success(instreamAd.getWhyThisAd());
                break;
            case "getAdSign":
                result.success(instreamAd.getAdSign());
                break;
            case "isClicked":
                result.success(instreamAd.isClicked());
                break;
            case "isExpired":
                result.success(instreamAd.isExpired());
                break;
            case "isImageAd":
                result.success(instreamAd.isImageAd());
                break;
            case "isShown":
                result.success(instreamAd.isShown());
                break;
            case "isVideoAd":
                result.success(instreamAd.isVideoAd());
                break;
            case "gotoWhyThisAdPage":
                gotoWhyThisAdPage(result);
                break;
            case "isTransparencyOpen":
                result.success(instreamAd.isTransparencyOpen());
                break;
            case "transparencyTplUrl":
                result.success(instreamAd.getTransparencyTplUrl());
                break;
            case "getBiddingInfo":
                HMSLogger.getInstance(context).startMethodExecutionTimer("getBiddingInfo");
                BiddingInfo biddingInfo = instreamAd.getBiddingInfo();
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

    private void gotoWhyThisAdPage(MethodChannel.Result result) {
        String whyThisAdUrl = instreamAd.getWhyThisAd();
        Intent i = new Intent(Intent.ACTION_VIEW, Uri.parse(whyThisAdUrl));
        i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(context, i, null);
        result.success(true);
    }
}
