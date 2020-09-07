/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.ml.langdetection;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.agconnect.config.AGConnectServicesConfig;
import com.huawei.hmf.tasks.OnFailureListener;
import com.huawei.hmf.tasks.OnSuccessListener;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.mlsdk.common.MLApplication;
import com.huawei.hms.mlsdk.langdetect.MLDetectedLang;
import com.huawei.hms.mlsdk.langdetect.MLLangDetectorFactory;
import com.huawei.hms.mlsdk.langdetect.cloud.MLRemoteLangDetector;
import com.huawei.hms.mlsdk.langdetect.cloud.MLRemoteLangDetectorSetting;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class LangDetectionMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = LangDetectionMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;
    private MLRemoteLangDetector langDetector;
    private MLRemoteLangDetectorSetting setting;

    public LangDetectionMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        String apiKey = AGConnectServicesConfig.fromContext(
                activity.getApplicationContext()).getString("client/api_key");
        MLApplication.getInstance().setApiKey(apiKey);
        switch (call.method) {
            case "getFirstBestDetect":
                getFirstBestDetect(call);
                break;
            case "getProbabilityDetect":
                getProbabilityDetect(call);
                break;
            case "stopDetection":
                stopDetection();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void getFirstBestDetect(MethodCall call) {
        try {
            HashMap map = call.argument("settings");
            if (map != null) {
                JSONObject object = new JSONObject(map);
                setting = new MLRemoteLangDetectorSetting.Factory()
                        .setTrustedThreshold((float) object.getDouble("trustedThreshold")).create();
                langDetector = MLLangDetectorFactory.getInstance().getRemoteLangDetector(setting);
                Task<String> firstBestDetectTask = langDetector.firstBestDetect(object.getString("sourceText"));
                firstBestDetectTask.addOnSuccessListener(new OnSuccessListener<String>() {
                    @Override
                    public void onSuccess(String s) {
                        mResult.success(s);
                    }
                }).addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(Exception detectionError) {
                        mResult.error(TAG, detectionError.getMessage(), "");
                    }
                });
            } else {
                mResult.error(TAG, "Arguments are not supposed to be null", "");
            }
        } catch (JSONException detectionError) {
            mResult.error(TAG, detectionError.getMessage(), "");
        }
    }

    private void getProbabilityDetect(MethodCall call) {
        try {
            HashMap map = call.argument("settings");
            if (map != null) {
                JSONObject object = new JSONObject(map);
                setting = new MLRemoteLangDetectorSetting.Factory()
                        .setTrustedThreshold((float) object.optDouble("trustedThreshold", 0.01f)).create();
                langDetector = MLLangDetectorFactory.getInstance().getRemoteLangDetector(setting);
                Task<List<MLDetectedLang>> probabilityDetectTask
                        = langDetector.probabilityDetect(object.getString("sourceText"));
                probabilityDetectTask.addOnSuccessListener(new OnSuccessListener<List<MLDetectedLang>>() {
                    @Override
                    public void onSuccess(List<MLDetectedLang> mlDetectedLangs) {
                        try {
                            mResult.success(onGetProbabilityDetectSuccess(mlDetectedLangs).toString());
                        } catch (JSONException e) {
                            mResult.error("Error", e.getMessage(), "");
                        }
                    }
                }).addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(Exception langDetectionError) {
                        mResult.error(TAG, langDetectionError.getMessage(), "");
                    }
                });
            } else {
                mResult.error(TAG, "Arguments must not be null", "");
            }
        } catch (JSONException langDetectionError) {
            mResult.error(TAG, langDetectionError.getMessage(), "");
        }
    }

    private static JSONObject onGetProbabilityDetectSuccess(List<MLDetectedLang> mlDetectedLangs) throws JSONException {
        JSONObject object = new JSONObject();
        for (MLDetectedLang mlDetectedLang : mlDetectedLangs) {
            object.putOpt("langCode", mlDetectedLang.getLangCode());
            object.putOpt("probability", mlDetectedLang.getProbability());
            object.putOpt("hashcode", mlDetectedLang.hashCode());
        }
        return object;
    }

    private void stopDetection() {
        if (langDetector != null) {
            langDetector.stop();
            langDetector = null;
            String success = "Detection is stopped";
            mResult.success(success);
        } else {
            mResult.error(TAG, "Lang detector is null", "");
        }
    }
}