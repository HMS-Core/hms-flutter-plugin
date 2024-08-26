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

package com.huawei.hms.flutter.mllanguage.handlers;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mllanguage.utils.FromMap;
import com.huawei.hms.flutter.mllanguage.utils.RequestBuilder;
import com.huawei.hms.mlsdk.common.MLException;
import com.huawei.hms.mlsdk.langdetect.MLDetectedLang;
import com.huawei.hms.mlsdk.langdetect.MLLangDetectorFactory;
import com.huawei.hms.mlsdk.langdetect.cloud.MLRemoteLangDetector;
import com.huawei.hms.mlsdk.langdetect.local.MLLocalLangDetector;

import org.json.JSONArray;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class LangDetectionHandler implements MethodChannel.MethodCallHandler {
    private final static String TAG = "LangDetectionHandler";

    private final ResponseHandler handler;

    private MLRemoteLangDetector langDetector;
    private MLLocalLangDetector mlLocalLangDetector;

    public LangDetectionHandler(Activity activity) {
        this.handler = ResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        handler.setup(TAG, call.method, result);
        switch (call.method) {
            case "firstBestDetect":
                getFirstBestDetect(call);
                break;
            case "syncFirstBestDetect":
                getSyncFirstBestDetect(call);
                break;
            case "probabilityDetect":
                getProbabilityDetect(call);
                break;
            case "syncProbabilityDetect":
                getSyncProbabilityDetect(call);
                break;
            case "stopLangDetector":
                stopLangDetector();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void getFirstBestDetect(@NonNull MethodCall call) {
        String sourceText = FromMap.toString("sourceText", call.argument("sourceText"), false);
        Boolean isRemote = FromMap.toBoolean("isRemote", call.argument("isRemote"));

        if (isRemote) {
            langDetector = MLLangDetectorFactory.getInstance().getRemoteLangDetector(RequestBuilder.createRemoteLangDetectorSetting(call));
            langDetector.firstBestDetect(sourceText)
                    .addOnSuccessListener(handler::success)
                    .addOnFailureListener(handler::exception);
        } else {
            mlLocalLangDetector = MLLangDetectorFactory.getInstance().getLocalLangDetector(RequestBuilder.createLocalLangDetectorSetting(call));
            mlLocalLangDetector.firstBestDetect(sourceText)
                    .addOnSuccessListener(handler::success)
                    .addOnFailureListener(handler::exception);
        }
    }

    private void getSyncFirstBestDetect(@NonNull MethodCall call) {
        String sourceText0 = FromMap.toString("sourceText", call.argument("sourceText"), false);
        Boolean isRemote = FromMap.toBoolean("isRemote", call.argument("isRemote"));

        if (isRemote) {
            langDetector = MLLangDetectorFactory.getInstance().getRemoteLangDetector(RequestBuilder.createRemoteLangDetectorSetting(call));
            try {
                String syncFirstBest = langDetector.syncFirstBestDetect(sourceText0);
                handler.success(syncFirstBest);
            } catch (MLException ex0) {
                handler.exception(ex0);
            }
        } else {
            mlLocalLangDetector = MLLangDetectorFactory.getInstance().getLocalLangDetector(RequestBuilder.createLocalLangDetectorSetting(call));
            try {
                String syncFirstBest = mlLocalLangDetector.syncFirstBestDetect(sourceText0);
                handler.success(syncFirstBest);
            } catch (MLException ex0) {
                handler.exception(ex0);
            }
        }
    }

    private void getProbabilityDetect(@NonNull MethodCall call) {
        String sourceText = FromMap.toString("sourceText", call.argument("sourceText"), false);
        Boolean isRemote = FromMap.toBoolean("isRemote", call.argument("isRemote"));

        if (isRemote) {
            langDetector = MLLangDetectorFactory
                    .getInstance()
                    .getRemoteLangDetector(RequestBuilder.createRemoteLangDetectorSetting(call));

            langDetector.probabilityDetect(sourceText)
                    .addOnSuccessListener(this::getProbabilityList)
                    .addOnFailureListener(handler::exception);
        } else {
            mlLocalLangDetector = MLLangDetectorFactory
                    .getInstance()
                    .getLocalLangDetector(RequestBuilder.createLocalLangDetectorSetting(call));

            mlLocalLangDetector.probabilityDetect(sourceText)
                    .addOnSuccessListener(this::getProbabilityList)
                    .addOnFailureListener(handler::exception);
        }
    }

    private void getSyncProbabilityDetect(@NonNull MethodCall call) {
        String sourceText1 = FromMap.toString("sourceText", call.argument("sourceText"), false);
        Boolean isRemote = FromMap.toBoolean("isRemote", call.argument("isRemote"));

        if (isRemote) {
            langDetector = MLLangDetectorFactory
                    .getInstance()
                    .getRemoteLangDetector(RequestBuilder.createRemoteLangDetectorSetting(call));
            try {
                List<MLDetectedLang> result = langDetector.syncProbabilityDetect(sourceText1);
                getProbabilityList(result);
            } catch (MLException e) {
                handler.exception(e);
            }
        } else {
            mlLocalLangDetector = MLLangDetectorFactory
                    .getInstance()
                    .getLocalLangDetector(RequestBuilder.createLocalLangDetectorSetting(call));
            try {
                List<MLDetectedLang> result = mlLocalLangDetector.syncProbabilityDetect(sourceText1);
                getProbabilityList(result);
            } catch (MLException e) {
                handler.exception(e);
            }
        }
    }

    private void stopLangDetector() {
        if (langDetector != null) {
            langDetector.stop();
            langDetector = null;
        }

        if (mlLocalLangDetector != null) {
            mlLocalLangDetector.stop();
            mlLocalLangDetector = null;
        }

        handler.success(true);
    }

    private void getProbabilityList(List<MLDetectedLang> mlDetectedLang) {
        ArrayList<Map<String, Object>> arrayList = new ArrayList<>();
        for (int i = 0; i < mlDetectedLang.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLDetectedLang lang = mlDetectedLang.get(i);
            map.put("langCode", lang.getLangCode());
            map.put("probability", lang.getProbability());
            arrayList.add(map);
        }
        handler.success(new JSONArray(arrayList).toString());
    }
}
