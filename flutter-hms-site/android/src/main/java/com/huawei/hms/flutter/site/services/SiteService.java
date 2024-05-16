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

package com.huawei.hms.flutter.site.services;

import android.app.Activity;
import android.content.Intent;
import android.text.TextUtils;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.site.listeners.SearchResultListenerImpl;
import com.huawei.hms.flutter.site.utils.ArgumentParser;
import com.huawei.hms.flutter.site.utils.HMSLogger;
import com.huawei.hms.flutter.site.utils.ObjectSerializer;
import com.huawei.hms.site.api.SearchService;
import com.huawei.hms.site.api.SearchServiceFactory;
import com.huawei.hms.site.api.model.DetailSearchRequest;
import com.huawei.hms.site.api.model.NearbySearchRequest;
import com.huawei.hms.site.api.model.QueryAutocompleteRequest;
import com.huawei.hms.site.api.model.QuerySuggestionRequest;
import com.huawei.hms.site.api.model.SearchStatus;
import com.huawei.hms.site.api.model.Site;
import com.huawei.hms.site.api.model.TextSearchRequest;
import com.huawei.hms.site.widget.SearchIntent;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public final class SiteService implements PluginRegistry.ActivityResultListener {
    private static final String TAG = SiteService.class.getSimpleName();

    private final Activity activity;

    private SearchService searchService;

    private SearchIntent searchIntent;

    private MethodChannel.Result result;

    public SiteService(@NonNull final Activity activity) {
        this.activity = activity;
    }

    public void initService(@NonNull final MethodCall call, @NonNull final MethodChannel.Result result) {
        final String apiKey = call.argument("apiKey");
        final String routePolicy = call.argument("routePolicy");
        if (apiKey != null && !TextUtils.isEmpty(apiKey)) {
            if (routePolicy == null) {
                searchService = SearchServiceFactory.create(activity, apiKey);
                Log.i(TAG, "SearchService has been created.");
                result.success(null);
            } else {
                searchService = SearchServiceFactory.create(activity, apiKey, routePolicy);
                Log.i(TAG, "SearchService has been created and set the data storage location to: " + routePolicy);
                result.success(null);
            }
        } else {
            result.error("-1", "Api key cannot be null or empty", null);
        }
    }

    public void textSearch(@NonNull final MethodCall call, @NonNull final MethodChannel.Result result) {
        final TextSearchRequest request = ArgumentParser.getTextSearchRequest(call);
        searchService.textSearch(request, new SearchResultListenerImpl<>(activity, result, call.method));
    }

    public void nearbySearch(@NonNull final MethodCall call, @NonNull final MethodChannel.Result result) {
        final NearbySearchRequest request = ArgumentParser.getNearbySearchRequest(call);
        searchService.nearbySearch(request, new SearchResultListenerImpl<>(activity, result, call.method));
    }

    public void detailSearch(@NonNull final MethodCall call, @NonNull final MethodChannel.Result result) {
        final DetailSearchRequest request = ArgumentParser.getDetailSearchRequest(call);
        searchService.detailSearch(request, new SearchResultListenerImpl<>(activity, result, call.method));
    }

    public void querySuggestion(@NonNull final MethodCall call, @NonNull final MethodChannel.Result result) {
        final QuerySuggestionRequest request = ArgumentParser.getQuerySuggestionRequest(call);
        searchService.querySuggestion(request, new SearchResultListenerImpl<>(activity, result, call.method));
    }

    public void queryAutocomplete(@NonNull final MethodCall call, @NonNull final MethodChannel.Result result) {
        final QueryAutocompleteRequest request = ArgumentParser.getQueryAutocompleteRequest(call);
        searchService.queryAutocomplete(request, new SearchResultListenerImpl<>(activity, result, call.method));
    }

    public void startSiteSearchActivity(@NonNull final MethodCall call, @NonNull final MethodChannel.Result result) {
        this.result = result;
        searchIntent = ArgumentParser.getSearchIntent(call);
        final Intent intent = searchIntent.getIntent(activity)
            .setPackage(activity.getApplicationContext().getPackageName());
        activity.startActivityForResult(intent, SearchIntent.SEARCH_REQUEST_CODE);
    }

    @Override
    public boolean onActivityResult(final int requestCode, final int resultCode, final Intent data) {
        final MethodChannel.Result incomingResult = result;
        result = null;

        if (incomingResult != null) {
            if (SearchIntent.SEARCH_REQUEST_CODE == requestCode && SearchIntent.isSuccess(resultCode)
                && searchIntent != null && data != null) {
                final Site site = searchIntent.getSiteFromIntent(data);
                incomingResult.success(ObjectSerializer.INSTANCE.toJson(site));
                HMSLogger.getInstance(activity).sendSingleEvent("siteSearch");
            } else if (searchIntent != null && data != null) {
                final SearchStatus searchStatus = searchIntent.getStatusFromIntent(data);
                incomingResult.error(searchStatus.getErrorCode(), searchStatus.getErrorMessage(), null);
                HMSLogger.getInstance(activity).sendSingleEvent("siteSearch", "-1");
            } else {
                incomingResult.error("-1", "Unknown error. Site search task is failed.", null);
                HMSLogger.getInstance(activity).sendSingleEvent("siteSearch", "-1");
            }
        }
        return true;
    }
}
