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

package com.huawei.hms.flutter.mltext;

import android.app.Activity;
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mltext.constant.Channel;
import com.huawei.hms.flutter.mltext.customview.CustomizedViewMethodCallHandler;
import com.huawei.hms.flutter.mltext.handlers.BankcardAnalyzerMethodHandler;
import com.huawei.hms.flutter.mltext.handlers.DocumentAnalyzerMethodHandler;
import com.huawei.hms.flutter.mltext.handlers.FormRecognitionMethodHandler;
import com.huawei.hms.flutter.mltext.handlers.GeneralCardAnalyzerMethodHandler;
import com.huawei.hms.flutter.mltext.handlers.IdCardAnalyzerMethodHandler;
import com.huawei.hms.flutter.mltext.handlers.LensHandler;
import com.huawei.hms.flutter.mltext.handlers.TextAnalyzerMethodHandler;
import com.huawei.hms.flutter.mltext.handlers.TextEmbeddingMethodHandler;
import com.huawei.hms.flutter.mltext.mlapplication.MlApplicationMethodHandler;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.TextureRegistry;

public class HuaweiMlTextPlugin implements FlutterPlugin, ActivityAware {
    public final static SparseArray<MethodChannel> ML_TEXT_CHANNELS = new SparseArray<>();
    private FlutterPluginBinding mFlutterPluginBinding;
    private MethodChannel textAnalyzerMethodChannel;
    private MethodChannel documentAnalyzerMethodChannel;
    private MethodChannel bankcardMethodChannel;
    private MethodChannel generalCardMethodChannel;
    private MethodChannel idCardChannel;
    private MethodChannel formDetectionMethodChannel;
    private MethodChannel textEmbeddingMethodChannel;
    private MethodChannel mlApplicationMethodChannel;
    private MethodChannel lensMethodChannel;
    private MethodChannel customizedViewChannel;
    private MethodChannel remoteViewChannel;

    private CustomizedViewMethodCallHandler customizedViewMethodCallHandler;

    private void onAttachedToEngine(@NonNull final BinaryMessenger messenger, @NonNull final Activity activity,
            final TextureRegistry textureRegistry) {
        initializeChannels(messenger);
        setHandlers(activity, textureRegistry);
    }

    private void initializeChannels(final BinaryMessenger messenger) {
        textAnalyzerMethodChannel = new MethodChannel(messenger, Channel.TEXT_ANALYZER_CHANNEL);
        documentAnalyzerMethodChannel = new MethodChannel(messenger, Channel.DOCUMENT_CHANNEL);
        bankcardMethodChannel = new MethodChannel(messenger, Channel.BANKCARD_CHANNEL);
        generalCardMethodChannel = new MethodChannel(messenger, Channel.GCR_CHANNEL);
        formDetectionMethodChannel = new MethodChannel(messenger, Channel.FORM_CHANNEL);
        idCardChannel = new MethodChannel(messenger, Channel.ICR_CHANNEL);
        textEmbeddingMethodChannel = new MethodChannel(messenger, Channel.TEXT_EMBEDDING_CHANNEL);
        mlApplicationMethodChannel = new MethodChannel(messenger, Channel.APPLICATION_CHANNEL);
        lensMethodChannel = new MethodChannel(messenger, Channel.LENS_CHANNEL);
        customizedViewChannel = new MethodChannel(messenger, Channel.CUSTOMIZED_VIEW);
        remoteViewChannel = new MethodChannel(messenger, Channel.REMOTE_VIEW);
    }

    private void setHandlers(final Activity activity, TextureRegistry textureRegistry) {
        textAnalyzerMethodChannel.setMethodCallHandler(new TextAnalyzerMethodHandler(activity));
        documentAnalyzerMethodChannel.setMethodCallHandler(new DocumentAnalyzerMethodHandler(activity));
        bankcardMethodChannel.setMethodCallHandler(new BankcardAnalyzerMethodHandler(activity));
        generalCardMethodChannel.setMethodCallHandler(new GeneralCardAnalyzerMethodHandler(activity));
        idCardChannel.setMethodCallHandler(new IdCardAnalyzerMethodHandler(activity));
        formDetectionMethodChannel.setMethodCallHandler(new FormRecognitionMethodHandler(activity));
        textEmbeddingMethodChannel.setMethodCallHandler(new TextEmbeddingMethodHandler(activity));
        mlApplicationMethodChannel.setMethodCallHandler(new MlApplicationMethodHandler(activity));
        lensMethodChannel.setMethodCallHandler(new LensHandler(activity, lensMethodChannel, textureRegistry));
        customizedViewMethodCallHandler = new CustomizedViewMethodCallHandler(activity, remoteViewChannel);
        customizedViewChannel.setMethodCallHandler(customizedViewMethodCallHandler);
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        this.mFlutterPluginBinding = flutterPluginBinding;
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        this.mFlutterPluginBinding = null;
        removeChannels();
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding activityPluginBinding) {
        if (mFlutterPluginBinding != null) {
            onAttachedToEngine(mFlutterPluginBinding.getBinaryMessenger(), activityPluginBinding.getActivity(),
                    mFlutterPluginBinding.getTextureRegistry());
            activityPluginBinding.addActivityResultListener(customizedViewMethodCallHandler);
        }
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding activityPluginBinding) {
        if (mFlutterPluginBinding != null) {
            onAttachedToEngine(mFlutterPluginBinding.getBinaryMessenger(), activityPluginBinding.getActivity(),
                    mFlutterPluginBinding.getTextureRegistry());
        }
    }

    private void removeChannels() {
        textAnalyzerMethodChannel = null;
        documentAnalyzerMethodChannel = null;
        bankcardMethodChannel = null;
        generalCardMethodChannel = null;
        formDetectionMethodChannel = null;
        idCardChannel = null;
        mlApplicationMethodChannel = null;
        lensMethodChannel = null;
        customizedViewChannel = null;
        remoteViewChannel = null;
        ML_TEXT_CHANNELS.clear();
    }

    @Override
    public void onDetachedFromActivity() {
        textAnalyzerMethodChannel.setMethodCallHandler(null);
        documentAnalyzerMethodChannel.setMethodCallHandler(null);
        bankcardMethodChannel.setMethodCallHandler(null);
        generalCardMethodChannel.setMethodCallHandler(null);
        formDetectionMethodChannel.setMethodCallHandler(null);
        idCardChannel.setMethodCallHandler(null);
        mlApplicationMethodChannel.setMethodCallHandler(null);
        lensMethodChannel.setMethodCallHandler(null);
        customizedViewChannel.setMethodCallHandler(null);
        remoteViewChannel.setMethodCallHandler(null);
    }
}
