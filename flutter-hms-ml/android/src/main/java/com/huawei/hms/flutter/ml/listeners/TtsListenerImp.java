/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.ml.listeners;

import android.app.Activity;
import android.os.Bundle;
import android.util.Pair;

import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.EventHandler;
import com.huawei.hms.mlsdk.tts.MLTtsAudioFragment;
import com.huawei.hms.mlsdk.tts.MLTtsCallback;
import com.huawei.hms.mlsdk.tts.MLTtsError;
import com.huawei.hms.mlsdk.tts.MLTtsWarn;

import java.util.HashMap;
import java.util.Map;

public class TtsListenerImp implements MLTtsCallback {
    private Activity activity;

    public TtsListenerImp(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onError(String taskId, MLTtsError err) {
        Map<String, Object> onErrorMap = new HashMap<>();
        onErrorMap.put("event", "onError");
        onErrorMap.put("taskId", taskId);
        onErrorMap.put("errorId", err.getErrorId());
        onErrorMap.put("message", err.getErrorMsg());
        onErrorMap.put("extension", err.getExtension());
        HMSLogger.getInstance(activity.getApplicationContext()).sendPeriodicEvent("onTtsError");
        sendEvent(onErrorMap);
    }

    @Override
    public void onWarn(String taskId, MLTtsWarn mlTtsWarn) {
        Map<String, Object> onWarnMap = new HashMap<>();
        onWarnMap.put("event", "onWarn");
        onWarnMap.put("taskId", taskId);
        onWarnMap.put("warnId", mlTtsWarn.getWarnId());
        onWarnMap.put("message", mlTtsWarn.getWarnMsg());
        onWarnMap.put("extension", mlTtsWarn.getExtension());
        HMSLogger.getInstance(activity.getApplicationContext()).sendPeriodicEvent("onTtsWarn");
        sendEvent(onWarnMap);
    }

    @Override
    public void onRangeStart(String taskId, int start, int end) {
        Map<String, Object> onRangeMap = new HashMap<>();
        onRangeMap.put("event", "onRangeStart");
        onRangeMap.put("taskId", taskId);
        onRangeMap.put("start", start);
        onRangeMap.put("end", end);
        HMSLogger.getInstance(activity.getApplicationContext()).sendPeriodicEvent("onTtsRangeStart");
        sendEvent(onRangeMap);
    }

    @Override
    public void onAudioAvailable(String taskId, MLTtsAudioFragment audioFragment, int offset, Pair<Integer, Integer> range, Bundle bundle) {
        Map<String, Object> onAudioMap = new HashMap<>();
        onAudioMap.put("event", "onAudioAvailable");
        onAudioMap.put("taskId", taskId);
        onAudioMap.put("audioData", audioFragment.getAudioData());
        onAudioMap.put("sampleRateInHz", audioFragment.getSampleRateInHz());
        onAudioMap.put("channelInfo", audioFragment.getChannelInfo());
        onAudioMap.put("audioFormat", audioFragment.getAudioFormat());
        HMSLogger.getInstance(activity.getApplicationContext()).sendPeriodicEvent("onTtsAudioAvailable");
        sendEvent(onAudioMap);
    }

    @Override
    public void onEvent(String taskId, int eventId, Bundle bundle) {
        Map<String, Object> onEventMap = new HashMap<>();
        onEventMap.put("event", "onEvent");
        onEventMap.put("taskId", taskId);
        onEventMap.put("eventId", eventId);
        HMSLogger.getInstance(activity.getApplicationContext()).sendPeriodicEvent("onTtsEvent");
        sendEvent(onEventMap);
    }

    private void sendEvent(final Map<String, Object> event) {
        EventHandler.getInstance().getUiHandler().post(() -> EventHandler.getInstance().getEventSink().success(event));
    }
}
