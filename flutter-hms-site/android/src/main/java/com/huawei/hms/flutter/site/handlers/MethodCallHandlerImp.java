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

package com.huawei.hms.flutter.site.handlers;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.site.services.SiteService;
import com.huawei.hms.flutter.site.utils.HMSLogger;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.Result;

public class MethodCallHandlerImp implements MethodChannel.MethodCallHandler {
    private final HMSLogger hmsLogger;
    private final SiteService service;

    public MethodCallHandlerImp(final HMSLogger hmsLogger,
                                final SiteService service) {
        this.hmsLogger = hmsLogger;
        this.service = service;
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        hmsLogger.startMethodExecutionTimer(call.method);

        switch (call.method) {
            case "initService":
                service.initService(call, result);
                break;
            case "textSearch":
                service.textSearch(call, result);
                break;
            case "nearbySearch":
                service.nearbySearch(call, result);
                break;
            case "detailSearch":
                service.detailSearch(call, result);
                break;
            case "querySuggestion":
                service.querySuggestion(call, result);
                break;
            case "queryAutocomplete":
                service.queryAutocomplete(call, result);
                break;
            case "startSiteSearchActivity":
                service.startSiteSearchActivity(call, result);
                break;
            case "enableLogger":
                hmsLogger.enableLogger();
                break;
            case "disableLogger":
                hmsLogger.disableLogger();
                break;
            default:
                result.notImplemented();
                break;
        }
    }
}
