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

package com.huawei.hms.flutter.nearbyservice;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.nearbyservice.beacon.BeaconMethodHandler;
import com.huawei.hms.flutter.nearbyservice.discovery.DiscoveryMethodHandler;
import com.huawei.hms.flutter.nearbyservice.logger.HMSLogger;
import com.huawei.hms.flutter.nearbyservice.message.MessageMethodHandler;
import com.huawei.hms.flutter.nearbyservice.transfer.TransferMethodHandler;
import com.huawei.hms.flutter.nearbyservice.utils.FromMap;
import com.huawei.hms.flutter.nearbyservice.utils.HmsHelper;
import com.huawei.hms.flutter.nearbyservice.utils.ToMap;
import com.huawei.hms.flutter.nearbyservice.utils.constants.Channels;
import com.huawei.hms.flutter.nearbyservice.utils.constants.ErrorCodes;
import com.huawei.hms.nearby.Nearby;
import com.huawei.hms.nearby.NearbyApiContext;
import com.huawei.hms.nearby.common.RegionCode;
import com.huawei.hms.nearby.message.Message;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import java.util.Map;

public class HuaweiNearbyServicePlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
    private Context context;

    private FlutterPluginBinding flutterPluginBinding;

    private MethodChannel channel;

    private MethodChannel discoveryMethodChannel;

    private EventChannel discoveryEventChannelConnect;

    private EventChannel discoveryEventChannelScan;

    private MethodChannel transferMethodChannel;

    private EventChannel transferEventChannel;

    private MethodChannel messageMethodChannel;

    private EventChannel messageEventChannel;

    private MethodChannel beaconMethodChannel;

    private EventChannel beaconEventChannel;

    private DiscoveryMethodHandler discoveryMethodHandler;

    private TransferMethodHandler transferMethodHandler;

    private MessageMethodHandler messageMethodHandler;

    private BeaconMethodHandler beaconMethodHandler;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        this.flutterPluginBinding = flutterPluginBinding;
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        context = binding.getActivity().getApplicationContext();
        if (flutterPluginBinding != null) {
            initChannels(flutterPluginBinding.getBinaryMessenger());
            initHandlers(binding.getActivity());
            setHandlers();
        }
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        onAttachedToActivity(binding);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onDetachedFromActivity() {
        resetHandlers();
        removeHandlers();
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        removeChannels();
    }

    private void initChannels(final BinaryMessenger messenger) {
        channel = new MethodChannel(messenger, Channels.NEARBY_METHOD_CHANNEL);
        discoveryMethodChannel = new MethodChannel(messenger, Channels.DISCOVERY_METHOD_CHANNEL);
        discoveryEventChannelConnect = new EventChannel(messenger, Channels.DISCOVERY_EVENT_CHANNEL_CONNECT);
        discoveryEventChannelScan = new EventChannel(messenger, Channels.DISCOVERY_EVENT_CHANNEL_SCAN);
        transferMethodChannel = new MethodChannel(messenger, Channels.TRANSFER_METHOD_CHANNEL);
        transferEventChannel = new EventChannel(messenger, Channels.TRANSFER_EVENT_CHANNEL);
        messageMethodChannel = new MethodChannel(messenger, Channels.MESSAGE_METHOD_CHANNEL);
        messageEventChannel = new EventChannel(messenger, Channels.MESSAGE_EVENT_CHANNEL);
        beaconMethodChannel = new MethodChannel(messenger, Channels.BEACON_METHOD_CHANNEL);
        beaconEventChannel = new EventChannel(messenger, Channels.BEACON_EVENT_CHANNEL);

    }

    private void initHandlers(Activity activity) {
        discoveryMethodHandler = new DiscoveryMethodHandler(discoveryEventChannelConnect, discoveryEventChannelScan,
            transferEventChannel, activity);
        transferMethodHandler = new TransferMethodHandler(activity);
        messageMethodHandler = new MessageMethodHandler(messageMethodChannel, messageEventChannel, activity);
        beaconMethodHandler = new BeaconMethodHandler(beaconEventChannel, activity);
    }

    private void setHandlers() {
        channel.setMethodCallHandler(this);
        discoveryMethodChannel.setMethodCallHandler(discoveryMethodHandler);
        transferMethodChannel.setMethodCallHandler(transferMethodHandler);
        messageMethodChannel.setMethodCallHandler(messageMethodHandler);
        beaconMethodChannel.setMethodCallHandler(beaconMethodHandler);
    }

    private void resetHandlers() {
        channel.setMethodCallHandler(null);
        discoveryMethodChannel.setMethodCallHandler(null);
        transferMethodChannel.setMethodCallHandler(null);
        messageMethodChannel.setMethodCallHandler(null);
        beaconMethodChannel.setMethodCallHandler(null);
    }

    private void removeHandlers() {
        discoveryMethodHandler = null;
        transferMethodHandler = null;
        messageMethodHandler = null;
        beaconMethodHandler = null;
    }

    private void removeChannels() {
        channel = null;
        discoveryMethodChannel = null;
        discoveryEventChannelConnect = null;
        discoveryEventChannelScan = null;
        transferMethodChannel = null;
        transferEventChannel = null;
        messageMethodChannel = null;
        messageEventChannel = null;
        beaconMethodChannel = null;
        beaconEventChannel = null;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer(call.method);
        switch (call.method) {
            case "getVersion":
                final String version = Nearby.getVersion();
                result.success(version);
                break;
            case "setApiKey":
                final String key = FromMap.toString("apiKey", call.argument("apiKey"), false);
                NearbyApiContext.getInstance().setApiKey(key);
                result.success(true);
                break;
            case "getApiKey":
                final String apiKey = NearbyApiContext.getInstance().getApiKey();
                result.success(apiKey);
                break;
            case "equalsMessage":
                final Map<String, Object> objectMap = ToMap.fromObject(call.argument("object"));
                final Map<String, Object> otherMap = ToMap.fromObject(call.argument("other"));
                final Message object = HmsHelper.createMessage(ToMap.fromObject(objectMap));
                final Message other = HmsHelper.createMessage(ToMap.fromObject(otherMap));
                result.success(object != null && object.equals(other));
                break;
            case "setAgcRegion":
                Object regionCodeObj = call.argument("regionCode");
                if (regionCodeObj instanceof Integer) {
                    final RegionCode code = intToEnum((Integer) regionCodeObj);
                    result.success(Nearby.setAgcRegion(context, code));
                }
                break;
            case "enableLogger":
                HMSLogger.getInstance(context).enableLogger();
                result.success(true);
                break;
            case "disableLogger":
                HMSLogger.getInstance(context).disableLogger();
                result.success(true);
                break;
            default:
                HMSLogger.getInstance(context).sendSingleEvent(call.method, ErrorCodes.NOT_FOUND);
                result.notImplemented();
                return;
        }
        HMSLogger.getInstance(context).sendSingleEvent(call.method);
    }

    public RegionCode intToEnum(int value) {
        for (RegionCode code : RegionCode.values()) {
            if (code.ordinal() == value) {
                return code;
            }
        }
        throw new IllegalArgumentException("Invalid integer value for enum: " + value);
    }
}
