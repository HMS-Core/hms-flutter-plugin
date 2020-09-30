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
import com.huawei.hms.site.widget.SearchFilter;
import com.huawei.hms.site.widget.SearchIntent;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;

public final class ArgumentParser {
    private ArgumentParser() {
    }

    public static TextSearchRequest toTextSearchRequest(final MethodCall call) {
        final TextSearchRequest request = new TextSearchRequest();
        request.setQuery(call.argument("query"));
        request.setLanguage(call.argument("language"));
        request.setCountryCode(call.argument("countryCode"));
        request.setPoliticalView(call.argument("politicalView"));
        request.setLocation(toCoordinate(call.argument("location")));
        request.setRadius(call.<Integer>argument("radius"));
        request.setPageSize(call.<Integer>argument("pageSize"));
        request.setPageIndex(call.<Integer>argument("pageIndex"));
        request.setPoiType(getPoiType(call.argument("poiType")));

        return request;
    }

    public static NearbySearchRequest toNearbySearchRequest(final MethodCall call) {
        final NearbySearchRequest request = new NearbySearchRequest();
        request.setQuery(call.argument("query"));
        request.setLanguage(call.argument("language"));
        request.setPoliticalView(call.argument("politicalView"));
        request.setLocation(toCoordinate(call.argument("location")));
        request.setRadius(call.<Integer>argument("radius"));
        request.setPageSize(call.<Integer>argument("pageSize"));
        request.setPageIndex(call.<Integer>argument("pageIndex"));
        request.setPoiType(getPoiType(call.argument("poiType")));

        return request;
    }

    public static DetailSearchRequest toDetailSearchRequest(final MethodCall call) {
        final DetailSearchRequest request = new DetailSearchRequest();
        request.setSiteId(call.argument("siteId"));
        request.setLanguage(call.argument("language"));
        request.setPoliticalView(call.argument("politicalView"));

        return request;
    }

    public static QuerySuggestionRequest toQuerySuggestionRequest(final MethodCall call) {
        final QuerySuggestionRequest request = new QuerySuggestionRequest();
        request.setQuery(call.argument("query"));
        request.setLanguage(call.argument("language"));
        request.setPoliticalView(call.argument("politicalView"));
        request.setLocation(toCoordinate(call.argument("location")));
        request.setRadius(call.<Integer>argument("radius"));
        request.setCountryCode(call.argument("countryCode"));
        request.setBounds(toCoordinateBounds(call.argument("bounds")));

        final List<String> poiTypeList = call.argument("poiTypes");
        List<LocationType> poiTypes = null;

        if (poiTypeList != null) {
            poiTypes = new ArrayList<>();
            for (final String type : poiTypeList) {
                poiTypes.add(LocationType.valueOf(type));
            }
        }
        request.setPoiTypes(poiTypes);

        return request;
    }

    private static Coordinate toCoordinate(final Map<String, Object> args) {
        if (args == null) {
            return null;
        }

        final double lat = (double) args.get("lat");
        final double lng = (double) args.get("lng");

        return new Coordinate(lat, lng);
    }

    private static CoordinateBounds toCoordinateBounds(final Map<String, Map<String, Object>> args) {
        if (args == null) {
            return null;
        }

        final Coordinate northeast = toCoordinate(args.get("northeast"));
        final Coordinate southwest = toCoordinate(args.get("southwest"));

        return new CoordinateBounds(northeast, southwest);
    }

    private static LocationType getPoiType(final String poiType) {
        return poiType == null ? null : LocationType.valueOf(poiType);
    }

    public static SearchIntent toSearchIntent(final MethodCall call, final String apiKey) {
        final SearchIntent searchIntent = new SearchIntent();
        final SearchFilter searchFilter = getSearchFilter(call.argument("searchFilter"));

        searchIntent.setApiKey(apiKey);
        searchIntent.setHint(call.argument("hint"));
        searchIntent.setSearchFilter(searchFilter);

        return searchIntent;
    }

    private static SearchFilter getSearchFilter(final Map<String, Object> args) {
        final SearchFilter searchFilter = new SearchFilter();

        if (args == null) {
            return searchFilter;
        }

        searchFilter.setCountryCode(ObjectUtils.cast(args.get("countryCode"), String.class));
        searchFilter.setLanguage((ObjectUtils.cast(args.get("language"), String.class)));
        searchFilter.setLocation(toCoordinate(ObjectUtils.cast(args.get("location"), Map.class)));
        searchFilter.setPoliticalView(ObjectUtils.cast(args.get("politicalView"), String.class));
        searchFilter.setQuery((ObjectUtils.cast(args.get("query"), String.class)));
        searchFilter.setRadius(ObjectUtils.cast(args.get("radius"), Integer.class));
        return searchFilter;
    }
}
