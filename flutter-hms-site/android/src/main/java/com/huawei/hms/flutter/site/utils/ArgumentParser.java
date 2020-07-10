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

package com.huawei.hms.flutter.site.utils;

import com.huawei.hms.site.api.model.Coordinate;
import com.huawei.hms.site.api.model.CoordinateBounds;
import com.huawei.hms.site.api.model.DetailSearchRequest;
import com.huawei.hms.site.api.model.LocationType;
import com.huawei.hms.site.api.model.NearbySearchRequest;
import com.huawei.hms.site.api.model.QuerySuggestionRequest;
import com.huawei.hms.site.api.model.TextSearchRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import io.flutter.plugin.common.MethodCall;

public class ArgumentParser {
    public static TextSearchRequest toTextSearchRequest(MethodCall call) {
        TextSearchRequest request = new TextSearchRequest();
        request.setQuery(call.<String>argument("query"));
        request.setLanguage(call.<String>argument("language"));
        request.setCountryCode(call.<String>argument("countryCode"));
        request.setPoliticalView(call.<String>argument("politicalView"));
        request.setLocation(toCoordinate(call.<Map<String, Object>>argument("location")));
        request.setRadius(call.<Integer>argument("radius"));
        request.setPageSize(call.<Integer>argument("pageSize"));
        request.setPageIndex(call.<Integer>argument("pageIndex"));
        request.setPoiType(getPoiType(call.<String>argument("poiType")));

        return request;
    }

    public static NearbySearchRequest toNearbySearchRequest(MethodCall call) {
        NearbySearchRequest request = new NearbySearchRequest();
        request.setQuery(call.<String>argument("query"));
        request.setLanguage(call.<String>argument("language"));
        request.setPoliticalView(call.<String>argument("politicalView"));
        request.setLocation(toCoordinate(call.<Map<String, Object>>argument("location")));
        request.setRadius(call.<Integer>argument("radius"));
        request.setPageSize(call.<Integer>argument("pageSize"));
        request.setPageIndex(call.<Integer>argument("pageIndex"));
        request.setPoiType(getPoiType(call.<String>argument("poiType")));

        return request;
    }

    public static DetailSearchRequest toDetailSearchRequest(MethodCall call) {
        DetailSearchRequest request = new DetailSearchRequest();
        request.setSiteId(call.<String>argument("siteId"));
        request.setLanguage(call.<String>argument("language"));
        request.setPoliticalView(call.<String>argument("politicalView"));

        return request;
    }

    public static QuerySuggestionRequest toQuerySuggestionRequest(MethodCall call) {
        QuerySuggestionRequest request = new QuerySuggestionRequest();
        request.setQuery(call.<String>argument("query"));
        request.setLanguage(call.<String>argument("language"));
        request.setPoliticalView(call.<String>argument("politicalView"));
        request.setLocation(toCoordinate(call.<Map<String, Object>>argument("location")));
        request.setRadius(call.<Integer>argument("radius"));
        request.setCountryCode(call.<String>argument("countryCode"));
        request.setBounds(toCoordinateBounds(
                call.<Map<String, Map<String, Object>>>argument("bounds")));

        List<String> poiTypeList = call.argument("poiTypes");
        List<LocationType> poiTypes = null;
        if (poiTypeList != null) {
            poiTypes = new ArrayList<>();
            for (String type : poiTypeList) {
                poiTypes.add(LocationType.valueOf(type));
            }
        }
        request.setPoiTypes(poiTypes);

        return request;
    }

    private static Coordinate toCoordinate(Map<String, Object> args) {
        if (args == null) {
            return null;
        }

        double lat = (double) args.get("lat");
        double lng = (double) args.get("lng");

        return new Coordinate(lat, lng);
    }

    private static CoordinateBounds toCoordinateBounds(Map<String, Map<String, Object>> args) {
        if (args == null) {
            return null;
        }

        Coordinate northeast = toCoordinate(args.get("northeast"));
        Coordinate southwest = toCoordinate(args.get("southwest"));

        return new CoordinateBounds(northeast, southwest);
    }

    private static LocationType getPoiType(String poiType) {
        return poiType == null ? null : LocationType.valueOf(poiType);
    }
}
