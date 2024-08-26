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

package com.huawei.hms.flutter.mltext.customview;

import static android.app.Activity.RESULT_OK;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mltext.HuaweiMlTextPlugin;
import com.huawei.hms.flutter.mltext.constant.Channel;
import com.huawei.hms.flutter.mltext.utils.Commons;
import com.huawei.hms.flutter.mltext.utils.FromMap;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class CustomizedViewMethodCallHandler implements MethodChannel.MethodCallHandler, PluginRegistry.ActivityResultListener {

    private int remoteChannelId;

    private Activity mActivity;

    private static final int REQUEST_CODE_SCAN_CUSTOMIZED = 14;

    private MethodChannel.Result pendingResult;

    public CustomizedViewMethodCallHandler(final Activity activity, final MethodChannel remoteChannel) {
        remoteChannelId = UUID.randomUUID().hashCode();
        HuaweiMlTextPlugin.ML_TEXT_CHANNELS.put(remoteChannelId, remoteChannel);
        mActivity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        pendingResult = result;
        if ("customizedView".equals(call.method)) {
            customizedView(call, result);
        } else {
            result.notImplemented();
        }
    }

    private void customizedView(MethodCall call, MethodChannel.Result result) {
        // Arguments from call

        Integer resultType = FromMap.toInteger("resultType", call.argument("resultType"));
        Integer recMode = FromMap.toInteger("recMode", call.argument("recMode"));
        Boolean isFlashAvailable = FromMap.toBoolean("isFlashAvailable", call.argument("isFlashAvailable"));
        Boolean isTitleAvailable = FromMap.toBoolean("isTitleAvailable", call.argument("isTitleAvailable"));
        String title = call.argument("title");
        Double heightFactor = call.argument("heightFactor");
        Double widthFactor = call.argument("widthFactor");


        // Intent
        Intent intent = new Intent(mActivity, CustomizedViewActivity.class);

        intent.putExtra(Channel.CHANNEL_REMOTE_KEY, remoteChannelId);

        // Intent extras
        intent.putExtra("widthFactor", widthFactor.floatValue());
        intent.putExtra("heightFactor", heightFactor.floatValue());
        intent.putExtra("resultType", resultType);
        intent.putExtra("recMode", recMode);

        intent.putExtra("isFlashAvailable", isFlashAvailable);
        intent.putExtra("isTitleAvailable", isTitleAvailable);
        intent.putExtra("title", title);

        // Start intent for customized view
        mActivity.startActivityForResult(intent, REQUEST_CODE_SCAN_CUSTOMIZED);
    }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent intent) {
        if (resultCode != RESULT_OK) {
            return false;
        }
        if (resultCode == RESULT_OK) {
            if (requestCode == REQUEST_CODE_SCAN_CUSTOMIZED ) {
                formatIdCardResult(intent);
            }
        }
        return false;
    }

    private void formatIdCardResult(Intent intent) {
        Map<String, Object> object = new HashMap<>();

        object.put("number", intent.getStringExtra("number"));
        Bitmap originalBitmap = intent.getParcelableExtra("originalBitmap");
        Bitmap numberBitmap = intent.getParcelableExtra("numberBitmap");
        object.put("expire", intent.getStringExtra("expire"));
        object.put("issuer", intent.getStringExtra("issuer"));
        object.put("type", intent.getStringExtra("type"));
        object.put("organization", intent.getStringExtra("organization"));
        object.put("originalBytes", Commons.bitmapToByteArray(originalBitmap));
        object.put("numberBytes", Commons.bitmapToByteArray(numberBitmap));
        pendingResult.success(object);
    }
}
