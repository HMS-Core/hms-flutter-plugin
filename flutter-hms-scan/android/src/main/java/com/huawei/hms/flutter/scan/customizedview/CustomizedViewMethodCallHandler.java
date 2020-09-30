/*
 * Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.huawei.hms.flutter.scan.customizedview;

import static android.app.Activity.RESULT_OK;

import android.app.Activity;
import android.content.Intent;
import android.text.TextUtils;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.scan.ScanPlugin;
import com.huawei.hms.flutter.scan.utils.Constants;
import com.huawei.hms.hmsscankit.ScanUtil;
import com.huawei.hms.ml.scan.HmsScan;
import com.huawei.hms.flutter.scan.utils.ValueGetter;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

import java.util.List;
import java.util.UUID;

public class CustomizedViewMethodCallHandler
    implements MethodChannel.MethodCallHandler, PluginRegistry.ActivityResultListener {

    private int customizedChannelId;
    private int remoteChannelId;
    private Activity mActivity;
    private MethodChannel.Result pendingResult;
    private Gson gson;

    private static final int REQUEST_CODE_SCAN_CUSTOMIZED = 14;

    public CustomizedViewMethodCallHandler(final Activity activity, final MethodChannel customizedChannel,
        final MethodChannel remoteChannel) {
        customizedChannelId = hashCode();
        remoteChannelId = UUID.randomUUID().hashCode();
        ScanPlugin.SCAN_CHANNELS.put(customizedChannelId, customizedChannel);
        ScanPlugin.SCAN_CHANNELS.put(remoteChannelId, remoteChannel);
        mActivity = activity;
        gson = new GsonBuilder().setPrettyPrinting().create();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        pendingResult = result;
        if ("customizedView".equals(call.method)) {
            customizedView(call);
        } else {
            result.notImplemented();
        }
    }

    private void customizedView(MethodCall call) {
        //Arguments from call
        int scanType = ValueGetter.getInt("scanType", call);
        List<Integer> additionalScanTypes = call.argument("additionalScanTypes");
        int[] scanTypesIntArray = null;

        int rectWidth = ValueGetter.getInt("rectWidth", call);
        int rectHeight = ValueGetter.getInt("rectHeight", call);

        boolean isGalleryAvailable = ValueGetter.getBoolean("isGalleryAvailable", call);
        boolean flashOnLightChange = ValueGetter.getBoolean("flashOnLightChange", call);
        boolean isFlashAvailable = ValueGetter.getBoolean("isFlashAvailable", call);

        boolean continuouslyScan = ValueGetter.getBoolean("continuouslyScan", call);

        //List<Integer> to int[]
        if (additionalScanTypes != null) {
            scanTypesIntArray = ValueGetter.scanTypesListToArray(additionalScanTypes);
        }

        //Intent
        Intent intent = new Intent(mActivity, CustomizedViewActivity.class);

        intent.putExtra(Constants.CHANNEL_ID_KEY, customizedChannelId);
        intent.putExtra(Constants.CHANNEL_REMOTE_KEY, remoteChannelId);

        //Intent extras
        intent.putExtra("scanType", scanType);
        if (additionalScanTypes != null) {
            intent.putExtra("additionalScanTypes", scanTypesIntArray);
        }
        intent.putExtra("rectWidth", rectWidth);
        intent.putExtra("rectHeight", rectHeight);

        intent.putExtra("flashOnLightChange", flashOnLightChange);
        intent.putExtra("isFlashAvailable", isFlashAvailable);
        intent.putExtra("gallery", isGalleryAvailable);
        intent.putExtra("continuouslyScan", continuouslyScan);

        //Start intent for customized view
        mActivity.startActivityForResult(intent, REQUEST_CODE_SCAN_CUSTOMIZED);
    }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent data) {

        //onActivityResult control
        if (resultCode != RESULT_OK || data == null) {
            return false;
        }
        //Request Code control
        //Customized View
        if (requestCode == REQUEST_CODE_SCAN_CUSTOMIZED) {
            if (pendingResult != null) {
                HmsScan hmsScan = data.getParcelableExtra(ScanUtil.RESULT);
                //Sending Result
                if (hmsScan != null && !TextUtils.isEmpty(hmsScan.getOriginalValue())) {
                    pendingResult.success(gson.toJson(hmsScan));
                    pendingResult = null; //reset
                }
            }
        } else {
            pendingResult = null;
        }
        return false;
    }
}
