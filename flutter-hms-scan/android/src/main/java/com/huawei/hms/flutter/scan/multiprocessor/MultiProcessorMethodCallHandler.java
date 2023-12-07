/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.scan.multiprocessor;

import static android.app.Activity.RESULT_OK;
import static com.huawei.hms.flutter.scan.utils.ValueGetter.analyzerDestroyWithLogger;
import static com.huawei.hms.flutter.scan.utils.ValueGetter.analyzerIsAvailableWithLogger;

import android.app.Activity;
import android.content.Intent;
import android.os.Parcelable;
import android.text.TextUtils;
import android.util.Log;
import android.util.SparseArray;

import androidx.annotation.NonNull;

import com.huawei.hmf.tasks.OnFailureListener;
import com.huawei.hmf.tasks.OnSuccessListener;
import com.huawei.hms.flutter.scan.ScanPlugin;
import com.huawei.hms.flutter.scan.logger.HMSLogger;
import com.huawei.hms.flutter.scan.utils.Constants;
import com.huawei.hms.flutter.scan.utils.Errors;
import com.huawei.hms.flutter.scan.utils.ValueGetter;
import com.huawei.hms.hmsscankit.ScanUtil;
import com.huawei.hms.ml.scan.HmsScan;
import com.huawei.hms.ml.scan.HmsScanAnalyzer;
import com.huawei.hms.mlsdk.common.MLFrame;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

import java.util.List;

public class MultiProcessorMethodCallHandler
        implements MethodChannel.MethodCallHandler, PluginRegistry.ActivityResultListener {

    static final int MULTIPROCESSOR_SYNC_CODE = 444;

    static final int MULTIPROCESSOR_ASYNC_CODE = 555;

    private static final int REQUEST_CODE_SCAN_MULTI = 15;

    private final HMSLogger mHMSLogger;

    private int channelId;

    private Activity mActivity;

    private MethodChannel.Result pendingResult;

    private Gson gson;

    public MultiProcessorMethodCallHandler(final Activity activity, final MethodChannel channel) {
        channelId = hashCode();
        ScanPlugin.SCAN_CHANNELS.put(channelId, channel);
        mActivity = activity;
        gson = new GsonBuilder().setPrettyPrinting().create();
        mHMSLogger = HMSLogger.getInstance(mActivity.getApplicationContext());
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        pendingResult = result;
        switch (call.method) {
            case "decodeMultiSync":
                decodeMultiSync(call, result);
                break;
            case "decodeMultiAsync":
                decodeMultiAsync(call, result);
                break;
            case "multiProcessorCamera":
                multiProcessorCamera(call, result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void multiProcessorCamera(MethodCall call, MethodChannel.Result result) {
        // Arguments from call
        int scanMode = ValueGetter.getInt("scanMode", call);
        int scanType = ValueGetter.getInt("scanType", call);
        List<Integer> additionalScanTypes = call.argument("additionalScanTypes");
        int[] scanTypesIntArray = null;

        // List<Integer> to int[]
        if (additionalScanTypes != null) {
            scanTypesIntArray = new int[additionalScanTypes.size()];
            for (int i = 0; i < additionalScanTypes.size(); i++) {
                scanTypesIntArray[i] = additionalScanTypes.get(i);
            }
        }

        // Camera color options
        List<String> colorList = call.argument("colorList");
        long[] colorListAsLongArray = null;
        if (colorList != null) {
            colorListAsLongArray = new long[colorList.size()];
            for (int i = 0; i < colorList.size(); i++) {
                colorListAsLongArray[i] = Long.parseLong(colorList.get(i));
            }
        }

        // Camera Frame options
        float strokeWidth = ValueGetter.getFloat("strokeWidth", call);

        ScanTextOptions scanTextOptions;

        if (call.argument("scanTextOptions") == null) {
            scanTextOptions = new ScanTextOptions();
        } else {
            scanTextOptions = gson.fromJson((String) call.argument("scanTextOptions"), ScanTextOptions.class);
        }

        // Gallery Button
        boolean isGalleryAvailable = ValueGetter.getBoolean("isGalleryAvailable", call);

        // Intent
        Intent intent = new Intent(mActivity, MultiProcessorActivity.class);

        intent.putExtra(Constants.CHANNEL_ID_KEY, channelId);

        // Intent extras
        intent.putExtra("scanType", scanType);
        if (additionalScanTypes != null) {
            intent.putExtra("additionalScanTypes", scanTypesIntArray);
        }
        intent.putExtra("colorList", colorListAsLongArray);

        intent.putExtra("gallery", isGalleryAvailable);
        intent.putExtra("strokeWidth", strokeWidth);

        intent.putExtra("textColor", scanTextOptions.getTextColor());
        intent.putExtra("textSize", scanTextOptions.getTextSize());
        intent.putExtra("showText", scanTextOptions.getShowText());
        intent.putExtra("textBackgroundColor", scanTextOptions.getTextBackgroundColor());
        intent.putExtra("showTextOutBounds", scanTextOptions.getShowTextOutBounds());
        intent.putExtra("autoSizeText", scanTextOptions.getAutoSizeText());
        intent.putExtra("minTextSize", scanTextOptions.getMinTextSize());
        intent.putExtra("granularity", scanTextOptions.getGranularity());

        // Multiprocessor Camera Mode
        intent.putExtra("scanMode", scanMode);

        // Start intent for multi processor camera
        if (scanMode == MULTIPROCESSOR_ASYNC_CODE || scanMode == MULTIPROCESSOR_SYNC_CODE) {
            mActivity.startActivityForResult(intent, REQUEST_CODE_SCAN_MULTI);
        } else {
            result.error(Errors.MP_CAMERA_SCAN_MODE_ERROR.getErrorCode(),
                    Errors.MP_CAMERA_SCAN_MODE_ERROR.getErrorMessage(),
                    null);
        }

    }

    private void decodeMultiSync(MethodCall call, MethodChannel.Result result) {
        // Analyzer options
        HmsScanAnalyzer analyzer = ValueGetter.analyzerForMultiDecoders(call, mActivity);

        // ML Frame from Bitmap
        MLFrame image = MLFrame.fromBitmap(ValueGetter.bitmapForDecoders(call, "data"));

        if (analyzerIsAvailableWithLogger(mActivity.getApplicationContext(), analyzer,
                "MultiProcessorMethodCallHandler")) {
            // Scan Results
            mHMSLogger.startMethodExecutionTimer("MultiProcessorMethodCallHandler.decodeMultiSync");
            SparseArray<HmsScan> scanResult = analyzer.analyseFrame(image);
            mHMSLogger.sendSingleEvent("MultiProcessorMethodCallHandler.decodeMultiSync");

            // Response to Flutter Side
            if (scanResult != null && scanResult.size() > 0 && scanResult.valueAt(0) != null && !TextUtils.isEmpty(
                    scanResult.valueAt(0).getOriginalValue())) {
                HmsScan[] info = new HmsScan[scanResult.size()];
                for (int index = 0; index < scanResult.size(); index++) {
                    info[index] = scanResult.valueAt(index);
                }
                result.success(gson.toJson(info));
            } else {
                result.error(Errors.DECODE_MULTI_SYNC_COULDNT_FIND.getErrorCode(),
                        Errors.DECODE_MULTI_SYNC_COULDNT_FIND.getErrorMessage(), null);
            }
        } else {
            Log.e(Errors.HMS_SCAN_ANALYZER_ERROR.getErrorCode(), Errors.HMS_SCAN_ANALYZER_ERROR.getErrorMessage(),
                    null);
            result.error(Errors.REMOTE_VIEW_ERROR.getErrorCode(), Errors.REMOTE_VIEW_ERROR.getErrorMessage(), null);
        }
        analyzerDestroyWithLogger(mActivity.getApplicationContext(), analyzer, "MultiProcessorMethodCallHandler");
    }

    private void decodeMultiAsync(MethodCall call, final MethodChannel.Result result) {
        // Analyzer options
        HmsScanAnalyzer analyzer = ValueGetter.analyzerForMultiDecoders(call, mActivity);

        // ML Frame from Bitmap
        MLFrame image = MLFrame.fromBitmap(ValueGetter.bitmapForDecoders(call, "data"));

        // onSuccess and onFailure of analyzeInAsync
        if (analyzerIsAvailableWithLogger(mActivity.getApplicationContext(), analyzer,
                "MultiProcessorMethodCallHandler")) {
            mHMSLogger.startMethodExecutionTimer("MultiProcessorMethodCallHandler.decodeMultiAsync");
            analyzer.analyzInAsyn(image).addOnSuccessListener(new OnSuccessListener<List<HmsScan>>() {
                @Override
                public void onSuccess(List<HmsScan> hmsScans) {
                    if (hmsScans != null && hmsScans.size() > 0 && hmsScans.get(0) != null && !TextUtils.isEmpty(
                            hmsScans.get(0).getOriginalValue())) {
                        HmsScan[] infos = new HmsScan[hmsScans.size()];
                        for (int index = 0; index < hmsScans.size(); index++) {
                            infos[index] = hmsScans.get(index);
                        }
                        result.success(gson.toJson(infos));
                        mHMSLogger.sendSingleEvent("MultiProcessorMethodCallHandler.decodeMultiAsync");
                    } else {
                        result.error(Errors.DECODE_MULTI_ASYNC_COULDNT_FIND.getErrorCode(),
                                Errors.DECODE_MULTI_ASYNC_COULDNT_FIND.getErrorMessage(), null);
                    }
                    analyzerDestroyWithLogger(mActivity.getApplicationContext(), analyzer,
                            "MultiProcessorMethodCallHandler");
                }
            }).addOnFailureListener(new OnFailureListener() {
                @Override
                public void onFailure(Exception e) {
                    result.error(Errors.DECODE_MULTI_ASYNC_ON_FAILURE.getErrorCode(),
                            Errors.DECODE_MULTI_ASYNC_ON_FAILURE.getErrorMessage(), gson.toJson(e));
                    mHMSLogger.sendSingleEvent("MultiProcessorMethodCallHandler.decodeMultiAsync",
                            Errors.DECODE_MULTI_ASYNC_ON_FAILURE.getErrorCode());
                    analyzerDestroyWithLogger(mActivity.getApplicationContext(), analyzer,
                            "MultiProcessorMethodCallHandler");
                }
            });
        } else {
            Log.e(Errors.HMS_SCAN_ANALYZER_ERROR.getErrorCode(), Errors.HMS_SCAN_ANALYZER_ERROR.getErrorMessage(),
                    null);
            result.error(Errors.REMOTE_VIEW_ERROR.getErrorCode(), Errors.REMOTE_VIEW_ERROR.getErrorMessage(), null);
            analyzerDestroyWithLogger(mActivity.getApplicationContext(), analyzer, "MultiProcessorMethodCallHandler");
        }
    }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
        // onActivityResult control
        if (resultCode != RESULT_OK || data == null) {
            return false;
        }
        // Request Code control
        // Multiprocessor Camera
        if (requestCode == REQUEST_CODE_SCAN_MULTI) {
            Parcelable[] obj = data.getParcelableArrayExtra(ScanUtil.RESULT);
            if (obj != null && obj.length > 0) {
                // Sending Result
                pendingResult.success(gson.toJson(obj));
                pendingResult = null; // reset
            }
        } else {
            pendingResult = null;
        }
        return false;
    }
}
