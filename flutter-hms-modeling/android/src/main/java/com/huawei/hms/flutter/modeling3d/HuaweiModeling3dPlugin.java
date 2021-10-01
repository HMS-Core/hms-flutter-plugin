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

package com.huawei.hms.flutter.modeling3d;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.modeling3d.materialgen.handlers.MaterialEngineHandler;
import com.huawei.hms.flutter.modeling3d.materialgen.handlers.MaterialGenAppHandler;
import com.huawei.hms.flutter.modeling3d.materialgen.handlers.MaterialTaskUtilHandler;
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
    private FlutterPluginBinding mFlutterPluginBinding;

    private MethodChannel materialEngineChannel;

    private MethodChannel materialGenAppChannel;

    private MethodChannel materialUtilChannel;

    private MethodChannel modelling3dRecEngineChannel;

    private MethodChannel modelling3dUtilsChannel;

    private MethodChannel reconstructApplicationChannel;

    private MethodChannel permissionChannel;

    private void onAttachedToEngine(final BinaryMessenger messenger, final Activity activity) {
        initChannels(messenger);
        setHandlers(activity);
    }

    private void initChannels(BinaryMessenger messenger) {
        materialEngineChannel = new MethodChannel(messenger, "com.huawei.modeling3d.materialgenengine/method");
        materialGenAppChannel = new MethodChannel(messenger, "com.huawei.modeling3d.materialgenapp/method");
        materialUtilChannel = new MethodChannel(messenger, "com.huawei.modeling3d.materialtask/method");

        modelling3dRecEngineChannel = new MethodChannel(messenger,
            Constants.Channels.MODELING3D_RECONSTRUCT_ENGINE_CHANNEL);
        modelling3dUtilsChannel = new MethodChannel(messenger, Constants.Channels.MODELING3D_TASK_UTILS_CHANNEL);
        reconstructApplicationChannel = new MethodChannel(messenger, Constants.Channels.RECONSTRUCT_APP_CHANNEL);

        permissionChannel = new MethodChannel(messenger, Constants.Channels.PERMISSION_CHANNEL);
    }

    private void setHandlers(Activity activity) {
        materialEngineChannel.setMethodCallHandler(new MaterialEngineHandler(activity, materialEngineChannel));

        materialGenAppChannel.setMethodCallHandler(new MaterialGenAppHandler(activity));

        materialUtilChannel.setMethodCallHandler(new MaterialTaskUtilHandler(activity));

        modelling3dRecEngineChannel.setMethodCallHandler(
            new Modeling3DEngineHandler(activity.getApplicationContext(), modelling3dRecEngineChannel));

        modelling3dUtilsChannel.setMethodCallHandler(new TaskUtilHandler(activity.getApplicationContext()));

        reconstructApplicationChannel.setMethodCallHandler(
            new ReconstructApplicationHandler(activity.getApplicationContext()));

        permissionChannel.setMethodCallHandler(new PermissionHandler(activity));
    }

    private void removeChannels() {
        materialEngineChannel = null;
        materialGenAppChannel = null;
        materialUtilChannel = null;
        modelling3dRecEngineChannel = null;
        modelling3dUtilsChannel = null;
        reconstructApplicationChannel = null;
        permissionChannel = null;
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
        if (mFlutterPluginBinding != null) {
            onAttachedToEngine(mFlutterPluginBinding.getBinaryMessenger(), binding.getActivity());
        }
    }

    @Override
    public void onDetachedFromActivity() {
        materialEngineChannel.setMethodCallHandler(null);
        materialGenAppChannel.setMethodCallHandler(null);
        materialUtilChannel.setMethodCallHandler(null);

        modelling3dRecEngineChannel.setMethodCallHandler(null);
        modelling3dUtilsChannel.setMethodCallHandler(null);
        reconstructApplicationChannel.setMethodCallHandler(null);

        permissionChannel.setMethodCallHandler(null);
    }
}
