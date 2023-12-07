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

import static com.huawei.hms.flutter.scan.scanutils.ScanUtilsMethodCallHandler.SCANMODEDECODE;
import static com.huawei.hms.flutter.scan.scanutils.ScanUtilsMethodCallHandler.SCANMODEDECODEWITHBITMAP;
import static com.huawei.hms.flutter.scan.utils.ValueGetter.analyzerIsAvailableWithLogger;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Point;
import android.os.Bundle;
import android.provider.MediaStore;
import android.text.TextUtils;
import android.util.Log;
import android.util.SparseArray;
import android.view.Display;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.FrameLayout;
import android.widget.ImageView;

import com.huawei.hmf.tasks.OnFailureListener;
import com.huawei.hmf.tasks.OnSuccessListener;
import com.huawei.hms.flutter.scan.R;
import com.huawei.hms.flutter.scan.ScanPlugin;
import com.huawei.hms.flutter.scan.logger.HMSLogger;
import com.huawei.hms.flutter.scan.utils.Constants;
import com.huawei.hms.flutter.scan.utils.Errors;
import com.huawei.hms.hmsscankit.ScanUtil;
import com.huawei.hms.ml.scan.HmsScan;
import com.huawei.hms.ml.scan.HmsScanAnalyzer;
import com.huawei.hms.mlsdk.common.MLFrame;

import io.flutter.plugin.common.MethodChannel;

import java.io.IOException;
import java.util.List;
import java.util.Objects;

public class MultiProcessorActivity extends Activity {

    public static final int REQUEST_CODE_PHOTO = 0X1113;

    private static final String TAG = "MultiProcessorActivity";

    public ScanResultView scanResultView;

    private MethodChannel multiProcessorChannel;

    private SurfaceHolder surfaceHolder;

    private MultiProcessorCamera mMultiProcessorCamera;

    private SurfaceCallBack surfaceCallBack;

    private MultiProcessorHandler handler;

    private boolean isShow;

    private int mode;

    private ImageView galleryButton;

    private HMSLogger mHMSLogger;

    private HmsScanAnalyzer mAnalyzer;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Window window = getWindow();

        // HMS Logger
        mHMSLogger = HMSLogger.getInstance(this.getApplicationContext());

        // Window options
        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.activity_multiprocessor);

        try {
            // MultiProcessor mode
            mode = Objects.requireNonNull(getIntent().getExtras()).getInt("scanMode");

            mMultiProcessorCamera = new MultiProcessorCamera();
            surfaceCallBack = new SurfaceCallBack();
            SurfaceView cameraPreview = findViewById(R.id.surfaceView);
            adjustSurface(cameraPreview);
            surfaceHolder = cameraPreview.getHolder();
            isShow = false;
            setBackOperation();

            Intent multiIntent = getIntent();
            galleryButton = findViewById(R.id.img_btn);
            galleryButton.setVisibility(View.INVISIBLE);

            int channelId = multiIntent.getIntExtra(Constants.CHANNEL_ID_KEY, -1);
            if (channelId == -1) {
                Log.e(Errors.MP_CHANNEL_ERROR.getErrorCode(), Errors.MP_CHANNEL_ERROR.getErrorMessage(), null);
                MultiProcessorActivity.this.finish();
            } else {
                multiProcessorChannel = ScanPlugin.SCAN_CHANNELS.get(channelId);
            }

            // Gallery option from Flutter.
            if (multiIntent.getExtras().getBoolean("gallery")
                    && mode == MultiProcessorMethodCallHandler.MULTIPROCESSOR_ASYNC_CODE) {
                galleryButton.setVisibility(View.VISIBLE);
                setPictureScanOperation();
            }

            scanResultView = findViewById(R.id.scan_result_view);

            mAnalyzer = new HmsScanAnalyzer.Creator(this).setHmsScanTypes(
                    Objects.requireNonNull(multiIntent.getExtras()).getInt("scanType"),
                    multiIntent.getExtras().getIntArray("additionalScanTypes")).create();
        } catch (Exception e) {
            Log.e(TAG, e.getMessage());
        }

    }

    // Adjust camera and surface.
    private void adjustSurface(SurfaceView cameraPreview) {
        FrameLayout.LayoutParams paramSurface = (FrameLayout.LayoutParams) cameraPreview.getLayoutParams();
        if (getSystemService(Context.WINDOW_SERVICE) != null) {
            WindowManager windowManager = (WindowManager) getSystemService(Context.WINDOW_SERVICE);
            Display defaultDisplay = Objects.requireNonNull(windowManager).getDefaultDisplay();
            Point outPoint = new Point();
            defaultDisplay.getRealSize(outPoint);
            float screenWidth = outPoint.x;
            float screenHeight = outPoint.y;
            float rate;
            if (screenWidth / (float) 1080 > screenHeight / (float) 1920) {
                rate = screenWidth / (float) 1080;
                int targetHeight = (int) (1920 * rate);
                paramSurface.width = FrameLayout.LayoutParams.MATCH_PARENT;
                paramSurface.height = targetHeight;
                int topMargin = (int) (-(targetHeight - screenHeight) / 2);
                if (topMargin < 0) {
                    paramSurface.topMargin = topMargin;
                }
            } else {
                rate = screenHeight / (float) 1920;
                int targetWidth = (int) (1080 * rate);
                paramSurface.width = targetWidth;
                paramSurface.height = FrameLayout.LayoutParams.MATCH_PARENT;
                int leftMargin = (int) (-(targetWidth - screenWidth) / 2);
                if (leftMargin < 0) {
                    paramSurface.leftMargin = leftMargin;
                }
            }
        }
    }

    // Back button
    private void setBackOperation() {
        ImageView backButton = findViewById(R.id.back_img);
        backButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onBackPressed();
            }
        });
    }

    @Override
    public void onBackPressed() {
        if (mode == MultiProcessorMethodCallHandler.MULTIPROCESSOR_ASYNC_CODE
                || mode == MultiProcessorMethodCallHandler.MULTIPROCESSOR_SYNC_CODE || mode == SCANMODEDECODE
                || mode == SCANMODEDECODEWITHBITMAP) {
            setResult(RESULT_CANCELED);
        }
        MultiProcessorActivity.this.finish();
    }

    // Gallery button
    private void setPictureScanOperation() {
        galleryButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent pickIntent = new Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
                pickIntent.setDataAndType(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, "image/*");
                MultiProcessorActivity.this.startActivityForResult(pickIntent, REQUEST_CODE_PHOTO);
            }
        });
    }

    // Camera Lifecycle
    @Override
    protected void onResume() {
        super.onResume();
        if (isShow) {
            initCamera();
        } else {
            surfaceHolder.addCallback(surfaceCallBack);
        }
    }

    @Override
    protected void onPause() {
        if (handler != null) {
            handler.quit();
            handler = null;
        }
        mMultiProcessorCamera.close();
        if (!isShow) {
            surfaceHolder.removeCallback(surfaceCallBack);
        }
        super.onPause();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
    }

    // Camera start method.
    private void initCamera() {
        try {
            mMultiProcessorCamera.open(surfaceHolder);
            if (handler == null) {
                Intent intent = getIntent();
                // Options from Flutter.
                long[] colorList = Objects.requireNonNull(intent.getExtras()).getLongArray("colorList");

                int textColor = intent.getExtras().getInt("textColor");
                float textSize = intent.getExtras().getFloat("textSize");
                float strokeWidth = intent.getExtras().getFloat("strokeWidth");

                int textBackgroundColor = intent.getExtras().getInt("textBackgroundColor");
                boolean showText = intent.getExtras().getBoolean("showText");
                boolean showTextOutBounds = intent.getExtras().getBoolean("showTextOutBounds");
                boolean autoSizeText = intent.getExtras().getBoolean("autoSizeText");
                int minTextSize = intent.getExtras().getInt("minTextSize");
                int granularity = intent.getExtras().getInt("granularity");
                boolean multiMode = intent.getExtras().getBoolean("multiMode");
                int scanType = intent.getExtras().getInt("scanType");
                int[] additionalScanTypes = intent.getExtras().getIntArray("additionalScanTypes");
                boolean parseResult = intent.getExtras().getBoolean("parseResult");

                // Handler for multi processor camera -- this is where camera continuously scan
                // barcode.
                if (mAnalyzer != null && multiProcessorChannel != null) {
                    handler = new MultiProcessorHandler(MultiProcessorActivity.this, multiProcessorChannel,
                            mMultiProcessorCamera, mode, colorList, textColor, textSize, strokeWidth,
                            textBackgroundColor,
                            showText, showTextOutBounds, autoSizeText, minTextSize, granularity, mAnalyzer, multiMode,
                            scanType, additionalScanTypes, parseResult);
                }
            }
        } catch (IOException e) {
            Log.e(TAG, e.toString(), e);
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode != RESULT_OK || data == null || requestCode != REQUEST_CODE_PHOTO) {
            return;
        }
        try {
            // Image-based scanning mode
            if (mode == MultiProcessorMethodCallHandler.MULTIPROCESSOR_SYNC_CODE && mAnalyzer != null) {
                decodeMultiSync(MediaStore.Images.Media.getBitmap(this.getContentResolver(), data.getData()));
            } else if (mode == MultiProcessorMethodCallHandler.MULTIPROCESSOR_ASYNC_CODE && mAnalyzer != null) {
                decodeMultiAsync(MediaStore.Images.Media.getBitmap(this.getContentResolver(), data.getData()));
            }
        } catch (Exception e) {
            Log.e(TAG, e.getMessage());
        }
    }

    // Multi Async mode for image based scanning mode.
    private void decodeMultiAsync(Bitmap bitmap) {
        MLFrame image = MLFrame.fromBitmap(bitmap);
        if (analyzerIsAvailableWithLogger(this.getApplicationContext(), mAnalyzer, "MultiProcessorActivity")) {
            mHMSLogger.startMethodExecutionTimer("MultiProcessorActivity.decodeMultiAsync");
            mAnalyzer.analyzInAsyn(image).addOnSuccessListener(new OnSuccessListener<List<HmsScan>>() {
                @Override
                public void onSuccess(List<HmsScan> hmsScans) {
                    if (hmsScans != null && hmsScans.size() > 0 && hmsScans.get(0) != null && !TextUtils.isEmpty(
                            hmsScans.get(0).getOriginalValue())) {
                        mHMSLogger.sendSingleEvent("MultiProcessorActivity.decodeMultiAsync");
                        HmsScan[] infos = new HmsScan[hmsScans.size()];
                        Intent intent = new Intent();
                        intent.putExtra(ScanUtil.RESULT, hmsScans.toArray(infos));
                        setResult(RESULT_OK, intent);
                        MultiProcessorActivity.this.finish();
                    }
                }
            }).addOnFailureListener(new OnFailureListener() {
                @Override
                public void onFailure(Exception e) {
                    Log.w(TAG, e);
                    mHMSLogger.sendSingleEvent("MultiProcessorActivity.decodeMultiAsync",
                            Errors.DECODE_MULTI_ASYNC_ON_FAILURE.getErrorCode());
                }
            });
        } else {
            Log.e(Errors.HMS_SCAN_ANALYZER_ERROR.getErrorCode(), Errors.HMS_SCAN_ANALYZER_ERROR.getErrorMessage(),
                    null);
        }
    }

    // Multi Sync mode for image based scanning mode.
    private void decodeMultiSync(Bitmap bitmap) {
        MLFrame image = MLFrame.fromBitmap(bitmap);
        if (analyzerIsAvailableWithLogger(this.getApplicationContext(), mAnalyzer, "MultiProcessorActivity")) {
            mHMSLogger.startMethodExecutionTimer("MultiProcessorActivity.decodeMultiSync");
            SparseArray<HmsScan> result = mAnalyzer.analyseFrame(image);
            mHMSLogger.sendSingleEvent("MultiProcessorActivity.decodeMultiSync");
            if (result != null && result.size() > 0 && result.valueAt(0) != null && !TextUtils.isEmpty(
                    result.valueAt(0).getOriginalValue())) {
                HmsScan[] info = new HmsScan[result.size()];
                for (int index = 0; index < result.size(); index++) {
                    info[index] = result.valueAt(index);
                }
                Intent intent = new Intent();
                intent.putExtra(ScanUtil.RESULT, info);
                setResult(RESULT_OK, intent);
                MultiProcessorActivity.this.finish();
            } else {
                Log.i("Error code: " + Errors.DECODE_MULTI_SYNC_COULDNT_FIND.getErrorCode(),
                        Errors.DECODE_MULTI_SYNC_COULDNT_FIND.getErrorMessage());
            }
        } else {
            Log.e(Errors.HMS_SCAN_ANALYZER_ERROR.getErrorCode(), Errors.HMS_SCAN_ANALYZER_ERROR.getErrorMessage(),
                    null);
        }
    }

    class SurfaceCallBack implements SurfaceHolder.Callback {

        @Override
        public void surfaceCreated(SurfaceHolder holder) {
            if (!isShow) {
                isShow = true;
                initCamera();
            }
        }

        @Override
        public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {

        }

        @Override
        public void surfaceDestroyed(SurfaceHolder holder) {
            isShow = false;
        }
    }
}
