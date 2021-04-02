/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.nearbyservice;

import android.app.Activity;
import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.nearbyservice.discovery.DiscoveryMethodHandler;
import com.huawei.hms.flutter.nearbyservice.logger.HMSLogger;
import com.huawei.hms.flutter.nearbyservice.message.MessageMethodHandler;
import com.huawei.hms.flutter.nearbyservice.permission.PermissionMethodHandler;
import com.huawei.hms.flutter.nearbyservice.transfer.TransferMethodHandler;
import com.huawei.hms.flutter.nearbyservice.utils.FromMap;
import com.huawei.hms.flutter.nearbyservice.utils.HmsHelper;
import com.huawei.hms.flutter.nearbyservice.utils.ToMap;
import com.huawei.hms.flutter.nearbyservice.utils.constants.Channels;
import com.huawei.hms.flutter.nearbyservice.utils.constants.ErrorCodes;
import com.huawei.hms.flutter.nearbyservice.wifi.WifiShareMethodHandler;
import com.huawei.hms.nearby.Nearby;
import com.huawei.hms.nearby.NearbyApiContext;
import com.huawei.hms.nearby.message.Message;

import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * HMS Nearby Plugin
 *
 * @author Huawei Technologies
 * @since (5.0.4 + 302)
 */
public class HuaweiNearbyServicePlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
    private static final String TAG = "HMSNearbyServicePlugin";

    private Context context;

    private FlutterPluginBinding flutterPluginBinding;

    private MethodChannel channel;

    private MethodChannel discoveryMethodChannel;
    private EventChannel discoveryEventChannelConnect;
    private EventChannel discoveryEventChannelScan;

    private MethodChannel transferMethodChannel;
    private EventChannel transferEventChannel;

    private MethodChannel wifiMethodChannel;
    private EventChannel wifiEventChannel;

    private MethodChannel messageMethodChannel;
    private EventChannel messageEventChannel;

    private MethodChannel permissionMethodChannel;

    private DiscoveryMethodHandler discoveryMethodHandler;
    private TransferMethodHandler transferMethodHandler;
    private WifiShareMethodHandler wifiMethodHandler;
    private MessageMethodHandler messageMethodHandler;
    private PermissionMethodHandler permissionMethodHandler;

    private void initChannels(final BinaryMessenger messenger) {
        channel = new MethodChannel(messenger, Channels.NEARBY_METHOD_CHANNEL);
        permissionMethodChannel = new MethodChannel(messenger, Channels.PERMISSION_METHOD_CHANNEL);
        discoveryMethodChannel = new MethodChannel(messenger, Channels.DISCOVERY_METHOD_CHANNEL);
        discoveryEventChannelConnect = new EventChannel(messenger, Channels.DISCOVERY_EVENT_CHANNEL_CONNECT);
        discoveryEventChannelScan = new EventChannel(messenger, Channels.DISCOVERY_EVENT_CHANNEL_SCAN);
        transferMethodChannel = new MethodChannel(messenger, Channels.TRANSFER_METHOD_CHANNEL);
        transferEventChannel = new EventChannel(messenger, Channels.TRANSFER_EVENT_CHANNEL);
        wifiMethodChannel = new MethodChannel(messenger, Channels.WIFI_METHOD_CHANNEL);
        wifiEventChannel = new EventChannel(messenger, Channels.WIFI_EVENT_CHANNEL);
        messageMethodChannel = new MethodChannel(messenger, Channels.MESSAGE_METHOD_CHANNEL);
        messageEventChannel = new EventChannel(messenger, Channels.MESSAGE_EVENT_CHANNEL);
    }

    private void initHandlers(Activity activity) {
        permissionMethodHandler = new PermissionMethodHandler(activity);
        discoveryMethodHandler = new DiscoveryMethodHandler(discoveryEventChannelConnect, discoveryEventChannelScan, transferEventChannel, activity);
        transferMethodHandler = new TransferMethodHandler(activity);
        wifiMethodHandler = new WifiShareMethodHandler(wifiEventChannel, activity);
        messageMethodHandler = new MessageMethodHandler(messageMethodChannel, messageEventChannel, activity);
    }

    private void setHandlers() {
        channel.setMethodCallHandler(this);
        permissionMethodChannel.setMethodCallHandler(permissionMethodHandler);
        discoveryMethodChannel.setMethodCallHandler(discoveryMethodHandler);
        transferMethodChannel.setMethodCallHandler(transferMethodHandler);
        wifiMethodChannel.setMethodCallHandler(wifiMethodHandler);
        messageMethodChannel.setMethodCallHandler(messageMethodHandler);
    }

    private void resetHandlers() {
        channel.setMethodCallHandler(null);
        permissionMethodChannel.setMethodCallHandler(null);
        discoveryMethodChannel.setMethodCallHandler(null);
        transferMethodChannel.setMethodCallHandler(null);
        messageMethodChannel.setMethodCallHandler(null);
    }

    private void removeHandlers() {
        permissionMethodHandler = null;
        discoveryMethodHandler = null;
        transferMethodHandler = null;
        wifiMethodHandler = null;
        messageMethodHandler = null;
    }

    private void removeChannels() {
        channel = null;
        permissionMethodChannel = null;
        discoveryMethodChannel = null;
        discoveryEventChannelConnect = null;
        discoveryEventChannelScan = null;
        transferMethodChannel = null;
        transferEventChannel = null;
        wifiMethodChannel = null;
        wifiEventChannel = null;
        messageMethodChannel = null;
        messageEventChannel = null;
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        this.flutterPluginBinding = flutterPluginBinding;
    }

    public static void registerWith(Registrar registrar) {
        final HuaweiNearbyServicePlugin instance = new HuaweiNearbyServicePlugin();
        instance.onAttachedToEngine(registrar.messenger(), registrar.activity());
    }

    private void onAttachedToEngine(BinaryMessenger messenger, Activity activity) {
        initChannels(messenger);
        initHandlers(activity);
        setHandlers();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer(call.method);
        switch (call.method) {
            case "getVersion":
                getVersion(result);
                break;
            case "setApiKey":
                setApiKey(call, result);
                break;
            case "getApiKey":
                getApiKey(result);
                break;
            case "equalsMessage":
                equalsMessage(call, result);
                break;
            case "enableLogger":
                enableLogger(result);
                break;
            case "disableLogger":
                disableLogger(result);
                break;
            default:
                HMSLogger.getInstance(context).sendSingleEvent(call.method, ErrorCodes.NOT_FOUND);
                result.notImplemented();
                return;
        }
        HMSLogger.getInstance(context).sendSingleEvent(call.method);
    }

    void getVersion(Result result) {
        result.success(Nearby.getVersion());
    }

    void setApiKey(MethodCall call, Result result) {
        Log.i(TAG, "setApiKey");
        String key = FromMap.toString("apiKey", call.argument("apiKey"), false);
        NearbyApiContext.getInstance().setApiKey(key);
        result.success(null);
        Log.i(TAG, "setApiKey call success");
    }

    void getApiKey(Result result) {
        Log.i(TAG, "getApiKey");
        result.success(NearbyApiContext.getInstance().getApiKey());
        Log.i(TAG, "getApiKey call success");
    }

    void equalsMessage(MethodCall call, Result result) {
        Map<String, Object> objectMap = ToMap.fromObject(call.argument("object"));
        Map<String, Object> otherMap = ToMap.fromObject(call.argument("other"));
        Message object = HmsHelper.createMessage(ToMap.fromObject(objectMap));
        Message other = HmsHelper.createMessage(ToMap.fromObject(otherMap));
        result.success(object != null && object.equals(other));
    }

    void enableLogger(Result result) {
        HMSLogger.getInstance(context).enableLogger();
        result.success(null);
    }

    void disableLogger(Result result) {
        HMSLogger.getInstance(context).disableLogger();
        result.success(null);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        removeChannels();
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        context = binding.getActivity().getApplicationContext();
        if (flutterPluginBinding != null) {
            onAttachedToEngine(flutterPluginBinding.getBinaryMessenger(), binding.getActivity());
        }
        binding.addRequestPermissionsResultListener(permissionMethodHandler);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        onAttachedToActivity(binding);
    }

    @Override
    public void onDetachedFromActivity() {
        resetHandlers();
        removeHandlers();
    }
}
