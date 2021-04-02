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

import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.ml.utils.FrameHolder;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.SettingUtils;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.imagesuperresolution.MLImageSuperResolutionAnalyzer;
import com.huawei.hms.mlsdk.imagesuperresolution.MLImageSuperResolutionAnalyzerFactory;
import com.huawei.hms.mlsdk.imagesuperresolution.MLImageSuperResolutionResult;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class ImageSuperResolutionMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = ImageSuperResolutionMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;
    private MLImageSuperResolutionAnalyzer mlImageSuperResolutionAnalyzer;

    public ImageSuperResolutionMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "asyncImageResolution":
                asyncResolution(call);
                break;
            case "syncImageResolution":
                syncImageResolution(call);
                break;
            case "stopImageResolutionAnalyzer":
                stopProcessing();
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    private void asyncResolution(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("asyncImageResolution");
        String processingImagePath = call.argument("path");
        String processingFrameType = call.argument("frameType");

        if (processingImagePath == null || processingImagePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncImageResolution", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        mlImageSuperResolutionAnalyzer = MLImageSuperResolutionAnalyzerFactory
                .getInstance()
                .getImageSuperResolutionAnalyzer(
                        SettingUtils.createImageResolutionSetting(call));
        MLFrame frame = SettingUtils.createMLFrame(
                activity,
                processingFrameType != null ? processingFrameType : "fromBitmap",
                processingImagePath,
                call);
        FrameHolder.getInstance().setFrame(frame);
        Task<MLImageSuperResolutionResult> task = mlImageSuperResolutionAnalyzer.asyncAnalyseFrame(frame);
        task.addOnSuccessListener(result -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("asyncImageResolution");
            mResult.success(getResultPath(result).toString());
        }).addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "asyncImageResolution", mResult));
    }

    private void syncImageResolution(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("syncImageResolution");
        String processingImagePath = call.argument("path");
        String processingFrameType = call.argument("frameType");

        if (processingImagePath == null || processingImagePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncImageResolution", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path must not be null", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        mlImageSuperResolutionAnalyzer = MLImageSuperResolutionAnalyzerFactory
                .getInstance()
                .getImageSuperResolutionAnalyzer(
                        SettingUtils.createImageResolutionSetting(call));

        MLFrame mFrame = SettingUtils.createMLFrame(
                activity,
                processingFrameType != null ? processingFrameType : "fromBitmap",
                processingImagePath,
                call);
        FrameHolder.getInstance().setFrame(mFrame);

        SparseArray<MLImageSuperResolutionResult> sparseArray = mlImageSuperResolutionAnalyzer.analyseFrame(mFrame);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("syncImageResolution");
        getSparseResolutionResult(sparseArray);
    }

    private void stopProcessing() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stopImageResolutionAnalyzer");
        if (mlImageSuperResolutionAnalyzer != null) {
            mlImageSuperResolutionAnalyzer.stop();
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopImageResolutionAnalyzer");
            mResult.success(true);
        } else {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopImageResolutionAnalyzer", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyzer is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
        }
    }

    private void getSparseResolutionResult(@NonNull SparseArray<MLImageSuperResolutionResult> array) {
        ArrayList<Map<String, Object>> mapList = new ArrayList<>();
        List<MLImageSuperResolutionResult> list = new ArrayList<>(array.size());
        for (int i = 0; i < array.size(); i++) {
            list.add(array.get(i));
        }
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLImageSuperResolutionResult resolutionResult = list.get(i);
            map.put("imagePath", HmsMlUtils.saveBitmapAndGetPath(activity.getApplicationContext(), resolutionResult.getBitmap()));
            mapList.add(map);
        }
        mResult.success(new JSONArray(mapList).toString());
    }

    private @NonNull JSONObject getResultPath(@NonNull MLImageSuperResolutionResult result) {
        HashMap<String, Object> resultMap = new HashMap<>();
        resultMap.put("imagePath", HmsMlUtils.saveBitmapAndGetPath(activity.getApplicationContext(), result.getBitmap()));
        return new JSONObject(resultMap);
    }
}
