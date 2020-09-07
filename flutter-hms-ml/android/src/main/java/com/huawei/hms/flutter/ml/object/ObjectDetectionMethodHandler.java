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

package com.huawei.hms.flutter.ml.object;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.ImagePathHelper;
import com.huawei.hms.flutter.ml.utils.MlTextUtils;
import com.huawei.hmf.tasks.OnFailureListener;
import com.huawei.hmf.tasks.OnSuccessListener;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.objects.MLObject;
import com.huawei.hms.mlsdk.objects.MLObjectAnalyzer;
import com.huawei.hms.mlsdk.objects.MLObjectAnalyzerSetting;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.List;
import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class ObjectDetectionMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = ObjectDetectionMethodHandler.class.getSimpleName();

    private MethodChannel.Result mResult;
    private MLObjectAnalyzerSetting setting;
    private MLObjectAnalyzer analyzer;

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "analyzeObject":
                analyzeObject(call);
                break;
            case "stopAnalyzer":
                stopAnalyzer();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void analyzeObject(MethodCall call) {
        String path;
        boolean allowMultiResults;
        try {
            String jsonString = null;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
                jsonString = Objects.requireNonNull(call.argument("settings")).toString();
            }
            if (jsonString == null) {
                mResult.error(TAG, "Arguments must not be null", "");
            } else {
                JSONObject object = new JSONObject(jsonString);
                path = object.getString("path");
                allowMultiResults = object.getBoolean("allowMultiResults");
                boolean allowClassification;
                allowClassification = object.getBoolean("allowClassification");

                if (allowMultiResults && allowClassification) {
                    setting = new MLObjectAnalyzerSetting.Factory()
                            .allowClassification()
                            .allowMultiResults()
                            .setAnalyzerType(MLObjectAnalyzerSetting.TYPE_PICTURE)
                            .create();
                } else if (allowMultiResults) {
                    setting = new MLObjectAnalyzerSetting.Factory()
                            .allowMultiResults()
                            .setAnalyzerType(MLObjectAnalyzerSetting.TYPE_PICTURE)
                            .create();
                } else {
                    setting = new MLObjectAnalyzerSetting.Factory()
                            .allowClassification()
                            .setAnalyzerType(MLObjectAnalyzerSetting.TYPE_PICTURE)
                            .create();
                }

                final String encodedImage = ImagePathHelper.pathToBase64(path);
                MLFrame frame = HmsMlUtils.getFrame(encodedImage);

                analyzer = MLAnalyzerFactory.getInstance().getLocalObjectAnalyzer(setting);
                Task<List<MLObject>> task = analyzer.asyncAnalyseFrame(frame);

                task.addOnSuccessListener(new OnSuccessListener<List<MLObject>>() {
                    @Override
                    public void onSuccess(List<MLObject> mlObjects) {
                        try {
                            mResult.success(onAnalyzeSuccess(mlObjects).toString());
                        } catch (JSONException objectError) {
                            mResult.error(TAG, objectError.getMessage(), "");
                        }
                    }
                }).addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(Exception objectError) {
                        mResult.error(TAG, objectError.getMessage(), "");
                    }
                });
            }
        } catch (JSONException objectError) {
            mResult.error(TAG, objectError.getMessage(), "");
        }
    }

    private static JSONObject onAnalyzeSuccess(List<MLObject> objects) throws JSONException {
        JSONObject object = new JSONObject();
        for (MLObject mlObject : objects) {
            object.putOpt("border", MlTextUtils.getBorders(mlObject.getBorder()));
            object.putOpt("typeIdentity", mlObject.getTypeIdentity());
            object.putOpt("typePossibility", mlObject.getTypePossibility());
        }
        return object;
    }

    private void stopAnalyzer() {
        if (analyzer == null) {
            mResult.error(TAG, "Analyzer is not initalized", "");
        } else {
            try {
                analyzer.stop();
                analyzer = null;
                String success = "Analyzer is stopped";
                mResult.success(success);
            } catch (IOException e) {
                mResult.error(TAG, e.getMessage(), "");
            }
        }
    }
}
