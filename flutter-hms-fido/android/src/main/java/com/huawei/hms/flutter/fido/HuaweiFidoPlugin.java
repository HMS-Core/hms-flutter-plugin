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

package com.huawei.hms.flutter.fido;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.fido.bioauthnx.BioAuthnManagerMethodHandler;
import com.huawei.hms.flutter.fido.bioauthnx.BioAuthnPromptMethodHandler;
import com.huawei.hms.flutter.fido.bioauthnx.FaceManagerMethodHandler;
import com.huawei.hms.flutter.fido.fidoclient.FidoClientMethodHandler;
import com.huawei.hms.flutter.fido.utils.Constants;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class HuaweiFidoPlugin implements FlutterPlugin, ActivityAware {
    private FlutterPluginBinding mFlutterPluginBinding;
    private ActivityPluginBinding mActivityPluginBinding;

    private MethodChannel bioAuthnManagerMethodChannel;
    private MethodChannel bioAuthnPromptMethodChannel;
    private MethodChannel faceManagerMethodChannel;
    private MethodChannel fidoClientMethodChannel;

    public static void registerWith(Registrar registrar) {
        HuaweiFidoPlugin plugin = new HuaweiFidoPlugin();
        plugin.onAttachedToEngine(registrar.messenger(), registrar.activity());
    }

    private void onAttachedToEngine(final BinaryMessenger messenger, final Activity activity) {
        initChannels(messenger);
        setHandlers(messenger, activity);
    }

    private void initChannels(BinaryMessenger messenger) {
        bioAuthnManagerMethodChannel = new MethodChannel(messenger, Constants.BIO_AUTH_MANAGER_METHOD_CHANNEL);
        bioAuthnPromptMethodChannel = new MethodChannel(messenger, Constants.BIO_AUTH_PROMPT_METHOD_CHANNEL);
        faceManagerMethodChannel = new MethodChannel(messenger, Constants.FACE_MANAGER_METHOD_CHANNEL);
        fidoClientMethodChannel = new MethodChannel(messenger, Constants.FIDO_CLIENT_METHOD_CHANNEL);
    }

    private void setHandlers(BinaryMessenger messenger, Activity activity) {
        bioAuthnManagerMethodChannel.setMethodCallHandler(new BioAuthnManagerMethodHandler(activity));
        bioAuthnPromptMethodChannel.setMethodCallHandler(new BioAuthnPromptMethodHandler(activity, messenger));
        faceManagerMethodChannel.setMethodCallHandler(new FaceManagerMethodHandler(activity, messenger));

        FidoClientMethodHandler handler = new FidoClientMethodHandler(activity);
        if (mActivityPluginBinding != null) {
            mActivityPluginBinding.addActivityResultListener(handler);
        }
        fidoClientMethodChannel.setMethodCallHandler(handler);
    }

    private void removeChannels() {
        bioAuthnManagerMethodChannel = null;
        bioAuthnPromptMethodChannel = null;
        faceManagerMethodChannel = null;
        fidoClientMethodChannel = null;
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        this.mFlutterPluginBinding = binding;
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        this.mFlutterPluginBinding = null;
        removeChannels();
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        mActivityPluginBinding = binding;
        if (mFlutterPluginBinding != null) {
            onAttachedToEngine(mFlutterPluginBinding.getBinaryMessenger(), binding.getActivity());
        }
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        mActivityPluginBinding = binding;
        if (mFlutterPluginBinding != null) {
            onAttachedToEngine(mFlutterPluginBinding.getBinaryMessenger(), binding.getActivity());
        }
    }

    @Override
    public void onDetachedFromActivity() {
        bioAuthnManagerMethodChannel.setMethodCallHandler(null);
        bioAuthnPromptMethodChannel.setMethodCallHandler(null);
        faceManagerMethodChannel.setMethodCallHandler(null);
        fidoClientMethodChannel.setMethodCallHandler(null);
        mActivityPluginBinding = null;
    }
}
