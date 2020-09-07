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

package com.huawei.hms.flutter.ml.document;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Base64;

import androidx.annotation.NonNull;

import com.huawei.agconnect.config.AGConnectServicesConfig;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.ImagePathHelper;
import com.huawei.hms.flutter.ml.utils.MlDocumentUtils;
import com.huawei.hmf.tasks.OnFailureListener;
import com.huawei.hmf.tasks.OnSuccessListener;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.common.MLApplication;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.document.MLDocument;
import com.huawei.hms.mlsdk.document.MLDocumentAnalyzer;
import com.huawei.hms.mlsdk.document.MLDocumentSetting;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.List;
import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class DocumentAnalyzerMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = DocumentAnalyzerMethodHandler.class.getSimpleName();

    private Activity activity;
    private MLDocumentAnalyzer analyzer;
    private MethodChannel.Result mResult;

    public DocumentAnalyzerMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        if (call.method.equals("analyzeDocument")) {
            analyzeDocument(call);
        } else if (call.method.equals("closeAnalyzer")) {
            closeAnalyzer();
        } else {
            result.notImplemented();
        }
    }

    private void analyzeDocument(MethodCall call) {
        List<String> languageList;
        MLDocumentSetting setting;
        try {
            String jsonString = null;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
                jsonString = Objects.requireNonNull(call.argument("settings")).toString();
            }
            if (jsonString == null) {
                mResult.error(TAG, "Arguments must not be null", "");
            } else {
                JSONObject object = new JSONObject(jsonString);
                languageList = HmsMlUtils.jsonArrayToList(object);
                setting = new MLDocumentSetting.Factory()
                        .setBorderType(object.getString("borderType"))
                        .setLanguageList(languageList)
                        .create();

                String imagePath = object.getString("path");
                final String encodedImage = ImagePathHelper.pathToBase64(imagePath);
                byte[] decodedString = Base64.decode(encodedImage, Base64.DEFAULT);

                String apiKey = AGConnectServicesConfig.fromContext(
                        activity.getApplicationContext()).getString("client/api_key");
                MLApplication.getInstance().setApiKey(apiKey);

                this.analyzer = MLAnalyzerFactory.getInstance().getRemoteDocumentAnalyzer(setting);
                Bitmap bitmap = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
                MLFrame frame = MLFrame.fromBitmap(bitmap);
                Task<MLDocument> task = analyzer.asyncAnalyseFrame(frame);

                task.addOnSuccessListener(new OnSuccessListener<MLDocument>() {
                    @Override
                    public void onSuccess(MLDocument mlDocument) {
                        onAnalyzeSuccess(mlDocument);
                    }
                });

                task.addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(Exception documentAnalyzeError) {
                        mResult.error(TAG, documentAnalyzeError.getMessage(), "");
                    }
                });
            }
        } catch (JSONException documentAnalyzeError) {
            mResult.error(TAG, documentAnalyzeError.getMessage(), "");
        }
    }

    private void onAnalyzeSuccess(MLDocument document) {
        JSONObject object = new JSONObject();
        try {
            object.putOpt("stringValue", document.getStringValue());
            object.putOpt("blocks", MlDocumentUtils.getDocBlocks(document.getBlocks()));
        } catch (JSONException e) {
            mResult.error(TAG, e.getMessage(), "");
        }
        mResult.success(object.toString());
    }

    private void closeAnalyzer() {
        if (analyzer == null) {
            mResult.error("Error", "Analyzer is not initialized", "");
        } else {
            try {
                analyzer.stop();
                analyzer = null;
                final String documentSuccess = "Document analyzer is closed";
                mResult.success(documentSuccess);
            } catch (IOException e) {
                mResult.error(TAG, e.getMessage(), "");
            }
        }
    }
}