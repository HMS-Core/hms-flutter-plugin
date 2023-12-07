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

package com.huawei.hms.flutter.scan.scanutils;

import static android.app.Activity.RESULT_OK;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Parcelable;
import android.text.TextUtils;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.scan.ScanPlugin;
import com.huawei.hms.flutter.scan.logger.HMSLogger;
import com.huawei.hms.flutter.scan.multiprocessor.MultiProcessorActivity;
import com.huawei.hms.flutter.scan.utils.Constants;
import com.huawei.hms.flutter.scan.utils.Errors;
import com.huawei.hms.flutter.scan.utils.ValueGetter;
import com.huawei.hms.hmsscankit.ScanUtil;
import com.huawei.hms.hmsscankit.WriterException;
import com.huawei.hms.ml.scan.HmsBuildBitmapOption;
import com.huawei.hms.ml.scan.HmsScan;
import com.huawei.hms.ml.scan.HmsScanAnalyzerOptions;
import com.huawei.hms.ml.scan.HmsScanFrame;
import com.huawei.hms.ml.scan.HmsScanFrameOptions;
import com.huawei.hms.ml.scan.HmsScanResult;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

import java.io.ByteArrayOutputStream;
import java.util.List;

public class ScanUtilsMethodCallHandler
        implements MethodChannel.MethodCallHandler, PluginRegistry.ActivityResultListener {
    private static final int REQUEST_CODE_SCAN_DEFAULT = 13;

    private static final int REQUEST_CODE_SCAN_BITMAP = 0X02;

    private static final int REQUEST_CODE_SCAN_DECODE = 0X03;

    public static final int SCANMODEDECODE = 222;

    public static final int SCANMODEDECODEWITHBITMAP = 333;

    private int channelId;

    private final HMSLogger mHMSLogger;

    private Activity mActivity;

    private MethodChannel.Result pendingResult;

    private Gson gson;

    public ScanUtilsMethodCallHandler(final Activity activity, MethodChannel channel) {
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
            case "defaultView":
                defaultView(call, result);
                break;
            case "buildBitmap":
                buildBitmap(call, result);
                break;
            case "decodeWithBitmap":
                decodeWithBitmap(call, result);
                break;
            case "decode":
                decode(call, result);
                break;
            case "disableLogger":
                mHMSLogger.disableLogger();
                break;
            case "enableLogger":
                mHMSLogger.enableLogger();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void defaultView(MethodCall call, MethodChannel.Result result) {
        // Arguments from call
        int scanType = ValueGetter.getInt("scanType", call);
        List<Integer> additionalScanTypes = call.argument("additionalScanTypes");
        int viewType = ValueGetter.getInt("viewType", call);
        boolean errorCheck = ValueGetter.getBoolean("errorCheck", call);
        int[] scanTypesIntArray = null;

        // List<Integer> to int[]
        if (additionalScanTypes != null) {
            scanTypesIntArray = new int[additionalScanTypes.size()];
            for (int i = 0; i < additionalScanTypes.size(); i++) {
                scanTypesIntArray[i] = additionalScanTypes.get(i);
            }
        }

        // Default view options
        HmsScanAnalyzerOptions.Creator creator = new HmsScanAnalyzerOptions.Creator();
        creator.setHmsScanTypes(scanType, scanTypesIntArray);
        creator.setViewType(viewType);
        creator.setErrorCheck(errorCheck);
        HmsScanAnalyzerOptions options = creator.create();

        // Start scan with options
        mHMSLogger.startMethodExecutionTimer("ScanUtilsMethodCallHandler.defaultView");

        if (ScanUtil.startScan(mActivity, REQUEST_CODE_SCAN_DEFAULT, options) == ScanUtil.SUCCESS) {
            Log.i("DefaultView", "Camera started.");
        } else {
            Log.i("DefaultView", Errors.SCAN_UTIL_NO_CAMERA_PERMISSION.getErrorMessage());
            result.error(Errors.SCAN_UTIL_NO_CAMERA_PERMISSION.getErrorCode(),
                    Errors.SCAN_UTIL_NO_CAMERA_PERMISSION.getErrorMessage(), null);
            mHMSLogger.sendSingleEvent("ScanUtilsMethodCallHandler.defaultView",
                    Errors.SCAN_UTIL_NO_CAMERA_PERMISSION.getErrorCode());
        }
    }

    private void buildBitmap(MethodCall call, MethodChannel.Result result) {

        // Arguments from call
        String content = ValueGetter.getString("content", call);
        int type = ValueGetter.getInt("type", call);
        int margin = ValueGetter.getInt("margin", call);
        int width = ValueGetter.getInt("width", call);
        int height = ValueGetter.getInt("height", call);

        int bitmapColor = ValueGetter.getInt("bitmapColor", call);
        int backgroundColor = ValueGetter.getInt("backgroundColor", call);

        Bitmap qrLogoBitmap = null;
        if (call.argument("qrLogo") != null) {
            qrLogoBitmap = ValueGetter.bitmapForDecoders(call, "qrLogo");
        }

        try {
            // Barcode options
            HmsBuildBitmapOption.Creator creator = new HmsBuildBitmapOption.Creator();
            if (qrLogoBitmap != null) {
                creator.setQRLogoBitmap(qrLogoBitmap);
            }
            creator.setBitmapBackgroundColor(backgroundColor);
            creator.setBitmapColor(bitmapColor);
            creator.setBitmapMargin(margin);
            HmsBuildBitmapOption options = creator.create();

            // Generate Barcode
            mHMSLogger.startMethodExecutionTimer("ScanUtilsMethodCallHandler.buildBitmap");
            final Bitmap qrBmp = ScanUtil.buildBitmap(content, type, width, height, options);

            // Casting into byte[]
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            qrBmp.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream);
            final byte[] byteArray = byteArrayOutputStream.toByteArray();

            // Sending result
            result.success(byteArray);
            mHMSLogger.sendSingleEvent("ScanUtilsMethodCallHandler.buildBitmap");

        } catch (WriterException e) {
            result.error(Errors.BUILD_BITMAP.getErrorCode(), Errors.BUILD_BITMAP.getErrorMessage(), gson.toJson(e));
            mHMSLogger.sendSingleEvent("ScanUtilsMethodCallHandler.buildBitmap", Errors.BUILD_BITMAP.getErrorCode());
        }
    }

    private void decodeWithBitmap(MethodCall call, MethodChannel.Result result) {
        // Arguments from call
        pendingResult = result;
        int scanType = ValueGetter.getInt("scanType", call);
        List<Integer> additionalScanTypes = call.argument("additionalScanTypes");
        Bitmap bitmap = ValueGetter.bitmapForDecoders(call, "data");
        boolean photoMode = ValueGetter.getBoolean("photoMode", call);
        HmsScanAnalyzerOptions.Creator creator = new HmsScanAnalyzerOptions.Creator();
        HmsScanAnalyzerOptions options = creator.create();
        HmsScan[] hmsScans = ScanUtil.decodeWithBitmap(mActivity.getApplicationContext(), bitmap, options);

        // List<Integer> to int[]
        int[] scanTypesIntArray = null;
        if (additionalScanTypes != null) {
            scanTypesIntArray = ValueGetter.scanTypesListToArray(additionalScanTypes);
        }

        if (!photoMode) {
            Intent intent = new Intent(mActivity.getApplicationContext(), MultiProcessorActivity.class);

            intent.putExtra(Constants.CHANNEL_ID_KEY, channelId);
            intent.putExtra("scanType", scanType);
            if (additionalScanTypes != null) {
                intent.putExtra("additionalScanTypes", scanTypesIntArray);
            }

            intent.putExtra("scanMode", SCANMODEDECODEWITHBITMAP);
            mActivity.startActivityForResult(intent, REQUEST_CODE_SCAN_BITMAP);
        } else {
            if (bitmap.toString().isEmpty()) {
                pendingResult.error(Errors.MP_CHANNEL_ERROR.getErrorCode(), Errors.MP_CHANNEL_ERROR.getErrorMessage(),
                        null);
            }
            // Default view options
            creator.setHmsScanTypes(scanType, scanTypesIntArray);
            creator.setPhotoMode(true);

            // Decode with bitmap
            mHMSLogger.startMethodExecutionTimer("ScanUtilsMethodCallHandler.decodeWithBitmap");
            mHMSLogger.sendSingleEvent("ScanUtilsMethodCallHandler.decodeWithBitmap");

            // Send result to flutter
            if (hmsScans != null && hmsScans.length > 0 && hmsScans[0] != null
                    && !TextUtils.isEmpty(hmsScans[0].getOriginalValue())) {
                result.success(gson.toJson(hmsScans));
            } else {
                result.error(Errors.DECODE_WITH_BITMAP_ERROR.getErrorCode(),
                        Errors.DECODE_WITH_BITMAP_ERROR.getErrorMessage(),
                        null);
            }

            if (bitmap.toString().isEmpty()) {
                pendingResult.error(Errors.MP_CHANNEL_ERROR.getErrorCode(), Errors.MP_CHANNEL_ERROR.getErrorMessage(),
                        null);
            }
        }

    }

    private void decode(MethodCall call, MethodChannel.Result result) {

        pendingResult = result;
        int scanType = ValueGetter.getInt("scanType", call);
        List<Integer> additionalScanTypes = call.argument("additionalScanTypes");
        boolean photoMode = ValueGetter.getBoolean("photoMode", call);
        boolean multiMode = ValueGetter.getBoolean("multiMode", call);
        boolean parseResult = ValueGetter.getBoolean("parseResult", call);

        // List<Integer> to int[]
        int[] scanTypesIntArray = null;
        if (additionalScanTypes != null) {
            scanTypesIntArray = ValueGetter.scanTypesListToArray(additionalScanTypes);
        }

        if (!photoMode) {
            Intent intent = new Intent(mActivity.getApplicationContext(), MultiProcessorActivity.class);

            intent.putExtra("scanType", scanType);
            intent.putExtra("multiMode", multiMode);
            intent.putExtra("parseResult", parseResult);
            if (additionalScanTypes != null) {
                intent.putExtra("additionalScanTypes", scanTypesIntArray);
            }
            intent.putExtra("scanMode", SCANMODEDECODE);
            intent.putExtra(Constants.CHANNEL_ID_KEY, channelId);
            mActivity.startActivityForResult(intent, REQUEST_CODE_SCAN_DECODE);
        } else {
            Bitmap bitmap = ValueGetter.bitmapForDecoders(call, "data");
            if (bitmap.toString().isEmpty()) {
                pendingResult.error(Errors.MP_CHANNEL_ERROR.getErrorCode(), Errors.MP_CHANNEL_ERROR.getErrorMessage(),
                        null);
            }

            HmsScanFrame frame;
            frame = new HmsScanFrame(bitmap);

            HmsScanFrameOptions.Creator creator = new HmsScanFrameOptions.Creator();
            creator.setHmsScanTypes(scanType, scanTypesIntArray);
            creator.setPhotoMode(true);
            creator.setMultiMode(multiMode);
            creator.setParseResult(parseResult);
            HmsScanFrameOptions options = creator.create();

            mHMSLogger.startMethodExecutionTimer("ScanUtilsMethodCallHandler.decode");
            HmsScanResult scanResult = ScanUtil.decode(mActivity.getApplicationContext(), frame, options);
            HmsScan[] hmsScans = scanResult.getHmsScans();
            mHMSLogger.sendSingleEvent("ScanUtilsMethodCallHandler.decode");

            if (hmsScans != null && hmsScans.length > 0 && hmsScans[0] != null
                    && !TextUtils.isEmpty(hmsScans[0].getOriginalValue())) {
                result.success(gson.toJson(hmsScans));

            } else {
                result.error(Errors.DECODE_WITH_BITMAP_ERROR.getErrorCode(),
                        Errors.DECODE_WITH_BITMAP_ERROR.getErrorMessage(), null);
            }
        }
    }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
        // onActivityResult control
        if (resultCode != RESULT_OK || data == null) {
            return false;
        }
        // Default View
        if (requestCode == REQUEST_CODE_SCAN_DEFAULT) {
            int errorCode = data.getIntExtra(ScanUtil.RESULT_CODE, ScanUtil.SUCCESS);
            if (errorCode == ScanUtil.SUCCESS) {
                if (pendingResult != null) {
                    HmsScan obj = data.getParcelableExtra(ScanUtil.RESULT);
                    // Sending Result
                    pendingResult.success(gson.toJson(obj));
                    HMSLogger.getInstance(mActivity.getApplicationContext())
                            .sendSingleEvent("ScanUtilsMethodCallHandler.defaultView");
                    pendingResult = null; // reset
                }
            } else if (errorCode == ScanUtil.SCAN_NO_DETECTED) {
                HMSLogger.getInstance(mActivity.getApplicationContext()).sendSingleEvent("ScanUtilsMethodCallHandler",
                        "null data");
                pendingResult.error(Errors.SCAN_NO_DETECTED.getErrorCode(), "No barcode is detected", null);
            }
        } else if (requestCode == REQUEST_CODE_SCAN_DECODE || requestCode == REQUEST_CODE_SCAN_BITMAP) {
            int errorCode = data.getIntExtra(ScanUtil.RESULT_CODE, ScanUtil.SUCCESS);
            if (errorCode == ScanUtil.SUCCESS) {
                if (pendingResult != null) {
                    Parcelable[] obj = data.getParcelableArrayExtra(ScanUtil.RESULT);
                    // Sending Result
                    pendingResult.success(gson.toJson(obj));
                    HMSLogger.getInstance(mActivity.getApplicationContext())
                            .sendSingleEvent("ScanUtilsMethodCallHandler.decodeWithBitmap");
                    pendingResult = null; // reset
                }
            } else if (errorCode == ScanUtil.SCAN_NO_DETECTED) {
                HMSLogger.getInstance(mActivity.getApplicationContext()).sendSingleEvent("ScanUtilsMethodCallHandler",
                        "null data");
                pendingResult.error(Errors.SCAN_NO_DETECTED.getErrorCode(), "No barcode is detected", null);
            }
        } else {
            pendingResult = null;
        }
        return false;
    }
}
