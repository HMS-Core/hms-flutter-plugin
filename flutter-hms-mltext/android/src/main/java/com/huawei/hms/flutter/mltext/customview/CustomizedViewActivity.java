/*
 * Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.huawei.hms.flutter.mltext.customview;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.graphics.Point;
import android.graphics.Rect;
import android.os.Build;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Display;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.huawei.hms.flutter.mltext.HuaweiMlTextPlugin;
import com.huawei.hms.flutter.mltext.R;
import com.huawei.hms.flutter.mltext.constant.Channel;
import com.huawei.hms.flutter.mltext.logger.HMSLogger;
import com.huawei.hms.flutter.mltext.utils.Errors;
import com.huawei.hms.mlplugin.card.bcr.CustomView;
import com.huawei.hms.mlplugin.card.bcr.MLBcrCaptureResult;

import java.lang.reflect.InvocationTargetException;

import io.flutter.plugin.common.MethodChannel;

public class CustomizedViewActivity extends Activity {
    private static final String TAG = CustomizedViewActivity.class.getSimpleName();
    private static final double TOP_OFFSET_RATIO = 0.4D;

    private CustomView remoteView;
    private ImageView flashButton;
    private FrameLayout frameLayout;
    private View titleLayout;
    private TextView title;
    private View lightLayout;

    private ViewfinderView viewfinderView;

    boolean isLight = false;
    private Gson mGson = new GsonBuilder().setPrettyPrinting().create();

    private HMSLogger mHMSLogger;

    private Float scanFrameWidthFactor = 0.8F;

    private Float scanFrameHeightFactor = 0.63084F;

    Intent intent;

    Bundle bundle;

    private MethodChannel remoteViewChannel;

    private int[] img = { R.drawable.flashlight_on, R.drawable.flashlight_off };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        mHMSLogger = HMSLogger.getInstance(this.getApplicationContext());
        intent = getIntent();

        int remoteChannelId = intent.getIntExtra(Channel.CHANNEL_REMOTE_KEY, -1);
        intent.getIntExtra(Channel.CHANNEL_REMOTE_KEY, -1);
        if (remoteChannelId == -1) {
            Log.e(Errors.REMOTE_VIEW_ERROR.getErrorCode(), Errors.REMOTE_VIEW_ERROR.getErrorMessage(), null);
            CustomizedViewActivity.this.finish();
        } else {
            remoteViewChannel = HuaweiMlTextPlugin.ML_TEXT_CHANNELS.get(remoteChannelId);
        }

        try {
            bundle = intent.getExtras();
        } catch (Exception e) {
            Log.i("Customized-Exception", e.getMessage());
        }

        initView();

        Rect mScanRect = createScanRectFromCamera();

        remoteView = new CustomView.Builder()
                .setContext(this)
                // Set the rectangular coordinate setting of the scan frame, required, otherwise
                // it will not be recognized.
                .setBoundingBox(mScanRect)
                // Set the type of result that the bank card identification expects to return.
                // MLBcrCaptureConfig.RESULT_SIMPLE：Only identify the card number and validity
                // period information.
                // MLBcrCaptureConfig.RESULT_ALL：Identify information such as card number,
                // expiration date, issuing bank, issuing organization, and card type.
                .setResultType(bundle.getInt("resultType"))
                .setRecMode(bundle.getInt("recMode"))
                // Set result monitoring
                .setOnBcrResultCallback(callback).build();

        // Set Method Call Handler for pause and resume actions of remote view.
        if (remoteViewChannel != null) {
            RemoteViewHandler remoteViewHandler = new RemoteViewHandler(remoteView, flashButton, mHMSLogger);
            remoteViewChannel.setMethodCallHandler(remoteViewHandler);
        }

        mHMSLogger.startMethodExecutionTimer("CustomizedViewActivity.customizedView");

        remoteView.onCreate(savedInstanceState);
        FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.MATCH_PARENT);
        frameLayout.addView(remoteView, params);

        addMainView(mScanRect);

    }

    private CustomView.OnBcrResultCallback callback = new CustomView.OnBcrResultCallback() {
        @Override
        public void onBcrResult(MLBcrCaptureResult idCardResult) {
            Intent intent = new Intent();
            Bitmap originalBitmap = idCardResult.getOriginalBitmap();
            originalBitmap = Bitmap.createScaledBitmap(originalBitmap, originalBitmap.getWidth() / 2,
                    originalBitmap.getHeight() / 2, true);
            Bitmap numberBitmap = idCardResult.getNumberBitmap();
            numberBitmap = Bitmap.createScaledBitmap(numberBitmap, numberBitmap.getWidth() / 2,
                    numberBitmap.getHeight() / 2, true);
            // Because the set mode is MLBcrCaptureConfig.RESULT_SIMPLE, only the
            // corresponding data is returned
            intent.putExtra("originalBitmap", originalBitmap);
            intent.putExtra("numberBitmap", numberBitmap);
            intent.putExtra("number", idCardResult.getNumber());
            intent.putExtra("expire", idCardResult.getExpire());
            intent.putExtra("issuer", idCardResult.getIssuer());
            intent.putExtra("organization", idCardResult.getOrganization());
            setResult(Activity.RESULT_OK, intent);
            finish();
        }
    };

    private void initView() {
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.activity_custom);
        frameLayout = findViewById(R.id.rim);
        lightLayout = findViewById(R.id.light_layout);
        flashButton = findViewById(R.id.imageButton2);
        titleLayout = findViewById(R.id.title_layout);
        title = findViewById(R.id.title);

        if (bundle.getBoolean("isTitleAvailable")) {
            titleLayout.setVisibility(View.VISIBLE);
        } else {
            titleLayout.setVisibility(View.GONE);
        }

        if (bundle.containsKey("title")) {
            title.setText(bundle.getString("title"));
        }

        if (bundle.getBoolean("isFlashAvailable")) {
            lightLayout.setVisibility(View.VISIBLE);
            setFlashOperation();
        } else {
            lightLayout.setVisibility(View.GONE);
        }
        setBackOperation();
        setRectFactors();
    }

    private void setRectFactors() {
        if (bundle.containsKey("widthFactor")) {
            scanFrameWidthFactor = bundle.getFloat("widthFactor");
        }
        if (bundle.containsKey("heightFactor")) {
            scanFrameHeightFactor = bundle.getFloat("heightFactor");
        }
    }

    private void setBackOperation() {
        ImageView backButton = findViewById(R.id.back_img);
        backButton.setOnClickListener(v -> CustomizedViewActivity.this.finish());
    }

    /**
     * Get real screen size information
     *
     * @return Point
     */
    private Point getRealScreenSize() {
        int heightPixels = 0;
        int widthPixels = 0;
        Point point = null;
        WindowManager manager = (WindowManager) this.getSystemService(Context.WINDOW_SERVICE);

        if (manager != null) {
            Display d = manager.getDefaultDisplay();
            DisplayMetrics metrics = new DisplayMetrics();
            d.getMetrics(metrics);
            heightPixels = metrics.heightPixels;
            widthPixels = metrics.widthPixels;
            Log.i(TAG, "heightPixels=" + heightPixels + " widthPixels=" + widthPixels);

            if (Build.VERSION.SDK_INT >= 14 && Build.VERSION.SDK_INT < 17) {
                try {
                    heightPixels = (Integer) Display.class.getMethod("getRawHeight").invoke(d);
                    widthPixels = (Integer) Display.class.getMethod("getRawWidth").invoke(d);
                    Log.i(TAG, "2 heightPixels=" + heightPixels + " widthPixels=" + widthPixels);
                } catch (IllegalArgumentException e) {
                    Log.w(TAG, "getRealScreenSize exception");
                } catch (IllegalAccessException e) {
                    Log.w(TAG, "getRealScreenSize exception");
                } catch (InvocationTargetException e) {
                    Log.w(TAG, "getRealScreenSize exception");
                } catch (NoSuchMethodException e) {
                    Log.w(TAG, "getRealScreenSize exception");
                }
            } else if (Build.VERSION.SDK_INT >= 17) {
                Point realSize = new Point();
                try {
                    Display.class.getMethod("getRealSize", Point.class).invoke(d, realSize);
                    heightPixels = realSize.y;
                    widthPixels = realSize.x;
                    Log.i(TAG, "3 heightPixels=" + heightPixels + " widthPixels=" + widthPixels);
                } catch (IllegalArgumentException e) {
                    Log.w(TAG, "getRealScreenSize exception");
                } catch (IllegalAccessException e) {
                    Log.w(TAG, "getRealScreenSize exception");
                } catch (InvocationTargetException e) {
                    Log.w(TAG, "getRealScreenSize exception");
                } catch (NoSuchMethodException e) {
                    Log.w(TAG, "getRealScreenSize exception");
                }
            }
        }
        Log.i(TAG, "getRealScreenSize widthPixels=" + widthPixels + " heightPixels=" + heightPixels);
        point = new Point(widthPixels, heightPixels);
        return point;
    }

    private Rect createScanRect(int screenWidth, int screenHeight) {
        final float heightFactor = scanFrameHeightFactor;
        final float mCardScale = scanFrameWidthFactor;
        int width = Math.round(screenWidth * heightFactor);
        int height = Math.round((float) width * mCardScale);
        int leftOffset = (screenWidth - width) / 2;
        int topOffset = (int) (screenHeight * TOP_OFFSET_RATIO) - height / 2;
        Log.i(TAG, "screenWidth=" + screenWidth + " screenHeight=" + screenHeight + "  rect width=" + width
                + " leftOffset " + leftOffset + " topOffset " + topOffset);
        return new Rect(leftOffset, topOffset, leftOffset + width, topOffset + height);
    }

    private Rect createScanRectFromCamera() {
        Point point = getRealScreenSize();
        int screenWidth = point.x;
        int screenHeight = point.y;
        return createScanRect(screenWidth, screenHeight);
    }

    private void setFlashOperation() {
        lightLayout.setOnClickListener(v -> {
            if (remoteView.getLightStatus()) {
                remoteView.switchLight();
                flashButton.setImageResource(img[1]);
            } else {
                remoteView.switchLight();
                flashButton.setImageResource(img[0]);
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
        Window window = getWindow();
        View decorView = window.getDecorView();
        int option = View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION;
        decorView.setSystemUiVisibility(option);
        if (Build.VERSION.SDK_INT >= 21) {
            window.setStatusBarColor(Color.TRANSPARENT);
            window.setNavigationBarColor(Color.TRANSPARENT);
        }
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

    private void addMainView(Rect frameRect) {
        this.viewfinderView = new ViewfinderView(this, frameRect);
        this.viewfinderView.setLayoutParams(
                new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
        this.frameLayout.addView(this.viewfinderView);
    }

}
