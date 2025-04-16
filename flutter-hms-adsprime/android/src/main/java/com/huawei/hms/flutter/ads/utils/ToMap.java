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

package com.huawei.hms.flutter.ads.utils;

import com.huawei.hms.ads.BiddingInfo;
import com.huawei.hms.ads.consent.bean.AdProvider;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ToMap {
    public static Map<String, Object> fromArgs(Object... args) {
        Map<String, Object> argsMap = new HashMap<>();
        int i = 0;
        if (args.length % 2 == 1) {
            argsMap.put("id", args[0]);
            i++;
        }
        for (; i < args.length; i += 2) {
            argsMap.put(args[i].toString(), args[i + 1]);
        }
        return argsMap;
    }

    public static Map<String, Object> fromObject(Object args) {
        Map<String, Object> resMap = new HashMap<>();
        if (args instanceof Map) {
            for (Object entry : ((Map) args).entrySet()) {
                if (entry instanceof Map.Entry) {
                    resMap.put(((Map.Entry) entry).getKey().toString(), ((Map.Entry) entry).getValue());
                }
            }
        }
        return resMap;
    }

    public static List<Map<String, Object>> createAdProviderMapList(List<AdProvider> adProviders) {
        List<Map<String, Object>> mapList = new ArrayList<>();
        for (AdProvider provider : adProviders) {
            mapList.add(adProvider(provider));
        }
        return mapList;
    }

    private static Map<String, Object> adProvider(AdProvider adProvider) {
        Map<String, Object> adMap = new HashMap<>();
        adMap.put("id", adProvider.getId());
        adMap.put("name", adProvider.getName());
        adMap.put("serviceArea", adProvider.getServiceArea());
        adMap.put("privacyPolicyUrl", adProvider.getPrivacyPolicyUrl());
        return adMap;
    }

    public static Map<String, Object> fromBiddingInfo(BiddingInfo biddingInfo) {
        Map<String, Object> map = new HashMap<>();
        map.put("price", biddingInfo.getPrice());
        map.put("currency", biddingInfo.getCur());
        map.put("nUrl", biddingInfo.getNurl());
        map.put("lUrl", biddingInfo.getLurl());
        return map;
    }
}
