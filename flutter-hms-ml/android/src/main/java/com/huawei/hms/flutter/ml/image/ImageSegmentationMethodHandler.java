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

package com.huawei.hms.flutter.ml.image;

import android.app.Activity;
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.FrameHolder;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.flutter.ml.utils.SettingUtils;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.imgseg.MLImageSegmentation;
import com.huawei.hms.mlsdk.imgseg.MLImageSegmentationAnalyzer;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class ImageSegmentationMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = ImageSegmentationMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;
    private MLImageSegmentationAnalyzer imageSegmentationAnalyzer;

    public ImageSegmentationMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "asyncAnalyzeFrame":
                getSegmentation(call);
                break;
            case "analyzeFrame":
                getSparseSegmentation(call);
                break;
            case "stopSegmentation":
                stopSegmentation();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void getSegmentation(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("asyncSegmentation");
        String segmentationImagePath = call.argument("path");
        String segmentationFrameType = call.argument("frameType");

        if (segmentationImagePath == null || segmentationImagePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncSegmentation", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        imageSegmentationAnalyzer = MLAnalyzerFactory.getInstance().getImageSegmentationAnalyzer(SettingUtils.createSegmentationSetting(call));
        MLFrame mlf = SettingUtils.createMLFrame(
                activity,
                segmentationFrameType != null ? segmentationFrameType : "fromBitmap",
                segmentationImagePath,
                call);
        FrameHolder.getInstance().setFrame(mlf);
        Task<MLImageSegmentation> task = imageSegmentationAnalyzer.asyncAnalyseFrame(mlf);
        task.addOnSuccessListener(mlImageSegmentation -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncSegmentation");
            mResult.success(getImageSegmentationResult(mlImageSegmentation).toString());
        }).addOnFailureListener(segException -> HmsMlUtils.handleException(activity, TAG, segException, "asyncSegmentation", mResult));

    }

    private void getSparseSegmentation(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getSparseImageSegmentation");
        String sparseSegmentationImagePath = call.argument("path");
        String sparseSegmentationFrame = call.argument("frameType");

        if (sparseSegmentationImagePath == null || sparseSegmentationImagePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getSparseImageSegmentation", "Error");
            mResult.error(TAG, "Image path is missing", "");
            return;
        }

        imageSegmentationAnalyzer = MLAnalyzerFactory.getInstance().getImageSegmentationAnalyzer(SettingUtils.createSegmentationSetting(call));

        MLFrame frame = SettingUtils.createMLFrame(
                activity,
                sparseSegmentationFrame != null ? sparseSegmentationFrame : "fromBitmap",
                sparseSegmentationImagePath,
                call);
        FrameHolder.getInstance().setFrame(frame);
        SparseArray<MLImageSegmentation> sparseArray = imageSegmentationAnalyzer.analyseFrame(frame);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getSparseImageSegmentation");
        segToJSONList(fromSparseToSegList(sparseArray));
    }

    private void stopSegmentation() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stopSegmentation");
        if (imageSegmentationAnalyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopSegmentation", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Image Segmentation Analyser is already closed", MlConstants.UNINITIALIZED_ANALYZER);
        } else {
            try {
                imageSegmentationAnalyzer.stop();
                imageSegmentationAnalyzer = null;
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopSegmentation");
                mResult.success(true);
            } catch (IOException e) {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopSegmentation", e.getMessage());
                mResult.error(TAG, e.getMessage(), "");
            }
        }
    }

    private @NonNull
    JSONObject getImageSegmentationResult(@NonNull MLImageSegmentation imageSegmentationResult) {
        HashMap<String, Object> segmentationMap = new HashMap<>();
        segmentationMap.put("bitmapForeground", HmsMlUtils.saveBitmapAndGetPath(activity.getApplicationContext(), imageSegmentationResult.getForeground()));
        segmentationMap.put("bitmapGrayscale", HmsMlUtils.saveBitmapAndGetPath(activity.getApplicationContext(), imageSegmentationResult.getGrayscale()));
        segmentationMap.put("masks", imageSegmentationResult.getMasks());
        segmentationMap.put("bitmapOriginal", HmsMlUtils.saveBitmapAndGetPath(activity.getApplicationContext(), imageSegmentationResult.getOriginal()));
        return new JSONObject(segmentationMap);
    }

    private @NonNull
    List<MLImageSegmentation> fromSparseToSegList(@NonNull SparseArray<MLImageSegmentation> array) {
        List<MLImageSegmentation> list = new ArrayList<>(array.size());
        for (int i = 0; i < array.size(); i++) {
            list.add(array.get(i));
        }
        return list;
    }

    private void segToJSONList(@NonNull List<MLImageSegmentation> list) {
        ArrayList<Map<String, Object>> segList = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLImageSegmentation segmentation = list.get(i);
            map.put("bitmapForeground", HmsMlUtils.saveBitmapAndGetPath(activity.getApplicationContext(), segmentation.getForeground()));
            map.put("bitmapGrayscale", HmsMlUtils.saveBitmapAndGetPath(activity.getApplicationContext(), segmentation.getGrayscale()));
            map.put("masks", segmentation.getMasks());
            map.put("bitmapOriginal", HmsMlUtils.saveBitmapAndGetPath(activity.getApplicationContext(), segmentation.getOriginal()));
            segList.add(map);
        }
        mResult.success(new JSONArray(segList).toString());
    }
}