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

package com.huawei.hms.flutter.ml.classification;

import android.app.Activity;
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.huawei.agconnect.config.AGConnectServicesConfig;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.ImagePathHelper;
import com.huawei.hmf.tasks.OnFailureListener;
import com.huawei.hmf.tasks.OnSuccessListener;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.classification.MLImageClassification;
import com.huawei.hms.mlsdk.classification.MLImageClassificationAnalyzer;
import com.huawei.hms.mlsdk.classification.MLLocalClassificationAnalyzerSetting;
import com.huawei.hms.mlsdk.classification.MLRemoteClassificationAnalyzerSetting;
import com.huawei.hms.mlsdk.common.MLApplication;
import com.huawei.hms.mlsdk.common.MLFrame;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.List;
import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class ClassificationMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = ClassificationMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;
    private MLImageClassificationAnalyzer analyzer;

    public ClassificationMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        String apiKey = AGConnectServicesConfig.fromContext(
                activity.getApplicationContext()).getString("client/api_key");
        MLApplication.getInstance().setApiKey(apiKey);
        switch (call.method) {
            case "defaultAnalyze":
                defaultClassificationAnalyze(call);
                break;
            case "analyzeLocally":
                analyzeClassificationLocally(call);
                break;
            case "analyzeRemotely":
                analyzeRemotely(call);
                break;
            case "sparseAnalyze":
                sparseAnalyze(call);
                break;
            case "closeAnalyzer":
                closeAnalyzer();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void defaultClassificationAnalyze(MethodCall call) {
        if (call.argument("path") == null) {
            mResult.error(TAG, "Image path must not be null!", "");
        } else {
            String imagePath = call.argument("path");
            analyzer = MLAnalyzerFactory.getInstance().getRemoteImageClassificationAnalyzer();
            final String encodedImage = ImagePathHelper.pathToBase64(imagePath);
            MLFrame frame = HmsMlUtils.getFrame(encodedImage);
            performTask(frame);
        }
    }

    private void analyzeClassificationLocally(MethodCall call) {
        try {
            String classificationJsonString = null;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
                classificationJsonString = Objects.requireNonNull(call.argument("settings")).toString();
            }
            if (classificationJsonString == null) {
                mResult.error(TAG, "Arguments must not be null", "");
            } else {
                JSONObject classificationObject = new JSONObject(classificationJsonString);
                String path = classificationObject.getString("path");
                float minAcceptablePossibility = (float) classificationObject.getDouble("minAcceptablePossibility");
                MLLocalClassificationAnalyzerSetting localSetting
                        = new MLLocalClassificationAnalyzerSetting
                        .Factory()
                        .setMinAcceptablePossibility(minAcceptablePossibility)
                        .create();
                analyzer = MLAnalyzerFactory.getInstance().getLocalImageClassificationAnalyzer(localSetting);

                final String encodedImage = ImagePathHelper.pathToBase64(path);
                MLFrame frame = HmsMlUtils.getFrame(encodedImage);
                performTask(frame);
            }
        } catch (JSONException e) {
            mResult.error(TAG, e.getMessage(), "");
        }
    }

    private void analyzeRemotely(MethodCall call) {
        try {
            String remoteClassificationString = null;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
                remoteClassificationString = Objects.requireNonNull(call.argument("settings")).toString();
            }
            if (remoteClassificationString == null) {
                mResult.error(TAG, "Arguments must not be null", "");
            } else {
                JSONObject remoteClassificationObject = new JSONObject(remoteClassificationString);
                String path = remoteClassificationObject.getString("path");
                float minAcceptablePossibility = (float) remoteClassificationObject.getDouble("minAcceptablePossibility");
                int largestNumberOfReturns = remoteClassificationObject.getInt("largestNumberOfReturns");

                MLRemoteClassificationAnalyzerSetting remoteSetting
                        = new MLRemoteClassificationAnalyzerSetting.Factory()
                        .setLargestNumOfReturns(largestNumberOfReturns)
                        .setMinAcceptablePossibility(minAcceptablePossibility).create();

                analyzer = MLAnalyzerFactory.getInstance().getRemoteImageClassificationAnalyzer(remoteSetting);

                final String encodedImage = ImagePathHelper.pathToBase64(path);
                MLFrame frame = HmsMlUtils.getFrame(encodedImage);
                performTask(frame);
            }
        } catch (JSONException e) {
            mResult.error(TAG, e.getMessage(), "");
        }
    }

    private void performTask(MLFrame frame) {
        Task<List<MLImageClassification>> task = analyzer.asyncAnalyseFrame(frame);

        task.addOnSuccessListener(new OnSuccessListener<List<MLImageClassification>>() {
            @Override
            public void onSuccess(List<MLImageClassification> mlImageClassifications) {
                try {
                    mResult.success(onAnalyzeSuccess(mlImageClassifications).toString());
                } catch (JSONException classifyError) {
                    mResult.error(TAG, classifyError.getMessage(), "");
                }
            }
        }).addOnFailureListener(new OnFailureListener() {
            @Override
            public void onFailure(Exception classifyError) {
                mResult.error(TAG, classifyError.getMessage(), "");
            }
        });
    }

    private void sparseAnalyze(MethodCall call) {
        try {
            String sparseJsonString = null;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
                sparseJsonString = Objects.requireNonNull(call.argument("settings")).toString();
            }
            if (sparseJsonString == null) {
                mResult.error(TAG, "Arguments must not be null", "");
            } else {
                JSONObject sparseObject = new JSONObject(sparseJsonString);
                String path = sparseObject.getString("path");
                final String encodedImage = ImagePathHelper.pathToBase64(path);
                analyzer = MLAnalyzerFactory.getInstance().getRemoteImageClassificationAnalyzer();
                MLFrame frame = HmsMlUtils.getFrame(encodedImage);
                SparseArray<MLImageClassification> analyseFrame = analyzer.analyseFrame(frame);
                if (analyseFrame != null) {
                    mResult.success(onSparseAnalyzeResult(analyseFrame).toString());
                }
            }
        } catch (JSONException e) {
            mResult.error(TAG, e.getMessage(), "");
        }
    }

    private static JSONObject onAnalyzeSuccess
            (List<MLImageClassification> mlImageClassifications) throws JSONException {
        JSONObject object = new JSONObject();
        for (int i = 0; i < mlImageClassifications.size(); i++) {
            JSONObject innerObject = new JSONObject();
            innerObject.putOpt("classificationIdentity", mlImageClassifications.get(i).getClassificationIdentity());
            innerObject.putOpt("name", mlImageClassifications.get(i).getName());
            innerObject.putOpt("possibility", mlImageClassifications.get(i).getPossibility());
            object.putOpt(String.valueOf(i), innerObject);
        }
        return object;
    }

    private static JSONObject onSparseAnalyzeResult(SparseArray<MLImageClassification> array) throws JSONException {
        JSONObject object = new JSONObject();
        for (int i = 0; i < array.size(); i++) {
            JSONObject inner = new JSONObject();
            inner.putOpt("classificationIdentity", array.get(i).getClassificationIdentity());
            inner.putOpt("name", array.get(i).getName());
            inner.putOpt("possibility", array.get(i).getPossibility());
            object.putOpt(String.valueOf(i), inner);
        }
        return object;
    }

    private void closeAnalyzer() {
        if (analyzer == null) {
            mResult.error(TAG, "Analyser is not initialized.", "");
        } else {
            try {
                analyzer.stop();
                analyzer = null;
                String success = "Analyzer is closed";
                mResult.success(success);
            } catch (IOException e) {
                mResult.error(TAG, e.getMessage(), "");
            }
        }
    }
}
