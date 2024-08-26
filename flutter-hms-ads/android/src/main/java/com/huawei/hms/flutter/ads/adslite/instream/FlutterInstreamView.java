/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.ads.adslite.instream;

import android.content.Context;
import android.view.View;

import com.huawei.hms.ads.MediaMuteListener;
import com.huawei.hms.ads.instreamad.InstreamAd;
import com.huawei.hms.ads.instreamad.InstreamMediaChangeListener;
import com.huawei.hms.ads.instreamad.InstreamMediaStateListener;
import com.huawei.hms.ads.instreamad.InstreamView;
import com.huawei.hms.flutter.ads.logger.HMSLogger;
import com.huawei.hms.flutter.ads.utils.FromMap;
import com.huawei.hms.flutter.ads.utils.constants.ErrorCodes;

import java.util.ArrayList;
import java.util.HashMap;

import io.flutter.Log;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

import static com.huawei.hms.flutter.ads.utils.FromMap.toIntegerArrayList;
import static com.huawei.hms.flutter.ads.utils.constants.ViewTypes.INSTREAM_VIEW;
import static io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import static io.flutter.plugin.common.MethodChannel.Result;

public class FlutterInstreamView implements PlatformView, MethodCallHandler {
    private final MethodChannel methodChannel;
    private final Context context;
    private final BinaryMessenger messenger;
    private static final String TAG = "InstreamAdListener";
    private InstreamView instreamView;

    FlutterInstreamView(final Context context, BinaryMessenger messenger, int id,
            HashMap<String, Object> creationParams) {
        this.methodChannel = new MethodChannel(messenger, INSTREAM_VIEW + "/" + id);
        this.methodChannel.setMethodCallHandler(this);
        this.context = context;
        this.messenger = messenger;

        ArrayList<Integer> instreamAdIds = FromMap.toIntegerArrayList("instreamAdIds",
                creationParams.get("instreamAdIds"));
        ArrayList<InstreamAd> instreamAds = new ArrayList<>();

        for (Integer instreamAdId : instreamAdIds) {
            InstreamAd ia = HmsInstreamAd.getInstreamAd(instreamAdId);
            if (ia != null) {
                instreamAds.add(ia);
            }
        }

        instreamView = new InstreamView(context);
        instreamView.setInstreamAds(instreamAds);
        instreamView.setInstreamMediaChangeListener(mediaChangeListener);
        instreamView.setInstreamMediaStateListener(mediaStateListener);
        instreamView.setMediaMuteListener(mediaMuteListener);
        instreamView.setOnInstreamAdClickListener(new InstreamView.OnInstreamAdClickListener() {
            @Override
            public void onClick() {
                HMSLogger.getInstance(context).startMethodExecutionTimer("onInstreamAdClick");
                Log.i(TAG, "onClick");
                methodChannel.invokeMethod("onClick", null, null);
                HMSLogger.getInstance(context).sendSingleEvent("onInstreamAdClick");
            }
        });
    }

    private InstreamMediaChangeListener mediaChangeListener = new InstreamMediaChangeListener() {
        @Override
        public void onSegmentMediaChange(InstreamAd instreamAd) {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onSegmentMediaChange");
            new HmsInstreamAd(instreamAd.hashCode(), context, messenger, instreamAd);
            HashMap<String, Integer> args = new HashMap<>();
            args.put("adId", instreamAd.hashCode());
            methodChannel.invokeMethod("onSegmentMediaChange", args, null);
            HMSLogger.getInstance(context).sendSingleEvent("onSegmentMediaChange");
        }
    };

    private InstreamMediaStateListener mediaStateListener = new InstreamMediaStateListener() {
        @Override
        public void onMediaProgress(int per, int playTime) {
            Log.i(TAG, "onMediaProgress");
            HashMap<String, Integer> args = new HashMap<>();
            args.put("per", per);
            args.put("playTime", playTime);
            methodChannel.invokeMethod("onMediaProgress", args, null);
        }

        @Override
        public void onMediaStart(int playTime) {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onMediaStart");
            Log.i(TAG, "onMediaStart");
            HashMap<String, Integer> args = new HashMap<>();
            args.put("playTime", playTime);
            methodChannel.invokeMethod("onMediaStart", args, null);
            HMSLogger.getInstance(context).sendSingleEvent("onMediaStart");
        }

        @Override
        public void onMediaPause(int playTime) {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onMediaPause");
            Log.i(TAG, "onMediaPause");
            HashMap<String, Integer> args = new HashMap<>();
            args.put("playTime", playTime);
            methodChannel.invokeMethod("onMediaPause", args, null);
            HMSLogger.getInstance(context).sendSingleEvent("onMediaPause");
        }

        @Override
        public void onMediaStop(int playTime) {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onMediaStop");
            Log.i(TAG, "onMediaStop");
            HashMap<String, Integer> args = new HashMap<>();
            args.put("playTime", playTime);
            methodChannel.invokeMethod("onMediaStop", args, null);
            HMSLogger.getInstance(context).sendSingleEvent("onMediaStop");
        }

        @Override
        public void onMediaCompletion(int playTime) {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onMediaCompletion");
            Log.i(TAG, "onMediaCompletion");
            HashMap<String, Integer> args = new HashMap<>();
            args.put("playTime", playTime);
            methodChannel.invokeMethod("onMediaCompletion", args, null);
            HMSLogger.getInstance(context).sendSingleEvent("onMediaCompletion");
        }

        @Override
        public void onMediaError(int playTime, int errorCode, int extra) {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onMediaError");
            Log.i(TAG, "onMediaError");
            HashMap<String, Integer> args = new HashMap<>();
            args.put("playTime", playTime);
            args.put("errorCode", errorCode);
            args.put("extra", extra);
            methodChannel.invokeMethod("onMediaError", args, null);
            HMSLogger.getInstance(context).sendSingleEvent("onMediaError", String.valueOf(errorCode));
        }
    };

    private MediaMuteListener mediaMuteListener = new MediaMuteListener() {
        @Override
        public void onMute() {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onMute");
            Log.i(TAG, "onMute");
            methodChannel.invokeMethod("onMute", null, null);
            HMSLogger.getInstance(context).sendSingleEvent("onMute");
        }

        @Override
        public void onUnmute() {
            HMSLogger.getInstance(context).startMethodExecutionTimer("onUnMute");
            Log.i(TAG, "onUnMute");
            methodChannel.invokeMethod("onUnMute", null, null);
            HMSLogger.getInstance(context).sendSingleEvent("onUnMute");
        }
    };

    @Override
    public View getView() {
        return instreamView;
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        HMSLogger.getInstance(context).startMethodExecutionTimer(call.method);
        if (instreamView == null) {
            result.error(ErrorCodes.NULL_VIEW, "InstreamView isn't created yet.", "");
            HMSLogger.getInstance(context).sendSingleEvent(call.method, ErrorCodes.NULL_VIEW);
            return;
        }
        switch (call.method) {
            case "destroy":
                instreamView.destroy();
                result.success(true);
                break;
            case "isPlaying":
                result.success(instreamView.isPlaying());
                break;
            case "mute":
                instreamView.mute();
                result.success(true);
                break;
            case "onClose":
                instreamView.onClose();
                result.success(true);
                break;
            case "pause":
                instreamView.pause();
                result.success(true);
                break;
            case "play":
                instreamView.play();
                result.success(true);
                break;
            case "removeInstreamMediaChangeListener":
                instreamView.removeInstreamMediaChangeListener();
                result.success(true);
                break;
            case "removeInstreamMediaStateListener":
                instreamView.removeInstreamMediaStateListener();
                result.success(true);
                break;
            case "removeMediaMuteListener":
                instreamView.removeMediaMuteListener();
                result.success(true);
                break;
            case "stop":
                instreamView.stop();
                result.success(true);
                break;
            case "unmute":
                instreamView.unmute();
                result.success(true);
                break;
            case "showAdvertiserInfoDialog":
                instreamView.showAdvertiserInfoDialog(instreamView, true);
                result.success(true);
                break;
            case "hideAdvertiserInfoDialog":
                instreamView.hideAdvertiserInfoDialog();
                result.success(true);
                break;
            case "showTransparencyDialog":
                HMSLogger.getInstance(context).startMethodExecutionTimer("instreamView.showTransparencyDialog");
                ArrayList<Integer> arrList = toIntegerArrayList("location", call.arguments);
                int[] location = new int[arrList.size()];

                for (int i = 0; i < arrList.size(); i++) {
                    location[i] = (arrList.get(i));
                }
                instreamView.showTransparencyDialog(instreamView, location);
                HMSLogger.getInstance(context).sendSingleEvent("instreamView.showTransparencyDialog");
                result.success(true);
                break;
            case "hideTransparencyDialog":
                HMSLogger.getInstance(context).startMethodExecutionTimer("instremView.hideTransparencyDialog");
                instreamView.hideTransparencyDialog();
                HMSLogger.getInstance(context).sendSingleEvent("instremView.hideTransparencyDialog");
                result.success(true);
                break;
            default:
                result.notImplemented();
                return;
        }
        HMSLogger.getInstance(context).sendSingleEvent(call.method);
    }

    @Override
    public void dispose() {
        if (instreamView == null) {
            return;
        }
        instreamView.removeInstreamMediaStateListener();
        instreamView.removeInstreamMediaChangeListener();
        instreamView.removeMediaMuteListener();
        instreamView.destroy();
    }
}