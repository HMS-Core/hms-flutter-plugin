/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License")
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/
package com.huawei.hms.flutter.ads.adslite.nativead;

import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.ads.AdListener;
import com.huawei.hms.ads.AdParam;
import com.huawei.hms.ads.nativead.DislikeAdReason;
import com.huawei.hms.ads.nativead.NativeAd;
import com.huawei.hms.ads.nativead.NativeAdConfiguration;
import com.huawei.hms.ads.nativead.NativeAdLoader;
import com.huawei.hms.flutter.ads.factory.AdParamFactory;
import com.huawei.hms.flutter.ads.logger.HMSLogger;
import com.huawei.hms.flutter.ads.utils.FromMap;
import com.huawei.hms.flutter.ads.utils.ToMap;
import com.huawei.hms.flutter.ads.utils.constants.ErrorCodes;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class NativeAdController implements MethodChannel.MethodCallHandler {
    private static final String TAG = "NativeAdController";
    private String id;
    private MethodChannel channel;
    private Context context;

    private NativeAd nativeAd;
    private AdListener adListener;
    private NativeAd.NativeAdLoadedListener nativeAdLoadedListener;
    private NativeAdLoader nativeAdLoader;
    private String adSlotId;
    private Map<String, Object> adParam;

    NativeAdController(String id, MethodChannel channel, Context context) {
        this.id = id;
        this.channel = channel;
        this.context = context;
        channel.setMethodCallHandler(this);
    }

    NativeAd getNativeAd() {
        return nativeAd;
    }

    void setNativeAd(NativeAd nativeAd) {
        this.nativeAd = nativeAd;
    }

    void setAdListener(AdListener adListener) {
        this.adListener = adListener;
    }

    void setNativeAdLoadedListener(NativeAd.NativeAdLoadedListener nativeAdLoadedListener) {
        this.nativeAdLoadedListener = nativeAdLoadedListener;
    }

    @Override
    public void onMethodCall(final MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "setup":
                setupController(call, result);
                break;
            case "dislikeAd":
                dislikeAd(call, result);
                break;
            case "setAllowCustomClick":
                HMSLogger.getInstance(context).startMethodExecutionTimer("setAllowCustomClick");
                nativeAd.setAllowCustomClick();
                result.success(true);
                HMSLogger.getInstance(context).sendSingleEvent("setAllowCustomClick");
                break;
            case "isCustomClickAllowed":
                result.success(nativeAd.isCustomClickAllowed());
                break;
            case "isCustomDislikeThisAdEnable":
                result.success(nativeAd.isCustomDislikeThisAdEnabled());
                break;
            case "triggerClick":
                HMSLogger.getInstance(context).startMethodExecutionTimer("triggerClick");
                nativeAd.triggerClick(FromMap.toBundle(call.arguments));
                result.success(true);
                HMSLogger.getInstance(context).sendSingleEvent("triggerClick");
                break;
            case "recordClickEvent":
                HMSLogger.getInstance(context).startMethodExecutionTimer("recordClickEvent");
                nativeAd.recordClickEvent();
                result.success(true);
                HMSLogger.getInstance(context).sendSingleEvent("recordClickEvent");
                break;
            case "recordImpressionEvent":
                HMSLogger.getInstance(context).startMethodExecutionTimer("recordImpressionEvent");
                nativeAd.recordImpressionEvent(FromMap.toBundle(call.arguments));
                result.success(true);
                HMSLogger.getInstance(context).sendSingleEvent("recordImpressionEvent");
                break;
            case "isLoading":
                result.success(nativeAdLoader.isLoading());
                break;
            case "gotoWhyThisAdPage":
                HMSLogger.getInstance(context).startMethodExecutionTimer("gotoWhyThisAdPage");
                nativeAd.gotoWhyThisAdPage(context);
                result.success(true);
                HMSLogger.getInstance(context).sendSingleEvent("gotoWhyThisAdPage");
                break;
            default:
                onNativeGetterMethodCall(call, result);
        }
    }

    private void onNativeGetterMethodCall(final MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "getAdSource":
                result.success(nativeAd.getAdSource());
                break;
            case "getDescription":
                result.success(nativeAd.getDescription());
                break;
            case "getCallToAction":
                result.success(nativeAd.getCallToAction());
                break;
            case "getDislikeAdReasons":
                getDislikeAdReasons(result);
                break;
            case "getTitle":
                result.success(nativeAd.getTitle());
                break;
            case "getVideoOperator":
                result.success(nativeAd.getVideoOperator() != null);
                break;
            case "getAdSign":
                result.success(nativeAd.getAdSign());
                break;
            case "getWhyThisAd":
                result.success(nativeAd.getWhyThisAd());
                break;
            case "getUniqueId":
                result.success(nativeAd.getUniqueId());
                break;
            default:
                onVideoMethodCall(call, result);
        }
    }

    private void onVideoMethodCall(final MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "getAspectRatio":
                getAspectRatio(result);
                break;
            case "hasVideo":
                HMSLogger.getInstance(context).startMethodExecutionTimer("hasVideo");
                boolean hasVideo = nativeAd.getVideoOperator() != null
                && nativeAd.getVideoOperator().hasVideo();
                result.success(hasVideo);
                HMSLogger.getInstance(context).sendSingleEvent("hasVideo");
                break;
            case "isCustomOperateEnabled":
                HMSLogger.getInstance(context).startMethodExecutionTimer("isCustomOperateEnabled");
                boolean isCustomOperateEnabled = nativeAd.getVideoOperator() != null
                        && nativeAd.getVideoOperator().isCustomizeOperateEnabled();
                        result.success(isCustomOperateEnabled);
                HMSLogger.getInstance(context).sendSingleEvent("isCustomOperateEnabled");
                break;
            case "isMuted":
                HMSLogger.getInstance(context).startMethodExecutionTimer("isMuted");
                boolean isMuted = nativeAd.getVideoOperator() != null
                        && nativeAd.getVideoOperator().isMuted();
                        result.success(isMuted);
                HMSLogger.getInstance(context).sendSingleEvent("isMuted");
                break;
            case "mute":
                mute(call, result);
                break;
            case "pause":
                pause(result);
                break;
            case "play":
                play(result);
                break;
            case "stop":
                stop(result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void getAspectRatio(MethodChannel.Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("getNativeAdAspectRatio");
        if (nativeAd.getVideoOperator() != null) {
            result.success(nativeAd.getVideoOperator().getAspectRatio());
            HMSLogger.getInstance(context).sendSingleEvent("getNativeAdAspectRatio");
        }
    }

    private void dislikeAd(final MethodCall call, MethodChannel.Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("dislikeNativeAd");
        nativeAd.dislikeAd(new DislikeAdListenerImpl(call));
        result.success(true);
        HMSLogger.getInstance(context).sendSingleEvent("dislikeNativeAd");
    }

    private void mute(MethodCall call, MethodChannel.Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("muteNativeAd");
        Boolean mute = FromMap.toBoolean("mute", call.argument("mute"));
        if (nativeAd.getVideoOperator() != null) {
            nativeAd.getVideoOperator().mute(mute);
            result.success(true);
            HMSLogger.getInstance(context).sendSingleEvent("muteNativeAd");
        } else {
            result.error(ErrorCodes.NULL_PARAM, "Video Operator or boolean parameter is null. Mute failed. | isMute : " + mute, "");
            HMSLogger.getInstance(context).sendSingleEvent("muteNativeAd");
        }
    }

    private void pause(MethodChannel.Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("pauseNativeAd");
        if (nativeAd.getVideoOperator() != null) {
            nativeAd.getVideoOperator().pause();
            result.success(true);
            HMSLogger.getInstance(context).sendSingleEvent("pauseNativeAd");
        } else {
            result.error(ErrorCodes.NULL_PARAM, "Video Operator is null. Pause failed.", "");
            HMSLogger.getInstance(context).sendSingleEvent("pauseNativeAd");
        }
    }

    private void play(MethodChannel.Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("playNativeAd");
        if (nativeAd.getVideoOperator() != null) {
            nativeAd.getVideoOperator().play();
            result.success(true);
            HMSLogger.getInstance(context).sendSingleEvent("playNativeAd");
        } else {
            result.error(ErrorCodes.NULL_PARAM, "Video Operator is null. Play failed.", "");
            HMSLogger.getInstance(context).sendSingleEvent("playNativeAd");
        }
    }

    private void stop(MethodChannel.Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("stopNativeAd");
        if (nativeAd.getVideoOperator() != null) {
            nativeAd.getVideoOperator().stop();
            result.success(true);
            HMSLogger.getInstance(context).sendSingleEvent("stopNativeAd");
        } else {
            result.error(ErrorCodes.NULL_PARAM, "Video Operator is null. Stop failed.", "");
            HMSLogger.getInstance(context).sendSingleEvent("stopNativeAd");
        }
    }

    private void setupController(MethodCall call, MethodChannel.Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("setupNativeAdController");
        String slotId = FromMap.toString("adSlotId", call.argument("adSlotId"));
        boolean slotIdChanged = slotId != null && slotId.equals(this.adSlotId);
        Map<String, Object> adParamMap = ToMap.fromObject(call.argument("adParam"));
        Map<String, Object> adConfigurationMap = ToMap.fromObject(call.argument("adConfiguration"));
        if (slotId != null && !slotId.isEmpty()) {
            if (slotIdChanged) {
                adSlotId = slotId;
            }
            if (nativeAdLoader == null || slotIdChanged) {
                NativeAdLoader.Builder builder = new NativeAdLoader.Builder(context, slotId);
                if (nativeAdLoadedListener != null) {
                    builder.setNativeAdLoadedListener(nativeAdLoadedListener);
                }
                if (adListener != null) {
                    builder.setAdListener(adListener);
                }
                nativeAdLoader = builder
                    .setNativeAdOptions(generateNativeAdConfiguration(adConfigurationMap))
                    .build();
                if (nativeAd == null || slotIdChanged) {
                    adParam = adParamMap;
                    loadAd();
                }
            }
            result.success(true);
            HMSLogger.getInstance(context).sendSingleEvent("setupNativeAdController");
        } else {
            result.error(ErrorCodes.NULL_PARAM, "adSlotId is either null or empty. Controller setup failed. | Controller id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("setupNativeAdController");
        }
    }

    private void loadAd() {
        channel.invokeMethod("onAdLoading", null);
        if (nativeAdLoader != null) {
            AdParamFactory factory;
            if (adParam != null) {
                factory = new AdParamFactory(adParam);
            } else {
                factory = new AdParamFactory(new HashMap<String, Object>());
            }

            AdParam param = factory.createAdParam();
            nativeAdLoader.loadAd(param);
        }
    }

    private void getDislikeAdReasons(MethodChannel.Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("getDislikeAdReasons");
        List<DislikeAdReason> reasonsList = nativeAd.getDislikeAdReasons();
        List<String> responseList = new ArrayList<>();
        if (reasonsList != null) {
            for (DislikeAdReason dislikeAdReason : reasonsList) {
                responseList.add(dislikeAdReason.getDescription());
            }
        }
        result.success(responseList);
        HMSLogger.getInstance(context).sendSingleEvent("getDislikeAdReasons");
    }

    private NativeAdConfiguration generateNativeAdConfiguration(Map<String, Object> adConfigurationMap) {
        NativeAdConfigurationFactory adConFactory;
        if (adConfigurationMap != null) {
            adConFactory = new NativeAdConfigurationFactory(adConfigurationMap);
        } else {
            adConFactory = new NativeAdConfigurationFactory(new HashMap<String, Object>());
        }

        return adConFactory.createNativeAdConfiguration();
    }

    static class DislikeAdListenerImpl implements DislikeAdReason {
        MethodCall call;

        DislikeAdListenerImpl(MethodCall call) {
            this.call = call;
        }

        @Override
        public String getDescription() {
            String desc = FromMap.toString("reason", call.argument("reason"));
            if (desc == null) {
                Log.w(TAG, "Reason is null. Returning an empty string as default.");
                return "";
            }
            return desc;
        }
    }
}