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

package com.huawei.hms.flutter.ads.adslite.splash;

import android.app.Activity;
import android.util.Log;
import android.util.SparseArray;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.huawei.hms.ads.AdParam;
import com.huawei.hms.ads.splash.SplashAd;
import com.huawei.hms.ads.splash.SplashAdDisplayListener;
import com.huawei.hms.ads.splash.SplashView;
import com.huawei.hms.flutter.ads.R;
import com.huawei.hms.flutter.ads.factory.AdParamFactory;
import com.huawei.hms.flutter.ads.utils.FromMap;
import com.huawei.hms.flutter.ads.utils.ResourceUtil;
import com.huawei.hms.flutter.ads.utils.constants.AdStatus;
import com.huawei.hms.flutter.ads.utils.constants.ErrorCodes;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class Splash {
    private static final String TAG = "SplashAd";
    private static SparseArray<Splash> splashAds = new SparseArray<>();

    enum AdType {
        above, below, aboveNoLogo, belowNoLogo
    }

    private final Activity activity;
    private final int id;
    private SplashView adView;
    private SplashAdDisplayListener displayListener;
    private SplashView.SplashAdLoadListener loadListener;
    private String adSlotId;
    private AdType adType;
    private AdParam adParam;
    private int orientation;
    private double topMargin;
    private String ownerText;
    private String footerText;
    private Map<String, Object> resources;
    private String status;

    Splash(int id, Activity activity) {
        this.id = id;
        this.activity = activity;
        this.status = AdStatus.CREATED;
        this.topMargin = 0.0;
        this.adType = AdType.above;
        this.resources = new HashMap<>();
        this.adView = new SplashView(activity);
        splashAds.put(id, this);
    }

    public static Splash get(Integer id) {
        if (id == null) {
            Log.e(TAG, "Ad id is null.");
            return null;
        }
        return splashAds.get(id);
    }

    SplashView getSplashView() {
        return adView;
    }

    void setStatus(String status) {
        this.status = status;
    }

    public boolean isCreated() {
        return this.status.equals(AdStatus.CREATED);
    }

    boolean isLoading() {
        return this.status.equals(AdStatus.LOADING);
    }

    public boolean isFailed() {
        return this.status.equals(AdStatus.FAILED);
    }

    void setDisplayListener(SplashAdDisplayListener displayListener) {
        this.displayListener = displayListener;
    }

    void setLoadListener(SplashView.SplashAdLoadListener loadListener) {
        this.loadListener = loadListener;
    }

    static void preloadAd(Activity activity, String adSlotId, int orientation, Map<String, Object> adParamMap, MethodChannel.Result result) {
        AdParamFactory factory = new AdParamFactory(adParamMap);
        AdParam adParam = factory.createAdParam();

        try {
            SplashAd.preloadAd(activity, adSlotId, orientation, adParam);
            result.success(true);
        } catch (Exception e) {
            Log.e(TAG.concat("-preloadAd"), "Splash ad failed to load");
            result.error(ErrorCodes.LOAD_FAILED, "Preload failed for Splash ad.", e.getMessage());
        }
    }

    void prepareForLoad(
        String adSlotId,
        int orientation,
        Double margin,
        String type,
        Map<String, Object> adParamMap,
        Map<String, Object> resources,
        Integer audioFocusType,
        MethodChannel.Result result
    ) {
        if (!isCreated()) {
            return;
        }

        setStatus(AdStatus.LOADING);
        this.adSlotId = adSlotId;

        if (type != null) {
            adType = AdType.valueOf(type);
        }

        this.orientation = orientation;

        if (margin != null) {
            topMargin = margin;
        }

        if (audioFocusType != null) {
            adView.setAudioFocusType(audioFocusType);
        }

        this.resources = resources;
        setResources(adView, resources);

        AdParamFactory factory = new AdParamFactory(adParamMap);
        this.adParam = factory.createAdParam();
        result.success(true);
    }

    void loadAd() {
        if (displayListener != null) {
            adView.setAdDisplayListener(displayListener);
        }

        SplashView.SplashAdLoadListener listener = new SplashDefaultLoadListener(this);
        if (loadListener != null) {
            listener = loadListener;
        }

        adView.load(adSlotId, orientation, adParam, listener);
    }

    void show() {
        if (isLoading() || adView == null) {
            return;
        }

        int layout;
        int rule;
        switch (adType) {
            case above:
                layout = R.layout.splash_ad_above_template;
                rule = RelativeLayout.ABOVE;
                break;
            case below:
                layout = R.layout.splash_ad_below_template;
                rule = RelativeLayout.BELOW;
                break;
            case aboveNoLogo:
                layout = R.layout.splash_ad_above_no_logo_template;
                rule = RelativeLayout.ABOVE;
                break;
            case belowNoLogo:
                layout = R.layout.splash_ad_below_no_logo_template;
                rule = RelativeLayout.BELOW;
                break;
            default:
                layout = R.layout.splash_ad_above_template;
                rule = RelativeLayout.ABOVE;
                break;
        }

        if (activity.findViewById(id) == null) {
            RelativeLayout content = new RelativeLayout(activity);
            RelativeLayout.LayoutParams splashParams =
                new RelativeLayout.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.MATCH_PARENT);
            content.setLayoutParams(splashParams);

            LayoutInflater inflater = LayoutInflater.from(activity);
            inflater.inflate(layout, content, true);

            String logoRes = FromMap.toString("logoResId", resources.get("logoResId"));
            ImageView image = content.findViewById(R.id.splash_logo);
            if (image != null && logoRes != null) {
                int imageResId = ResourceUtil.getLogoResourceIdFromContext(activity, logoRes);
                if (imageResId != 0) {
                    image.setImageResource(imageResId);
                }
            }

            TextView owner = content.findViewById(R.id.splash_owner);
            if (owner != null && ownerText != null) {
                owner.setText(ownerText);
            }

            TextView footer = content.findViewById(R.id.splash_footer);
            if (footer != null && footerText != null) {
                footer.setText(footerText);
            }

            RelativeLayout splashContent = content.findViewById(R.id.splash_content);
            RelativeLayout.LayoutParams adParams =
                new RelativeLayout.LayoutParams(
                    RelativeLayout.LayoutParams.WRAP_CONTENT,
                    RelativeLayout.LayoutParams.WRAP_CONTENT);
            adParams.addRule(rule, splashContent.getId());
            adView.setLayoutParams(adParams);

            content.setId(id);
            content.addView(adView);

            final float scale = activity.getResources().getDisplayMetrics().density;
            int margin = topMargin > 0 ? (int) (topMargin * scale) : 0;

            RelativeLayout.LayoutParams param = new RelativeLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
            param.setMargins(0, margin, 0, 0);
            activity.addContentView(content, param);
        }
    }

    public void destroy() {
        if (adView != null) {
            adView.destroyView();
        }

        View contentView = activity.findViewById(id);
        if (contentView == null || !(contentView.getParent() instanceof ViewGroup)) {
            return;
        }

        ViewGroup contentParent = (ViewGroup) (contentView.getParent());
        contentParent.removeView(contentView);

        splashAds.remove(id);
        Log.i(TAG, "Splash ad destroyed");
    }

    public static void destroyAll() {
        for (int i = 0; i < splashAds.size(); i++) {
            splashAds.valueAt(i).destroy();
        }
        splashAds.clear();
    }

    private void setResources(SplashView adView, Map<String, Object> args) {
        String logoRes = FromMap.toString("logoResId", args.get("logoResId"));
        if (logoRes != null) {
            int logoResId = ResourceUtil.getLogoResourceIdFromContext(activity, logoRes);
            if (logoResId != 0) {
                adView.setLogoResId(logoResId);
            }
        }

        String mediaNameRes = FromMap.toString("mediaNameResId", args.get("mediaNameResId"));
        if (mediaNameRes != null) {
            int mediaNameResId = ResourceUtil.getStringResourceIdFromContext(activity, mediaNameRes);
            if (mediaNameResId != 0) {
                adView.setMediaNameResId(mediaNameResId);
            }
        }

        String sloganRes = FromMap.toString("sloganResId", args.get("sloganResId"));
        if (sloganRes != null) {
            int sloganResId = ResourceUtil.getStringResourceIdFromContext(activity, sloganRes);
            if (sloganResId != 0) {
                adView.setSloganResId(sloganResId);
            }
        }

        String wideSloganRes = FromMap.toString("wideSloganResId", args.get("wideSloganResId"));
        if (wideSloganRes != null) {
            int wideSloganResId = ResourceUtil.getStringResourceIdFromContext(activity, wideSloganRes);
            if (wideSloganResId != 0) {
                adView.setWideSloganResId(wideSloganResId);
            }
        }

        String owner = FromMap.toString("ownerText", args.get("ownerText"));
        if (owner != null) {
            this.ownerText = owner;
        }

        String footer = FromMap.toString("footerText", args.get("footerText"));
        if (footer != null) {
            this.footerText = footer;
        }
    }

    static class SplashDefaultLoadListener extends SplashView.SplashAdLoadListener {
        Splash splash;

        SplashDefaultLoadListener(Splash splash) {
            this.splash = splash;
        }

        @Override
        public void onAdFailedToLoad(int errorCode) {
            Log.w(TAG, "onAdFailed: " + errorCode);
            splash.setStatus(AdStatus.FAILED);
        }

        @Override
        public void onAdLoaded() {
            Log.i(TAG, "onAdLoaded");
            splash.setStatus(AdStatus.LOADED);
            splash.show();
        }
    }
}

