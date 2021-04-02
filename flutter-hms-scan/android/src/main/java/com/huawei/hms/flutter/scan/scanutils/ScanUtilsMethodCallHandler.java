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

package com.huawei.hms.flutter.scan.scanutils;

import static android.app.Activity.RESULT_OK;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.text.TextUtils;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.hmsscankit.ScanUtil;
import com.huawei.hms.hmsscankit.WriterException;
import com.huawei.hms.ml.scan.HmsBuildBitmapOption;
import com.huawei.hms.ml.scan.HmsScan;
import com.huawei.hms.ml.scan.HmsScanAnalyzerOptions;
import com.huawei.hms.flutter.scan.logger.HMSLogger;
import com.huawei.hms.flutter.scan.utils.Errors;
import com.huawei.hms.flutter.scan.utils.ValueGetter;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

import java.io.ByteArrayOutputStream;
import java.util.List;

public class ScanUtilsMethodCallHandler
    implements MethodChannel.MethodCallHandler, PluginRegistry.ActivityResultListener {
    private Activity mActivity;
    private MethodChannel.Result pendingResult;
    private final HMSLogger mHMSLogger;
    private Gson gson;

    private static final int REQUEST_CODE_SCAN_DEFAULT = 13;

    public ScanUtilsMethodCallHandler(final Activity activity) {
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
        //Arguments from call
        int scanType = ValueGetter.getInt("scanType", call);
        List<Integer> additionalScanTypes = call.argument("additionalScanTypes");
        int[] scanTypesIntArray = null;

        //List<Integer> to int[]
        if (additionalScanTypes != null) {
            scanTypesIntArray = new int[additionalScanTypes.size()];
            for (int i = 0; i < additionalScanTypes.size(); i++) {
                scanTypesIntArray[i] = additionalScanTypes.get(i);
            }
        }

        //Default view options
        HmsScanAnalyzerOptions.Creator creator = new HmsScanAnalyzerOptions.Creator();
        creator.setHmsScanTypes(scanType, scanTypesIntArray);
        HmsScanAnalyzerOptions options = creator.create();

        //Start scan with options
        mHMSLogger.startMethodExecutionTimer("ScanUtilsMethodCallHandler.defaultView");

        if (ScanUtil.startScan(mActivity, REQUEST_CODE_SCAN_DEFAULT, options) == ScanUtil.SUCCESS) {
            Log.i("DefaultView", "Camera started.");
        } else {
            Log.i("DefaultView", Errors.scanUtilNoCameraPermission.getErrorMessage());
            result.error(Errors.scanUtilNoCameraPermission.getErrorCode(),
                Errors.scanUtilNoCameraPermission.getErrorMessage(), null);
            mHMSLogger.sendSingleEvent("ScanUtilsMethodCallHandler.defaultView",
                Errors.scanUtilNoCameraPermission.getErrorCode());
        }
    }

    private void buildBitmap(MethodCall call, MethodChannel.Result result) {

        //Arguments from call
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
            //Barcode options
            HmsBuildBitmapOption.Creator creator = new HmsBuildBitmapOption.Creator();
            if (qrLogoBitmap != null) {
                creator.setQRLogoBitmap(qrLogoBitmap);
            }
            creator.setBitmapBackgroundColor(backgroundColor);
            creator.setBitmapColor(bitmapColor);
            creator.setBitmapMargin(margin);
            HmsBuildBitmapOption options = creator.create();

            //Generate Barcode
            mHMSLogger.startMethodExecutionTimer("ScanUtilsMethodCallHandler.buildBitmap");
            final Bitmap qrBmp = ScanUtil.buildBitmap(content, type, width, height, options);

            //Casting into byte[]
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            qrBmp.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream);
            final byte[] byteArray = byteArrayOutputStream.toByteArray();

            //Sending result
            result.success(byteArray);
            mHMSLogger.sendSingleEvent("ScanUtilsMethodCallHandler.buildBitmap");

        } catch (WriterException e) {
            result.error(Errors.buildBitmap.getErrorCode(), Errors.buildBitmap.getErrorMessage(), gson.toJson(e));
            mHMSLogger.sendSingleEvent("ScanUtilsMethodCallHandler.buildBitmap", Errors.buildBitmap.getErrorCode());
        }
    }

    private void decodeWithBitmap(MethodCall call, MethodChannel.Result result) {
        //Arguments from call
        int scanType = ValueGetter.getInt("scanType", call);
        List<Integer> additionalScanTypes = call.argument("additionalScanTypes");
        Bitmap bitmap = ValueGetter.bitmapForDecoders(call, "data");

        //List<Integer> to int[]
        int[] scanTypesIntArray = null;
        if (additionalScanTypes != null) {
            scanTypesIntArray = ValueGetter.scanTypesListToArray(additionalScanTypes);
        }

        //Default view options
        HmsScanAnalyzerOptions.Creator creator = new HmsScanAnalyzerOptions.Creator();
        creator.setHmsScanTypes(scanType, scanTypesIntArray);
        creator.setPhotoMode(true);
        HmsScanAnalyzerOptions options = creator.create();

        //Decode with bitmap
        mHMSLogger.startMethodExecutionTimer("ScanUtilsMethodCallHandler.decodeWithBitmap");
        HmsScan[] hmsScans = ScanUtil.decodeWithBitmap(mActivity, bitmap, options);
        mHMSLogger.sendSingleEvent("ScanUtilsMethodCallHandler.decodeWithBitmap");

        //Send result to flutter
        if (hmsScans != null && hmsScans.length > 0 && hmsScans[0] != null && !TextUtils.isEmpty(
            hmsScans[0].getOriginalValue())) {
            result.success(gson.toJson(hmsScans[0]));
        } else {
            result.error(Errors.decodeWithBitmapError.getErrorCode(), Errors.decodeWithBitmapError.getErrorMessage(),
                null);
        }

    }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
        //onActivityResult control
        if (resultCode != RESULT_OK || data == null) {
            return false;
        }
        //Default View
        if (requestCode == REQUEST_CODE_SCAN_DEFAULT) {
            if (pendingResult != null) {
                HmsScan obj = data.getParcelableExtra(ScanUtil.RESULT);
                //Sending Result
                pendingResult.success(gson.toJson(obj));
                HMSLogger.getInstance(mActivity.getApplicationContext())
                    .sendSingleEvent("ScanUtilsMethodCallHandler.defaultView");
                pendingResult = null; //reset
            }
        } else {
            pendingResult = null;
        }
        return false;
    }
}
