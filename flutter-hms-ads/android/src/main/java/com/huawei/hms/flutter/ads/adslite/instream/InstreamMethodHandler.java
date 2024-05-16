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

package com.huawei.hms.flutter.ads.adslite.instream;

import android.content.Context;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ads.utils.FromMap;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class InstreamMethodHandler implements MethodChannel.MethodCallHandler  {
    private final BinaryMessenger messenger;
    private final Context context;

    public InstreamMethodHandler(final BinaryMessenger messenger, final Context context) {
        this.messenger = messenger;
        this.context = context;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "initInstreamLoader":
                initInstreamLoader(call, result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void initInstreamLoader(MethodCall call, MethodChannel.Result result){
        Integer id = FromMap.toInteger("id", call.argument("id"));
        String adId = FromMap.toString("adId", call.argument("adId"));
        Integer totalDuration = FromMap.toInteger("totalDuration", call.argument("totalDuration"));
        Integer maxCount = FromMap.toInteger("maxCount", call.argument("maxCount"));

        new InstreamAdLoader(context, messenger, id, adId, totalDuration, maxCount);
    }
}
