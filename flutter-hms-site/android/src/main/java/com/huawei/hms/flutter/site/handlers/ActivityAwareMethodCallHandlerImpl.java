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

import android.app.Activity;
import android.content.Intent;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.site.listeners.SearchResultListenerImpl;
import com.huawei.hms.flutter.site.logger.HMSLogger;
import com.huawei.hms.flutter.site.utils.ArgumentParser;
import com.huawei.hms.flutter.site.utils.SingletonGson;
import com.huawei.hms.site.api.SearchService;
import com.huawei.hms.site.api.model.DetailSearchRequest;
import com.huawei.hms.site.api.model.NearbySearchRequest;
import com.huawei.hms.site.api.model.QuerySuggestionRequest;
import com.huawei.hms.site.api.model.Site;
import com.huawei.hms.site.api.model.TextSearchRequest;
import com.huawei.hms.site.widget.SearchIntent;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

public class ActivityAwareMethodCallHandlerImpl implements ActivityAwareMethodCallHandler {
    private final Activity activity;
    private final SearchService searchService;
    private final String apiKey;
    private final HMSLogger hmsLogger;

    private Result result;
    private SearchIntent searchIntent;

    public ActivityAwareMethodCallHandlerImpl(final Activity activity, final SearchService searchService,
        final String apiKey) {
        this.activity = activity;
        this.searchService = searchService;
        this.apiKey = apiKey;
        hmsLogger = HMSLogger.getInstance(activity.getApplicationContext());
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        hmsLogger.startMethodExecutionTimer(call.method);

        switch (call.method) {
            case "enableLogger":
                hmsLogger.enableLogger();
                break;
            case "disableLogger":
                hmsLogger.disableLogger();
                break;
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
            case "startSiteSearchActivity":
                startSiteSearchActivity(call, result, apiKey);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    @Override
    public boolean onActivityResult(final int requestCode, final int resultCode, final Intent data) {
        final Result incomingResult = result;
        result = null;

        if (incomingResult != null) {
            if (SearchIntent.SEARCH_REQUEST_CODE == requestCode && SearchIntent.isSuccess(resultCode)
                && searchIntent != null) {
                final Site site = searchIntent.getSiteFromIntent(data);
                incomingResult.success(SingletonGson.getInstance().toJson(site));
                hmsLogger.sendSingleEvent("siteSearch");
            } else {
                incomingResult.error("NULL_INTENT", "searchIntent is null", null);
                hmsLogger.sendSingleEvent("siteSearch", "-1");
            }
        }

        return true;
    }

    private void textSearch(@NonNull final MethodCall call, @NonNull final Result result) {
        final TextSearchRequest request = ArgumentParser.toTextSearchRequest(call);
        searchService.textSearch(request,
            new SearchResultListenerImpl<>(activity.getApplicationContext(), result, call.method));
    }

    private void nearbySearch(@NonNull final MethodCall call, @NonNull final Result result) {
        final NearbySearchRequest request = ArgumentParser.toNearbySearchRequest(call);
        searchService.nearbySearch(request,
            new SearchResultListenerImpl<>(activity.getApplicationContext(), result, call.method));
    }

    private void detailSearch(@NonNull final MethodCall call, @NonNull final Result result) {
        final DetailSearchRequest request = ArgumentParser.toDetailSearchRequest(call);
        searchService.detailSearch(request,
            new SearchResultListenerImpl<>(activity.getApplicationContext(), result, call.method));
    }

    private void querySuggestion(@NonNull final MethodCall call, @NonNull final Result result) {
        final QuerySuggestionRequest request = ArgumentParser.toQuerySuggestionRequest(call);
        searchService.querySuggestion(request,
            new SearchResultListenerImpl<>(activity.getApplicationContext(), result, call.method));
    }

    private void startSiteSearchActivity(@NonNull final MethodCall call, @NonNull final Result result,
        final String apiKey) {
        this.result = result;
        searchIntent = ArgumentParser.toSearchIntent(call, apiKey);
        final Intent intent = searchIntent.getIntent(activity);
        activity.startActivityForResult(intent, SearchIntent.SEARCH_REQUEST_CODE);
    }
}
