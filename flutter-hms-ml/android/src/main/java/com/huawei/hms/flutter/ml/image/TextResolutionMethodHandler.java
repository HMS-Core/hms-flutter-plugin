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
import android.graphics.Bitmap;
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.ml.utils.FrameHolder;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.textimagesuperresolution.MLTextImageSuperResolution;
import com.huawei.hms.mlsdk.textimagesuperresolution.MLTextImageSuperResolutionAnalyzer;
import com.huawei.hms.mlsdk.textimagesuperresolution.MLTextImageSuperResolutionAnalyzerFactory;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class TextResolutionMethodHandler implements MethodChannel.MethodCallHandler {
    private final static String TAG = TextResolutionMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;
    MLTextImageSuperResolutionAnalyzer analyzer;

    public TextResolutionMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "asyncTextResolution":
                asyncTextResolution(call);
                break;
            case "syncTextResolution":
                syncTextResolution(call);
                break;
            case "stopTextResolution":
                stopTextResolution();
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    private void asyncTextResolution(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("asyncTextResolution");
        String imagePath = call.argument("path");

        if (imagePath == null || imagePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncTextResolution", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        analyzer = MLTextImageSuperResolutionAnalyzerFactory.getInstance().getTextImageSuperResolutionAnalyzer();

        final Bitmap bitmap = HmsMlUtils.getARGB8888(imagePath);
        MLFrame frame = new MLFrame.Creator().setBitmap(bitmap).create();
        FrameHolder.getInstance().setFrame(frame);

        Task<MLTextImageSuperResolution> task = analyzer.asyncAnalyseFrame(frame);
        task.addOnSuccessListener(mlTextImageSuperResolution -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncTextResolution");
            mResult.success(sendResults(mlTextImageSuperResolution).toString());
        }).addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "asyncTextResolution", mResult));
    }

    private void syncTextResolution(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("syncTextResolution");
        String imagePath = call.argument("path");

        if (imagePath == null || imagePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncTextResolution", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        analyzer = MLTextImageSuperResolutionAnalyzerFactory.getInstance().getTextImageSuperResolutionAnalyzer();

        final Bitmap bitmap = HmsMlUtils.getARGB8888(imagePath);
        MLFrame frame = new MLFrame.Creator().setBitmap(bitmap).create();
        FrameHolder.getInstance().setFrame(frame);

        SparseArray<MLTextImageSuperResolution> resolutionSparseArray = analyzer.analyseFrame(frame);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncTextResolution");
        mResult.success(textResolutionToJSONArray(resolutionSparseArray).toString());
    }

    private void stopTextResolution() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stopTextResolution");
        if (analyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopTextResolution", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyzer is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
        } else {
            analyzer.stop();
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopTextResolution");
            mResult.success(true);
        }
    }

    private @NonNull JSONObject sendResults(@NonNull MLTextImageSuperResolution resolution) {
        Map<String, Object> resolutionMap = new HashMap<>();
        resolutionMap.put("bitmap", HmsMlUtils.saveBitmapAndGetPath(activity.getApplicationContext(), resolution.getBitmap()));
        return new JSONObject(resolutionMap);
    }

    private @NonNull JSONArray textResolutionToJSONArray(@NonNull SparseArray<MLTextImageSuperResolution> detections) {
        List<MLTextImageSuperResolution> list = new ArrayList<>(detections.size());
        for (int i = 0; i < detections.size(); i++) {
            MLTextImageSuperResolution detection = detections.get(i);
            list.add(detection);
        }

        ArrayList<Map<String, Object>> resList = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLTextImageSuperResolution resolution =  list.get(i);
            map.put("bitmap", HmsMlUtils.saveBitmapAndGetPath(activity.getApplicationContext(), resolution.getBitmap()));
            resList.add(map);
        }
        return new JSONArray(resList);
    }
}
