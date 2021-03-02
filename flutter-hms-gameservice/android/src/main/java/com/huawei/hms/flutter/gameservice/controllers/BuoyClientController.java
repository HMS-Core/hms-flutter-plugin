/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.gameservice.controllers;

import android.app.Activity;
import android.content.Context;
import android.util.Pair;

import com.huawei.hms.flutter.gameservice.common.Constants;
import com.huawei.hms.flutter.gameservice.common.utils.HMSLogger;
import com.huawei.hms.flutter.gameservice.common.utils.ValueGetter;
import com.huawei.hms.jos.games.Games;
import com.huawei.hms.jos.games.buoy.BuoyClient;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class BuoyClientController {
    private Context context;

    private BuoyClient buoyClient;

    public BuoyClientController(Activity activity) {
        this.context = activity.getApplicationContext();
        this.buoyClient = Games.getBuoyClient(activity);
    }

    public void onMethodCall(final MethodCall call, final MethodChannel.Result result) {
        final Pair<String, String> methodNamePair = ValueGetter.methodNameExtractor(call);
        Constants.BuoyClientMethods methodName = Constants.BuoyClientMethods.getEnum(methodNamePair.second);
        if (methodName == Constants.BuoyClientMethods.SHOW_FLOAT_WINDOW) {
            showFloatWindow(call.method, result);
        } else if (methodName == Constants.BuoyClientMethods.HIDE_FLOAT_WINDOW) {
            hideFloatWindow(call.method, result);
        }
    }

    public void showFloatWindow(final String methodName, final MethodChannel.Result result) {
        buoyClient.showFloatWindow();
        HMSLogger.getInstance(context).sendSingleEvent(methodName);
        result.success(true);
    }

    public void hideFloatWindow(final String methodName, final MethodChannel.Result result) {
        buoyClient.hideFloatWindow();
        HMSLogger.getInstance(context).sendSingleEvent(methodName);
        result.success(true);
    }
}
