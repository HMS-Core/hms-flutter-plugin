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
import android.util.Log;
import android.util.SparseArray;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;

import com.huawei.hms.ads.AdListener;
import com.huawei.hms.ads.AdParam;
import com.huawei.hms.ads.BannerAdSize;
import com.huawei.hms.ads.banner.BannerView;
import com.huawei.hms.flutter.ads.factory.AdParamFactory;
import com.huawei.hms.flutter.ads.utils.constants.AdStatus;

import java.util.Map;

public class Banner {
    private static final String TAG = "Banner";
    private static SparseArray<Banner> allBannerAds = new SparseArray<>();

    private final Activity activity;
    private final int id;
    private BannerView bannerView;
    private AdListener adListener;
    private BannerAdSize adSize;
    private Long bannerRefresh;
    private double offset;
    private int gravity;
    private String status;

    Banner(Integer id, BannerAdSize adSize, Long bannerRefresh, Activity activity) {
        this.id = id;
        this.activity = activity;
        this.adSize = adSize;
        this.bannerRefresh = bannerRefresh;
        this.offset = 0.0;
        this.gravity = Gravity.BOTTOM;
        allBannerAds.put(id, this);
        this.bannerView = new BannerView(activity);
        setStatus(AdStatus.CREATED);
        Log.i(TAG, "Banner view initialized");
    }

    public boolean isCreated() {
        return this.status.equals(AdStatus.CREATED);
    }

    void setStatus(String status) {
        this.status = status;
    }

    boolean isLoading() {
        return this.status.equals(AdStatus.LOADING);
    }

    boolean isPreparing() {
        return this.status.equals(AdStatus.PREPARING);
    }

    public boolean isLoaded() {
        return this.status.equals(AdStatus.LOADED);
    }

    public boolean isFailed() {
        return this.status.equals(AdStatus.FAILED);
    }

    void setAdListener(AdListener adListener) {
        this.adListener = adListener;
    }

    void setOffset(double offset) {
        this.offset = offset;
    }

    public void setGravity(int gravity) {
        this.gravity = gravity;
    }

    public static Banner get(Integer id) {
        if (id == null) {
            Log.e(TAG, "Ad id is null.");
            return null;
        }
        return allBannerAds.get(id);
    }

    BannerView getBannerView() {
        return bannerView;
    }

    void loadAd(String adSlotId, Map<String, Object> adParamMap) {
        if (!isCreated()) {
            return;
        }
        setStatus(AdStatus.LOADING);

        bannerView.setBannerAdSize(adSize);
        Log.i(TAG, "Banner ad size is set");
        bannerView.setAdId(adSlotId);
        Log.i(TAG, "Banner ad slot id is set");
        if (bannerRefresh != null) {
            bannerView.setBannerRefresh(bannerRefresh);
            Log.i(TAG, "bannerRefreshTime set : " + bannerRefresh);
        }

        bannerView.setAdListener(adListener != null ? adListener : new BannerDefaultListener(this));

        AdParamFactory factory = new AdParamFactory(adParamMap);
        AdParam adParam = factory.createAdParam();
        bannerView.loadAd(adParam);
    }

    public void show() {
        if (isLoading()) {
            Log.i(TAG, "Banner ad is being prepared.");
            setStatus(AdStatus.PREPARING);
            return;
        }
        if (!isLoaded()) {
            Log.e(TAG, "Banner ad is not loaded!");
            return;
        }
        if (activity.findViewById(id) != null) {
            Log.i(TAG, "Banner ad is already displayed.");
            return;
        }
        LinearLayout content = new LinearLayout(activity);
        ViewGroup.LayoutParams bannerParams = new ViewGroup.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
        content.setOrientation(LinearLayout.VERTICAL);
        content.setGravity(gravity);
        float scale = activity.getResources().getDisplayMetrics().density;
        if (gravity == Gravity.BOTTOM || (gravity == Gravity.CENTER_VERTICAL && offset > 0)) {
            content.setPadding(0, 0, 0, (int) (offset * scale));
        } else if (gravity == Gravity.TOP || (gravity == Gravity.CENTER_VERTICAL && offset < 0)) {
            content.setPadding(0, (int) (offset * scale), 0, 0);
        }

        content.setId(id);
        content.addView(bannerView);
        activity.addContentView(content, bannerParams);
    }

    public void destroy() {
        bannerView.destroy();
        Log.i(TAG, "Banner ad destroyed.");
        View contentView = activity.findViewById(id);
        if (contentView == null) {
            Log.w(TAG, "Banner ad view not found in activity!");
            return;
        }
        ((ViewGroup) (contentView.getParent())).removeView(contentView);
        allBannerAds.remove(id);
    }

    public static void destroyAll() {
        for (int i = 0; i < allBannerAds.size(); i++) {
            allBannerAds.valueAt(i).destroy();
        }
        allBannerAds.clear();
    }

    static class BannerDefaultListener extends AdListener {
        private Banner banner;

        BannerDefaultListener(Banner banner) {
            this.banner = banner;
        }

        @Override
        public void onAdLoaded() {
            Log.i(TAG, "onBannerAdLoaded");
            boolean wasPreparing = banner.isPreparing();
            banner.setStatus(AdStatus.LOADED);
            if (wasPreparing) {
                banner.show();
            }
        }

        @Override
        public void onAdFailed(int errorCode) {
            Log.w(TAG, "onBannerAdFailed: " + errorCode);
            banner.setStatus(AdStatus.FAILED);
        }
    }
}
