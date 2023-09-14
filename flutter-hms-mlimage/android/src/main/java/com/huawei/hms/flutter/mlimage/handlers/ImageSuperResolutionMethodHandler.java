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

package com.huawei.hms.flutter.mlimage.handlers;

import android.app.Activity;
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mlimage.constant.Method;
import com.huawei.hms.flutter.mlimage.constant.Param;
import com.huawei.hms.flutter.mlimage.utils.FromMap;
import com.huawei.hms.flutter.mlimage.utils.Commons;
import com.huawei.hms.flutter.mlimage.utils.SettingCreator;
import com.huawei.hms.flutter.mlimage.utils.MLResponseHandler;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.imagesuperresolution.MLImageSuperResolutionAnalyzer;
import com.huawei.hms.mlsdk.imagesuperresolution.MLImageSuperResolutionAnalyzerFactory;
import com.huawei.hms.mlsdk.imagesuperresolution.MLImageSuperResolutionResult;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class ImageSuperResolutionMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = ImageSuperResolutionMethodHandler.class.getSimpleName();

    private final MLResponseHandler responseHandler;

    private MLImageSuperResolutionAnalyzer analyzer;

    public ImageSuperResolutionMethodHandler(Activity activity) {
        this.responseHandler = MLResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) {
        responseHandler.setup(TAG, methodCall.method, result);
        switch (methodCall.method) {
            case Method.ANALYZE_FRAME:
                analyzeFrame(methodCall);
                break;
            case Method.ASYNC_ANALYZE_FRAME:
                asyncAnalyzeFrame(methodCall);
                break;
            case Method.STOP:
                stop();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void getSparseResolutionResult(@NonNull SparseArray<MLImageSuperResolutionResult> array) {
        List<MLImageSuperResolutionResult> list = new ArrayList<>(array.size());
        for (int i = 0; i < array.size(); i++) {
            list.add(array.get(i));
        }
        ArrayList<Map<String, Object>> mapList = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLImageSuperResolutionResult resolutionResult = list.get(i);
            map.put(Param.BYTES, Commons.bitmapToByteArray(resolutionResult.getBitmap()));
            mapList.add(map);
        }
        responseHandler.success(mapList);
    }

    private void sendSuccessResult(@NonNull MLImageSuperResolutionResult result) {
        HashMap<String, Object> resultMap = new HashMap<>();
        resultMap.put(Param.BYTES, Commons.bitmapToByteArray(result.getBitmap()));
        responseHandler.success(resultMap);
    }
    
    private void analyzeFrame(MethodCall call) {
        String resolutionImagePath = FromMap.toString(Param.PATH, call.argument(Param.PATH), false);

        analyzer = MLImageSuperResolutionAnalyzerFactory.getInstance().getImageSuperResolutionAnalyzer(SettingCreator.createImageResolutionSetting(call));

        MLFrame frame = SettingCreator.frameFromBitmap(resolutionImagePath);

        SparseArray<MLImageSuperResolutionResult> result = analyzer.analyseFrame(frame);
        getSparseResolutionResult(result);
    }
    
    private void asyncAnalyzeFrame(MethodCall call) {
        String resolutionImagePath = FromMap.toString(Param.PATH, call.argument(Param.PATH), false);

        analyzer = MLImageSuperResolutionAnalyzerFactory.getInstance()
                .getImageSuperResolutionAnalyzer(SettingCreator.createImageResolutionSetting(call));

        MLFrame frame = SettingCreator.frameFromBitmap(resolutionImagePath);
        analyzer.asyncAnalyseFrame(frame)
                .addOnSuccessListener(this::sendSuccessResult)
                .addOnFailureListener(responseHandler::exception);
    }
    
    private void stop() {
        if (analyzer == null) {
            responseHandler.noService();
            return;
        }
        analyzer.stop();
        responseHandler.success(true);
    }
}
