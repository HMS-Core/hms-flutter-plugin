/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.ml.imgseg;

import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.provider.MediaStore;
import android.util.Log;
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.ImagePathHelper;
import com.huawei.hmf.tasks.OnFailureListener;
import com.huawei.hmf.tasks.OnSuccessListener;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.mlsdk.MLAnalyzerFactory;
import com.huawei.hms.mlsdk.common.MLFrame;
import com.huawei.hms.mlsdk.imgseg.MLImageSegmentation;
import com.huawei.hms.mlsdk.imgseg.MLImageSegmentationAnalyzer;
import com.huawei.hms.mlsdk.imgseg.MLImageSegmentationSetting;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class ImageSegmentationMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = ImageSegmentationMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;
    private MLImageSegmentationAnalyzer imageSegmentationAnalyzer;
    private MLImageSegmentationSetting setting;

    public ImageSegmentationMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "getDefaultSegmentation":
                getDefaultSegmentation(call);
                break;
            case "getImageSegmentation":
                getSegmentation(call);
                break;
            case "getSparseImageSegmentation":
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

    private void getDefaultSegmentation(MethodCall call) {
        if (call.argument("path") == null) {
            mResult.error(TAG, "Image path must not be null!", "");
        } else {
            String imgPath = call.argument("path");
            imageSegmentationAnalyzer = MLAnalyzerFactory.getInstance().getImageSegmentationAnalyzer();
            final String encodedImg = ImagePathHelper.pathToBase64(imgPath);
            MLFrame frame = HmsMlUtils.getFrame(encodedImg);
            Task<MLImageSegmentation> task = imageSegmentationAnalyzer.asyncAnalyseFrame(frame);
            task.addOnSuccessListener(new OnSuccessListener<MLImageSegmentation>() {
                @Override
                public void onSuccess(MLImageSegmentation mlImageSegmentation) {
                    try {
                        mResult.success(getImageSegmentationResult(mlImageSegmentation).toString());
                    } catch (JSONException segError) {
                        mResult.error(TAG, segError.getMessage(), "");
                    }
                }
            }).addOnFailureListener(new OnFailureListener() {
                @Override
                public void onFailure(Exception segError) {
                    mResult.error(TAG, segError.getMessage(), "");
                }
            });
        }
    }

    private void getSegmentation(MethodCall call) {
        try {
            String segJsonString = null;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
                segJsonString = Objects.requireNonNull(call.argument("settings")).toString();
            }
            if (segJsonString == null) {
                mResult.error(TAG, "Arguments must not be null", "");
            } else {
                JSONObject segObject = new JSONObject(segJsonString);
                String imagePathInfo = segObject.getString("path");
                boolean exactMode = segObject.optBoolean("exactMode", true);
                int analyserType = segObject.optInt("analyzerType", 0);
                int scene = segObject.optInt("scene", 0);

                setting = new MLImageSegmentationSetting.Factory()
                        .setExact(exactMode)
                        .setAnalyzerType(analyserType)
                        .setScene(scene)
                        .create();

                imageSegmentationAnalyzer = MLAnalyzerFactory.getInstance().getImageSegmentationAnalyzer(setting);

                final String encoded = ImagePathHelper.pathToBase64(imagePathInfo);
                MLFrame frame = HmsMlUtils.getFrame(encoded);

                Task<MLImageSegmentation> task = imageSegmentationAnalyzer.asyncAnalyseFrame(frame);

                task.addOnSuccessListener(new OnSuccessListener<MLImageSegmentation>() {
                    @Override
                    public void onSuccess(MLImageSegmentation mlImageSegmentation) {
                        try {
                            mResult.success(getImageSegmentationResult(mlImageSegmentation).toString());
                        } catch (JSONException segException) {
                            mResult.error(TAG, segException.getMessage(), "");
                        }
                    }
                }).addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(Exception segException) {
                        mResult.error(TAG, segException.getMessage(), "");
                    }
                });
            }
        } catch (JSONException segException) {
            mResult.error(TAG, segException.getMessage(), "");
        }
    }

    private void getSparseSegmentation(MethodCall call) {
        try {
            String sparseSegJsonString = null;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
                sparseSegJsonString = Objects.requireNonNull(call.argument("settings")).toString();
            }
            if (sparseSegJsonString == null) {
                mResult.error(TAG, "Arguments must not be null", "");
            } else {
                JSONObject sparseSegObject = new JSONObject(sparseSegJsonString);
                String imagePath = sparseSegObject.getString("path");
                boolean exactMode = sparseSegObject.optBoolean("exactMode", true);
                int analyserType = sparseSegObject.optInt("analyzerType", 0);
                int scene = sparseSegObject.optInt("scene", 0);

                setting = new MLImageSegmentationSetting.Factory()
                        .setExact(exactMode)
                        .setAnalyzerType(analyserType)
                        .setScene(scene)
                        .create();

                imageSegmentationAnalyzer = MLAnalyzerFactory.getInstance().getImageSegmentationAnalyzer(setting);

                final String encodedImage = ImagePathHelper.pathToBase64(imagePath);
                MLFrame frame = HmsMlUtils.getFrame(encodedImage);
                SparseArray<MLImageSegmentation> sparseArray = imageSegmentationAnalyzer.analyseFrame(frame);
                if (sparseArray != null) {
                    mResult.success(getImageSegmentationSparseResult(sparseArray).toString());
                } else {
                    mResult.error(TAG, "Result is null", "");
                }
            }
        } catch (JSONException e) {
            mResult.error(TAG, e.getMessage(), "");
        }
    }

    private JSONObject getImageSegmentationResult
            (MLImageSegmentation imageSegmentationResult) throws JSONException {
        JSONObject jsonObject = new JSONObject();
        jsonObject.putOpt("bitmapForeground", getImagePathFromUri(
                activity.getApplicationContext(), imageSegmentationResult.getForeground()));
        jsonObject.putOpt("bitmapGrayscale", getImagePathFromUri(
                activity.getApplicationContext(), imageSegmentationResult.getGrayscale()));
        jsonObject.putOpt("bitmapOriginal", getImagePathFromUri(
                activity.getApplicationContext(), imageSegmentationResult.getOriginal()));
        return jsonObject;
    }

    private static String getImagePathFromUri(Context context, Bitmap image) {
        if (image != null) {
            ByteArrayOutputStream bytes = new ByteArrayOutputStream();
            image.compress(Bitmap.CompressFormat.JPEG, 100, bytes);
            return MediaStore.Images.Media.insertImage(context.getContentResolver(), image, "Title", "Desc");
        }
        return "No path";
    }

    private JSONObject getImageSegmentationSparseResult(SparseArray<MLImageSegmentation> array) {
        JSONObject object = new JSONObject();
        try {
            for (int i = 0; i < array.size(); i++) {
                int key = array.keyAt(i);
                MLImageSegmentation mlImageSegmentation = array.get(key);
                object.putOpt(String.valueOf(key), getImageSegmentationResult(mlImageSegmentation));
            }
        } catch (JSONException e) {
            Log.i(TAG, Objects.requireNonNull(e.getMessage()));
        }
        return object;
    }

    private void stopSegmentation() {
        if (imageSegmentationAnalyzer == null) {
            mResult.success("Image Segmentation Analyser is already closed");
        } else {
            try {
                imageSegmentationAnalyzer.stop();
                imageSegmentationAnalyzer = null;
                mResult.success("Image Segmentation Analyser is closed ");
            } catch (IOException e) {
                mResult.error(TAG, e.getMessage(), "");
            }
        }
    }
}