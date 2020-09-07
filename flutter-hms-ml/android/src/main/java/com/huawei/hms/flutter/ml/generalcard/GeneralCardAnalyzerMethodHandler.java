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

package com.huawei.hms.flutter.ml.generalcard;

import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.provider.MediaStore;
import android.util.Base64;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ml.utils.ImagePathHelper;
import com.huawei.hms.mlplugin.card.gcr.MLGcrCapture;
import com.huawei.hms.mlplugin.card.gcr.MLGcrCaptureConfig;
import com.huawei.hms.mlplugin.card.gcr.MLGcrCaptureFactory;
import com.huawei.hms.mlplugin.card.gcr.MLGcrCaptureResult;
import com.huawei.hms.mlplugin.card.gcr.MLGcrCaptureUIConfig;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class GeneralCardAnalyzerMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = GeneralCardAnalyzerMethodHandler.class.getSimpleName();

    private Activity activity;
    private MethodChannel.Result mResult;

    private String language;
    private int orientation;
    private int scanBoxCornerColor;
    private String tipText;
    private int tipTextColor;
    private int photoButtonResId;

    public GeneralCardAnalyzerMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "startCaptureActivity":
                startCapturing(call);
                break;
            case "startPictureTakingActivity":
                startTakingPicture(call);
                break;
            case "localImage":
                localImage(call);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void localImage(MethodCall call) {
        try {
            String localImageJsonString = null;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
                localImageJsonString = Objects.requireNonNull(call.argument("settings")).toString();
            }
            if (localImageJsonString == null) {
                mResult.error(TAG, "Arguments must not be null", "");
            } else {
                JSONObject localImageObject = new JSONObject(localImageJsonString);
                String path = localImageObject.getString("path");
                JSONObject captureConfig = localImageObject.optJSONObject("captureConfig");

                if (captureConfig == null) {
                    language = null;
                } else {
                    language = captureConfig.optString("language", "zh");
                }

                final String encodedImage = ImagePathHelper.pathToBase64(path);
                byte[] decodedString = Base64.decode(encodedImage, Base64.DEFAULT);
                Bitmap bitmap = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
                MLGcrCaptureConfig config = new MLGcrCaptureConfig.Factory().setLanguage(language).create();
                MLGcrCapture ocrManager = MLGcrCaptureFactory.getInstance().getGcrCapture(config);
                ocrManager.captureImage(bitmap, null, callback);
            }
        } catch (JSONException e) {
            mResult.error(TAG, e.getMessage(), "");
        }
    }

    private void getJsonObject(String source) throws JSONException {
        JSONObject settings = new JSONObject(source);

        JSONObject captureConfig = settings.optJSONObject("captureConfig");
        if (captureConfig == null) {
            language = null;
        } else {
            language = captureConfig.getString("language");
        }

        JSONObject captureUiConfig = settings.optJSONObject("captureUiConfig");
        if (captureUiConfig == null) {
            orientation = 0;
            tipText = "Recognizing..";
            photoButtonResId = 2131165293;
            tipTextColor = Color.BLUE;
            scanBoxCornerColor = Color.BLUE;
        } else {
            orientation = captureUiConfig.getInt("orientation");
            tipText = captureUiConfig.getString("tipText");
            photoButtonResId = captureUiConfig.getInt("photoButtonResId");
            tipTextColor = captureUiConfig.getInt("tipTextColor");
            scanBoxCornerColor = captureUiConfig.getInt("scanBoxCornerColor");
        }
    }

    private void startTakingPicture(MethodCall call) {
        try {
            String jsonString = null;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
                jsonString = Objects.requireNonNull(call.argument("settings")).toString();
            }
            getJsonObject(jsonString);
            startTakingPictureActivity(callback);
        } catch (JSONException e) {
            mResult.error(TAG, e.getMessage(), "");
        }
    }

    private void startCapturing(MethodCall call) {
        try {
            String jsonString = null;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
                jsonString = Objects.requireNonNull(call.argument("settings")).toString();
            }
            getJsonObject(jsonString);
            startCaptureActivity(callback);

        } catch (JSONException e) {
            mResult.error(TAG, e.getMessage(), "");
        }
    }

    private void startCaptureActivity(MLGcrCapture.Callback callBack) {
        MLGcrCaptureConfig cardConfig = new MLGcrCaptureConfig.Factory().setLanguage(language).create();
        MLGcrCaptureUIConfig uiConfig = new MLGcrCaptureUIConfig.Factory()
                .setTipText(tipText)
                .setTipTextColor(tipTextColor)
                .setOrientation(orientation)
                .setScanBoxCornerColor(scanBoxCornerColor)
                .setPhotoButtonResId(photoButtonResId)
                .create();
        MLGcrCapture ocrManager = MLGcrCaptureFactory.getInstance().getGcrCapture(cardConfig, uiConfig);
        ocrManager.capturePreview(activity, null, callBack);
    }

    private void startTakingPictureActivity(MLGcrCapture.Callback callBack) {
        MLGcrCaptureConfig cardConfig = new MLGcrCaptureConfig.Factory().setLanguage(language).create();
        MLGcrCaptureUIConfig uiConfig = new MLGcrCaptureUIConfig.Factory()
                .setTipText(tipText)
                .setTipTextColor(tipTextColor)
                .setOrientation(orientation)
                .setScanBoxCornerColor(scanBoxCornerColor)
                .setPhotoButtonResId(photoButtonResId)
                .create();
        MLGcrCapture ocrManager = MLGcrCaptureFactory.getInstance().getGcrCapture(cardConfig, uiConfig);
        ocrManager.capturePhoto(activity, null, callBack);
    }

    private MLGcrCapture.Callback callback = new MLGcrCapture.Callback() {
        @Override
        public int onResult(MLGcrCaptureResult mlGcrCaptureResult, Object o) {
            if (mlGcrCaptureResult == null) {
                return MLGcrCaptureResult.CAPTURE_CONTINUE;
            }
            try {
                onAnalyzeSuccess(mlGcrCaptureResult);
            } catch (JSONException e) {
                mResult.error(TAG, e.getMessage(), "");
            }
            return MLGcrCaptureResult.CAPTURE_STOP;
        }

        @Override
        public void onCanceled() {
            mResult.error(TAG, "Callback canceled", "");
        }

        @Override
        public void onFailure(int i, Bitmap bitmap) {
            mResult.error(TAG, String.valueOf(i), "");
        }

        @Override
        public void onDenied() {
            mResult.error(TAG, "Callback denied", "");
        }
    };

    private void onAnalyzeSuccess(MLGcrCaptureResult cardResult) throws JSONException {
        JSONObject object = new JSONObject();
        object.putOpt("text", cardResult.text.getStringValue());
        if (cardResult.cardBitmap != null) {
            object.putOpt("cardBitmap",
                    getImagePathFromUri(activity.getApplicationContext(), cardResult.cardBitmap));
        }
        mResult.success(object.toString());
    }

    private static String getImagePathFromUri(Context inContext, Bitmap inImage) {
        if (inImage != null) {
            ByteArrayOutputStream bytes = new ByteArrayOutputStream();
            inImage.compress(Bitmap.CompressFormat.JPEG, 100, bytes);
            return MediaStore.Images.Media.insertImage(inContext.getContentResolver(), inImage, "Title", "Desc");
        }
        return "No path";
    }
}