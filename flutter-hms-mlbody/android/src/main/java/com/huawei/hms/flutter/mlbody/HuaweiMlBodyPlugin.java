/*
 * Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.mlbody;

import android.app.Activity;
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mlbody.constant.Constants;
import com.huawei.hms.flutter.mlbody.handlers.AppHandler;
import com.huawei.hms.flutter.mlbody.handlers.Face3dMethodHandler;
import com.huawei.hms.flutter.mlbody.handlers.FaceMethodHandler;
import com.huawei.hms.flutter.mlbody.handlers.GestureHandler;
import com.huawei.hms.flutter.mlbody.handlers.HandMethodHandler;
import com.huawei.hms.flutter.mlbody.handlers.InteractiveLivenessCustomDetectionHandler;
import com.huawei.hms.flutter.mlbody.handlers.InteractiveLivenessHandler;
import com.huawei.hms.flutter.mlbody.handlers.LensHandler;
import com.huawei.hms.flutter.mlbody.handlers.LivenessHandler;
import com.huawei.hms.flutter.mlbody.handlers.SkeletonHandler;
import com.huawei.hms.flutter.mlbody.handlers.VerificationHandler;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.TextureRegistry;

public class HuaweiMlBodyPlugin implements FlutterPlugin, ActivityAware {
    public final static SparseArray<MethodChannel> ML_BODY_CHANNELS = new SparseArray<>();
    private FlutterPluginBinding mFlutterPluginBinding;
    private MethodChannel appChannel;
    private MethodChannel faceMethodChannel;
    private MethodChannel face3DMethodChannel;
    private MethodChannel handMethodChannel;
    private MethodChannel gestureMethodChannel;
    private MethodChannel skeletonMethodChannel;
    private MethodChannel verificationMethodChannel;
    private MethodChannel livenessMethodChannel;
    private MethodChannel interactiveLivenessMethodChannel;
    private MethodChannel lensMethodChannel;
    private MethodChannel customizedMethodChannel;

    private void onAttachedToEngine(final BinaryMessenger messenger, final Activity activity,
            final TextureRegistry registry) {
        initChannels(messenger);
        setHandlers(activity, messenger, registry);
    }

    private void initChannels(BinaryMessenger messenger) {
        appChannel = new MethodChannel(messenger, Constants.APP_CHANNEL);
        faceMethodChannel = new MethodChannel(messenger, Constants.FACE_CHANNEL);
        face3DMethodChannel = new MethodChannel(messenger, Constants.FACE_3D_CHANNEL);
        handMethodChannel = new MethodChannel(messenger, Constants.HAND_CHANNEL);
        gestureMethodChannel = new MethodChannel(messenger, Constants.GESTURE_CHANNEL);
        skeletonMethodChannel = new MethodChannel(messenger, Constants.SKELETON_CHANNEL);
        verificationMethodChannel = new MethodChannel(messenger, Constants.VERIFICATION_CHANNEL);
        livenessMethodChannel = new MethodChannel(messenger, Constants.LIVENESS_CHANNEL);
        interactiveLivenessMethodChannel = new MethodChannel(messenger, Constants.INTERACTIVE_LIVENESS_CHANNEL);
        lensMethodChannel = new MethodChannel(messenger, Constants.LENS_CHANNEL);
        customizedMethodChannel = new MethodChannel(messenger, Constants.CUSTOMIIZED_CHANNEL);
    }

    private void setHandlers(Activity activity, BinaryMessenger messenger, TextureRegistry registry) {
        appChannel.setMethodCallHandler(new AppHandler(activity));
        faceMethodChannel.setMethodCallHandler(new FaceMethodHandler(activity));
        face3DMethodChannel.setMethodCallHandler(new Face3dMethodHandler(activity));
        handMethodChannel.setMethodCallHandler(new HandMethodHandler(activity));
        gestureMethodChannel.setMethodCallHandler(new GestureHandler(activity));
        skeletonMethodChannel.setMethodCallHandler(new SkeletonHandler(activity));
        verificationMethodChannel.setMethodCallHandler(new VerificationHandler(activity));
        livenessMethodChannel.setMethodCallHandler(new LivenessHandler(activity));
        interactiveLivenessMethodChannel.setMethodCallHandler(new InteractiveLivenessHandler(activity, messenger));
        lensMethodChannel.setMethodCallHandler(new LensHandler(activity, lensMethodChannel, registry));
        customizedMethodChannel.setMethodCallHandler(new InteractiveLivenessCustomDetectionHandler(activity));
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        this.mFlutterPluginBinding = flutterPluginBinding;
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        this.mFlutterPluginBinding = null;
        removeChannels();
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        if (mFlutterPluginBinding != null) {
            onAttachedToEngine(mFlutterPluginBinding.getBinaryMessenger(), binding.getActivity(),
                    mFlutterPluginBinding.getTextureRegistry());
        }
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        if (mFlutterPluginBinding != null) {
            onAttachedToEngine(mFlutterPluginBinding.getBinaryMessenger(), binding.getActivity(),
                    mFlutterPluginBinding.getTextureRegistry());
        }
    }

    private void removeChannels() {
        appChannel = null;
        faceMethodChannel = null;
        face3DMethodChannel = null;
        handMethodChannel = null;
        gestureMethodChannel = null;
        skeletonMethodChannel = null;
        verificationMethodChannel = null;
        livenessMethodChannel = null;
        interactiveLivenessMethodChannel = null;
        lensMethodChannel = null;
        ML_BODY_CHANNELS.clear();
        customizedMethodChannel = null;
    }

    @Override
    public void onDetachedFromActivity() {
        appChannel.setMethodCallHandler(null);
        faceMethodChannel.setMethodCallHandler(null);
        face3DMethodChannel.setMethodCallHandler(null);
        handMethodChannel.setMethodCallHandler(null);
        gestureMethodChannel.setMethodCallHandler(null);
        skeletonMethodChannel.setMethodCallHandler(null);
        verificationMethodChannel.setMethodCallHandler(null);
        livenessMethodChannel.setMethodCallHandler(null);
        interactiveLivenessMethodChannel.setMethodCallHandler(null);
        lensMethodChannel.setMethodCallHandler(null);
        customizedMethodChannel.setMethodCallHandler(null);
    }
}
