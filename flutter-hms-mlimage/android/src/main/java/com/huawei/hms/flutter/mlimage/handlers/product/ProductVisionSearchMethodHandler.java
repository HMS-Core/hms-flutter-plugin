/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.mlimage.handlers.product;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.facebook.drawee.backends.pipeline.Fresco;
import com.huawei.hms.flutter.mlimage.utils.Commons;
import com.huawei.hms.flutter.mlimage.utils.FromMap;
import com.huawei.hms.flutter.mlimage.utils.MLResponseHandler;
import com.huawei.hms.flutter.mlimage.utils.SettingCreator;
import com.huawei.hms.mlplugin.productvisionsearch.MLProductVisionSearchCapture;
import com.huawei.hms.mlplugin.productvisionsearch.MLProductVisionSearchCaptureFactory;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.productvisionsearch.MLProductVisionSearch;
import com.huawei.hms.mlsdk.productvisionsearch.MLVisionSearchProduct;
import com.huawei.hms.mlsdk.productvisionsearch.MLVisionSearchProductImage;
import com.huawei.hms.mlsdk.productvisionsearch.cloud.MLRemoteProductVisionSearchAnalyzer;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class ProductVisionSearchMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = ProductVisionSearchMethodHandler.class.getSimpleName();

    private final Activity activity;
    private final MLResponseHandler responseHandler;

    private MLRemoteProductVisionSearchAnalyzer analyzer;

    public ProductVisionSearchMethodHandler(Activity activity) {
        this.activity = activity;
        this.responseHandler = MLResponseHandler.getInstance(activity);
        Fresco.initialize(this.activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        responseHandler.setup(TAG, call.method, result);
        switch (call.method) {
            case "analyzeProduct":
                startAnalyze(call);
                break;
            case "analyzeProductWithPlugin":
                pluginProductAnalyze(call, result);
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
        String imagePath = FromMap.toString("path", call.argument("path"), false);

        analyzer = MLAnalyzerFactory.getInstance().getRemoteProductVisionSearchAnalyzer(SettingCreator.createProductSetting(call));

        MLFrame mlFrame = SettingCreator.frameFromBitmap(imagePath);

        analyzer.asyncAnalyseFrame(mlFrame)
                .addOnSuccessListener(this::onAnalyzeSuccess)
                .addOnFailureListener(responseHandler::exception);
    }

    private void pluginProductAnalyze(MethodCall call, MethodChannel.Result result) {
        MLProductVisionSearchCapture capture = MLProductVisionSearchCaptureFactory.getInstance()
                .create(SettingCreator.createPluginProductSetting(call, activity, result));
        capture.startCapture(activity);
    }

    private void stopAnalyzer() {
        if (analyzer == null) {
            responseHandler.noService();
            return;
        }
        analyzer.stop();
        analyzer = null;
        responseHandler.success(true);
    }

    private void onAnalyzeSuccess(@NonNull List<MLProductVisionSearch> mlProductVisionSearches) {
        ArrayList<Map<String, Object>> prdList = new ArrayList<>();
        for (int i = 0; i < mlProductVisionSearches.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLProductVisionSearch search = mlProductVisionSearches.get(i);
            map.put("border", Commons.createBorderMap(search.getBorder()));
            map.put("type", search.getType());
            map.put("productList", getProductList(search.getProductList()));
            prdList.add(map);
        }
        responseHandler.success(prdList);
    }

    private static ArrayList<Map<String, Object>> getProductList(List<MLVisionSearchProduct> products) {
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
        return prdList;
    }

    private static ArrayList<Map<String, Object>> getProductImageList(List<MLVisionSearchProductImage> images) {
        ArrayList<Map<String, Object>> imgList = new ArrayList<>();
        for (int i = 0; i < images.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLVisionSearchProductImage image = images.get(i);
            map.put("possibility", image.getPossibility());
            map.put("imageId", image.getImageId());
            map.put("productId", image.getProductId());
            imgList.add(map);
        }
        return imgList;
    }
}
