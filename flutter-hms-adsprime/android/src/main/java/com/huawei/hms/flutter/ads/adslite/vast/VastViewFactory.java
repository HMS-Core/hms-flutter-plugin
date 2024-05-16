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

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class VastViewFactory extends PlatformViewFactory {
    private final Activity activity;
    private final BinaryMessenger messenger;

    public VastViewFactory(Activity activity, BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        this.activity = activity;
        this.messenger = messenger;
    }

    @NonNull
    @Override
    public PlatformView create(@Nullable Context context, int viewId, @Nullable Object args) {
        return new FlutterVastView(activity, messenger, viewId, creationParamsToMap(args));
    }

    private Map<String, Object> creationParamsToMap(@Nullable Object args) {
        if (args != null) {
            return (Map<String, Object>) args;
        }
        return new HashMap<>();
    }
}
