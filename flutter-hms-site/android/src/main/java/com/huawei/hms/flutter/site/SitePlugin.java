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

package com.huawei.hms.flutter.site;

import android.content.Context;
import android.net.Uri;
import androidx.annotation.NonNull;
import com.huawei.agconnect.config.AGConnectServicesConfig;
import com.huawei.hms.flutter.site.handlers.MethodCallHandlerImpl;
import com.huawei.hms.site.api.SearchService;
import com.huawei.hms.site.api.SearchServiceFactory;

import com.google.gson.Gson;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class SitePlugin implements FlutterPlugin {
    private Gson mGson;
    private MethodChannel mMethodChannel;
    private SearchService mSearchService;
    private MethodChannel.MethodCallHandler mMethodCallHandler;

    public static void registerWith(Registrar registrar) {
        final SitePlugin instance = new SitePlugin();
        instance.onAttachedToEngine(registrar.context(), registrar.messenger());
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        onAttachedToEngine(binding.getApplicationContext(), binding.getBinaryMessenger());
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        mMethodChannel.setMethodCallHandler(null);
        mMethodCallHandler = null;
        mMethodChannel = null;
        mSearchService = null;
        mGson = null;
    }

    private void onAttachedToEngine(Context context, BinaryMessenger messenger) {
        final String apiKey = AGConnectServicesConfig.fromContext(context).getString("client/api_key");
        final String encodedApiKey = Uri.encode(apiKey);
        mGson = new Gson();
        mSearchService = SearchServiceFactory.create(context, encodedApiKey);
        mMethodChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.site/method");
        mMethodCallHandler = new MethodCallHandlerImpl(mSearchService, mGson);
        mMethodChannel.setMethodCallHandler(mMethodCallHandler);
    }
}
