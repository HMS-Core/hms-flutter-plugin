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
import com.huawei.hms.flutter.mlimage.utils.Commons;
import com.huawei.hms.flutter.mlimage.utils.FromMap;
import com.huawei.hms.flutter.mlimage.utils.SettingCreator;
import com.huawei.hms.flutter.mlimage.utils.MLResponseHandler;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.imgseg.MLImageSegmentation;
import com.huawei.hms.mlsdk.imgseg.MLImageSegmentationAnalyzer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class SegmentationMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = SegmentationMethodHandler.class.getSimpleName();

    private final MLResponseHandler responseHandler;

    private MLImageSegmentationAnalyzer segmentationAnalyzer;

    public SegmentationMethodHandler(Activity activity) {
        this.responseHandler = MLResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        responseHandler.setup(TAG, call.method, result);
        switch (call.method) {
            case Method.ASYNC_ANALYZE_FRAME:
                asyncSegmentation(call);
                break;
            case Method.ANALYZE_FRAME:
                syncSegmentation(call);
                break;
            case Method.STOP:
                stop();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void getImageSegmentationResult(@NonNull MLImageSegmentation imageSegmentationResult) {
        Map<String, Object> map = new HashMap<>();
        map.put(Param.FOREGROUND, Commons.bitmapToByteArray(imageSegmentationResult.getForeground()));
        map.put(Param.GRAYSCALE, Commons.bitmapToByteArray(imageSegmentationResult.getForeground()));
        map.put(Param.MASKS, imageSegmentationResult.getMasks());
        map.put(Param.ORIGINAL, Commons.bitmapToByteArray(imageSegmentationResult.getForeground()));
        responseHandler.success(map);
    }

    private List<MLImageSegmentation> fromSparseToSegList(SparseArray<MLImageSegmentation> array) {
        List<MLImageSegmentation> list = new ArrayList<>(array.size());
        for (int i = 0; i < array.size(); i++) {
            list.add(array.get(i));
        }
        return list;
    }

    public static ArrayList<Map<String, Object>> segListMap(List<MLImageSegmentation> list) {
        ArrayList<Map<String, Object>> segList = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLImageSegmentation segmentation = list.get(i);
            map.put(Param.FOREGROUND, Commons.bitmapToByteArray(segmentation.getForeground()));
            map.put(Param.GRAYSCALE, Commons.bitmapToByteArray(segmentation.getForeground()));
            map.put(Param.MASKS, segmentation.getMasks());
            map.put(Param.ORIGINAL, Commons.bitmapToByteArray(segmentation.getForeground()));
            segList.add(map);
        }
        return segList;
    }

    private void asyncSegmentation(@NonNull MethodCall call) {
        String segmentationImagePath = FromMap.toString(Param.PATH, call.argument(Param.PATH), false);

        segmentationAnalyzer = MLAnalyzerFactory.getInstance().getImageSegmentationAnalyzer(SettingCreator.createSegmentationSetting(call));

        MLFrame frame = SettingCreator.frameFromBitmap(segmentationImagePath);

        segmentationAnalyzer.asyncAnalyseFrame(frame)
                .addOnSuccessListener(this::getImageSegmentationResult)
                .addOnFailureListener(responseHandler::exception);
    }

    private void syncSegmentation(@NonNull MethodCall call) {
        String sparseSegmentationImagePath = FromMap.toString(Param.PATH, call.argument(Param.PATH), false);

        segmentationAnalyzer = MLAnalyzerFactory.getInstance().getImageSegmentationAnalyzer(SettingCreator.createSegmentationSetting(call));

        MLFrame frame = SettingCreator.frameFromBitmap(sparseSegmentationImagePath);

        SparseArray<MLImageSegmentation> sparseArray = segmentationAnalyzer.analyseFrame(frame);
        responseHandler.success(segListMap(fromSparseToSegList(sparseArray)));
    }

    private void stop() {
        if (segmentationAnalyzer == null) {
            responseHandler.noService();
            return;
        }
        try {
            segmentationAnalyzer.stop();
            segmentationAnalyzer = null;
            responseHandler.success(true);
        } catch (IOException e) {
            responseHandler.exception(e);
        }
    }
}
