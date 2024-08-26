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

package com.huawei.hms.flutter.mlbody.handlers;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Rect;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.util.TypedValue;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import android.annotation.SuppressLint;
import androidx.annotation.RequiresApi;

import com.huawei.hms.flutter.mlbody.R;
import com.huawei.hms.mlsdk.interactiveliveness.MLInteractiveLivenessCaptureResult;
import com.huawei.hms.mlsdk.interactiveliveness.MLInteractiveLivenessDetectView;
import com.huawei.hms.mlsdk.interactiveliveness.OnMLInteractiveLivenessDetectCallback;
import com.huawei.hms.mlsdk.interactiveliveness.action.InteractiveLivenessStateCode;
import com.huawei.hms.mlsdk.interactiveliveness.action.MLInteractiveLivenessConfig;

import java.util.HashMap;

public class InteractiveLivenessCustomDetectionActivity extends Activity {

    private MLInteractiveLivenessDetectView mlInteractiveLivenessDetectView;

    private FrameLayout mPreviewContainer;

    private static final String TAG = InteractiveLivenessCustomDetectionActivity.class.getSimpleName();

    private RelativeLayout mTextContainer;

    private Intent intent;

    private Context mContext;

    private boolean defaultConfig = false;
    private Bundle bundle;

    private ImageView imgBack;

    String failResult = "";

    boolean autoSizeText = false;
    private MLInteractiveLivenessConfig interactiveLivenessConfig;

    int minTextSize = 3;

    private float textSize;

    int maxTextSize = 24;

    int textMargin = 900;

    int granularity = 0;

    private TextView statusCode;

    TextView tips;

    String title = "";

    boolean showStatusCode;

    boolean isStatusCodes = true;

    public static final int DETECT_FACE_TIME_OUT = 11404;
    private HashMap<Integer, String> actionMap = new HashMap<>();

    private HashMap<Integer, String> statusCodeList = new HashMap<>();

    @RequiresApi(api = Build.VERSION_CODES.O)
    @SuppressLint({ "WrongViewCast", "UseCompatLoadingForDrawables", "MissingInflatedId" })

    @Override
    public void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        mContext = this.getApplicationContext();
        intent = getIntent();
        initStatusCodeList();
        try {
            bundle = intent.getExtras();
        } catch (Exception e) {
            Log.i("Customized-Exception", e.getMessage());
        }

        setContentView(R.layout.activity_liveness_custom_detection);
        mPreviewContainer = findViewById(R.id.surface_layout);

        statusCode = findViewById(R.id.status_code);
        tips = findViewById(R.id.tips);

        autoSizeText = bundle.getBoolean("autoSizeText");
        minTextSize = bundle.getInt("minTextSize");
        maxTextSize = bundle.getInt("maxTextSize");
        textMargin = bundle.getInt("textMargin");
        textSize = bundle.getFloat("textSize");
        granularity = bundle.getInt("granularity");
        title = bundle.getString("title");
        showStatusCode = bundle.getBoolean("showStatusCodes");

        imgBack = findViewById(R.id.img_back);
        TextView imgBackHeader = findViewById(R.id.img_back_title);
        applyStyleAutoSize(statusCode);
        applyStyleAutoSize(tips);

        if (showStatusCode) {
            statusCode.setVisibility(View.VISIBLE);
        } else {
            statusCode.setVisibility(View.GONE);
        }

        ImageView scanBg = new ImageView(this);
        ViewGroup.LayoutParams layoutParams = new FrameLayout.LayoutParams(
                bundle.getInt("cameraFrameRight") - bundle.getInt("cameraFrameLeft"),
                bundle.getInt("cameraFrameBottom") - bundle.getInt("cameraFrameTop"));
        scanBg.setLayoutParams(layoutParams);
        scanBg.setY(bundle.getInt("faceFrameTop") - 25);
        scanBg.setX(bundle.getInt("faceFrameLeft"));
        scanBg.setImageDrawable(getDrawable(R.drawable.liveness_detection_frame_bold));

        imgBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
        mTextContainer = findViewById(R.id.bg);

        imgBackHeader.setText(title);

        tips.setTextColor(bundle.getInt("textColor"));
        mTextContainer.setY(textMargin);

        if (bundle.getBoolean("showStatusCodes")) {
            statusCode.setVisibility(View.VISIBLE);
        } else {
            statusCode.setVisibility(View.GONE);
        }

        if (autoSizeText) {

            tips.setAutoSizeTextTypeUniformWithConfiguration(minTextSize, maxTextSize, granularity,
                    TypedValue.COMPLEX_UNIT_DIP);
        } else {

            tips.setTextSize(textSize);
        }

        actionMap = (HashMap<Integer, String>) getIntent().getSerializableExtra("actionArray");
        int[] actionArray = new int[actionMap.size()];

        if (actionArray != null && actionArray.length != 0) {
            int index = 0;
            for (Integer key : actionMap.keySet()) {
                actionArray[index++] = key;
            }

            interactiveLivenessConfig = new MLInteractiveLivenessConfig.Builder()
                    .setActionArray(actionArray, bundle.getInt("num"),
                            bundle.getBoolean("isRandom"))
                    .build();

        } else {
            defaultConfig = true;
            interactiveLivenessConfig = new MLInteractiveLivenessConfig.Builder().build();
        }

        statusCodeList = (HashMap<Integer, String>) getIntent().getSerializableExtra("statusCodes");

        mlInteractiveLivenessDetectView = new MLInteractiveLivenessDetectView.Builder().setContext(this)
                // Set the position of the camera video stream. (The coordinates of the upper
                // left vertex and lower right vertex are determined based on the preview view.)
                .setFrameRect(
                        new Rect(bundle.getInt("cameraFrameLeft"), bundle.getInt("cameraFrameTop"),
                                bundle.getInt("cameraFrameRight"),
                                bundle.getInt("cameraFrameBottom")))
                // Set the configurations for interactive biometric verification.
                .setActionConfig(interactiveLivenessConfig)
                // Set the position of the face frame relative to the camera preview view. The
                // coordinates of the upper left vertex and lower right vertex are determined
                // based on a 640 x 480 px image. You are advised to ensure the face frame
                // dimensions comply with the ratio of a real face. The face frame is used to
                // check whether a face is too close to or far from the camera, and whether a
                // face deviates from the camera view.
                .setFaceRect(new Rect(bundle.getInt("faceFrameLeft"), bundle.getInt("faceFrameTop"),
                        bundle.getInt("faceFrameRight"),
                        bundle.getInt("faceFrameBottom")))
                // Set the verification timeout interval. The recommended value is about 10,000
                // ms.
                .setDetectionTimeOut(bundle.getInt("detectionTimeOut"))
                .setDetectCallback(new OnMLInteractiveLivenessDetectCallback() {
                    @SuppressLint("SetTextI18n")
                    @Override
                    public void onCompleted(MLInteractiveLivenessCaptureResult result) {

                        if (!isStatusCodes) {
                            statusCode.setText(statusCodeList.get(result.getStateCode()));
                        }
                        switch (result.getStateCode()) {
                            // Processing logic when the verification is passed.
                            case InteractiveLivenessStateCode.ALL_ACTION_CORRECT:
                                tips.setText("success");
                                InteractiveLivenessCustomDetectionHandler.CUSTOM_CALLBACK.onSuccess(result);
                                finish();
                                break;
                            // Processing logic during verification.

                            case InteractiveLivenessStateCode.IN_PROGRESS:
                                // Processing logic during verification.
                                if (showStatusCode && isStatusCodes) {
                                    statusCode.setText(statusCodeList.get(2000));
                                }
                                switch (result.getActionType()) {
                                    case MLInteractiveLivenessConfig.SHAKE_DOWN_ACTION:
                                        if (defaultConfig) {
                                            tips.setText("Nod your head.");
                                        } else {
                                            tips.setText(actionMap.get(1));
                                        }
                                        break;
                                    case MLInteractiveLivenessConfig.OPEN_MOUTH_ACTION:
                                        if (defaultConfig) {
                                            tips.setText("Open your mouth. ");
                                        } else {
                                            tips.setText(actionMap.get(2));
                                        }
                                        break;
                                    case MLInteractiveLivenessConfig.EYE_CLOSE_ACTION:
                                        if (defaultConfig) {
                                            tips.setText("Blink. ");
                                        } else {
                                            tips.setText(actionMap.get(3));
                                        }
                                        break;
                                    case MLInteractiveLivenessConfig.SHAKE_LEFT_ACTION:
                                        if (defaultConfig) {
                                            tips.setText("Turn your head to the left. ");
                                        } else {
                                            tips.setText(actionMap.get(4));
                                        }
                                        break;
                                    case MLInteractiveLivenessConfig.SHAKE_RIGHT_ACTION:
                                        if (defaultConfig) {
                                            tips.setText("Turn your head to the right. ");
                                        } else {
                                            tips.setText(actionMap.get(5));
                                        }
                                        break;
                                    case MLInteractiveLivenessConfig.GAZED_ACTION:
                                        if (defaultConfig) {
                                            tips.setText("Stare at the screen. ");
                                        } else {
                                            tips.setText(actionMap.get(6));
                                        }
                                        break;
                                    default:
                                        break;
                                }
                                break;
                            case InteractiveLivenessStateCode.RESULT_TIME_OUT:
                                InteractiveLivenessCustomDetectionHandler.CUSTOM_CALLBACK
                                        .onFailure(DETECT_FACE_TIME_OUT);
                                finish();
                                break;

                            case InteractiveLivenessStateCode.FACE_ASPECT:
                                if (showStatusCode && isStatusCodes) {
                                    statusCode.setText(statusCodeList.get(1001));
                                }
                                break;
                            case InteractiveLivenessStateCode.NO_FACE:
                                if (showStatusCode && isStatusCodes) {
                                    statusCode.setText(statusCodeList.get(1002));
                                }
                                break;
                            case InteractiveLivenessStateCode.MULTI_FACES:
                                if (showStatusCode && isStatusCodes) {
                                    statusCode.setText(statusCodeList.get(1003));
                                }
                                break;
                            case InteractiveLivenessStateCode.PART_FACE:
                                if (showStatusCode && isStatusCodes) {
                                    statusCode.setText(statusCodeList.get(1004));
                                }
                                break;
                            case InteractiveLivenessStateCode.BIG_FACE:
                                if (showStatusCode && isStatusCodes) {
                                    statusCode.setText(statusCodeList.get(1005));
                                }
                                break;
                            case InteractiveLivenessStateCode.SMALL_FACE:
                                if (showStatusCode && isStatusCodes) {
                                    statusCode.setText(statusCodeList.get(1006));
                                }
                                break;
                            case InteractiveLivenessStateCode.WEAR_SUNGLASSES:
                                if (showStatusCode && isStatusCodes) {
                                    statusCode.setText(statusCodeList.get(1007));
                                }
                                break;
                            case InteractiveLivenessStateCode.WEAR_MASK:
                                if (showStatusCode && isStatusCodes) {
                                    statusCode.setText(statusCodeList.get(1008));
                                }
                                break;
                            case InteractiveLivenessStateCode.ACTION_MUTUALLY_EXCLUSIVE_ERROR:
                                if (showStatusCode && isStatusCodes) {
                                    statusCode.setText(statusCodeList.get(1009));
                                }
                                break;
                            case InteractiveLivenessStateCode.CONTINUITY_DETECTION_ERROR:
                                if (showStatusCode && isStatusCodes) {
                                    statusCode.setText(statusCodeList.get(1014));
                                }
                                break;
                            case InteractiveLivenessStateCode.DARK:
                                if (showStatusCode && isStatusCodes) {
                                    statusCode.setText(statusCodeList.get(1018));
                                }
                                break;
                            case InteractiveLivenessStateCode.BLUR:
                                if (showStatusCode && isStatusCodes) {
                                    statusCode.setText(statusCodeList.get(1019));
                                }
                                break;
                            case InteractiveLivenessStateCode.BACK_LIGHTING:
                                if (showStatusCode && isStatusCodes) {
                                    statusCode.setText(statusCodeList.get(1020));
                                }
                                break;
                            case InteractiveLivenessStateCode.BRIGHT:
                                if (showStatusCode && isStatusCodes) {
                                    statusCode.setText(statusCodeList.get(1021));
                                }
                                break;
                            case InteractiveLivenessStateCode.SPOOFING:
                                if (showStatusCode && isStatusCodes) {
                                    statusCode.setText(statusCodeList.get(2002));
                                }
                                break;
                            case InteractiveLivenessStateCode.LIVE_AND_ACTION_CORRECT:
                                if (showStatusCode && isStatusCodes) {
                                    statusCode.setText(statusCodeList.get(2003));
                                }
                                break;
                            case InteractiveLivenessStateCode.GUIDE_DETECTION_SUCCESS:
                                if (showStatusCode && isStatusCodes) {
                                    statusCode.setText(statusCodeList.get(2004));
                                }
                                break;
                            case InteractiveLivenessStateCode.INIT_FACE_RECTANGLE_ERROR:
                                if (showStatusCode && isStatusCodes) {
                                    statusCode.setText(statusCodeList.get(2007));
                                }
                                break;
                            case InteractiveLivenessStateCode.ERROR_RESULT_BEFORE:
                                if (showStatusCode && isStatusCodes) {
                                    statusCode.setText(statusCodeList.get(5020));
                                }
                                break;
                            default:
                                Log.e(TAG, String.valueOf(result.getStateCode()));
                                break;
                        }
                    }

                    @Override
                    public void onError(int errorCode) {
                        InteractiveLivenessCustomDetectionHandler.CUSTOM_CALLBACK
                                .onFailure(errorCode);
                    }
                })
                .build();
        mPreviewContainer.addView(mlInteractiveLivenessDetectView);
        mPreviewContainer.addView(scanBg, 1);
        mlInteractiveLivenessDetectView.onCreate(savedInstanceState);
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    void applyStyleAutoSize(TextView textView) {
        if (autoSizeText) {
            textView.setAutoSizeTextTypeUniformWithConfiguration(minTextSize, maxTextSize, granularity,
                    TypedValue.COMPLEX_UNIT_DIP);
        } else {
            textView.setTextSize(textSize);
        }
    }

    void initStatusCodeList() {
        statusCodeList.put(1001, "The face orientation is inconsistent with that of the phone.");
        statusCodeList.put(1002, "No face is detected.");
        statusCodeList.put(1003, "Multiple faces are detected.");
        statusCodeList.put(1004, "The face deviates from the center of the face frame.");
        statusCodeList.put(1005, "The face is too large.");
        statusCodeList.put(1006, "The face is too small.");
        statusCodeList.put(1007, "The face is blocked by the sunglasses.");
        statusCodeList.put(1008, "The face is blocked by the mask.");
        statusCodeList.put(1009, "The detected action is not the required one.");
        statusCodeList.put(1014, "The continuity detection fails.");
        statusCodeList.put(1018, "The light is dark.");
        statusCodeList.put(1019, "The image is blurry.");
        statusCodeList.put(1020, "The face is backlit.");
        statusCodeList.put(1021, "The light is bright.");
        statusCodeList.put(2000, "In progress");
        statusCodeList.put(2002, "The face does not belong to a real person. ");
        statusCodeList.put(2003, "Verification is performed, and the detected action is correct.");
        statusCodeList.put(2004, "Verification succeeded.");
        statusCodeList.put(2007, "The position of the face frame is not set before the algorithm is called.");
        statusCodeList.put(5020, "The previous detection ended when it was not complete.");
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        mlInteractiveLivenessDetectView.onDestroy();
    }

    @Override
    protected void onPause() {
        super.onPause();
        mlInteractiveLivenessDetectView.onPause();
    }

    @Override
    protected void onResume() {
        super.onResume();
        mlInteractiveLivenessDetectView.onResume();
    }

    @Override
    protected void onStart() {
        super.onStart();
        mlInteractiveLivenessDetectView.onStart();
    }

    @Override
    protected void onStop() {
        super.onStop();
        mlInteractiveLivenessDetectView.onStop();
    }
}
