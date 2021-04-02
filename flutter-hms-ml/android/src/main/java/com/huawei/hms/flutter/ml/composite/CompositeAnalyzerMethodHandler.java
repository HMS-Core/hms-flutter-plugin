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

package com.huawei.hms.flutter.ml.composite;

import android.app.Activity;
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.FrameHolder;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.flutter.ml.utils.SettingUtils;
import com.huawei.hms.mlsdk.common.MLCompositeAnalyzer;
import com.huawei.hms.mlsdk.common.MLFrame;

import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class CompositeAnalyzerMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = CompositeAnalyzerMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;

    private MLCompositeAnalyzer compositeAnalyzer;

    public CompositeAnalyzerMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "analyzeFrame":
                analyzeFrame(call);
                break;
            case "isAvailable":
                isAnalyzerAvailable();
                break;
            case "destroy":
                destroyAnalyzer();
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    private void analyzeFrame(@NonNull MethodCall call) {
        String path = call.argument("path");
        List<String> analyzers = call.argument("list");

        if (path == null || path.isEmpty() || analyzers == null) {
            mResult.error(TAG, "Illegal parameters", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        compositeAnalyzer = SettingUtils.createCompositeCreator(analyzers).create();
        MLFrame frame = SettingUtils.createMLFrame(activity, "fromBitmap", path, call);
        FrameHolder.getInstance().setFrame(frame);

        SparseArray<Object> sparseArray = compositeAnalyzer.analyseFrame(frame);
        List<Object> list = new ArrayList<>(sparseArray.size());
        for (int i = 0; i < sparseArray.size(); i++) {
            list.add(sparseArray.get(i));
        }
        HmsMlUtils.sendSuccessResult(activity, "syncCompositeAnalyze", mResult, list);
    }

    private void isAnalyzerAvailable() {
        if (compositeAnalyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("isCompositeAnalyzerAvailable", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyzer is not initialized!", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("isCompositeAnalyzerAvailable");
        mResult.success(compositeAnalyzer.isAvailable());
    }

    private void destroyAnalyzer() {
        if (compositeAnalyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("destroyCompositeAnalyzer", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyzer is not initialized!", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }
        compositeAnalyzer.destroy();
        compositeAnalyzer = null;
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("destroyCompositeAnalyzer");
        mResult.success(true);
    }
}
