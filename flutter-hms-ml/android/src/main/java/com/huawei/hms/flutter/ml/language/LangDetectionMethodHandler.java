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

package com.huawei.hms.flutter.ml.language;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.flutter.ml.utils.SettingUtils;
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

public class LangDetectionMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = LangDetectionMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;
    private MLRemoteLangDetector langDetector;
    private MLLocalLangDetector mlLocalLangDetector;

    public LangDetectionMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
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
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getFirstBestDetect");
        String sourceText = call.argument("sourceText");
        Boolean isRemote = call.argument("isRemote");

        if (sourceText == null || sourceText.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getFirstBestDetect", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Source text is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        if (isRemote != null && isRemote) {
            langDetector = MLLangDetectorFactory.getInstance().getRemoteLangDetector(SettingUtils.createRemoteLangDetectorSetting(call));
            Task<String> firstBestDetectTask = langDetector.firstBestDetect(sourceText);
            firstBestDetectTask
                    .addOnSuccessListener(s -> HmsMlUtils.sendSuccessResult(activity, "getFirstBestDetect", mResult, s))
                    .addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "getFirstBestDetect", mResult));
        } else {
            mlLocalLangDetector = MLLangDetectorFactory.getInstance().getLocalLangDetector(SettingUtils.createLocalLangDetectorSetting(call));
            Task<String> firstBestDetectTask = mlLocalLangDetector.firstBestDetect(sourceText);
            firstBestDetectTask
                    .addOnSuccessListener(s -> HmsMlUtils.sendSuccessResult(activity, "getFirstBestDetect", mResult, s))
                    .addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "getFirstBestDetect", mResult));
        }
    }

    private void getSyncFirstBestDetect(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getFirstBestDetect");
        String sourceText0 = call.argument("sourceText");
        Boolean isRemote = call.argument("isRemote");

        if (sourceText0 == null || sourceText0.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getFirstBestDetect", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Source text is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        if (isRemote != null && isRemote) {
            langDetector = MLLangDetectorFactory.getInstance().getRemoteLangDetector(SettingUtils.createRemoteLangDetectorSetting(call));
            try {
                String syncFirstBest = langDetector.syncFirstBestDetect(sourceText0);
                HmsMlUtils.sendSuccessResult(activity, "getFirstBestDetect", mResult, syncFirstBest);
            } catch (MLException ex0) {
                HmsMlUtils.handleException(activity, TAG, ex0, "getFirstBestDetect", mResult);
            }
        } else {
            mlLocalLangDetector = MLLangDetectorFactory.getInstance().getLocalLangDetector(SettingUtils.createLocalLangDetectorSetting(call));
            try {
                String syncFirstBest = mlLocalLangDetector.syncFirstBestDetect(sourceText0);
                HmsMlUtils.sendSuccessResult(activity, "getFirstBestDetect", mResult, syncFirstBest);
            } catch (MLException ex0) {
                HmsMlUtils.handleException(activity, TAG, ex0, "getFirstBestDetect", mResult);
            }
        }
    }

    private void getProbabilityDetect(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getProbabilityDetect");
        String sourceText = call.argument("sourceText");
        Boolean isRemote = call.argument("isRemote");

        if (sourceText == null || sourceText.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getProbabilityDetect", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Source text is missing", "");
            return;
        }

        if (isRemote != null && isRemote) {
            langDetector = MLLangDetectorFactory.getInstance().getRemoteLangDetector(SettingUtils.createRemoteLangDetectorSetting(call));

            Task<List<MLDetectedLang>> probabilityDetectTask = langDetector.probabilityDetect(sourceText);
            probabilityDetectTask.addOnSuccessListener(this::getProbabilityList).addOnFailureListener(e -> {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getProbabilityDetect", e.getMessage());
                mResult.error(TAG, e.getMessage(), "");
            });
        } else {
            mlLocalLangDetector = MLLangDetectorFactory.getInstance().getLocalLangDetector(SettingUtils.createLocalLangDetectorSetting(call));

            Task<List<MLDetectedLang>> probabilityDetectTask = mlLocalLangDetector.probabilityDetect(sourceText);
            probabilityDetectTask.addOnSuccessListener(this::getProbabilityList).addOnFailureListener(e -> {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getProbabilityDetect", e.getMessage());
                mResult.error(TAG, e.getMessage(), "");
            });
        }
    }

    private void getSyncProbabilityDetect(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getProbabilityDetect");
        String sourceText1 = call.argument("sourceText");
        Boolean isRemote = call.argument("isRemote");

        if (sourceText1 == null || sourceText1.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getProbabilityDetect", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Source text is missing", "");
            return;
        }

        if (isRemote != null && isRemote) {
            langDetector = MLLangDetectorFactory.getInstance().getRemoteLangDetector(SettingUtils.createRemoteLangDetectorSetting(call));
            try {
                List<MLDetectedLang> result = langDetector.syncProbabilityDetect(sourceText1);
                getProbabilityList(result);
            } catch (MLException e) {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getProbabilityDetect", String.valueOf(e.getErrCode()));
                mResult.error(TAG, e.getMessage(), String.valueOf(e.getErrCode()));
            }
        } else {
            mlLocalLangDetector = MLLangDetectorFactory.getInstance().getLocalLangDetector(SettingUtils.createLocalLangDetectorSetting(call));
            try {
                List<MLDetectedLang> result = mlLocalLangDetector.syncProbabilityDetect(sourceText1);
                getProbabilityList(result);
            } catch (MLException e) {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getProbabilityDetect", String.valueOf(e.getErrCode()));
                mResult.error(TAG, e.getMessage(), String.valueOf(e.getErrCode()));
            }
        }
    }

    private void stopLangDetector() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stopLangDetector");

        if (langDetector != null) {
            langDetector.stop();
            langDetector = null;
        }

        if (mlLocalLangDetector != null) {
            mlLocalLangDetector.stop();
            mlLocalLangDetector = null;
        }

        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopLangDetector");
        mResult.success(true);
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
        JSONArray jsonArray = new JSONArray(arrayList);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getProbabilityDetect");
        mResult.success(jsonArray.toString());
    }
}