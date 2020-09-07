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
package com.huawei.hms.flutter.ads;

import android.app.Activity;
import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.ads.BannerAdSize;
import com.huawei.hms.ads.HwAds;
import com.huawei.hms.ads.RequestOptions;
import com.huawei.hms.ads.consent.inter.Consent;
import com.huawei.hms.ads.identifier.AdIdVerifyException;
import com.huawei.hms.ads.identifier.AdvertisingIdClient;
import com.huawei.hms.flutter.ads.adslite.banner.Banner;
import com.huawei.hms.flutter.ads.adslite.banner.BannerMethodHandler;
import com.huawei.hms.flutter.ads.adslite.interstitial.InterstitialMethodHandler;
import com.huawei.hms.flutter.ads.adslite.nativead.NativeAdStreamHandler;
import com.huawei.hms.flutter.ads.adslite.reward.HmsRewardAd;
import com.huawei.hms.flutter.ads.adslite.interstitial.Interstitial;
import com.huawei.hms.flutter.ads.adslite.reward.RewardMethodHandler;
import com.huawei.hms.flutter.ads.adslite.splash.Splash;
import com.huawei.hms.flutter.ads.adslite.nativead.NativeAdControllerFactory;
import com.huawei.hms.flutter.ads.adslite.nativead.NativeAdPlatformViewFactory;
import com.huawei.hms.flutter.ads.adslite.splash.SplashMethodHandler;
import com.huawei.hms.flutter.ads.consent.ConsentMethodHandler;
import com.huawei.hms.flutter.ads.consent.ConsentStreamHandler;
import com.huawei.hms.flutter.ads.factory.EventChannelFactory;
import com.huawei.hms.flutter.ads.installreferrer.HmsInstallReferrer;
import com.huawei.hms.flutter.ads.installreferrer.InstallReferrerMethodHandler;
import com.huawei.hms.flutter.ads.utils.FromMap;
import com.huawei.hms.flutter.ads.utils.ToMap;
import com.huawei.hms.flutter.ads.utils.constants.Channels;
import com.huawei.hms.flutter.ads.utils.constants.ErrorCodes;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.platform.PlatformViewRegistry;

import static com.huawei.hms.flutter.ads.utils.constants.ViewTypes.NATIVE_VIEW;

/**
 * Hms Ads Plugin
 *
 * @author Huawei Technologies
 * @since (13.4.32)
 */
public class HmsAdsPlugin implements FlutterPlugin, ActivityAware, MethodCallHandler {
    private static final String TAG = "HUAWEI_ADS_PLUGIN";
    private Activity activity;
    private Context context;
    private MethodChannel methodChannel;
    private BinaryMessenger messenger;
    private FlutterPluginBinding flutterPluginBinding;
    private Consent consentInfo;

    private EventChannel consentEventChannel;
    private MethodChannel splashMethodChannel;
    private MethodChannel bannerMethodChannel;
    private MethodChannel rewardMethodChannel;
    private MethodChannel interstitialMethodChannel;
    private MethodChannel referrerMethodChannel;
    private MethodChannel consentMethodChannel;

    private SplashMethodHandler splashMethodHandler;
    private BannerMethodHandler bannerMethodHandler;
    private RewardMethodHandler rewardMethodHandler;
    private InterstitialMethodHandler interstitialMethodHandler;
    private InstallReferrerMethodHandler installReferrerMethodHandler;
    private ConsentMethodHandler consentMethodHandler;
    private EventChannel.StreamHandler consentStreamHandler;

    public static void registerWith(Registrar registrar) {
        final HmsAdsPlugin instance = new HmsAdsPlugin();
        final MethodChannel channel = new MethodChannel(registrar.messenger(), Channels.LIBRARY_METHOD_CHANNEL);
        registrar.publish(instance);
        instance.onAttachedToEngine(registrar.platformViewRegistry(), channel, registrar.context(), registrar.messenger(), registrar.activity());
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        this.flutterPluginBinding = flutterPluginBinding;
    }

    private void onAttachedToEngine(PlatformViewRegistry registry, MethodChannel channel, Context applicationContext, BinaryMessenger messenger, Activity activity) {
        registry.registerViewFactory(NATIVE_VIEW, new NativeAdPlatformViewFactory(activity));
        this.activity = activity;
        this.context = applicationContext;
        this.methodChannel = channel;
        this.messenger = messenger;
        this.methodChannel.setMethodCallHandler(this);
        this.consentInfo = Consent.getInstance(activity);
        initAdChannels(messenger);
        initAdHandlers();
        setAdHandlers();
    }

    private void initAdChannels(final BinaryMessenger messenger) {
        splashMethodChannel = new MethodChannel(messenger, Channels.SPLASH_METHOD_CHANNEL);
        bannerMethodChannel = new MethodChannel(messenger, Channels.BANNER_METHOD_CHANNEL);
        rewardMethodChannel = new MethodChannel(messenger, Channels.REWARD_METHOD_CHANNEL);
        interstitialMethodChannel = new MethodChannel(messenger, Channels.INTERSTITIAL_METHOD_CHANNEL);
        referrerMethodChannel = new MethodChannel(messenger, Channels.REFERRER_METHOD_CHANNEL);
        consentMethodChannel = new MethodChannel(messenger, Channels.CONSENT_METHOD_CHANNEL);
        consentEventChannel = new EventChannel(messenger, Channels.CONSENT_EVENT_CHANNEL);
    }

    private void initAdHandlers() {
        splashMethodHandler = new SplashMethodHandler(messenger, activity);
        bannerMethodHandler = new BannerMethodHandler(messenger, activity);
        rewardMethodHandler = new RewardMethodHandler(messenger, activity);
        interstitialMethodHandler = new InterstitialMethodHandler(messenger, activity);
        installReferrerMethodHandler = new InstallReferrerMethodHandler(activity, referrerMethodChannel);
        consentMethodHandler = new ConsentMethodHandler(context, consentInfo);
        consentStreamHandler = new ConsentStreamHandler(consentInfo);
    }

    private void setAdHandlers() {
        splashMethodChannel.setMethodCallHandler(splashMethodHandler);
        bannerMethodChannel.setMethodCallHandler(bannerMethodHandler);
        rewardMethodChannel.setMethodCallHandler(rewardMethodHandler);
        interstitialMethodChannel.setMethodCallHandler(interstitialMethodHandler);
        referrerMethodChannel.setMethodCallHandler(installReferrerMethodHandler);
        consentMethodChannel.setMethodCallHandler(consentMethodHandler);
        consentEventChannel.setStreamHandler(consentStreamHandler);
    }

    private void resetAdHandlers() {
        splashMethodChannel.setMethodCallHandler(null);
        bannerMethodChannel.setMethodCallHandler(null);
        rewardMethodChannel.setMethodCallHandler(null);
        interstitialMethodChannel.setMethodCallHandler(null);
        referrerMethodChannel.setMethodCallHandler(null);
        consentMethodChannel.setMethodCallHandler(null);
        consentEventChannel.setStreamHandler(null);
    }

    private void removeAdHandlers() {
        splashMethodHandler = null;
        bannerMethodHandler = null;
        rewardMethodHandler = null;
        interstitialMethodHandler = null;
        installReferrerMethodHandler = null;
        consentMethodHandler = null;
        consentStreamHandler = null;
    }

    private void removeAdChannels() {
        splashMethodChannel = null;
        bannerMethodChannel = null;
        rewardMethodChannel = null;
        interstitialMethodChannel = null;
        referrerMethodChannel = null;
        consentMethodChannel = null;
        consentEventChannel = null;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "bannerSize-getHeightPx":
                getHeightPx(call, result);
                break;
            case "bannerSize-getWidthPx":
                getWidthPx(call, result);
                break;
            case "getCurrentDirectionBannerSize":
                getCurrentDirectionBannerSize(call, result);
                break;
            case "getLandscapeBannerSize":
                getLandScapeBannerSize(call, result);
                break;
            case "getPortraitBannerSize":
                getPortraitBannerSize(call, result);
                break;
            // HWAds Methods
            case "HwAds-init":
                adsInit(result);
                break;
            case "HwAds-initWithAppCode":
                adsInitWithAppCode(call, result);
                break;
            case "HwAds-getSdkVersion":
                result.success(HwAds.getSDKVersion());
                break;
            case "HwAds-getRequestOptions":
                getRequestOptions(result);
                break;
            case "HwAds-setRequestOptions":
                setRequestOptions(call, result);
                break;
            // AdvertisingId METHODS
            case "getAdvertisingIdInfo":
                getAdvertisingIdInfo(result);
                break;
            case "verifyAdId":
                verifyAdId(call, result);
                break;
            case "initNativeAdController":
                initNativeAdController(call, result);
                break;
            case "destroyNativeAdController":
                destroyNativeAdController(call, result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void getHeightPx(MethodCall call, Result result) {
        Integer width;
        Integer height;
        width = FromMap.toInteger("width", call.argument("width"));
        height = FromMap.toInteger("height", call.argument("height"));
        if (width != null && height != null) {
            result.success(new BannerAdSize(width, height).getHeightPx(activity));
        } else {
            result.error(ErrorCodes.NULL_PARAM, "Null parameter provided for the method. getHeightPx failed.", "");
        }
    }

    private void getWidthPx(MethodCall call, Result result) {
        Integer width;
        Integer height;
        width = FromMap.toInteger("width", call.argument("width"));
        height = FromMap.toInteger("height", call.argument("height"));
        if (width != null && height != null) {
            result.success(new BannerAdSize(width, height).getWidthPx(activity));
        } else {
            result.error(ErrorCodes.NULL_PARAM, "Null parameter provided for the method. getWidthPx failed.", "");
        }
    }

    private void getCurrentDirectionBannerSize(MethodCall call, Result result) {
        Integer width;
        width = FromMap.toInteger("width", call.argument("width"));
        if (width != null) {
            BannerAdSize bannerAdSize = BannerAdSize.getCurrentDirectionBannerSize(activity, width);
            result.success(ToMap.fromArgs("width", bannerAdSize.getWidth(), "height", bannerAdSize.getHeight()));
        } else {
            result.error(ErrorCodes.NULL_PARAM, "Null parameter provided for the method. getCurrentDirectionBannerSize failed.", "");
        }
    }

    private void getLandScapeBannerSize(MethodCall call, Result result) {
        Integer width;
        width = FromMap.toInteger("width", call.argument("width"));
        if (width != null) {
            BannerAdSize bannerAdSize = BannerAdSize.getLandscapeBannerSize(activity, width);
            result.success(ToMap.fromArgs("width", bannerAdSize.getWidth(), "height", bannerAdSize.getHeight()));
        } else {
            result.error(ErrorCodes.NULL_PARAM, "Null parameter provided for the method. getLandScapeBannerSize failed.", "");
        }
    }

    private void getPortraitBannerSize(MethodCall call, Result result) {
        Integer width;
        width = FromMap.toInteger("width", call.argument("width"));
        if (width != null) {
            BannerAdSize bannerAdSize = BannerAdSize.getPortraitBannerSize(activity, width);
            result.success(ToMap.fromArgs("width", bannerAdSize.getWidth(), "height", bannerAdSize.getHeight()));
        } else {
            result.error(ErrorCodes.NULL_PARAM, "Null parameter provided for the method. getPortraitBannerSize failed.", "");
        }
    }

    private void adsInit(Result result) {
        try {
            HwAds.init(activity);
            Log.i(TAG, "HW Ads Kit initialized");
            result.success(true);
        } catch (Exception e) {
            Log.e(TAG, "HW Ads initialization failed.");
            result.error(ErrorCodes.INNER, "HW Ads initialization failed.", e.getMessage());
        }
    }

    private void adsInitWithAppCode(MethodCall call, Result result) {
        try {
            String appCode = FromMap.toString("appCode", call.argument("appCode"));
            if (appCode != null) {
                HwAds.init(context, appCode);
                Log.i(TAG, "HW Ads Kit initialized.");
                result.success(true);
            } else {
                result.error(ErrorCodes.NULL_PARAM, "Null parameter provided for the method. HW Ads init failed.", "");
            }
        } catch (Exception e) {
            result.error(ErrorCodes.INNER, "HW Ads initialization failed.", e.getMessage());
        }
    }

    private void setRequestOptions(MethodCall call, Result result) {
        String adContentClassification = FromMap.toString("adContentClassification", call.argument("adContentClassification"));
        Integer tagForUnderAge = FromMap.toInteger("tagForUnderAgeOfPromise", call.argument("tagForUnderAgeOfPromise"));
        Integer tagForChildProtection = FromMap.toInteger("tagForChildProtection", call.argument("tagForChildProtection"));
        Integer nonPersonalizedAd = FromMap.toInteger("nonPersonalizedAd", call.argument("nonPersonalizedAd"));
        String appCountry = FromMap.toString("appCountry", call.argument("appCountry"));
        String appLang = FromMap.toString("appLang", call.argument("appLang"));

        RequestOptions options = new RequestOptions().toBuilder()
            .setAdContentClassification(adContentClassification)
            .setTagForUnderAgeOfPromise(tagForUnderAge)
            .setTagForUnderAgeOfPromise(tagForChildProtection)
            .setNonPersonalizedAd(nonPersonalizedAd)
            .setAppCountry(appCountry)
            .setAppLang(appLang)
            .build();

        HwAds.setRequestOptions(options);
        Log.i(TAG, "Request Options set");
        result.success(true);
    }

    private void getRequestOptions(Result result) {
        RequestOptions options = HwAds.getRequestOptions();
        Map<String, Object> arguments = new HashMap<>();
        if (options != null) {
            arguments.put("adContentClassification", options.getAdContentClassification());
            arguments.put("tagForUnderAgeOfPromise", options.getTagForUnderAgeOfPromise());
            arguments.put("tagForChildProtection", options.getTagForChildProtection());
            arguments.put("nonPersonalizedAd", options.getNonPersonalizedAd());
            arguments.put("appCountry", options.getAppCountry());
            arguments.put("appLang", options.getAppLang());
            result.success(arguments);
        } else {
            Log.w(TAG, "Request Options null");
            result.success(null);
        }
    }

    private void getAdvertisingIdInfo(Result result) {
        Map<String, Object> arguments = new HashMap<>();
        try {
            AdvertisingIdClient.Info clientInfo = AdvertisingIdClient.getAdvertisingIdInfo(activity);
            Log.i(TAG, "Ad id information retrieved successfully.");
            arguments.put("advertisingId", clientInfo.getId());
            arguments.put("limitAdTrackingEnabled", clientInfo.isLimitAdTrackingEnabled());
            result.success(arguments);
        } catch (IOException e) {
            Log.e(TAG, "Ad id information retrieval failed.");
            result.error(ErrorCodes.INNER, "Ad id information retrieval failed.", e.getMessage());
        }
    }

    private void verifyAdId(MethodCall call, Result result) {
        new VerifyAdIdThread(call, result).start();
    }

    private void initNativeAdController(MethodCall call, Result result) {
        Integer id = FromMap.toInteger("id", call.argument("id"));
        if (id != null) {
            EventChannelFactory.create(id, Channels.NATIVE_EVENT_CHANNEL, messenger);
            EventChannelFactory.setup(id, new NativeAdStreamHandler());
            NativeAdControllerFactory.createController(id, messenger, context);
            result.success(true);
        } else {
            result.error(ErrorCodes.NULL_PARAM, "Null parameter provided for the method. Controller init failed.", "");
        }
    }

    private void destroyNativeAdController(MethodCall call, Result result) {
        Integer id = FromMap.toInteger("id", call.argument("id"));
        if (id != null && NativeAdControllerFactory.dispose(id)) {
            EventChannelFactory.dispose(id);
            result.success(true);
        } else {
            result.error(ErrorCodes.NOT_FOUND, "No controller for provided id. Destroy controller failed. | Controller id : " + id, "");
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        Splash.destroyAll();
        Banner.destroyAll();
        Interstitial.destroyAll();
        HmsRewardAd.destroyAll();
        HmsInstallReferrer.disposeAll();
        this.flutterPluginBinding = null;
        methodChannel = null;
        messenger = null;
        activity = null;
        consentInfo = null;
        resetAdHandlers();
        removeAdHandlers();
        removeAdChannels();
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        if (flutterPluginBinding != null) {
            onAttachedToEngine(
                flutterPluginBinding.getPlatformViewRegistry(),
                new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), Channels.LIBRARY_METHOD_CHANNEL),
                flutterPluginBinding.getApplicationContext(),
                flutterPluginBinding.getBinaryMessenger(),
                binding.getActivity());
        }
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        Splash.destroyAll();
        Banner.destroyAll();
        Interstitial.destroyAll();
        HmsRewardAd.destroyAll();
        HmsInstallReferrer.disposeAll();
        activity = null;
        consentInfo = null;
        resetAdHandlers();
        removeAdHandlers();
        removeAdChannels();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        if (flutterPluginBinding != null) {
            onAttachedToEngine(
                flutterPluginBinding.getPlatformViewRegistry(),
                new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), Channels.LIBRARY_METHOD_CHANNEL),
                flutterPluginBinding.getApplicationContext(),
                flutterPluginBinding.getBinaryMessenger(),
                binding.getActivity());
        }
    }

    @Override
    public void onDetachedFromActivity() {
        Splash.destroyAll();
        Banner.destroyAll();
        Interstitial.destroyAll();
        HmsRewardAd.destroyAll();
        HmsInstallReferrer.disposeAll();
        activity = null;
        consentInfo = null;
        resetAdHandlers();
        removeAdHandlers();
        removeAdChannels();
    }

    class VerifyAdIdThread extends Thread {
        private MethodCall call;
        private MethodChannel.Result result;

        VerifyAdIdThread(MethodCall call, MethodChannel.Result result) {
            super("verifyAdId");
            this.call = call;
            this.result = result;
        }

        @Override
        public void run() {
            String adId = FromMap.toString("adId", call.argument("adId"));
            Boolean limitTracking = FromMap.toBoolean("limitTracking", call.argument("limitTracking"));
            try {
                final boolean isVerified = AdvertisingIdClient.verifyAdId(activity, adId, limitTracking);
                Log.i(TAG, "AdvertisingIdClient - verifyAdId: " + isVerified);
                new Handler(Looper.getMainLooper()).post(new Runnable() {
                    @Override
                    public void run() {
                        result.success(isVerified);
                    }
                });
            } catch (final AdIdVerifyException e) {
                Log.e(TAG, "Ad id verification failed");
                new Handler(Looper.getMainLooper()).post(new Runnable() {
                    @Override
                    public void run() {
                        result.error(ErrorCodes.VERIFY_FAILED, "Ad id verification failed.", e.getMessage());
                    }
                });
            }
        }
    }
}