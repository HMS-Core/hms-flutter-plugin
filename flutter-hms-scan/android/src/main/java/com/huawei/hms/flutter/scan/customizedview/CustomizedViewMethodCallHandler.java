/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.scan.customizedview;

import android.app.Activity;
import android.content.Intent;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.scan.ScanPlugin;
import com.huawei.hms.flutter.scan.utils.Constants;
import com.huawei.hms.flutter.scan.utils.ValueGetter;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import java.util.List;
import java.util.UUID;

public class CustomizedViewMethodCallHandler implements MethodChannel.MethodCallHandler {

    private int customizedChannelId;

    private int remoteChannelId;

    private Activity mActivity;

    public CustomizedViewMethodCallHandler(final Activity activity, final MethodChannel customizedChannel,
        final MethodChannel remoteChannel) {
        customizedChannelId = hashCode();
        remoteChannelId = UUID.randomUUID().hashCode();
        ScanPlugin.SCAN_CHANNELS.put(customizedChannelId, customizedChannel);
        ScanPlugin.SCAN_CHANNELS.put(remoteChannelId, remoteChannel);
        mActivity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if ("customizedView".equals(call.method)) {
            customizedView(call, result);
        } else {
            result.notImplemented();
        }
    }

    private void customizedView(MethodCall call, MethodChannel.Result result) {
        // Arguments from call
        int scanType = ValueGetter.getInt("scanType", call);
        List<Integer> additionalScanTypes = call.argument("additionalScanTypes");
        int[] scanTypesIntArray = null;

        int rectWidth = ValueGetter.getInt("rectWidth", call);
        int rectHeight = ValueGetter.getInt("rectHeight", call);

        boolean isGalleryAvailable = ValueGetter.getBoolean("isGalleryAvailable", call);
        boolean flashOnLightChange = ValueGetter.getBoolean("flashOnLightChange", call);
        boolean isFlashAvailable = ValueGetter.getBoolean("isFlashAvailable", call);

        boolean continuouslyScan = ValueGetter.getBoolean("continuouslyScan", call);
        boolean enableReturnBitmap = ValueGetter.getBoolean("enableReturnBitmap", call);

        // List<Integer> to int[]
        if (additionalScanTypes != null) {
            scanTypesIntArray = ValueGetter.scanTypesListToArray(additionalScanTypes);
        }

        // Intent
        Intent intent = new Intent(mActivity, CustomizedViewActivity.class);

        intent.putExtra(Constants.CHANNEL_ID_KEY, customizedChannelId);
        intent.putExtra(Constants.CHANNEL_REMOTE_KEY, remoteChannelId);

        // Intent extras
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
        intent.putExtra("enableReturnBitmap", enableReturnBitmap);

        // Start intent for customized view
        mActivity.startActivity(intent);
        result.success(true);
    }
}
