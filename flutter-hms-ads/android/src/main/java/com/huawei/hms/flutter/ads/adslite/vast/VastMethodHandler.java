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

package com.huawei.hms.flutter.ads.adslite.vast;

import android.content.Context;

import androidx.annotation.NonNull;

import com.huawei.hms.ads.vast.adapter.SdkFactory;
import com.huawei.hms.ads.vast.adapter.VastSdkConfiguration;
import com.huawei.hms.flutter.ads.utils.FromMap;

import java.util.Map;
import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class VastMethodHandler implements MethodChannel.MethodCallHandler {
    private final Context context;

    public VastMethodHandler(final Context context) {
        this.context = context;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "SdkFactory-init":
                init(call, result);
                break;
            case "SdkFactory-getConfiguration":
                getConfiguration(result);
                break;
            case "SdkFactory-updateSdkServerConfig":
                updateSdkServerConfig(call, result);
                break;
            case "SdkFactory-userAcceptAdLicense":
                userAcceptAdLicense(call, result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void init(MethodCall call, MethodChannel.Result result) {
        final Map<String, Object> configMap = FromMap.toHashMap("configuration", call.argument("configuration"));
        SdkFactory.init(context, VastUtils.vastSdkConfigurationFromMap(Objects.requireNonNull(configMap)));
        result.success(true);
    }

    private void getConfiguration(MethodChannel.Result result) {
        final VastSdkConfiguration configuration = SdkFactory.getConfiguration();
        if (configuration != null) {
            result.success(VastUtils.vastSdkConfigurationToMap(configuration));
        } else {
            result.success(null);
        }
    }

    private void updateSdkServerConfig(MethodCall call, MethodChannel.Result result) {
        final String slotId = FromMap.toString("slotId", call.argument("slotId"));
        SdkFactory.updateSdkServerConfig(slotId);
        result.success(true);
    }

    private void userAcceptAdLicense(MethodCall call, MethodChannel.Result result) {
        final Boolean isAcceptOrNot = FromMap.toBoolean("isAcceptOrNot", call.argument("isAcceptOrNot"));
        SdkFactory.userAcceptAdLicense(isAcceptOrNot);
        result.success(true);
    }
}
