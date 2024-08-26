/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.mllanguage;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mllanguage.handlers.AftHandler;
import com.huawei.hms.flutter.mllanguage.handlers.AsrHandler;
import com.huawei.hms.flutter.mllanguage.handlers.LangDetectionHandler;
import com.huawei.hms.flutter.mllanguage.handlers.LanguageApp;
import com.huawei.hms.flutter.mllanguage.handlers.LocalTranslateHandler;
import com.huawei.hms.flutter.mllanguage.handlers.RemoteTranslateHandler;
import com.huawei.hms.flutter.mllanguage.handlers.RttHandler;
import com.huawei.hms.flutter.mllanguage.handlers.SoundDetectionHandler;
import com.huawei.hms.flutter.mllanguage.handlers.TranslateLanguageHandler;
import com.huawei.hms.flutter.mllanguage.handlers.TtsHandler;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

public class HuaweiMlLanguagePlugin implements FlutterPlugin, ActivityAware {
    private FlutterPluginBinding flutterPluginBinding;
    private ActivityPluginBinding activityPluginBinding;

    private MethodChannel appChannel;
    private MethodChannel localTranslateChannel;
    private MethodChannel remoteTranslateChannel;
    private MethodChannel translateLanguageChannel;
    private MethodChannel soundDetectionChannel;
    private MethodChannel asrChannel;
    private MethodChannel langDetectChannel;
    private MethodChannel aftChannel;
    private MethodChannel rttChannel;
    private MethodChannel ttsChannel;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        this.flutterPluginBinding = binding;
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        activityPluginBinding = binding;
        if (flutterPluginBinding != null) {
            onAttachedToEngine(flutterPluginBinding.getBinaryMessenger(), binding.getActivity());
        }
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        activityPluginBinding = binding;
        if (flutterPluginBinding != null) {
            onAttachedToEngine(flutterPluginBinding.getBinaryMessenger(), binding.getActivity());
        }
    }

    @Override
    public void onDetachedFromActivity() {
        appChannel.setMethodCallHandler(null);
        localTranslateChannel.setMethodCallHandler(null);
        remoteTranslateChannel.setMethodCallHandler(null);
        translateLanguageChannel.setMethodCallHandler(null);
        soundDetectionChannel.setMethodCallHandler(null);
        asrChannel.setMethodCallHandler(null);
        langDetectChannel.setMethodCallHandler(null);
        aftChannel.setMethodCallHandler(null);
        rttChannel.setMethodCallHandler(null);
        ttsChannel.setMethodCallHandler(null);
        activityPluginBinding = null;
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        flutterPluginBinding = null;
        removeChannels();
    }

    private void onAttachedToEngine(final BinaryMessenger messenger, final Activity activity) {
        initChannels(messenger);
        setHandlers(activity);
    }

    private void initChannels(BinaryMessenger messenger) {
        appChannel = new MethodChannel(messenger, "hms_lang_app");
        localTranslateChannel = new MethodChannel(messenger, "hms_lang_local_translator");
        remoteTranslateChannel = new MethodChannel(messenger, "hms_lang_remote_translator");
        translateLanguageChannel = new MethodChannel(messenger, "hms_lang_translate_language");
        soundDetectionChannel = new MethodChannel(messenger, "hms_lang_sound_detection");
        asrChannel = new MethodChannel(messenger, "hms_lang_asr");
        langDetectChannel = new MethodChannel(messenger, "hms_lang_detection");
        aftChannel = new MethodChannel(messenger, "hms_lang_aft");
        rttChannel = new MethodChannel(messenger, "hms_lang_rtt");
        ttsChannel = new MethodChannel(messenger, "hms_lang_tts");
    }

    private void setHandlers(Activity activity) {
        appChannel.setMethodCallHandler(new LanguageApp(activity));
        localTranslateChannel.setMethodCallHandler(new LocalTranslateHandler(activity, localTranslateChannel));
        remoteTranslateChannel.setMethodCallHandler(new RemoteTranslateHandler(activity));
        translateLanguageChannel.setMethodCallHandler(new TranslateLanguageHandler(activity));
        soundDetectionChannel.setMethodCallHandler(new SoundDetectionHandler(activity, soundDetectionChannel));
        final AsrHandler asrHandler = new AsrHandler(activity, asrChannel);
        if (activityPluginBinding != null) {
            activityPluginBinding.addActivityResultListener(asrHandler);
        }
        asrChannel.setMethodCallHandler(asrHandler);
        langDetectChannel.setMethodCallHandler(new LangDetectionHandler(activity));
        aftChannel.setMethodCallHandler(new AftHandler(activity, aftChannel));
        rttChannel.setMethodCallHandler(new RttHandler(activity, rttChannel));
        ttsChannel.setMethodCallHandler(new TtsHandler(activity, ttsChannel));
    }

    private void removeChannels() {
        appChannel = null;
        localTranslateChannel = null;
        remoteTranslateChannel = null;
        translateLanguageChannel = null;
        soundDetectionChannel = null;
        asrChannel = null;
        langDetectChannel = null;
        aftChannel = null;
        rttChannel = null;
        ttsChannel = null;
    }
}
