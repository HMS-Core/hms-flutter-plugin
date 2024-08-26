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

package com.huawei.hms.flutter.mlbody.handlers;

import android.app.Activity;
import android.content.Intent;

import androidx.annotation.NonNull;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.huawei.hms.flutter.mlbody.constant.Constants;
import com.huawei.hms.flutter.mlbody.data.FromMap;
import com.huawei.hms.flutter.mlbody.data.MlBodyActions;
import com.huawei.hms.flutter.mlbody.data.Rect;
import com.huawei.hms.flutter.mlbody.data.TextOptions;
import com.huawei.hms.flutter.mlbody.data.ToMap;
import com.huawei.hms.mlsdk.interactiveliveness.MLInteractiveLivenessCapture;
import com.huawei.hms.mlsdk.interactiveliveness.MLInteractiveLivenessCaptureResult;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class InteractiveLivenessCustomDetectionHandler implements MethodChannel.MethodCallHandler {

    private int remoteChannelId;

    private Activity mActivity;

    public static MethodChannel.Result pendingResult;

    private Gson gson;

    public InteractiveLivenessCustomDetectionHandler(final Activity activity) {
        remoteChannelId = UUID.randomUUID().hashCode();
        mActivity = activity;
        gson = new GsonBuilder().setPrettyPrinting().create();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        pendingResult = result;
        if ("startCustomizedView".equals(call.method)) {
            customizedView(call, result);
        } else {
            result.notImplemented();
        }
    }

    public static Map<String, Object> fromObject(Object args) {
        Map<String, Object> resMap = new HashMap<>();
        if (args instanceof Map) {
            for (Object entry : ((Map) args).entrySet()) {
                if (entry instanceof Map.Entry) {
                    resMap.put(((Map.Entry) entry).getKey().toString(), ((Map.Entry) entry).getValue());
                }
            }
        }
        return resMap;
    }

    private void customizedView(MethodCall call, MethodChannel.Result result) {
        // Arguments from call

        int num = 1;
        boolean isRandom = false;
        HashMap<Integer, Object> actionArrayHashMap = new HashMap<>();
        HashMap<Integer, Object> statusCodeListArrayHashMap = new HashMap<>();

        MlBodyActions actionMap;
        if (call.argument("action") != null) {
            Map<String, Object> action = fromObject(call.argument("action"));
            Map<String, Object> actionArray = fromObject(action.get("actionArray"));
            action.get("isRandom");
            action.get("num");
            for (Map.Entry<String, Object> entry : actionArray.entrySet()) {
                actionArrayHashMap.put(Integer.parseInt(entry.getKey()), entry.getValue());
            }
            isRandom = (boolean) action.get("isRandom");
            num = (int) action.get("num");
        } else {
            actionMap = new MlBodyActions();
        }

        if (call.argument("statusCodes") != null) {
            Map<String, Object> statusCodesArray = fromObject(call.argument("statusCodes"));

            for (Map.Entry<String, Object> entry : statusCodesArray.entrySet()) {
                statusCodeListArrayHashMap.put(Integer.parseInt(entry.getKey()), entry.getValue());
            }
        }

        TextOptions textOptions;
        if (call.argument("scanTextOptions") == null) {
            textOptions = new TextOptions();
        } else {
            textOptions = gson.fromJson((String) call.argument("scanTextOptions"), TextOptions.class);
        }

        Rect cameraFrame;
        if (call.argument("cameraFrame") == null) {
            cameraFrame = new Rect();
        } else {
            cameraFrame = gson.fromJson((String) call.argument("cameraFrame"), Rect.class);
        }

        Rect faceFrame;
        if (call.argument("faceFrame") == null) {
            faceFrame = new Rect();
        } else {
            faceFrame = gson.fromJson((String) call.argument("faceFrame"), Rect.class);
        }

        String title = FromMap.toString("title", call.argument("title"), false);
        boolean showStatusCodes = FromMap.toBoolean("showStatusCodes", call.argument("showStatusCodes"));
        int textMargin = FromMap.toInteger("textMargin", call.argument("textMargin"));

        int detectionTimeOut = FromMap.toInteger("detectionTimeOut", call.argument("detectionTimeOut"));

        // Intent
        Intent intent = new Intent(mActivity, InteractiveLivenessCustomDetectionActivity.class);

        intent.putExtra(Constants.CHANNEL_REMOTE_KEY, remoteChannelId);

        intent.putExtra("isRandom", isRandom);
        intent.putExtra("num", num);
        intent.putExtra("actionArray", actionArrayHashMap);
        intent.putExtra("title", title);
        intent.putExtra("textColor", textOptions.getTextColor());
        intent.putExtra("textSize", textOptions.getTextSize());
        intent.putExtra("autoSizeText", textOptions.getAutoSizeText());
        intent.putExtra("minTextSize", textOptions.getMinTextSize());
        intent.putExtra("maxTextSize", textOptions.getMaxTextSize());
        intent.putExtra("granularity", textOptions.getGranularity());
        intent.putExtra("textMargin", textMargin);
        intent.putExtra("detectionTimeOut", detectionTimeOut);
        intent.putExtra("statusCodes", statusCodeListArrayHashMap);
        intent.putExtra("showStatusCodes", showStatusCodes);

        intent.putExtra("faceFrameBottom", faceFrame.getBottom());
        intent.putExtra("faceFrameTop", faceFrame.getTop());
        intent.putExtra("faceFrameRight", faceFrame.getRight());
        intent.putExtra("faceFrameLeft", faceFrame.getLeft());

        intent.putExtra("cameraFrameBottom", cameraFrame.getBottom());
        intent.putExtra("cameraFrameTop", cameraFrame.getTop());
        intent.putExtra("cameraFrameRight", cameraFrame.getRight());
        intent.putExtra("cameraFrameLeft", cameraFrame.getLeft());

        // Start intent for customized view
        mActivity.startActivity(intent);
    }

    public static final MLInteractiveLivenessCapture.Callback CUSTOM_CALLBACK = new MLInteractiveLivenessCapture.Callback() {
        @Override
        public void onSuccess(MLInteractiveLivenessCaptureResult result) {
            pendingResult.success(ToMap.InteractiveLivenessToMap.getResult(result));
        }

        @Override
        public void onFailure(int errorCode) {
            pendingResult.error("" + errorCode, null, null);
        }
    };
}
