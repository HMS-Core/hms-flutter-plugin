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

import android.content.Intent;

import androidx.annotation.NonNull;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener;

public interface ActivityAwareMethodCallHandler extends MethodCallHandler, ActivityResultListener {
    /**
     * Handles the specified method call received from Flutter.
     * @param call   A {@link MethodCall}.
     * @param result A {@link Result} used for submitting the result of the call.
     */
    @Override
    void onMethodCall(@NonNull MethodCall call, @NonNull Result result);

    /**
     * Called when an activity you launched exits.
     * @param requestCode Request code that specified when calling startActvityForResultMethod
     * @param resultCode  Result status code
     * @param data        Incoming data
     * @return true if the result has been handled.
     */
    @Override
    boolean onActivityResult(int requestCode, int resultCode, Intent data);
}
