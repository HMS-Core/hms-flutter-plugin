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

package com.huawei.hms.flutter.ads.adslite.interstitial;

import android.app.Activity;
import android.content.Context;
import android.util.Log;
import android.util.SparseArray;

import com.huawei.hms.ads.AdListener;
import com.huawei.hms.ads.InterstitialAd;
import com.huawei.hms.flutter.ads.factory.AdParamFactory;
import com.huawei.hms.flutter.ads.utils.constants.AdStatus;

import java.util.Map;

public class Interstitial {
    private static final String TAG = "Interstitial";
    private static SparseArray<Interstitial> allInterstitialAds = new SparseArray<>();

    private InterstitialAd interstitial;
    private AdListener adListener;
    private final int id;
    private String status;

    Interstitial(int id, boolean openInHmsCore, Activity activity, final Context context) {
        this.id = id;
        allInterstitialAds.put(id, this);
        this.interstitial = new InterstitialAd(openInHmsCore ? context : activity);
        setStatus(AdStatus.CREATED);
        Log.i(TAG, "Interstitial ad initialized");
    }

    void setStatus(String status) {
        this.status = status;
    }

    public boolean isCreated() {
        return this.status.equals(AdStatus.CREATED);
    }

    boolean isPreparing() {
        return this.status.equals(AdStatus.PREPARING);
    }

    boolean isLoading() {
        return this.status.equals(AdStatus.LOADING);
    }

    boolean isLoaded() {
        return this.status.equals(AdStatus.LOADED);
    }

    public boolean isFailed() {
        return this.status.equals(AdStatus.FAILED);
    }

    void setAdListener(AdListener adListener) {
        this.adListener = adListener;
    }

    public static Interstitial get(Integer id) {
        if (id == null) {
            Log.e(TAG, "Ad id is null.");
            return null;
        }
        return allInterstitialAds.get(id);
    }

    public InterstitialAd getInterstitialAd() {
        return interstitial;
    }

    void loadAd(String adSlotId, Map<String, Object> adParam) {
        setStatus(AdStatus.LOADING);
        Log.i(TAG, "Interstitial ad is loading");
        interstitial.setAdId(adSlotId);
        Log.i(TAG, "Interstitial ad slot id set");

        interstitial.setAdListener(adListener != null ? adListener : new InterstitialDefaultListener(this));

        AdParamFactory factory = new AdParamFactory(adParam);
        interstitial.loadAd(factory.createAdParam());
    }

    public void show() {
        if (isLoading()) {
            Log.i(TAG, "Interstitial ad is being prepared.");
            setStatus(AdStatus.PREPARING);
            return;
        }
        if (!interstitial.isLoaded()) {
            Log.e(TAG, "Interstitial ad is not loaded!");
            return;
        }
        interstitial.show();
    }

    public void destroy() {
        allInterstitialAds.remove(id);
    }

    public static void destroyAll() {
        for (int i = 0; i < allInterstitialAds.size(); i++) {
            allInterstitialAds.valueAt(i).destroy();
        }
        allInterstitialAds.clear();
    }

    static class InterstitialDefaultListener extends AdListener {
        Interstitial interstitial;

        InterstitialDefaultListener(Interstitial interstitial) {
            this.interstitial = interstitial;
        }

        @Override
        public void onAdLoaded() {
            Log.i(TAG, "onInterstitialAdLoaded");
            boolean wasPreparing = interstitial.isPreparing();
            interstitial.setStatus(AdStatus.LOADED);
            if (wasPreparing) {
                interstitial.show();
            }
        }

        @Override
        public void onAdFailed(int errorCode) {
            Log.w(TAG, "onInterstitialAdFailed: " + errorCode);
            interstitial.setStatus(AdStatus.FAILED);
        }
    }
}
