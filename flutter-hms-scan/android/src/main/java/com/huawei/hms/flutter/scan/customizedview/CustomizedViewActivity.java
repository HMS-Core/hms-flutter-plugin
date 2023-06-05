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

package com.huawei.hms.flutter.scan.customizedview;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Rect;
import android.os.Bundle;
import android.provider.MediaStore;
import android.text.TextUtils;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;

import com.huawei.hms.flutter.scan.R;
import com.huawei.hms.flutter.scan.ScanPlugin;
import com.huawei.hms.flutter.scan.logger.HMSLogger;
import com.huawei.hms.flutter.scan.utils.Constants;
import com.huawei.hms.flutter.scan.utils.Errors;
import com.huawei.hms.hmsscankit.OnLightVisibleCallBack;
import com.huawei.hms.hmsscankit.OnResultCallback;
import com.huawei.hms.hmsscankit.RemoteView;
import com.huawei.hms.hmsscankit.ScanUtil;
import com.huawei.hms.ml.scan.HmsScan;
import com.huawei.hms.ml.scan.HmsScanAnalyzerOptions;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import io.flutter.plugin.common.MethodChannel;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.HashMap;
import java.util.Objects;

public class CustomizedViewActivity extends Activity {
    // Declare the key. It is used to obtain the value returned from Scan Kit.
    public static final int REQUEST_CODE_PHOTO = 0X1113;

    private static final String TAG = "CustomizedViewActivity";

    int mScreenWidth;

    int mScreenHeight;

    int scanFrameSizeWidth;

    int scanFrameSizeHeight;

    boolean continuouslyScan;

    Intent intent;

    private RemoteView remoteView;

    private ImageView flashButton;

    private Gson mGson = new GsonBuilder().setPrettyPrinting().create();

    private HMSLogger mHMSLogger;

    private MethodChannel customizedViewChannel;

    private MethodChannel remoteViewChannel;

    // Flash button image
    private int[] img = {R.drawable.flashlight_on, R.drawable.flashlight_off};

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // HMS Logger
        mHMSLogger = HMSLogger.getInstance(this.getApplicationContext());
        intent = getIntent();
        // Window options.
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.activity_defined);

        try {
            int customizedChannelId = intent.getIntExtra(Constants.CHANNEL_ID_KEY, -1);
            int remoteChannelId = intent.getIntExtra(Constants.CHANNEL_REMOTE_KEY, -1);
            intent.getIntExtra(Constants.CHANNEL_REMOTE_KEY, -1);
            if (customizedChannelId == -1 || remoteChannelId == -1) {
                Log.e(Errors.REMOTE_VIEW_ERROR.getErrorCode(), Errors.REMOTE_VIEW_ERROR.getErrorMessage(), null);
                CustomizedViewActivity.this.finish();
            } else {
                customizedViewChannel = ScanPlugin.SCAN_CHANNELS.get(customizedChannelId);
                remoteViewChannel = ScanPlugin.SCAN_CHANNELS.get(remoteChannelId);
            }

            // Bind the camera preview screen.
            FrameLayout frameLayout = findViewById(R.id.rim);
            ImageView galleryButton = findViewById(R.id.img_btn);
            ImageView scanFrame = findViewById(R.id.scan_area);
            flashButton = findViewById(R.id.flush_btn);

            // 1. Obtain the screen density to calculate the viewfinder's rectangle.
            DisplayMetrics dm = getResources().getDisplayMetrics();
            float density = dm.density;
            // 2. Obtain the screen size.
            mScreenWidth = dm.widthPixels;
            mScreenHeight = dm.heightPixels;

            scanFrameSizeHeight = Objects.requireNonNull(intent.getExtras()).getInt("rectHeight");
            scanFrameSizeWidth = intent.getExtras().getInt("rectWidth");

            int scanFrameSizeHeight = (int) (this.scanFrameSizeHeight * density);
            int scanFrameSizeWidth = (int) (this.scanFrameSizeWidth * density);

            // 3. Calculate the viewfinder's rectangle, which in the middle of the layout.
            // Set the scanning area. (Optional. Rect can be null. If no settings are specified, it will be located in the middle of the layout.)
            Rect rect = new Rect();
            rect.left = mScreenWidth / 2 - scanFrameSizeWidth / 2;
            rect.right = mScreenWidth / 2 + scanFrameSizeWidth / 2;
            rect.top = mScreenHeight / 2 - scanFrameSizeHeight / 2;
            rect.bottom = mScreenHeight / 2 + scanFrameSizeHeight / 2;

            scanFrame.getLayoutParams().height = rect.height();
            scanFrame.getLayoutParams().width = rect.width();

            // Continuously Scan option from Flutter.
            continuouslyScan = intent.getExtras().getBoolean("continuouslyScan");

            // Initialize the RemoteView instance, and set callback for the scanning result.
            RemoteView.Builder builder = new RemoteView.Builder().setContext(this)
                .setBoundingBox(rect)
                .setContinuouslyScan(continuouslyScan)
                .setFormat(intent.getExtras().getInt("scanType"), intent.getExtras().getIntArray("additionalScanTypes"));

            if (intent.getExtras().getBoolean("enableReturnBitmap")) {
                remoteView = builder.enableReturnBitmap().build();
            } else {
                remoteView = builder.build();
            }

            // Set Method Call Handler for pause and resume actions of remote view.
            if (remoteViewChannel != null) {
                RemoteViewHandler remoteViewHandler = new RemoteViewHandler(remoteView, flashButton, mHMSLogger);
                remoteViewChannel.setMethodCallHandler(remoteViewHandler);
            }

            // Subscribe to the scanning result callback event.
            mHMSLogger.startMethodExecutionTimer("CustomizedViewActivity.customizedView");
            remoteView.setOnResultCallback(new OnResultCallback() {
                @Override
                public void onResult(HmsScan[] result) {
                    // Check the result.
                    if (result == null || result.length == 0 || result[0] == null || TextUtils.isEmpty(result[0].getOriginalValue())) {
                        return;
                    }
                    HashMap<String, Object> resultMap = mGson.fromJson(mGson.toJson(result[0]), HashMap.class);
                    if (resultMap.containsKey("originalBitmap")) {
                        resultMap.remove("originalBitmap");

                        int bytes = result[0].getOriginalBitmap().getByteCount();
                        ByteBuffer buffer = ByteBuffer.allocate(bytes);
                        result[0].getOriginalBitmap().copyPixelsToBuffer(buffer);
                        final byte[] array = buffer.array();

                        resultMap.put("originalBitmap", array);
                    }

                    if (customizedViewChannel != null) {
                        customizedViewChannel.invokeMethod("CustomizedViewResponse", resultMap);
                    }

                    if (continuouslyScan) {
                        mHMSLogger.sendPeriodicEvent("CustomizedViewActivity.customizedView");
                    } else {
                        mHMSLogger.sendSingleEvent("CustomizedViewActivity.customizedView");
                        CustomizedViewActivity.this.finish();
                    }
                }
            });

            // Load the customized view to the activity.
            mHMSLogger.startMethodExecutionTimer("remoteView.onCreate");
            remoteView.onCreate(savedInstanceState);
            mHMSLogger.sendSingleEvent("remoteView.onCreate");

            FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.MATCH_PARENT);
            frameLayout.addView(remoteView, params);

            // Set the back, photo scanning, and flashlight operations.
            setBackOperation();

            // Flash button visibility
            flashButton.setVisibility(View.INVISIBLE);

            // When the light is dim, this API is called back to display the flashlight switch.
            if (intent.getExtras().getBoolean("flashOnLightChange")) {
                setFlashOperation();
                mHMSLogger.startMethodExecutionTimer("remoteView.setOnLightVisibleCallback");
                remoteView.setOnLightVisibleCallback(new OnLightVisibleCallBack() {
                    @Override
                    public void onVisibleChanged(boolean visible) {
                        if (visible) {
                            flashButton.setVisibility(View.VISIBLE);
                        } else {
                            flashButton.setVisibility(View.INVISIBLE);
                        }
                    }
                });
                mHMSLogger.sendSingleEvent("remoteView.setOnLightVisibleCallback");
            }

            // Flash Button option from Flutter.
            if (intent.getExtras().getBoolean("isFlashAvailable")) {
                flashButton.setVisibility(View.VISIBLE);
                setFlashOperation();
            }

            // Gallery Button option from Flutter
            if (intent.getExtras().getBoolean("gallery")) {
                galleryButton.setVisibility(View.VISIBLE);
                setPictureScanOperation();
            }
        } catch (Exception e) {
            Log.e(TAG, e.getMessage());
        }
    }

    // Gallery button
    private void setPictureScanOperation() {
        ImageView galleryButton = findViewById(R.id.img_btn);
        galleryButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent pickIntent = new Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
                pickIntent.setDataAndType(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, "image/*");
                CustomizedViewActivity.this.startActivityForResult(pickIntent, REQUEST_CODE_PHOTO);

            }
        });
    }

    // Normal flash button
    private void setFlashOperation() {
        flashButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mHMSLogger.startMethodExecutionTimer("remoteView.getLightStatus");
                boolean lightStatus = remoteView.getLightStatus();
                mHMSLogger.sendSingleEvent("remoteView.getLightStatus");
                mHMSLogger.startMethodExecutionTimer("remoteView.switchLight");
                remoteView.switchLight();
                mHMSLogger.sendSingleEvent("remoteView.switchLight");
                if (lightStatus) {
                    flashButton.setImageResource(img[1]);
                } else {
                    flashButton.setImageResource(img[0]);
                }
            }
        });
    }

    // Back button
    private void setBackOperation() {
        ImageView backButton = findViewById(R.id.back_img);
        backButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                CustomizedViewActivity.this.finish();
            }
        });
    }

    /**
     * Call the lifecycle management method of the remoteView activity.
     * Flutter callbacks.
     */
    @Override
    protected void onStart() {
        super.onStart();
        mHMSLogger.startMethodExecutionTimer("remoteView.onStart");
        remoteView.onStart();
        mHMSLogger.sendSingleEvent("remoteView.onStart");
        if (remoteViewChannel != null) {
            remoteViewChannel.invokeMethod("onStart", null);
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        mHMSLogger.startMethodExecutionTimer("remoteView.onResume");
        remoteView.onResume();
        mHMSLogger.sendSingleEvent("remoteView.onResume");
        if (remoteViewChannel != null) {
            remoteViewChannel.invokeMethod("onResume", null);
        }
    }

    @Override
    protected void onPause() {
        super.onPause();
        mHMSLogger.startMethodExecutionTimer("remoteView.onPause");
        remoteView.onPause();
        mHMSLogger.sendSingleEvent("remoteView.onPause");
        if (remoteViewChannel != null) {
            remoteViewChannel.invokeMethod("onPause", null);
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        mHMSLogger.startMethodExecutionTimer("remoteView.onDestroy");
        remoteView.onDestroy();
        mHMSLogger.sendSingleEvent("remoteView.onDestroy");
        if (remoteViewChannel != null) {
            remoteViewChannel.invokeMethod("onDestroy", null);
        }
    }

    @Override
    protected void onStop() {
        super.onStop();
        mHMSLogger.startMethodExecutionTimer("remoteView.onStop");
        remoteView.onStop();
        mHMSLogger.sendSingleEvent("remoteView.onStop");
        if (remoteViewChannel != null) {
            remoteViewChannel.invokeMethod("onStop", null);
        }
    }

    /**
     * Handle the return results from the gallery.
     *
     * @param requestCode requestCode
     * @param resultCode resultCode
     * @param data Intent
     */
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == RESULT_OK && requestCode == REQUEST_CODE_PHOTO) {
            intent = getIntent();
            try {
                Bitmap bitmap = MediaStore.Images.Media.getBitmap(this.getContentResolver(), data.getData());
                mHMSLogger.startMethodExecutionTimer("CustomizedViewActivity.decodeWithBitmap");
                HmsScan[] hmsScans = ScanUtil.decodeWithBitmap(CustomizedViewActivity.this, bitmap,
                    new HmsScanAnalyzerOptions.Creator().setHmsScanTypes(
                        Objects.requireNonNull(intent.getExtras()).getInt("scanType"),
                        intent.getExtras().getIntArray("additionalScanTypes")).setPhotoMode(true).create());
                mHMSLogger.sendSingleEvent("CustomizedViewActivity.decodeWithBitmap");
                if (hmsScans != null && hmsScans.length > 0 && hmsScans[0] != null && !TextUtils.isEmpty(
                    hmsScans[0].getOriginalValue())) {
                    Intent resultIntent = new Intent();
                    resultIntent.putExtra(ScanUtil.RESULT, hmsScans[0]);
                    setResult(RESULT_OK, resultIntent);
                    CustomizedViewActivity.this.finish();
                }
            } catch (IOException e) {
                Log.e("Customized-IOException", e.getMessage(), e.getCause());
            }
        }
    }
}
