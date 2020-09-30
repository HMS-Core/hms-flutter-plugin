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

import android.app.Activity;
import android.content.Context;
import android.net.Uri;

import androidx.annotation.NonNull;

import com.huawei.agconnect.config.AGConnectServicesConfig;
import com.huawei.hms.flutter.site.constants.Channel;
import com.huawei.hms.flutter.site.handlers.ActivityAwareMethodCallHandlerImpl;
import com.huawei.hms.site.api.SearchService;
import com.huawei.hms.site.api.SearchServiceFactory;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class SitePlugin implements FlutterPlugin, ActivityAware {
    private SearchService searchService;
    private MethodChannel methodChannel;
    private ActivityAwareMethodCallHandlerImpl methodCallHandler;

    public static void registerWith(final Registrar registrar) {
        final SitePlugin instance = new SitePlugin();
        final Activity activity = registrar.activity();
        final Context context = registrar.context();

        // When context is available
        // searchService and methodChannel are instantiated
        instance.onAttachedToEngine(registrar.context(), registrar.messenger());

        // When activity is available
        // methodCallHandler is instantiated
        instance.methodCallHandler = new ActivityAwareMethodCallHandlerImpl(activity, instance.searchService,
            instance.getApiKey(context));
        instance.methodChannel.setMethodCallHandler(instance.methodCallHandler);
    }

    private String getApiKey(Context context) {
        final String rawApiKey = AGConnectServicesConfig.fromContext(context).getString("client/api_key");
        return Uri.encode(rawApiKey);
    }

    private void onAttachedToEngine(final Context context, final BinaryMessenger messenger) {
        searchService = SearchServiceFactory.create(context, getApiKey(context));
        methodChannel = new MethodChannel(messenger, Channel.METHOD_SEARCH_SERVICE);
    }

    private void onDetachedFromEngine() {
        searchService = null;
        methodChannel = null;
    }

    @Override
    public void onAttachedToEngine(@NonNull final FlutterPluginBinding binding) {
        onAttachedToEngine(binding.getApplicationContext(), binding.getBinaryMessenger());
    }

    @Override
    public void onDetachedFromEngine(@NonNull final FlutterPluginBinding binding) {
        onDetachedFromEngine();
    }

    @Override
    public void onAttachedToActivity(@NonNull final ActivityPluginBinding binding) {
        final Activity activity = binding.getActivity();
        methodCallHandler = new ActivityAwareMethodCallHandlerImpl(activity, searchService,
            getApiKey(activity.getApplicationContext()));
        methodChannel.setMethodCallHandler(methodCallHandler);
        binding.addActivityResultListener(methodCallHandler);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull final ActivityPluginBinding binding) {
        onAttachedToActivity(binding);
    }

    @Override
    public void onDetachedFromActivity() {
        methodChannel.setMethodCallHandler(null);
        methodCallHandler = null;
    }
}
