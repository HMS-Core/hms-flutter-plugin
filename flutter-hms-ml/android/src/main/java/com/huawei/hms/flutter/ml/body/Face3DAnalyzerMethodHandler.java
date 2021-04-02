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

package com.huawei.hms.flutter.ml.body;

import android.app.Activity;
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.EventHandler;
import com.huawei.hms.flutter.ml.utils.FrameHolder;
import com.huawei.hms.flutter.ml.utils.tojson.FaceToJson;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;

import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.flutter.ml.utils.SettingUtils;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.face.face3d.ML3DFace;
import com.huawei.hms.mlsdk.face.face3d.ML3DFaceAnalyzer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class Face3DAnalyzerMethodHandler implements MethodChannel.MethodCallHandler, EventChannel.StreamHandler {
    private static final String TAG = Face3DAnalyzerMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;

    private ML3DFaceAnalyzer analyzer;

    public Face3DAnalyzerMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "async3dFaceAnalyze":
                async3dFaceAnalyze(call);
                break;
            case "sync3dFaceAnalyze":
                sync3dFaceAnalyze(call);
                break;
            case "isAvailable":
                is3dAnalyzerAvailable();
                break;
            case "stop":
                stop();
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    private void async3dFaceAnalyze(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("async3dFaceAnalyze");
        String path = call.argument("path");
        String frame = call.argument("frameType");

        if (path == null || path.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("async3dFaceAnalyze", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing!", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        analyzer = MLAnalyzerFactory.getInstance().get3DFaceAnalyzer(SettingUtils.create3DAnalyzeSetting(call));
        MLFrame mlFrame = SettingUtils.createMLFrame(activity, frame != null ? frame : "fromBitmap", path, call);
        FrameHolder.getInstance().setFrame(mlFrame);
        Task<List<ML3DFace>> face3dTask = analyzer.asyncAnalyseFrame(mlFrame);

        face3dTask.addOnSuccessListener(ml3DFaces -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("async3dFaceAnalyze");
            mResult.success(FaceToJson.face3DToJSONArray(ml3DFaces).toString());
        }).addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "async3dFaceAnalyze", mResult));
    }

    private void sync3dFaceAnalyze(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("sync3dFaceAnalyze");
        String path1 = call.argument("path");
        String frame1 = call.argument("frameType");

        if (path1 == null || path1.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("sync3dFaceAnalyze", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Image path is missing!", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        analyzer = MLAnalyzerFactory.getInstance().get3DFaceAnalyzer(SettingUtils.create3DAnalyzeSetting(call));
        MLFrame mlFrame = SettingUtils.createMLFrame(activity, frame1 != null ? frame1 : "fromBitmap", path1, call);
        FrameHolder.getInstance().setFrame(mlFrame);

        SparseArray<ML3DFace> faceSparseArray = analyzer.analyseFrame(mlFrame);
        List<ML3DFace> arrayList = new ArrayList<>(faceSparseArray.size());
        for (int i = 0; i < faceSparseArray.size(); i++) {
            arrayList.add(faceSparseArray.valueAt(i));
        }
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("sync3dFaceAnalyze");
        mResult.success(FaceToJson.face3DToJSONArray(arrayList).toString());
    }

    private void is3dAnalyzerAvailable() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("is3dFaceAnalyzerAvailable");
        if (analyzer == null) {
            mResult.error(TAG, "Analyzer is not initialized!", "");
            return;
        }

        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("is3dFaceAnalyzerAvailable");
        mResult.success(analyzer.isAvailable());
    }

    private void stop() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stop3dFaceAnalyzer");
        if (analyzer == null) {
            mResult.error(TAG, "Analyzer is not initialized!", "");
            return;
        }

        try {
            analyzer.stop();
            analyzer = null;
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stop3dFaceAnalyzer");
            mResult.success(true);
        } catch (IOException e1) {
            mResult.error(TAG, e1.getMessage(), "");
        }
    }

    @Override
    public void onCancel(Object arguments1) {
        EventHandler.getInstance().setEventSink(null);
    }

    @Override
    public void onListen(Object arguments1, EventChannel.EventSink events1) {
        EventHandler.getInstance().setEventSink(events1);
    }
}
