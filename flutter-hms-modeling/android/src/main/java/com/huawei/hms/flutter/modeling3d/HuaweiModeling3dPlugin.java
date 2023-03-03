/*
 * Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.modeling3d;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.modeling3d.materialgen.handlers.MaterialEngineHandler;
import com.huawei.hms.flutter.modeling3d.materialgen.handlers.MaterialGenAppHandler;
import com.huawei.hms.flutter.modeling3d.materialgen.handlers.MaterialTaskUtilHandler;
import com.huawei.hms.flutter.modeling3d.modeling3dcapture.Modeling3dCaptureImageEngineHandler;
import com.huawei.hms.flutter.modeling3d.motioncapture.MotionCaptureViewFactory;
import com.huawei.hms.flutter.modeling3d.utils.Constants;
import com.huawei.hms.flutter.modeling3d.reconstruct3d.Modeling3DEngineHandler;
import com.huawei.hms.flutter.modeling3d.reconstruct3d.ReconstructApplicationHandler;
import com.huawei.hms.flutter.modeling3d.reconstruct3d.TaskUtilHandler;
import com.huawei.hms.flutter.modeling3d.utils.PermissionHandler;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

public class HuaweiModeling3dPlugin implements FlutterPlugin, ActivityAware {
    private FlutterPluginBinding flutterPluginBinding;
    private MethodChannel modeling3dReconstructTaskUtilsChannel;
    private MethodChannel modeling3dReconstructEngineChannel;
    private MethodChannel reconstructApplicationChannel;
    private MethodChannel materialGenApplicationChannel;
    private MethodChannel modeling3dTextureEngineChannel;
    private MethodChannel modeling3dTextureTaskUtilsChannel;
    private MethodChannel modeling3dCaptureImageEngineChannel;
    private MethodChannel modeling3dPermissionClientChannel;


    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        this.flutterPluginBinding = binding;
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding activityPluginBinding) {
        if (flutterPluginBinding != null) {
            onAttachedToEngine(flutterPluginBinding.getBinaryMessenger(), activityPluginBinding.getActivity());

            final MotionCaptureViewFactory motionCaptureViewFactory = new MotionCaptureViewFactory(flutterPluginBinding.getBinaryMessenger(), activityPluginBinding.getActivity());
            flutterPluginBinding.getPlatformViewRegistry().registerViewFactory(Constants.ViewType.VIEW_TYPE, motionCaptureViewFactory);
        }
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
        modeling3dReconstructTaskUtilsChannel.setMethodCallHandler(null);
        modeling3dReconstructEngineChannel.setMethodCallHandler(null);
        reconstructApplicationChannel.setMethodCallHandler(null);
        materialGenApplicationChannel.setMethodCallHandler(null);
        modeling3dTextureEngineChannel.setMethodCallHandler(null);
        modeling3dTextureTaskUtilsChannel.setMethodCallHandler(null);
        modeling3dCaptureImageEngineChannel.setMethodCallHandler(null);
        modeling3dPermissionClientChannel.setMethodCallHandler(null);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        flutterPluginBinding = null;

        modeling3dReconstructTaskUtilsChannel = null;
        modeling3dReconstructEngineChannel = null;
        reconstructApplicationChannel = null;
        materialGenApplicationChannel = null;
        modeling3dTextureEngineChannel = null;
        modeling3dTextureTaskUtilsChannel = null;
        modeling3dCaptureImageEngineChannel = null;
        modeling3dPermissionClientChannel = null;
    }

    private void onAttachedToEngine(final BinaryMessenger messenger, final Activity activity) {
        modeling3dReconstructTaskUtilsChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.modeling3d/reconstructTaskUtils/method");
        modeling3dReconstructEngineChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.modeling3d/reconstructEngine/method");
        reconstructApplicationChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.modeling3d/reconstructApplication/method");
        materialGenApplicationChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.modeling3d/materialGenApplication/method");
        modeling3dTextureEngineChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.modeling3d/textureEngine/method");
        modeling3dTextureTaskUtilsChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.modeling3d/textureTaskUtils/method");
        modeling3dCaptureImageEngineChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.modeling3d/captureImageEngine/method");
        modeling3dPermissionClientChannel = new MethodChannel(messenger, "com.huawei.hms.flutter.modeling3d/permission/method");

        modeling3dReconstructTaskUtilsChannel.setMethodCallHandler(new TaskUtilHandler(activity));
        modeling3dReconstructEngineChannel.setMethodCallHandler(new Modeling3DEngineHandler(activity, modeling3dReconstructEngineChannel));
        reconstructApplicationChannel.setMethodCallHandler(new ReconstructApplicationHandler(activity));
        materialGenApplicationChannel.setMethodCallHandler(new MaterialGenAppHandler(activity));
        modeling3dTextureEngineChannel.setMethodCallHandler(new MaterialEngineHandler(activity, modeling3dTextureEngineChannel));
        modeling3dTextureTaskUtilsChannel.setMethodCallHandler(new MaterialTaskUtilHandler(activity));
        modeling3dCaptureImageEngineChannel.setMethodCallHandler(new Modeling3dCaptureImageEngineHandler(activity, modeling3dCaptureImageEngineChannel));
        modeling3dPermissionClientChannel.setMethodCallHandler(new PermissionHandler(activity));
    }
}
