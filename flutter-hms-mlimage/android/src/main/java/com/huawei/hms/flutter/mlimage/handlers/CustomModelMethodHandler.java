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
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mlimage.constant.Method;
import com.huawei.hms.flutter.mlimage.constant.Param;
import com.huawei.hms.flutter.mlimage.utils.Commons;
import com.huawei.hms.flutter.mlimage.utils.FromMap;
import com.huawei.hms.flutter.mlimage.utils.MLResponseHandler;
import com.huawei.hms.mlsdk.common.MLException;
import com.huawei.hms.mlsdk.custom.MLCustomLocalModel;
import com.huawei.hms.mlsdk.custom.MLCustomRemoteModel;
import com.huawei.hms.mlsdk.custom.MLModelDataType;
import com.huawei.hms.mlsdk.custom.MLModelExecutor;
import com.huawei.hms.mlsdk.custom.MLModelExecutorSettings;
import com.huawei.hms.mlsdk.custom.MLModelInputOutputSettings;
import com.huawei.hms.mlsdk.custom.MLModelInputs;
import com.huawei.hms.mlsdk.model.download.MLLocalModelManager;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class CustomModelMethodHandler implements MethodChannel.MethodCallHandler {
    private static final String TAG = CustomModelMethodHandler.class.getSimpleName();

    private final Activity activity;
    private final MLResponseHandler responseHandler;
    private final ArrayList<String> mLabels;

    private MLModelExecutor modelExecutor;
    private Bitmap mBitmap;

    public CustomModelMethodHandler(Activity activity) {
        this.activity = activity;
        this.mLabels = new ArrayList<>();
        this.responseHandler = MLResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        responseHandler.setup(TAG, call.method, result);
        switch (call.method) {
            case Method.CREATE_BITMAP:
                createBitmap(call);
                break;
            case Method.DOWNLOAD_REMOTE_MODEL:
                downloadModel(call);
                break;
            case Method.PREPARE_EXECUTOR:
                prepareExecutor(call);
                break;
            case Method.START_EXECUTOR:
                startExecutor(call);
                break;
            case Method.GET_OUTPUT_INDEX:
                getOutputIndex(call);
                break;
            case Method.STOP_EXECUTOR:
                stopExecutor();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void stopExecutor() {
        if (modelExecutor == null) {
            responseHandler.noService();
            return;
        }

        try {
            modelExecutor.close();
            responseHandler.success(true);
        } catch (IOException e) {
            responseHandler.exception(e);
        }
    }

    private void getOutputIndex(MethodCall call) {
        String name = FromMap.toString("name", call.argument("name"), false);

        if (name == null || name.isEmpty()) {
            responseHandler.exception(new Exception("Channel name must not be null or empty"));
            return;
        }

        if (modelExecutor == null) {
            responseHandler.noService();
            return;
        }

        modelExecutor.getOutputIndex(name)
                .addOnSuccessListener(responseHandler::success)
                .addOnFailureListener(responseHandler::exception);
    }

    private void createBitmap(MethodCall call) {
        String path = FromMap.toString(Param.PATH, call.argument(Param.PATH), false);

        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inSampleSize = 16;
        mBitmap = BitmapFactory.decodeFile(path, options);
        responseHandler.success(true);
    }

    private void downloadModel(MethodCall call) {
        String modelName = FromMap.toString(Param.MODEL_NAME, call.argument(Param.MODEL_NAME), false);

        MLCustomRemoteModel remoteModel = new MLCustomRemoteModel.Factory(modelName).create();

        MLLocalModelManager.getInstance().downloadModel(remoteModel)
                .addOnSuccessListener(aVoid -> responseHandler.success(true))
                .addOnFailureListener(responseHandler::exception);
    }

    private void prepareExecutor(MethodCall call) {
        String modelName = FromMap.toString(Param.MODEL_NAME, call.argument(Param.MODEL_NAME), false);
        String assetPath = FromMap.toString(Param.ASSET_PATH, call.argument(Param.ASSET_PATH), false);

        MLCustomLocalModel localModel = new MLCustomLocalModel.Factory(modelName).setAssetPathFile(assetPath).create();
        MLCustomRemoteModel remoteModel = new MLCustomRemoteModel.Factory(modelName).create();

        MLLocalModelManager.getInstance().isModelExist(remoteModel)
                .addOnSuccessListener(isDownloaded -> {
                    MLModelExecutorSettings settings;
                    if (isDownloaded) {
                        Log.i(TAG, "Executor created with remote model");
                        settings = new MLModelExecutorSettings.Factory(remoteModel).create();
                    } else {
                        Log.i(TAG, "Executor created with local model");
                        settings = new MLModelExecutorSettings.Factory(localModel).create();
                    }
                    try {
                        modelExecutor = MLModelExecutor.getInstance(settings);
                        responseHandler.success(true);
                    } catch (MLException e) {
                        responseHandler.exception(e);
                    }
                }).addOnFailureListener(responseHandler::exception);
    }

    private void startExecutor(MethodCall call) {
        if (modelExecutor == null) {
            responseHandler.noService();
            return;
        }

        // Label file name
        String labelFileName = FromMap.toString(Param.LABEL_FILE_NAME, call.argument(Param.LABEL_FILE_NAME), false);
        readLabels(labelFileName);

        // Input output settings map
        Map<String, Object> settingsMap = FromMap.fromObject(call.argument(Param.SETTINGS));

        // Model data type
        Integer modelDataType = FromMap.toInteger(Param.TYPE, settingsMap.get(Param.TYPE));

        // Input array creation
        List<Integer> inputArgs = FromMap.toTypeOfArrayList(settingsMap.get(Param.INPUTS), Integer.class);
        int[] inputsArray = Commons.convertIntegers(inputArgs);
        int[] inputs = new int[inputsArray.length];

        for (int i = 0; i < inputs.length; i++) {
            inputs[i] = (int) inputsArray[i];
        }

        // Output array creation
        List<Integer> outputArgs = FromMap.toTypeOfArrayList(settingsMap.get(Param.OUTPUTS), Integer.class);
        int[] outputsArray = Commons.convertIntegers(outputArgs);
        int[] outputs = new int[outputsArray.length];

        for (int i = 0; i < outputs.length; i++) {
            outputs[i] = (int) outputsArray[i];
        }

        if (modelDataType == null) {
            responseHandler.exception(new Exception("model data type must not be null"));
            return;
        }

        exec(inputs, outputs);
    }

    private void exec(int[] inputs, int[] outputs) {
        int first = inputs[0];
        int width = inputs[1];
        int height = inputs[2];
        int channelSize = inputs[3];

        final Bitmap inputBitmap = Bitmap.createScaledBitmap(mBitmap, width, height, true);
        final byte[][][][] input = new byte[first][height][width][channelSize];

        for (int i = 0; i < width; i++) {
            for (int j = 0; j < height; j++) {
                int pixel = inputBitmap.getPixel(i, j);
                input[0][j][i][0] = (byte) Color.red(pixel);
                input[0][j][i][1] = (byte) Color.green(pixel);
                input[0][j][i][2] = (byte) Color.blue(pixel);
            }
        }

        MLModelInputs inputs2 = null;
        try {
            inputs2 = new MLModelInputs.Factory().add(input).create();
        } catch (MLException e) {
            responseHandler.exception(e);
        }

        MLModelInputOutputSettings inOutSettings = null;
        try {
            inOutSettings = new MLModelInputOutputSettings.Factory()
                    .setInputFormat(0, MLModelDataType.BYTE, inputs)
                    .setOutputFormat(0, MLModelDataType.BYTE, outputs)
                    .create();
        } catch (MLException e) {
            responseHandler.exception(e);
        }

        modelExecutor.exec(inputs2, inOutSettings)
                .addOnSuccessListener(mlModelOutputs -> {
                    byte[][] output = mlModelOutputs.getOutput(0); // index
                    byte[] probabilities = output[0];
                    float[] pro = new float[probabilities.length];
                    for (int i = 0; i < pro.length; i++) {
                        pro[i] = probabilities[i] / 255f;
                    }
                    prepareResult(pro, outputs[1]);
                }).addOnFailureListener(responseHandler::exception);
    }

    private void readLabels(String assetFileName) {
        InputStream is = null;
        BufferedReader br = null;

        try {
            is = activity.getAssets().open(assetFileName);
            br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8));
            String readString;
            while ((readString = br.readLine()) != null) {
                mLabels.add(readString);
            }
            br.close();
        } catch (IOException error) {
            responseHandler.exception(error);
        } finally {
            if (is != null) {
                try {
                    is.close();
                } catch (IOException e) {
                    responseHandler.exception(e);
                }
            }
            if (br != null) {
                try {
                    br.close();
                } catch (IOException e) {
                    responseHandler.exception(e);
                }
            }
        }
    }

    private void prepareResult(float[] probabilities, int outputSize) {
        Map<String, Float> localResult = new HashMap<>();

        for (int i = 0; i < outputSize; i++) {
            localResult.put(mLabels.get(i), probabilities[i]);
        }

        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.N) {
            Map<String, Float> filteredMap = localResult
                    .entrySet()
                    .stream()
                    .filter(x -> x.getValue() != 0)
                    .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));

            for (Map.Entry<String, Float> entry : filteredMap.entrySet()) {
                if (entry.getValue() < 0) {
                    entry.setValue(-1 * entry.getValue());
                }
            }
            responseHandler.success((filteredMap));
        }
    }
}
