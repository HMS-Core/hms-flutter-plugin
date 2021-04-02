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
import com.huawei.hms.flutter.ads.adslite.bannerad.BannerViewFactory;
import com.huawei.hms.flutter.ads.adslite.instream.InstreamMethodHandler;
import com.huawei.hms.flutter.ads.adslite.instream.InstreamViewFactory;
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
import com.huawei.hms.flutter.ads.logger.HMSLogger;
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

import static com.huawei.hms.flutter.ads.utils.constants.ViewTypes.BANNER_VIEW;
import static com.huawei.hms.flutter.ads.utils.constants.ViewTypes.INSTREAM_VIEW;
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
    private MethodChannel instreamMethodChannel;
    private MethodChannel referrerMethodChannel;
    private MethodChannel consentMethodChannel;

    private SplashMethodHandler splashMethodHandler;
    private BannerMethodHandler bannerMethodHandler;
    private RewardMethodHandler rewardMethodHandler;
    private InterstitialMethodHandler interstitialMethodHandler;
    private InstreamMethodHandler instreamMethodHandler;
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
        registry.registerViewFactory(BANNER_VIEW, new BannerViewFactory(messenger));
        registry.registerViewFactory(INSTREAM_VIEW, new InstreamViewFactory(messenger));
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
        instreamMethodChannel = new MethodChannel(messenger, Channels.INSTREAM_METHOD_CHANNEL);
        referrerMethodChannel = new MethodChannel(messenger, Channels.REFERRER_METHOD_CHANNEL);
        consentMethodChannel = new MethodChannel(messenger, Channels.CONSENT_METHOD_CHANNEL);
        consentEventChannel = new EventChannel(messenger, Channels.CONSENT_EVENT_CHANNEL);
    }

    private void initAdHandlers() {
        splashMethodHandler = new SplashMethodHandler(messenger, activity, context);
        bannerMethodHandler = new BannerMethodHandler(messenger, activity, context);
        rewardMethodHandler = new RewardMethodHandler(messenger, activity, context);
        interstitialMethodHandler = new InterstitialMethodHandler(messenger, activity, context);
        instreamMethodHandler = new InstreamMethodHandler(messenger, context);
        installReferrerMethodHandler = new InstallReferrerMethodHandler(activity, referrerMethodChannel);
        consentMethodHandler = new ConsentMethodHandler(context, consentInfo);
        consentStreamHandler = new ConsentStreamHandler(consentInfo, context);
    }

    private void setAdHandlers() {
        if (splashMethodChannel != null) splashMethodChannel.setMethodCallHandler(splashMethodHandler);
        if (bannerMethodChannel != null) bannerMethodChannel.setMethodCallHandler(bannerMethodHandler);
        if (rewardMethodChannel != null) rewardMethodChannel.setMethodCallHandler(rewardMethodHandler);
        if (interstitialMethodChannel != null) interstitialMethodChannel.setMethodCallHandler(interstitialMethodHandler);
        if (instreamMethodChannel != null) instreamMethodChannel.setMethodCallHandler(instreamMethodHandler);
        if (referrerMethodChannel != null) referrerMethodChannel.setMethodCallHandler(installReferrerMethodHandler);
        if (consentMethodChannel != null) consentMethodChannel.setMethodCallHandler(consentMethodHandler);
        if (consentEventChannel != null) consentEventChannel.setStreamHandler(consentStreamHandler);
    }

    private void resetAdHandlers() {
        if (splashMethodChannel != null) splashMethodChannel.setMethodCallHandler(null);
        if (bannerMethodChannel != null) bannerMethodChannel.setMethodCallHandler(null);
        if (rewardMethodChannel != null) rewardMethodChannel.setMethodCallHandler(null);
        if (interstitialMethodChannel != null) interstitialMethodChannel.setMethodCallHandler(null);
        if (instreamMethodChannel != null) instreamMethodChannel.setMethodCallHandler(null);
        if (referrerMethodChannel != null) referrerMethodChannel.setMethodCallHandler(null);
        if (consentMethodChannel != null) consentMethodChannel.setMethodCallHandler(null);
        if (consentEventChannel != null) consentEventChannel.setStreamHandler(null);
    }

    private void removeAdHandlers() {
        splashMethodHandler = null;
        bannerMethodHandler = null;
        rewardMethodHandler = null;
        interstitialMethodHandler = null;
        instreamMethodHandler = null;
        installReferrerMethodHandler = null;
        consentMethodHandler = null;
        consentStreamHandler = null;
    }

    private void removeAdChannels() {
        splashMethodChannel = null;
        bannerMethodChannel = null;
        rewardMethodChannel = null;
        interstitialMethodChannel = null;
        instreamMethodChannel = null;
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
            case "HwAds-setConsent":
                setConsent(call, result);
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
            case "enableLogger":
                HMSLogger.getInstance(context).enableLogger();
                result.success(true);
                break;
            case "disableLogger":
                HMSLogger.getInstance(context).disableLogger();
                result.success(true);
                break;
            default:
                result.notImplemented();
        }
    }

    private void getHeightPx(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("getHeightPx");
        Integer width;
        Integer height;
        width = FromMap.toInteger("width", call.argument("width"));
        height = FromMap.toInteger("height", call.argument("height"));
        if (width != null && height != null) {
            result.success(new BannerAdSize(width, height).getHeightPx(activity));
            HMSLogger.getInstance(context).sendSingleEvent("getHeightPx");
        } else {
            result.error(ErrorCodes.NULL_PARAM, "Null parameter provided for the method. getHeightPx failed.", "");
            HMSLogger.getInstance(context).sendSingleEvent("getHeightPx", ErrorCodes.NULL_PARAM);
        }
    }

    private void getWidthPx(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("getWidthPx");
        Integer width;
        Integer height;
        width = FromMap.toInteger("width", call.argument("width"));
        height = FromMap.toInteger("height", call.argument("height"));
        if (width != null && height != null) {
            result.success(new BannerAdSize(width, height).getWidthPx(activity));
            HMSLogger.getInstance(context).sendSingleEvent("getWidthPx");
        } else {
            result.error(ErrorCodes.NULL_PARAM, "Null parameter provided for the method. getWidthPx failed.", "");
            HMSLogger.getInstance(context).sendSingleEvent("getHeightPx", ErrorCodes.NULL_PARAM);
        }
    }

    private void getCurrentDirectionBannerSize(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("getCurrentDirectionBannerSize");
        Integer width;
        width = FromMap.toInteger("width", call.argument("width"));
        if (width != null) {
            BannerAdSize bannerAdSize = BannerAdSize.getCurrentDirectionBannerSize(activity, width);
            result.success(ToMap.fromArgs("width", bannerAdSize.getWidth(), "height", bannerAdSize.getHeight()));
            HMSLogger.getInstance(context).sendSingleEvent("getCurrentDirectionBannerSize");
        } else {
            result.error(ErrorCodes.NULL_PARAM, "Null parameter provided for the method. getCurrentDirectionBannerSize failed.", "");
            HMSLogger.getInstance(context).sendSingleEvent("getCurrentDirectionBannerSize", ErrorCodes.NULL_PARAM);
        }
    }

    private void getLandScapeBannerSize(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("getLandScapeBannerSize");
        Integer width;
        width = FromMap.toInteger("width", call.argument("width"));
        if (width != null) {
            BannerAdSize bannerAdSize = BannerAdSize.getLandscapeBannerSize(activity, width);
            HMSLogger.getInstance(context).sendSingleEvent("getLandScapeBannerSize");
            result.success(ToMap.fromArgs("width", bannerAdSize.getWidth(), "height", bannerAdSize.getHeight()));
            HMSLogger.getInstance(context).sendSingleEvent("getLandScapeBannerSize");
        } else {
            result.error(ErrorCodes.NULL_PARAM, "Null parameter provided for the method. getLandScapeBannerSize failed.", "");
            HMSLogger.getInstance(context).sendSingleEvent("getLandScapeBannerSize", ErrorCodes.NULL_PARAM);
        }
    }

    private void getPortraitBannerSize(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("getPortraitBannerSize");
        Integer width;
        width = FromMap.toInteger("width", call.argument("width"));
        if (width != null) {
            BannerAdSize bannerAdSize = BannerAdSize.getPortraitBannerSize(activity, width);
            result.success(ToMap.fromArgs("width", bannerAdSize.getWidth(), "height", bannerAdSize.getHeight()));
            HMSLogger.getInstance(context).sendSingleEvent("getPortraitBannerSize");
        } else {
            result.error(ErrorCodes.NULL_PARAM, "Null parameter provided for the method. getPortraitBannerSize failed.", "");
            HMSLogger.getInstance(context).sendSingleEvent("getPortraitBannerSize", ErrorCodes.NULL_PARAM);
        }
    }

    private void adsInit(Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("adsInit");
        try {
            HwAds.init(activity);
            Log.i(TAG, "HW Ads Kit initialized");
            result.success(true);
            HMSLogger.getInstance(context).sendSingleEvent("adsInit");
        } catch (Exception e) {
            Log.e(TAG, "HW Ads initialization failed.");
            result.error(ErrorCodes.INNER, "HW Ads initialization failed.", e.getMessage());
            HMSLogger.getInstance(context).sendSingleEvent("adsInit", ErrorCodes.INNER);
        }
    }

    private void adsInitWithAppCode(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("adsInitWithAppCode");
        try {
            String appCode = FromMap.toString("appCode", call.argument("appCode"));
            if (appCode != null) {
                HwAds.init(context, appCode);
                Log.i(TAG, "HW Ads Kit initialized.");
                HMSLogger.getInstance(context).sendSingleEvent("adsInitWithAppCode");
                result.success(true);
            } else {
                result.error(ErrorCodes.NULL_PARAM, "Null parameter provided for the method. HW Ads init failed.", "");
                HMSLogger.getInstance(context).sendSingleEvent("adsInitWithAppCode", ErrorCodes.NULL_PARAM);
            }
        } catch (Exception e) {
            result.error(ErrorCodes.INNER, "HW Ads initialization failed.", e.getMessage());
            HMSLogger.getInstance(context).sendSingleEvent("adsInitWithAppCode", ErrorCodes.INNER);
        }
    }

    private void setRequestOptions(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("setRequestOptions");
        String adContentClassification = FromMap.toString("adContentClassification", call.argument("adContentClassification"));
        Integer tagForUnderAge = FromMap.toInteger("tagForUnderAgeOfPromise", call.argument("tagForUnderAgeOfPromise"));
        Integer tagForChildProtection = FromMap.toInteger("tagForChildProtection", call.argument("tagForChildProtection"));
        Integer nonPersonalizedAd = FromMap.toInteger("nonPersonalizedAd", call.argument("nonPersonalizedAd"));
        String appCountry = FromMap.toString("appCountry", call.argument("appCountry"));
        String appLang = FromMap.toString("appLang", call.argument("appLang"));

        RequestOptions options = new RequestOptions().toBuilder()
            .setAdContentClassification(adContentClassification)
            .setTagForUnderAgeOfPromise(tagForUnderAge)
            .setTagForChildProtection(tagForChildProtection)
            .setNonPersonalizedAd(nonPersonalizedAd)
            .setAppCountry(appCountry)
            .setAppLang(appLang)
            .build();

        HwAds.setRequestOptions(options);
        Log.i(TAG, "Request Options set");
        result.success(true);
        HMSLogger.getInstance(context).sendSingleEvent("setRequestOptions");
    }

    private void setConsent(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("setConsent");
        String consent = FromMap.toString("consent", call.argument("consent"));
        HwAds.setConsent(consent);
        Log.i(TAG, "Consent set");
        result.success(true);
        HMSLogger.getInstance(context).sendSingleEvent("setConsent");
    }

    private void getRequestOptions(Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("getRequestOptions");
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
        HMSLogger.getInstance(context).sendSingleEvent("getRequestOptions");
    }

    private void getAdvertisingIdInfo(Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("getAdvertisingIdInfo");
        Map<String, Object> arguments = new HashMap<>();
        try {
            AdvertisingIdClient.Info clientInfo = AdvertisingIdClient.getAdvertisingIdInfo(activity);
            Log.i(TAG, "Ad id information retrieved successfully.");
            arguments.put("advertisingId", clientInfo.getId());
            arguments.put("limitAdTrackingEnabled", clientInfo.isLimitAdTrackingEnabled());
            result.success(arguments);
            HMSLogger.getInstance(context).sendSingleEvent("getAdvertisingIdInfo");
        } catch (IOException e) {
            Log.e(TAG, "Ad id information retrieval failed.");
            result.error(ErrorCodes.INNER, "Ad id information retrieval failed.", e.getMessage());
            HMSLogger.getInstance(context).sendSingleEvent("getAdvertisingIdInfo", ErrorCodes.INNER);
        }
    }

    private void verifyAdId(MethodCall call, Result result) {
        new VerifyAdIdThread(call, result).start();
    }

    private void initNativeAdController(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("initNativeAdController");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        if (id != null) {
            EventChannelFactory.create(id, Channels.NATIVE_EVENT_CHANNEL, messenger);
            EventChannelFactory.setup(id, new NativeAdStreamHandler(context));
            NativeAdControllerFactory.createController(id, messenger, context);
            result.success(true);
            HMSLogger.getInstance(context).sendSingleEvent("initNativeAdController");
        } else {
            result.error(ErrorCodes.NULL_PARAM, "Null parameter provided for the method. Controller init failed.", "");
            HMSLogger.getInstance(context).sendSingleEvent("initNativeAdController", ErrorCodes.NULL_PARAM);
        }
    }

    private void destroyNativeAdController(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer("destroyNativeAdController");
        Integer id = FromMap.toInteger("id", call.argument("id"));
        if (id != null && NativeAdControllerFactory.dispose(id)) {
            EventChannelFactory.dispose(id);
            result.success(true);
            HMSLogger.getInstance(context).sendSingleEvent("destroyNativeAdController");
        } else {
            result.error(ErrorCodes.NOT_FOUND, "No controller for provided id. Destroy controller failed. | Controller id : " + id, "");
            HMSLogger.getInstance(context).sendSingleEvent("destroyNativeAdController", ErrorCodes.NOT_FOUND);
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
        Interstitial.destroyAll();
        Banner.destroyAll();
        HmsRewardAd.destroyAll();
        HmsInstallReferrer.disposeAll();
        consentInfo = null;
        activity = null;
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
            HMSLogger.getInstance(context).startMethodExecutionTimer("verifyAdId");
            String adId = FromMap.toString("adId", call.argument("adId"));
            Boolean limitTracking = FromMap.toBoolean("limitTracking", call.argument("limitTracking"));
            try {
                final boolean isVerified = AdvertisingIdClient.verifyAdId(activity, adId, limitTracking);
                Log.i(TAG, "AdvertisingIdClient - verifyAdId: " + isVerified);
                new Handler(Looper.getMainLooper()).post(new Runnable() {
                    @Override
                    public void run() {
                        result.success(isVerified);
                        HMSLogger.getInstance(context).sendSingleEvent("verifyAdId");
                    }
                });
            } catch (final AdIdVerifyException e) {
                Log.e(TAG, "Ad id verification failed");
                new Handler(Looper.getMainLooper()).post(new Runnable() {
                    @Override
                    public void run() {
                        result.error(ErrorCodes.VERIFY_FAILED, "Ad id verification failed.", e.getMessage());
                        HMSLogger.getInstance(context).sendSingleEvent("verifyAdId", ErrorCodes.VERIFY_FAILED);
                    }
                });
            }
        }
    }
}