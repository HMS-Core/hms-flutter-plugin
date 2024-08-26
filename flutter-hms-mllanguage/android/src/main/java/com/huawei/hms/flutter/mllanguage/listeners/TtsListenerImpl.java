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
import android.util.Pair;

import com.huawei.hms.flutter.mllanguage.utils.HMSLogger;
import com.huawei.hms.mlsdk.tts.MLTtsAudioFragment;
import com.huawei.hms.mlsdk.tts.MLTtsCallback;
import com.huawei.hms.mlsdk.tts.MLTtsError;
import com.huawei.hms.mlsdk.tts.MLTtsWarn;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class TtsListenerImpl implements MLTtsCallback {
    private final Handler handler = new Handler(Looper.getMainLooper());
    private final Activity activity;
    private final MethodChannel channel;

    public TtsListenerImpl(Activity activity, MethodChannel channel) {
        this.activity = activity;
        this.channel = channel;
    }

    @Override
    public void onError(String s, MLTtsError mlTtsError) {
        Map<String, Object> m1 = new HashMap<>();
        m1.put("event", "onError");
        m1.put("taskId", s);
        m1.put("errorId", mlTtsError.getErrorId());
        m1.put("message", mlTtsError.getErrorMsg());
        m1.put("extension", mlTtsError.getExtension());
        invoke(m1);
    }

    @Override
    public void onWarn(String s, MLTtsWarn mlTtsWarn) {
        Map<String, Object> m2 = new HashMap<>();
        m2.put("event", "onWarn");
        m2.put("taskId", s);
        m2.put("warnId", mlTtsWarn.getWarnId());
        m2.put("message", mlTtsWarn.getWarnMsg());
        m2.put("extension", mlTtsWarn.getExtension());
        invoke(m2);
    }

    @Override
    public void onRangeStart(String s, int i, int i1) {
        Map<String, Object> m3 = new HashMap<>();
        m3.put("event", "onRangeStart");
        m3.put("taskId", s);
        m3.put("start", i);
        m3.put("end", i1);
        invoke(m3);
    }

    @Override
    public void onAudioAvailable(String s, MLTtsAudioFragment mlTtsAudioFragment, int i, Pair<Integer, Integer> pair, Bundle bundle) {
        Map<String, Object> m4 = new HashMap<>();
        m4.put("event", "onAudioAvailable");
        m4.put("taskId", s);
        m4.put("offset", i);
        m4.put("audioData", mlTtsAudioFragment.getAudioData());
        m4.put("sampleRateInHz", mlTtsAudioFragment.getSampleRateInHz());
        m4.put("channelInfo", mlTtsAudioFragment.getChannelInfo());
        m4.put("audioFormat", mlTtsAudioFragment.getAudioFormat());
        invoke(m4);
    }

    @Override
    public void onEvent(String s, int i, Bundle bundle) {
        Map<String, Object> m5 = new HashMap<>();
        m5.put("event", "onEvent");
        m5.put("taskId", s);
        m5.put("eventId", i);
        invoke(m5);
    }

    private void invoke(Map<String, Object> map) {
        if (map.get("event").equals("onError")) {
            HMSLogger.getInstance(activity).sendPeriodicEvent("ttsEvent", String.valueOf(map.get("errorId")));
        } else {
            HMSLogger.getInstance(activity).sendPeriodicEvent("ttsEvent");
        }
        handler.post(() -> channel.invokeMethod("ttsEvent", map));
    }
}
