/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.site.utils;

import com.huawei.hms.site.api.model.DetailSearchRequest;
import com.huawei.hms.site.api.model.NearbySearchRequest;
import com.huawei.hms.site.api.model.QueryAutocompleteRequest;
import com.huawei.hms.site.api.model.QuerySuggestionRequest;
import com.huawei.hms.site.api.model.TextSearchRequest;
import com.huawei.hms.site.widget.SearchFilter;
import com.huawei.hms.site.widget.SearchIntent;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;

public final class ArgumentParser {
    private ArgumentParser() {
    }

    public static TextSearchRequest getTextSearchRequest(final MethodCall call) {
        return ObjectSerializer.INSTANCE.fromJson(call.arguments(), TextSearchRequest.class);
    }

    public static NearbySearchRequest getNearbySearchRequest(final MethodCall call) {
        return ObjectSerializer.INSTANCE.fromJson(call.arguments(), NearbySearchRequest.class);
    }

    public static DetailSearchRequest getDetailSearchRequest(final MethodCall call) {
        return ObjectSerializer.INSTANCE.fromJson(call.arguments(), DetailSearchRequest.class);
    }

    public static QuerySuggestionRequest getQuerySuggestionRequest(final MethodCall call) {
        return ObjectSerializer.INSTANCE.fromJson(call.arguments(), QuerySuggestionRequest.class);
    }

    public static QueryAutocompleteRequest getQueryAutocompleteRequest(final MethodCall call) {
        return ObjectSerializer.INSTANCE.fromJson(call.arguments(), QueryAutocompleteRequest.class);
    }

    public static SearchIntent getSearchIntent(final MethodCall call) {
        final Map<String, Object> searchFilterMap = call.argument("searchFilter");
        final String searchFilterAsJson = ObjectSerializer.INSTANCE.toJson(searchFilterMap);

        final String hint = call.argument("hint");
        final String apiKey = call.argument("apiKey");

        final SearchIntent searchIntent = new SearchIntent();
        searchIntent.setHint(hint);
        searchIntent.setApiKey(apiKey);

        final SearchFilter searchFilter = ObjectSerializer.INSTANCE.fromJson(searchFilterAsJson, SearchFilter.class);

        if (searchFilter != null) {
            searchIntent.setSearchFilter(searchFilter);
        } else {
            searchIntent.setSearchFilter(new SearchFilter());
        }
        return searchIntent;
    }
}
