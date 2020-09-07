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

package com.huawei.hms.flutter.ml.text;

import android.app.Activity;
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.huawei.agconnect.config.AGConnectServicesConfig;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.ImagePathHelper;
import com.huawei.hms.flutter.ml.utils.MlTextUtils;
import com.huawei.hmf.tasks.OnFailureListener;
import com.huawei.hmf.tasks.Task;
import com.huawei.hmf.tasks.OnSuccessListener;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.common.MLApplication;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.text.MLLocalTextSetting;
import com.huawei.hms.mlsdk.text.MLRemoteTextSetting;
import com.huawei.hms.mlsdk.text.MLText;
import com.huawei.hms.mlsdk.text.MLTextAnalyzer;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.List;
import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class TextAnalyzerMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = TextAnalyzerMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;
    private MLTextAnalyzer analyzer;

    public TextAnalyzerMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "analyzeLocally":
                analyzeTextLocally(call);
                break;
            case "analyzeRemotely":
                analyzeTextRemotely(call);
                break;
            case "analyzeWithSparseArray":
                analyzeWithSparseArray(call);
                break;
            case "getAnalyzerInfo":
                getAnalyzerInfo();
                break;
            case "stopAnalyzer":
                stopAnalyzer();
                break;
            default:
                break;
        }
    }

    private void analyzeTextLocally(MethodCall call) {
        try {
            String localTextJsonString = null;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
                localTextJsonString = Objects.requireNonNull(call.argument("settings")).toString();
            }
            if (localTextJsonString == null) {
                mResult.error(TAG, "Arguments must not be null", "");
            } else {
                JSONObject localTextObject = new JSONObject(localTextJsonString);
                String imagePath = localTextObject.getString("path");
                final String encodedImage = ImagePathHelper.pathToBase64(imagePath);

                MLLocalTextSetting setting = new MLLocalTextSetting.Factory()
                        .setOCRMode(localTextObject.getInt("ocrMode"))
                        .setLanguage(localTextObject.getString("language"))
                        .create();
                analyzer = MLAnalyzerFactory.getInstance().getLocalTextAnalyzer(setting);
                MLFrame localTextFrame = HmsMlUtils.getFrame(encodedImage);
                Task<MLText> task = analyzer.asyncAnalyseFrame(localTextFrame);

                task.addOnSuccessListener(new OnSuccessListener<MLText>() {
                    @Override
                    public void onSuccess(MLText localText) {
                        onAnalyzeSuccess(localText);
                    }
                }).addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(Exception localTextError) {
                        mResult.error(TAG, localTextError.getMessage(), "");
                    }
                });
            }
        } catch (JSONException localTextError) {
            mResult.error(TAG, localTextError.getMessage(), "");
        }
    }

    private void analyzeTextRemotely(MethodCall call) {
        List<String> languages;
        try {
            String jsonString = null;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
                jsonString = Objects.requireNonNull(call.argument("settings")).toString();
            }
            if (jsonString == null) {
                mResult.error(TAG, "Arguments must not be null", "");
            } else {
                JSONObject object = new JSONObject(jsonString);
                languages = HmsMlUtils.jsonArrayToList(object);
                String imagePath = object.getString("path");
                final String encodedImage = ImagePathHelper.pathToBase64(imagePath);
                String apiKey = AGConnectServicesConfig.fromContext(
                        activity.getApplicationContext()).getString("client/api_key");
                MLApplication.getInstance().setApiKey(apiKey);
                MLRemoteTextSetting mlRemoteTextSetting = new MLRemoteTextSetting.Factory()
                        .setTextDensityScene(object.getInt("textDensityScene"))
                        .setLanguageList(languages)
                        .setBorderType(object.getString("borderType"))
                        .create();
                analyzer = MLAnalyzerFactory.getInstance().getRemoteTextAnalyzer(mlRemoteTextSetting);
                MLFrame remoteTextFrame = HmsMlUtils.getFrame(encodedImage);
                Task<MLText> task = analyzer.asyncAnalyseFrame(remoteTextFrame);

                task.addOnSuccessListener(new OnSuccessListener<MLText>() {
                    @Override
                    public void onSuccess(MLText remoteText) {
                        onAnalyzeSuccess(remoteText);
                    }
                }).addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(Exception remoteTextError) {
                        mResult.error(TAG, remoteTextError.getMessage(), "");
                    }
                });
            }
        } catch (JSONException remoteTextError) {
            mResult.error(TAG, remoteTextError.getMessage(), "");
        }
    }

    private void analyzeWithSparseArray(MethodCall call) {
        try {
            String jsonString = null;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
                jsonString = Objects.requireNonNull(call.argument("settings")).toString();
            }
            if (jsonString == null) {
                mResult.error(TAG, "Arguments must not be null", "");
            } else {
                JSONObject object = new JSONObject(jsonString);
                String language = object.getString("language");
                int ocrMode = object.getInt("ocrMode");
                String imagePath = object.getString("path");
                final String encodedImage = ImagePathHelper.pathToBase64(imagePath);
                MLFrame frame = HmsMlUtils.getFrame(encodedImage);

                SparseArray<MLText.Block> sparseArray
                        = new MLTextAnalyzer.Factory(activity.getApplicationContext())
                        .setLocalOCRMode(ocrMode)
                        .setLanguage(language)
                        .create().analyseFrame(frame);

                if (sparseArray != null) {
                    mResult.success(MlTextUtils.fromSparseArrayMLTextBlockToJSON(sparseArray).toString());
                } else {
                    mResult.error(TAG, "Sparse Array result is null", "");
                }
            }
        } catch (JSONException e) {
            mResult.error(TAG, e.getMessage(), "");
        }
    }

    private void onAnalyzeSuccess(MLText mlText) {
        mResult.success(String.valueOf(MlTextUtils.fromMLTextBlockToJson(mlText)));
    }

    private void stopAnalyzer() {
        if (analyzer == null)
            mResult.error(TAG, "Analyser is not initialized.", "");
        else {
            try {
                analyzer.close();
                analyzer = null;
                String success = "Analyzer is closed";
                mResult.success(success);
            } catch (IOException e) {
                mResult.error(TAG, e.getMessage(), "");
            }
        }
    }

    private void getAnalyzerInfo() {
        int analyseType;
        boolean isAnalyserAvailable;
        if (analyzer == null) {
            mResult.error(TAG, "Analyzer is not initialized", "");
        } else {
            try {
                isAnalyserAvailable = analyzer.isAvailable();
                analyseType = analyzer.getAnalyseType();
                JSONObject analyserInfo = new JSONObject();
                analyserInfo.putOpt("isAvailable", isAnalyserAvailable);
                analyserInfo.putOpt("analyzeType", analyseType);
                mResult.success(analyserInfo.toString());
            } catch (JSONException e) {
                mResult.error(TAG, e.getMessage(), "");
            }
        }
    }
}