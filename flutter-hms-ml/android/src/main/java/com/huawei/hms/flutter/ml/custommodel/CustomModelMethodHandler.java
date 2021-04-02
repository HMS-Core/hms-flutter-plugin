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

package com.huawei.hms.flutter.ml.custommodel;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.mlsdk.common.MLException;
import com.huawei.hms.mlsdk.custom.MLCustomLocalModel;
import com.huawei.hms.mlsdk.custom.MLCustomRemoteModel;
import com.huawei.hms.mlsdk.custom.MLModelDataType;
import com.huawei.hms.mlsdk.custom.MLModelExecutor;
import com.huawei.hms.mlsdk.custom.MLModelExecutorSettings;
import com.huawei.hms.mlsdk.custom.MLModelInputOutputSettings;
import com.huawei.hms.mlsdk.custom.MLModelInputs;
import com.huawei.hms.mlsdk.model.download.MLLocalModelManager;
import com.huawei.hms.mlsdk.model.download.MLModelDownloadListener;
import com.huawei.hms.mlsdk.model.download.MLModelDownloadStrategy;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class CustomModelMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = CustomModelMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;
    private MLModelExecutor modelExecutor;
    private MLModelDownloadStrategy strategy;
    private MLCustomLocalModel localModel;

    private ArrayList<String> mLabels = new ArrayList<>();

    private String imagePath;
    private String labelFileName;
    private Integer bitmapSize;
    private Integer channelSize;
    private Integer outputLength;
    private Integer region;
    private Integer modelDataType;
    private Boolean wifiNeeded;
    private Boolean deviceIdleNeeded;
    private Boolean chargingNeeded;

    public CustomModelMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "loadCustomModel":
                loadModel(call);
                break;
            case "startModelExecutor":
                executeModel();
                break;
            case "stopModelExecutor":
                stopModelExecutor();
                break;
            case "getOutputIndex":
                getOPIndex(call);
                break;
            default:
                mResult.notImplemented();
                break;
        }
    }

    private void getOPIndex(MethodCall call) {
        String name = call.argument("name");
        if (modelExecutor == null || name == null || name.isEmpty()) {
            mResult.error(TAG, "Null Object", MlConstants.NULL_OBJECT);
            return;
        }
        modelExecutor.getOutputIndex(name).addOnSuccessListener(integer -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getOutputIndex");
            mResult.success(integer);
        }).addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "getOutputIndex", mResult));
    }

    private void loadModel(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("loadCustomModel");
        imagePath = call.argument("imagePath");
        String modelName = call.argument("modelName");
        modelDataType = call.argument("modelDataType");
        String assetPathFile = call.argument("assetPathFile");
        String localFullPathFile = call.argument("localFullPathFile");
        Boolean isFromAsset = call.argument("isFromAsset");
        labelFileName = call.argument("labelFileName");
        bitmapSize = call.argument("bitmapSize");
        channelSize = call.argument("channelSize");
        outputLength = call.argument("outputLength");
        region = call.argument("region");
        wifiNeeded = call.argument("wifiNeeded");
        chargingNeeded = call.argument("chargingNeeded");
        deviceIdleNeeded = call.argument("deviceIdleNeeded");

        createDownloadStrategy();
        downloadModel(modelName);

        if (isFromAsset != null && isFromAsset) {
            localModel = new MLCustomLocalModel.Factory(modelName).setAssetPathFile(assetPathFile).create();
        } else {
            localModel = new MLCustomLocalModel.Factory(modelName).setLocalFullPathFile(localFullPathFile).create();
        }

        MLCustomRemoteModel remoteModel = new MLCustomRemoteModel.Factory(modelName).create();
        MLLocalModelManager.getInstance().isModelExist(remoteModel).addOnSuccessListener(isDownloaded -> {
            if (isDownloaded) {
                final MLModelExecutorSettings settings = new MLModelExecutorSettings.Factory(remoteModel).create();
                setExecutor(settings);
            } else {
                final MLModelExecutorSettings settings = new MLModelExecutorSettings.Factory(localModel).create();
                setExecutor(settings);
            }
        }).addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "loadCustomModel", mResult));
    }

    private void setExecutor(MLModelExecutorSettings settings) {
        try {
            modelExecutor = MLModelExecutor.getInstance(settings);
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("loadCustomModel");
            mResult.success(true);
        } catch (MLException e) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("loadCustomModel", String.valueOf(e.getErrCode()));
            mResult.error(TAG, e.getMessage(), String.valueOf(e.getErrCode()));
        }
    }

    private void createDownloadStrategy() {
        MLModelDownloadStrategy.Factory factory = new MLModelDownloadStrategy.Factory();
        if (wifiNeeded) factory.needWifi();
        if (chargingNeeded) factory.needCharging();
        if (deviceIdleNeeded) factory.needDeviceIdle();
        factory.setRegion(region == null ? 1002 : region);
        strategy = factory.create();
    }

    private void downloadModel(String name) {
        final MLCustomRemoteModel customRemoteModel = new MLCustomRemoteModel.Factory(name).create();
        final MLModelDownloadListener modelDownloadListener =
                (alreadyDownLength, totalLength) -> Log.i(TAG.concat(" Download Listener"), String.valueOf(alreadyDownLength));
        MLLocalModelManager.getInstance().downloadModel(customRemoteModel, strategy, modelDownloadListener);
    }

    private void executeModel() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("startModelExecutor");
        if (modelExecutor == null || imagePath == null || imagePath.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("startModelExecutor", "Error");
            mResult.error(TAG, "Executor or image path is missing", "");
            return;
        }
        try {
            final Bitmap srcBitmap = BitmapFactory.decodeFile(imagePath);
            final Bitmap inputBitmap = Bitmap.createScaledBitmap(srcBitmap, bitmapSize, bitmapSize, true);

            final float[][][][] input = new float[1][channelSize][bitmapSize][bitmapSize];

            for (int i = 0; i < bitmapSize; i++) {
                for (int j = 0; j < bitmapSize; j++) {
                    int pixel = inputBitmap.getPixel(i, j);
                    input[0][0][j][i] = Color.red(pixel);
                    input[0][1][j][i] = Color.green(pixel);
                    input[0][2][j][i] = Color.blue(pixel);
                }
            }

            MLModelInputs inputs = new MLModelInputs.Factory().add(input).create();

            MLModelInputOutputSettings inputOutputSettings = new MLModelInputOutputSettings.Factory()
                    .setInputFormat(0, modelDataType != null ? modelDataType : MLModelDataType.FLOAT32, new int[]{1, channelSize, bitmapSize, bitmapSize})
                    .setOutputFormat(0, modelDataType != null ? modelDataType : MLModelDataType.FLOAT32, new int[]{1, outputLength})
                    .create();

            modelExecutor.exec(inputs, inputOutputSettings).addOnSuccessListener(mlModelOutputs -> {
                float[][] output = mlModelOutputs.getOutput(0);
                float[] probabilities = output[0];
                prepareResult(probabilities);
            }).addOnFailureListener(e -> {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("startModelExecutor", e.getMessage());
                mResult.error(TAG, e.getMessage(), "");
            });
        } catch (MLException e) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("startModelExecutor", String.valueOf(e.getErrCode()));
            mResult.error(TAG, e.getMessage(), "");
        }
    }

    private void stopModelExecutor() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("stopModelExecutor");
        if (modelExecutor == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopModelExecutor", "Error");
            mResult.error(TAG, "Executor is not initialized", "");
            return;
        }
        try {
            modelExecutor.close();
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopModelExecutor");
            mResult.success(true);
        } catch (IOException e) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("stopModelExecutor", e.getMessage());
            mResult.error(TAG, e.getMessage(), "");
        }
    }

    private BufferedReader prepareResult(float[] probabilities) {
        InputStream is = null;
        BufferedReader br = null;
        try {
            is = activity.getAssets().open(labelFileName);
            br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8));
            String readString;
            while ((readString = br.readLine()) != null) {
                mLabels.add(readString);
            }
            br.close();
            Map<String, Float> localResult = new HashMap<>();
            for (int i = 0; i < outputLength; i++) {
                localResult.put(mLabels.get(i), probabilities[i]);
            }
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("startModelExecutor");
            mResult.success(localResult);
        } catch (IOException error) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("startModelExecutor", error.getMessage());
            mResult.error(TAG, error.getMessage(), "");
        } finally {
            if (is != null) {
                try {
                    is.close();
                } catch (IOException error) {
                    HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("startModelExecutor", error.getMessage());
                    mResult.error(TAG, error.getMessage(), "");
                }
            }
        }
        return br;
    }
}
