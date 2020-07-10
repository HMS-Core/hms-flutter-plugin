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

package com.huawei.hms.flutter.site.handlers;

import androidx.annotation.NonNull;
import com.huawei.hms.flutter.site.listeners.ResultListener;
import com.huawei.hms.flutter.site.utils.ArgumentParser;
import com.huawei.hms.site.api.SearchService;
import com.huawei.hms.site.api.model.DetailSearchRequest;
import com.huawei.hms.site.api.model.DetailSearchResponse;
import com.huawei.hms.site.api.model.NearbySearchRequest;
import com.huawei.hms.site.api.model.NearbySearchResponse;
import com.huawei.hms.site.api.model.QuerySuggestionRequest;
import com.huawei.hms.site.api.model.QuerySuggestionResponse;
import com.huawei.hms.site.api.model.TextSearchRequest;
import com.huawei.hms.site.api.model.TextSearchResponse;

import com.google.gson.Gson;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class MethodCallHandlerImpl implements MethodCallHandler {
    private final SearchService mSearchService;
    private final Gson mGson;

    public MethodCallHandlerImpl(SearchService searchService, Gson gson) {
        mSearchService = searchService;
        mGson = gson;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "textSearch":
                textSearch(call, result);
                break;
            case "nearbySearch":
                nearbySearch(call, result);
                break;
            case "detailSearch":
                detailSearch(call, result);
                break;
            case "querySuggestion":
                querySuggestion(call, result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void textSearch(@NonNull MethodCall call, @NonNull Result result) {
        TextSearchRequest request = ArgumentParser.toTextSearchRequest(call);
        mSearchService.textSearch(request, new ResultListener<TextSearchResponse>(result, mGson));
    }

    private void nearbySearch(@NonNull MethodCall call, @NonNull Result result) {
        NearbySearchRequest request = ArgumentParser.toNearbySearchRequest(call);
        mSearchService.nearbySearch(request, new ResultListener<NearbySearchResponse>(result, mGson));
    }

    private void detailSearch(@NonNull MethodCall call, @NonNull Result result) {
        DetailSearchRequest request = ArgumentParser.toDetailSearchRequest(call);
        mSearchService.detailSearch(request, new ResultListener<DetailSearchResponse>(result, mGson));
    }

    private void querySuggestion(@NonNull MethodCall call, @NonNull Result result) {
        QuerySuggestionRequest request = ArgumentParser.toQuerySuggestionRequest(call);
        mSearchService.querySuggestion(request, new ResultListener<QuerySuggestionResponse>(result, mGson));
    }
}
