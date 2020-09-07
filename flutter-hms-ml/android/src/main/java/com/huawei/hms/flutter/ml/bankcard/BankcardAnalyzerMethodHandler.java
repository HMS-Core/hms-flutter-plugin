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

package com.huawei.hms.flutter.ml.bankcard;

import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.provider.MediaStore;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.ImagePathHelper;
import com.huawei.hmf.tasks.OnFailureListener;
import com.huawei.hmf.tasks.OnSuccessListener;
import com.huawei.hmf.tasks.Task;
import com.huawei.hms.mlplugin.card.bcr.MLBcrCapture;
import com.huawei.hms.mlplugin.card.bcr.MLBcrCaptureConfig;
import com.huawei.hms.mlplugin.card.bcr.MLBcrCaptureFactory;
import com.huawei.hms.mlplugin.card.bcr.MLBcrCaptureResult;
import com.huawei.hms.mlsdk.card.MLBcrAnalyzerFactory;
import com.huawei.hms.mlsdk.card.bcr.MLBankCard;
import com.huawei.hms.mlsdk.card.bcr.MLBcrAnalyzer;
import com.huawei.hms.mlsdk.card.bcr.MLBcrAnalyzerSetting;
import com.huawei.hms.mlsdk.common.MLFrame;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class BankcardAnalyzerMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = BankcardAnalyzerMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;
    private MLBcrAnalyzer sdkAnalyzer;
    private MLBcrAnalyzerSetting mlBcrAnalyzerSetting;

    public BankcardAnalyzerMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "analyzeBankcard":
                analyzeBankcard(call);
                break;
            case "startCaptureActivity":
                startCaptureActivity(call, this.callback);
                break;
            case "stopAnalyzer":
                stopAnalyzer();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void analyzeBankcard(MethodCall call) {
        try {
            String bcrJsonString = null;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
                bcrJsonString = Objects.requireNonNull(call.argument("settings")).toString();
            }
            if (bcrJsonString == null) {
                mResult.error(TAG, "Arguments must not be null", "");
            } else {
                JSONObject bcrObject = new JSONObject(bcrJsonString);
                String imagePath = bcrObject.getString("path");

                bcrObject.getString("langType");
                mlBcrAnalyzerSetting = new MLBcrAnalyzerSetting.Factory()
                        .setLangType(bcrObject.getString("langType"))
                        .create();

                final String encodedImage = ImagePathHelper.pathToBase64(imagePath);
                MLFrame frame = HmsMlUtils.getFrame(encodedImage);

                sdkAnalyzer = MLBcrAnalyzerFactory.getInstance().getBcrAnalyzer(mlBcrAnalyzerSetting);
                Task<MLBankCard> task = sdkAnalyzer.asyncAnalyseFrame(frame);

                task.addOnSuccessListener(new OnSuccessListener<MLBankCard>() {
                    @Override
                    public void onSuccess(MLBankCard mlBankCard) {
                        try {
                            mResult.success(onAnalyzeSuccess(mlBankCard).toString());
                        } catch (JSONException bcrException) {
                            mResult.error(TAG, bcrException.getMessage(), "");
                        }
                    }
                }).addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(Exception bcrException) {
                        mResult.error(TAG, bcrException.getMessage(), "");
                    }
                });
            }
        } catch (JSONException bcrException) {
            mResult.error(TAG, bcrException.getMessage(), "");
        }
    }

    private void startCaptureActivity(MethodCall call, MLBcrCapture.Callback Callback) {
        try {
            String jsonString = null;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
                jsonString = Objects.requireNonNull(call.argument("settings")).toString();
            }
            if (jsonString == null) {
                mResult.error(TAG, "Arguments must not be null", "");
            } else {
                JSONObject object = new JSONObject(jsonString);
                int orientation = object.getInt("orientation");

                MLBcrCaptureConfig config = new MLBcrCaptureConfig.Factory()
                        .setOrientation(orientation)
                        .create();

                MLBcrCapture bcrCapture = MLBcrCaptureFactory.getInstance().getBcrCapture(config);
                bcrCapture.captureFrame(activity, Callback);
            }
        } catch (JSONException e) {
            mResult.error(TAG, e.getMessage(), "");
        }
    }

    private MLBcrCapture.Callback callback = new MLBcrCapture.Callback() {
        @Override
        public void onSuccess(MLBcrCaptureResult mlBcrCaptureResult) {
            if (mlBcrCaptureResult == null) {
                Log.i(TAG, "Result is null");
            } else {
                captureResult(mlBcrCaptureResult);
            }
        }

        @Override
        public void onCanceled() {
            mResult.error(TAG, "Capture canceled", "");
        }

        @Override
        public void onFailure(int i, Bitmap bitmap) {
            mResult.error(TAG, String.valueOf(i), "");
        }

        @Override
        public void onDenied() {
            mResult.error(TAG, "Capture denied", "");
        }
    };

    private JSONObject onAnalyzeSuccess(MLBankCard bankCard) throws JSONException {
        JSONObject object = new JSONObject();
        object.putOpt("expire", bankCard.getExpire());
        object.putOpt("number", bankCard.getNumber());
        object.putOpt("retCode", bankCard.getRetCode());
        object.putOpt("tipsCode", bankCard.getTipsCode());
        object.putOpt("type", bankCard.getType());
        if (bankCard.getOriginalBitmap() != null) {
            object.putOpt("originalBitmap",
                    getImagePathFromUri(
                            activity.getApplicationContext(),
                            bankCard.getOriginalBitmap()));
        }
        if (bankCard.getNumberBitmap() != null) {
            object.putOpt("numberBitmap",
                    getImagePathFromUri(
                            activity.getApplicationContext(),
                            bankCard.getNumberBitmap()));
        }
        return object;
    }

    private static String getImagePathFromUri(Context inContext, Bitmap inImage) {
        if (inImage != null) {
            ByteArrayOutputStream bytes = new ByteArrayOutputStream();
            inImage.compress(Bitmap.CompressFormat.JPEG, 100, bytes);
            return MediaStore.Images.Media.insertImage(inContext.getContentResolver(), inImage, "Title", "Desc");
        }
        return "No path";
    }

    private void captureResult(MLBcrCaptureResult bankCardResult) {
        JSONObject object = new JSONObject();
        try {
            object.putOpt("number", bankCardResult.getNumber());
            object.putOpt("expire", bankCardResult.getExpire());
            object.putOpt("type", bankCardResult.getType());
            object.putOpt("issuer", bankCardResult.getIssuer());
            if (bankCardResult.getOriginalBitmap() != null) {
                object.putOpt("originalBitmap",
                        getImagePathFromUri(
                                activity.getApplicationContext(),
                                bankCardResult.getOriginalBitmap()));
            }
            if (bankCardResult.getNumberBitmap() != null) {
                object.putOpt("numberBitmap",
                        getImagePathFromUri(
                                activity.getApplicationContext(),
                                bankCardResult.getNumberBitmap()));
            }
            mResult.success(object.toString());
        } catch (JSONException e) {
            mResult.error(TAG, e.getMessage(), "");
        }
    }

    private void stopAnalyzer() {
        if (sdkAnalyzer == null)
            mResult.error(TAG, "Analyser is not initialized.", "");
        else {
            sdkAnalyzer.stop();
            sdkAnalyzer = null;
            String success = "Analyzer is stopped";
            mResult.success(success);
        }
    }
}