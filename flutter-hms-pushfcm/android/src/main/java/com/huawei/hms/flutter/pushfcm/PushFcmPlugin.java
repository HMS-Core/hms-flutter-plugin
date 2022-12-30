/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.pushfcm;

import android.content.Context;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.pushfcm.constants.Method;
import com.huawei.hms.flutter.pushfcm.logger.HMSLogger;
import com.huawei.hms.push.plugin.base.proxy.ProxySettings;
import com.huawei.hms.push.plugin.fcm.FcmPushProxy;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * PushFcmPlugin
 *
 * @since 6.1.0
 */
public class PushFcmPlugin implements FlutterPlugin, MethodCallHandler {

    private static final String METHOD_CHANNEL = "com.huawei.hms.flutter.pushfcm/method";

    private MethodChannel channel;

    private Context context;

    public void onAttachedToEngine(final BinaryMessenger messenger, final Context context) {
        channel = new MethodChannel(messenger, METHOD_CHANNEL);
        channel.setMethodCallHandler(this);
        this.context = context;
    }

    @Override
    public void onAttachedToEngine(@NonNull final FlutterPluginBinding flutterPluginBinding) {
        onAttachedToEngine(flutterPluginBinding.getBinaryMessenger(), flutterPluginBinding.getApplicationContext());
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        switch (Method.valueOf(call.method)) {
            case initFcmProxy:
                HMSLogger.getInstance(context).startMethodExecutionTimer(Method.initFcmProxy.name());
                result.success(FcmPushProxy.init(context));
                HMSLogger.getInstance(context).sendSingleEvent(Method.initFcmProxy.name());
                break;
            case setCountryCode:
                HMSLogger.getInstance(context).startMethodExecutionTimer(Method.setCountryCode.name());
                ProxySettings.setCountryCode(context, call.argument("countryCode"));
                result.success(0);
                HMSLogger.getInstance(context).sendSingleEvent(Method.setCountryCode.name());
                break;
            case enableLogger:
                HMSLogger.getInstance(context).enableLogger();
                result.success(null);
                break;
            case disableLogger:
                HMSLogger.getInstance(context).disableLogger();
                result.success(null);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull final FlutterPluginBinding binding) {
        if (channel != null) {
            channel.setMethodCallHandler(null);
        }
    }
}
