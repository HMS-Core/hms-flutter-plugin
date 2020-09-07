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

package com.huawei.hms.flutter.ml.productvisionsearch;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Base64;

import androidx.annotation.NonNull;

import com.huawei.agconnect.config.AGConnectServicesConfig;
import com.huawei.hms.flutter.ml.utils.ImagePathHelper;
import com.huawei.hms.flutter.ml.utils.MlTextUtils;
import com.huawei.hmf.tasks.OnFailureListener;
import com.huawei.hmf.tasks.OnSuccessListener;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.common.MLApplication;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.productvisionsearch.MLProductVisionSearch;
import com.huawei.hms.mlsdk.productvisionsearch.MLVisionSearchProduct;
import com.huawei.hms.mlsdk.productvisionsearch.MLVisionSearchProductImage;
import com.huawei.hms.mlsdk.productvisionsearch.cloud.MLRemoteProductVisionSearchAnalyzer;
import com.huawei.hms.mlsdk.productvisionsearch.cloud.MLRemoteProductVisionSearchAnalyzerSetting;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.List;
import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class ProductVisionSearchMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = ProductVisionSearchMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;
    private MLRemoteProductVisionSearchAnalyzer analyzer;

    public ProductVisionSearchMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        String apiKey = AGConnectServicesConfig.fromContext(
                activity.getApplicationContext()).getString("client/api_key");
        MLApplication.getInstance().setApiKey(apiKey);
        switch (call.method) {
            case "startAnalyze":
                startAnalyze(call);
                break;
            case "stopAnalyzer":
                stopAnalyzer();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void startAnalyze(MethodCall call) {
        String imagePath;
        int largestNumberOfReturns;
        int region;
        try {
            String jsonString = null;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
                jsonString = Objects.requireNonNull(call.argument("settings")).toString();
            }
            if (jsonString == null) {
                mResult.error(TAG, "Arguments must not be null", "");
            } else {
                JSONObject object = new JSONObject(jsonString);
                imagePath = object.getString("path");
                largestNumberOfReturns = object.getInt("largestNumberOfReturns");
                region = object.getInt("region");

                final String encodedImage = ImagePathHelper.pathToBase64(imagePath);
                byte[] decodedString = Base64.decode(encodedImage, Base64.DEFAULT);

                MLRemoteProductVisionSearchAnalyzerSetting setting = new MLRemoteProductVisionSearchAnalyzerSetting
                        .Factory()
                        .setLargestNumOfReturns(largestNumberOfReturns)
                        .setRegion(region)
                        .create();

                analyzer = MLAnalyzerFactory.getInstance().getRemoteProductVisionSearchAnalyzer(setting);

                Bitmap bitmap = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
                MLFrame mlFrame = new MLFrame.Creator().setBitmap(bitmap).create();

                Task<List<MLProductVisionSearch>> task = analyzer.asyncAnalyseFrame(mlFrame);

                task.addOnSuccessListener(new OnSuccessListener<List<MLProductVisionSearch>>() {
                    @Override
                    public void onSuccess(List<MLProductVisionSearch> mlProductVisionSearches) {
                        try {
                            onAnalyzeSuccess(mlProductVisionSearches);
                        } catch (JSONException productError) {
                            mResult.error(TAG, productError.getMessage(), "");
                        }
                    }
                }).addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(Exception productError) {
                        mResult.error(TAG, productError.getMessage(), "");
                    }
                });
            }
        } catch (JSONException productError) {
            mResult.error(TAG, productError.getMessage(), "");
        }
    }

    private void onAnalyzeSuccess(List<MLProductVisionSearch> mlProductVisionSearches) throws JSONException {
        JSONObject object = new JSONObject();
        for (MLProductVisionSearch productVisionSearch : mlProductVisionSearches) {
            object.putOpt("type", productVisionSearch.getType());
            object.putOpt("border", MlTextUtils.getBorders(productVisionSearch.getBorder()));
            object.putOpt("productList", getProductList(productVisionSearch.getProductList()));
        }
        mResult.success(object.toString());
    }

    private static JSONObject getProductList(List<MLVisionSearchProduct> products) throws JSONException {
        JSONObject object = new JSONObject();
        for (MLVisionSearchProduct product : products) {
            object.putOpt("possibility", product.getPossibility());
            object.putOpt("productId", product.getProductId());
            object.putOpt("imageList", getProductImageList(product.getImageList()));
        }
        return object;
    }

    private static JSONObject getProductImageList(List<MLVisionSearchProductImage> images) throws JSONException {
        JSONObject object = new JSONObject();
        for (MLVisionSearchProductImage image : images) {
            object.putOpt("possibility", image.getPossibility());
            object.putOpt("imageId", image.getImageId());
            object.putOpt("productId", image.getProductId());
        }
        return object;
    }

    private void stopAnalyzer() {
        if (analyzer == null) {
            mResult.error("Error", "Analyzer is not initialized", "");
        } else {
            analyzer.stop();
            analyzer = null;
            String success = "Analyzer is stopped";
            mResult.success(success);
        }
    }
}
