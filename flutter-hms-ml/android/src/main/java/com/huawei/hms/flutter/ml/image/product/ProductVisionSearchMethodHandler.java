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

package com.huawei.hms.flutter.ml.image.product;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.facebook.drawee.backends.pipeline.Fresco;
import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.FrameHolder;
import com.huawei.hms.flutter.ml.utils.tojson.FaceToJson;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.ml.utils.SettingUtils;
import com.huawei.hms.mlplugin.productvisionsearch.MLProductVisionSearchCapture;
import com.huawei.hms.mlplugin.productvisionsearch.MLProductVisionSearchCaptureFactory;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.productvisionsearch.MLProductVisionSearch;
import com.huawei.hms.mlsdk.productvisionsearch.MLVisionSearchProduct;
import com.huawei.hms.mlsdk.productvisionsearch.MLVisionSearchProductImage;
import com.huawei.hms.mlsdk.productvisionsearch.cloud.MLRemoteProductVisionSearchAnalyzer;

import org.json.JSONArray;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        Fresco.initialize(activity);
        mResult = result;
        switch (call.method) {
            case "analyzeProduct":
                startAnalyze(call);
                break;
            case "analyzeProductWithPlugin":
                pluginProductAnalyze(call);
                break;
            case "stopProductAnalyzer":
                stopAnalyzer();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void startAnalyze(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("analyzeProduct");
        String imagePath = call.argument("path");
        String productFrameType = call.argument("frameType");

        if (imagePath == null || imagePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyzeProduct", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }
        analyzer = MLAnalyzerFactory.getInstance().getRemoteProductVisionSearchAnalyzer(SettingUtils.createProductSetting(call));
        MLFrame mlFrame = SettingUtils.createMLFrame(activity, productFrameType != null ? productFrameType : "fromBitmap", imagePath, call);
        FrameHolder.getInstance().setFrame(mlFrame);
        Task<List<MLProductVisionSearch>> task = analyzer.asyncAnalyseFrame(mlFrame);
        task.addOnSuccessListener(mlProductVisionSearches -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyzeProduct");
            onAnalyzeSuccess(mlProductVisionSearches);
        }).addOnFailureListener(productError -> HmsMlUtils.handleException(activity, TAG, productError, "analyzeProduct", mResult));
    }

    private void pluginProductAnalyze(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("analyzeProductWithPlugin");
        MLProductVisionSearchCapture capture = MLProductVisionSearchCaptureFactory
                .getInstance()
                .create(SettingUtils.createPluginProductSetting(call, activity, mResult));
        capture.startCapture(activity);
    }

    private void stopAnalyzer() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stopProductAnalyzer");
        if (analyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopProductAnalyzer", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error("Error", "Analyzer is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
        } else {
            analyzer.stop();
            analyzer = null;
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopProductAnalyzer");
            mResult.success(true);
        }
    }

    private void onAnalyzeSuccess(@NonNull List<MLProductVisionSearch> mlProductVisionSearches) {
        ArrayList<Map<String, Object>> prdList = new ArrayList<>();
        for (int i = 0; i < mlProductVisionSearches.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLProductVisionSearch search = mlProductVisionSearches.get(i);
            map.put("border", FaceToJson.createBorderJSON(search.getBorder()));
            map.put("type", search.getType());
            map.put("productList", getProductList(search.getProductList()));
            prdList.add(map);
        }
        mResult.success(new JSONArray(prdList).toString());
    }

    private static @NonNull JSONArray getProductList(@NonNull List<MLVisionSearchProduct> products) {
        ArrayList<Map<String, Object>> prdList = new ArrayList<>();
        for (int i = 0; i < products.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLVisionSearchProduct product = products.get(i);
            map.put("customContent", product.getCustomContent());
            map.put("imageList", getProductImageList(product.getImageList()));
            map.put("possibility", product.getPossibility());
            map.put("productId", product.getProductId());
            map.put("productUrl", product.getProductUrl());
            prdList.add(map);
        }
        return new JSONArray(prdList);
    }

    private static @NonNull JSONArray getProductImageList(@NonNull List<MLVisionSearchProductImage> images) {
        ArrayList<Map<String, Object>> imgList = new ArrayList<>();
        for (int i = 0; i < images.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLVisionSearchProductImage image = images.get(i);
            map.put("possibility", image.getPossibility());
            map.put("imageId", image.getImageId());
            map.put("productId", image.getProductId());
            imgList.add(map);
        }
        return new JSONArray(imgList);
    }
}
