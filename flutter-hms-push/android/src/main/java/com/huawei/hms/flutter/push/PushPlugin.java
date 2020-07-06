/*
Copyright (c) Huawei Technologies Co., Ltd. 2012-2020. All rights reserved.

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

package com.huawei.hms.flutter.push;

import android.content.Context;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.push.constants.Param;
import com.huawei.hms.flutter.push.event.DataMessageStreamHandler;
import com.huawei.hms.flutter.push.event.TokenStreamHandler;
import com.huawei.hms.flutter.push.utils.Utils;
import com.huawei.hms.flutter.push.hms.FlutterHmsInstanceId;
import com.huawei.hms.flutter.push.hms.FlutterHmsMessaging;
import com.huawei.hms.flutter.push.constants.Method;
import com.huawei.hms.flutter.push.constants.Channel;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * class PushPlugin
 *
 * @since 4.0.4
 */
public class PushPlugin implements FlutterPlugin, MethodCallHandler {

    private MethodChannel channel;
    private static volatile Context context;

    public static Context getContext() {
        return PushPlugin.context;
    }

    public static void setContext(Context context) {
        PushPlugin.context = context;
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), Channel.METHOD_CHANNEL.id());
        channel.setMethodCallHandler(this);
        PushPlugin.setContext(flutterPluginBinding.getApplicationContext());

        EventChannel tokenEventChannel = new EventChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), Channel.TOKEN_CHANNEL.id());
        tokenEventChannel.setStreamHandler(new TokenStreamHandler(context));

        EventChannel dataMessageEventChannel = new EventChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), Channel.DATA_MESSAGE_CHANNEL.id());
        dataMessageEventChannel.setStreamHandler(new DataMessageStreamHandler(context));
    }

    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), Channel.METHOD_CHANNEL.id());
        channel.setMethodCallHandler(new PushPlugin());
        context = registrar.context();
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        if (channel != null) channel.setMethodCallHandler(null);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (Method.valueOf(call.method)) {
            case getId:
                FlutterHmsInstanceId.getId(result);
                break;
            case getAAID:
                FlutterHmsInstanceId.getAAID(result);
                break;
            case getAppId:
                FlutterHmsInstanceId.getAppId(result);
                break;
            case getCreationTime:
                FlutterHmsInstanceId.getCreationTime(result);
                break;
            case deleteAAID:
                FlutterHmsInstanceId.deleteAAID(result);
                break;
            default:
                onMethodCallToken(call, result);
        }
    }

    private void onMethodCallToken(@NonNull MethodCall call, @NonNull Result result) {
        switch (Method.valueOf(call.method)) {
            case getToken:
                FlutterHmsInstanceId.getToken();
                break;
            case deleteToken:
                FlutterHmsInstanceId.deleteToken();
                break;
            default:
                onMethodCallSubscribe(call, result);
        }
    }

    private void onMethodCallSubscribe(@NonNull MethodCall call, @NonNull Result result) {
        switch (Method.valueOf(call.method)) {
            case subscribe:
                FlutterHmsMessaging.subscribe(Utils.getStringArgument(call, Param.TOPIC.code()), result);
                break;
            case unsubscribe:
                FlutterHmsMessaging.unsubscribe(Utils.getStringArgument(call, Param.TOPIC.code()), result);
                break;
            default:
                onMethodCallEnable(call, result);
        }
    }

    private void onMethodCallEnable(@NonNull MethodCall call, @NonNull Result result) {
        switch (Method.valueOf(call.method)) {
            case turnOnPush:
                FlutterHmsMessaging.turnOnPush(result);
                break;
            case turnOffPush:
                FlutterHmsMessaging.turnOffPush(result);
                break;
            case setAutoInitEnabled:
                FlutterHmsMessaging.setAutoInitEnabled(Utils.getBoolArgument(call, Param.ENABLED.code()), result);
                break;
            case isAutoInitEnabled:
                FlutterHmsMessaging.isAutoInitEnabled(result);
                break;
            case getAgConnectValues:
                FlutterHmsInstanceId.getAgConnectValues(result);
                break;
            case showToast:
                Toast.makeText(context, Utils.getStringArgument(call, Param.MESSAGE.code()), Toast.LENGTH_LONG).show();
                break;
            default:
                result.notImplemented();
        }
    }

}
