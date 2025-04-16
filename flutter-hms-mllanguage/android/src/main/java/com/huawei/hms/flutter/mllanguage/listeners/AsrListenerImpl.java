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

package com.huawei.hms.flutter.mllanguage.listeners;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;

import com.huawei.hms.flutter.mllanguage.utils.HMSLogger;
import com.huawei.hms.mlsdk.asr.MLAsrListener;
import com.huawei.hms.mlsdk.asr.MLAsrRecognizer;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class AsrListenerImpl implements MLAsrListener {
    private final Handler handler = new Handler(Looper.getMainLooper());
    private final Activity activity;
    private final MethodChannel channel;

    public AsrListenerImpl(Activity activity, MethodChannel channel) {
        this.activity = activity;
        this.channel = channel;
    }

    @Override
    public void onResults(Bundle bundle) {
        Map<String, Object> m1 = new HashMap<>();
        m1.put("event", "onResults");
        m1.put("result", bundle.getString(MLAsrRecognizer.RESULTS_RECOGNIZED));
        invoke(m1);
    }

    @Override
    public void onRecognizingResults(Bundle bundle) {
        Map<String, Object> m2 = new HashMap<>();
        m2.put("event", "onRecognizingResults");
        m2.put("result", bundle.getString(MLAsrRecognizer.RESULTS_RECOGNIZING));
        invoke(m2);
    }

    @Override
    public void onError(int i, String s) {
        Map<String, Object> m3 = new HashMap<>();
        m3.put("event", "onError");
        m3.put("errCode", i);
        m3.put("errMsg", s);
        invoke(m3);
    }

    @Override
    public void onStartListening() {
        Map<String, Object> m4 = new HashMap<>();
        m4.put("event", "onStartListening");
        invoke(m4);
    }

    @Override
    public void onStartingOfSpeech() {
        Map<String, Object> m5 = new HashMap<>();
        m5.put("event", "onStartingOfSpeech");
        invoke(m5);
    }

    @Override
    public void onVoiceDataReceived(byte[] bytes, float v, Bundle bundle) {
        Map<String, Object> m6 = new HashMap<>();
        m6.put("event", "onVoiceDataReceived");
        m6.put("bytes", bytes);
        m6.put("energy", v);
        invoke(m6);
    }

    @Override
    public void onState(int i, Bundle bundle) {
        Map<String, Object> m7 = new HashMap<>();
        m7.put("event", "onState");
        m7.put("state", i);
        invoke(m7);
    }

    private void invoke(Map<String, Object> data) {
        if (data.get("event").equals("onError")) {
            HMSLogger.getInstance(activity).sendPeriodicEvent("asrEvent", data.get("errCode").toString());
        } else {
            HMSLogger.getInstance(activity).sendPeriodicEvent("asrEvent");
        }
        handler.post(() -> channel.invokeMethod("asrEvent", data));
    }
}
