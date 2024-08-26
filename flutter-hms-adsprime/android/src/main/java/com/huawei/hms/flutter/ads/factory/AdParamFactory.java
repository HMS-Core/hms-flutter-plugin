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

package com.huawei.hms.flutter.ads.factory;

import android.location.Location;
import android.util.Log;

import com.huawei.hms.ads.AdParam;
import com.huawei.hms.ads.BiddingParam;
import com.huawei.hms.flutter.ads.utils.FromMap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class AdParamFactory {
    private static final String TAG = "AdParamFactory";

    private final Map<String, Object> adParamMap;

    private AdParam.Builder builder;

    public AdParamFactory(Map<String, Object> adParamMap) {
        this.adParamMap = adParamMap;
    }

    public AdParam createAdParam() {
        Log.i(TAG, "Create ad param begin");
        builder = new AdParam.Builder();
        if (adParamMap == null) {
            return builder.build();
        }
        Integer gender = FromMap.toInteger("gender", adParamMap.get("gender"));
        String adContentClassification = FromMap.toString("adContentClassification",
            adParamMap.get("adContentClassification"));
        Integer tagForChildProtection = FromMap.toInteger("tagForChildProtection",
            adParamMap.get("tagForChildProtection"));
        Integer tagForUnderAgeOfPromise = FromMap.toInteger("tagForUnderAgeOfPromise",
            adParamMap.get("tagForUnderAgeOfPromise"));
        Integer nonPersonalizedAd = FromMap.toInteger("nonPersonalizedAd", adParamMap.get("nonPersonalizedAd"));
        String appCountry = FromMap.toString("appCountry", adParamMap.get("appCountry"));
        String appLang = FromMap.toString("appLang", adParamMap.get("appLang"));
        String countryCode = FromMap.toString("countryCode", adParamMap.get("countryCode"));
        String contentBundle = FromMap.toString("contentBundle", adParamMap.get("contentBundle"));
        String locationProvider = FromMap.toString("locationProvider", adParamMap.get("locationProvider"));
        Double locationLatitude = FromMap.toDouble("locationLatitude", adParamMap.get("locationLatitude"));
        Double locationLongitude = FromMap.toDouble("locationLongitude", adParamMap.get("locationLongitude"));
        String consent = FromMap.toString("consent", adParamMap.get("consent"));
        ArrayList<Integer> detailedCreativeTypeList = FromMap.toIntegerArrayList("detailedCreativeTypeList",
            adParamMap.get("detailedCreativeTypeList"));
        boolean requestLocation = FromMap.toBoolean("requestLocation", adParamMap.get("requestLocation"));
        Integer tMax = FromMap.toInteger("tMax", adParamMap.get("tMax"));
        Map<String, Object> addBiddingParamMap = FromMap.toHashMap("addBiddingParamMap",
            adParamMap.get("addBiddingParamMap"));
        Map<String, Object> setBiddingParamMap = FromMap.toHashMap("setBiddingParamMap",
            adParamMap.get("setBiddingParamMap"));
        String slotId;

        if (tMax != null) {
            builder.setTMax(tMax);
        }

        if (addBiddingParamMap != null) {
            slotId = (String) addBiddingParamMap.get("slotId");
            Log.i(TAG, "slot id is " + slotId);
            BiddingParam bp = FromMap.toBiddingParam((Map<String, Object>) addBiddingParamMap.get("biddingParam"));

            builder.addBiddingParamMap(slotId, bp);
            Log.i(TAG, "add bidding param map");
        }

        if (setBiddingParamMap != null) {
            Map<String, BiddingParam> paramMap = new HashMap<String, BiddingParam>();

            for (String key : setBiddingParamMap.keySet()) {
                BiddingParam bp = FromMap.toBiddingParam(FromMap.toHashMap(key, setBiddingParamMap.get(key)));
                paramMap.put(key, bp);
            }

            builder.setBiddingParamMap(paramMap);
            Log.i(TAG, "setBiddingParamMap" + paramMap);

        }

        if (gender != null && (gender >= 0 && gender < 3)) {
            Log.i(TAG, "set gender");
            builder.setGender(gender);
        } else {
            Log.w(TAG, "Invalid gender value");
        }

        if (adContentClassification != null) {
            Log.i(TAG, "set adContentClassification");
            builder.setAdContentClassification(adContentClassification);
        }
        if (tagForChildProtection != null) {
            Log.i(TAG, "set tagForChildProtection");
            builder.setTagForChildProtection(tagForChildProtection);
        }
        if (tagForUnderAgeOfPromise != null) {
            Log.i(TAG, "set tagForUnderAgeOfPromise");
            builder.setTagForUnderAgeOfPromise(tagForUnderAgeOfPromise);
        }
        if (nonPersonalizedAd != null) {
            Log.i(TAG, "set nonPersonalizedAd");
            builder.setNonPersonalizedAd(nonPersonalizedAd);
        }
        if (appCountry != null) {
            Log.i(TAG, "set appCountry");
            builder.setAppCountry(appCountry);
        }
        if (appLang != null) {
            Log.i(TAG, "set appLang");
            builder.setAppLang(appLang);
        }
        if (countryCode != null) {
            Log.i(TAG, "set countryCode");
            builder.setBelongCountryCode(countryCode);
        }
        if (contentBundle != null) {
            Log.i(TAG, "set contentBundle");
            builder.setContentBundle(contentBundle);
        }
        if (locationProvider != null && locationLatitude != null && locationLongitude != null) {
            Log.i(TAG, "set location");
            Location location = new Location(locationProvider);
            location.setLatitude(locationLatitude);
            location.setLongitude(locationLongitude);
            builder.setLocation(location);
        }
        if (consent != null) {
            Log.i(TAG, "set consent");
            builder.setConsent(consent);
        }
        if (!detailedCreativeTypeList.isEmpty()) {
            Log.i(TAG, "set detailedCreativeTypeList");
            builder.setDetailedCreativeTypeList(detailedCreativeTypeList);
        }
        Log.i(TAG, "set requestLocation");
        builder.setRequestLocation(requestLocation);
        return builder.build();
    }
}
