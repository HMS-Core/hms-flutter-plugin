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
import android.os.Handler;
import android.os.Looper;

import com.huawei.hms.flutter.mllanguage.utils.HMSLogger;
import com.huawei.hms.mlsdk.aft.cloud.MLRemoteAftListener;
import com.huawei.hms.mlsdk.aft.cloud.MLRemoteAftResult;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class AftListenerImpl implements MLRemoteAftListener {
    private final Handler handler = new Handler(Looper.getMainLooper());
    private final Activity activity;
    private final MethodChannel channel;

    public AftListenerImpl(Activity activity, MethodChannel channel) {
        this.activity = activity;
        this.channel = channel;
    }

    @Override
    public void onInitComplete(String s, Object o) {
        Map<String, Object> map = new HashMap<>();
        map.put("event", "onInitComplete");
        map.put("taskId", s);
        invoke(map);
    }

    @Override
    public void onUploadProgress(String s, double v, Object o) {
        Map<String, Object> map = new HashMap<>();
        map.put("event", "onUploadProgress");
        map.put("taskId", s);
        map.put("progress", v);
        invoke(map);
    }

    @Override
    public void onEvent(String s, int i, Object o) {
        Map<String, Object> map = new HashMap<>();
        map.put("event", "onEvent");
        map.put("taskId", s);
        map.put("eventId", i);
        invoke(map);
    }

    @Override
    public void onResult(String s, MLRemoteAftResult mlRemoteAftResult, Object o) {
        Map<String, Object> map = new HashMap<>();
        if (mlRemoteAftResult.isComplete()) {
            map.put("event", "onResult");
            map.put("taskId", s);
            map.put("result", getAftResult(mlRemoteAftResult));
            invoke(map);
        }
    }

    @Override
    public void onError(String s, int i, String s1) {
        Map<String, Object> map = new HashMap<>();
        map.put("event", "onError");
        map.put("taskId", s);
        map.put("errorCode", i);
        map.put("message", s1);
        invoke(map);
    }

    private void invoke(Map<String, Object> map) {
        if (map.get("event").equals("onError")) {
            HMSLogger.getInstance(activity).sendPeriodicEvent("aftEvent", String.valueOf(map.get("errorCode")));
        } else {
            HMSLogger.getInstance(activity).sendPeriodicEvent("aftEvent");
        }
        handler.post(() -> channel.invokeMethod("aftEvent", map));
    }

    private Map<String, Object> getAftResult(MLRemoteAftResult result) {
        Map<String, Object> map = new HashMap<>();
        map.put("isComplete", result.isComplete());
        map.put("taskId", result.getTaskId());
        map.put("text", result.getText());
        if (result.getSegments() != null) {
            map.put("segments", segListToMap(result.getSegments()));
        }
        if (result.getWords() != null) {
            map.put("words", segListToMap(result.getWords()));
        }
        if (result.getSentences() != null) {
            map.put("sentences", segListToMap(result.getSentences()));
        }
        return map;
    }

    private List<Map<String, Object>> segListToMap(List<MLRemoteAftResult.Segment> list) {
        ArrayList<Map<String, Object>> segList = new ArrayList<>();
        if (list != null) {
            for (int i = 0; i < list.size(); i++) {
                Map<String, Object> map = new HashMap<>();
                MLRemoteAftResult.Segment segment = list.get(i);
                map.put("text", segment.getText());
                map.put("startTime", segment.getStartTime());
                map.put("endTime", segment.getEndTime());
                segList.add(map);
            }
        }
        return segList;
    }
}
