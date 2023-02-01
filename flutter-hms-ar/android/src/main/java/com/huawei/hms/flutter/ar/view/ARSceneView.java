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

package com.huawei.hms.flutter.ar.view;

import static com.huawei.hms.flutter.ar.util.ParserUtil.getColorRGBA;
import static com.huawei.hms.flutter.ar.util.ParserUtil.getDefaultPath;
import static com.huawei.hms.flutter.ar.util.ParserUtil.intToFocusModeEnum;
import static com.huawei.hms.flutter.ar.util.ParserUtil.intToPlaneFindingModeEnum;
import static com.huawei.hms.flutter.ar.util.ParserUtil.intToPowerModeEnum;
import static com.huawei.hms.flutter.ar.util.ParserUtil.intToUpdateModeEnum;

import android.app.Activity;
import android.opengl.GLSurfaceView;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;

import androidx.annotation.NonNull;

import com.huawei.hiar.ARConfigBase;
import com.huawei.hiar.ARTrackable;
import com.huawei.hiar.common.FaceHealthCheckState;
import com.huawei.hiar.listener.FaceHealthCheckStateEvent;
import com.huawei.hiar.listener.FaceHealthServiceListener;
import com.huawei.hms.flutter.ar.constants.ARSceneType;
import com.huawei.hms.flutter.ar.constants.Channel;
import com.huawei.hms.flutter.ar.logger.HMSLogger;
import com.huawei.hms.plugin.ar.core.ARSetupFacade;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigAugmentedImage;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigBase;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigBasePointLine;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigBaseWorld;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigBody;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigFace;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigHand;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigSceneMesh;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigWorld;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigWorldBody;
import com.huawei.hms.plugin.ar.core.config.ColorRGBA;
import com.huawei.hms.plugin.ar.core.helper.CameraConfigListener;
import com.huawei.hms.plugin.ar.core.helper.CameraIntrinsicsListener;
import com.huawei.hms.plugin.ar.core.helper.MessageTextListener;
import com.huawei.hms.plugin.ar.core.helper.face.FaceHealthyResult;
import com.huawei.hms.plugin.ar.core.helper.sceneMesh.SceneMeshDrawFrameListener;
import com.huawei.hms.plugin.ar.core.model.AugmentedImageDBModel;
import com.huawei.hms.plugin.ar.core.serializer.CommonSerializer;
import com.huawei.hms.plugin.ar.core.serializer.PluginARTrackableSerializer;

import io.flutter.FlutterInjector;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.platform.PlatformView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.Arrays;
import java.util.EventObject;
import java.util.List;
import java.util.Map;

public class ARSceneView implements PlatformView, MethodCallHandler {
    private static final String TAG = ARSceneView.class.getSimpleName();

    private static final String TEXTURE_PATH = "texturePath";

    private static final String FILE_NAME = "fileName";

    private final ARSceneType arSceneType;

    private final MethodChannel methodChannel;

    private GLSurfaceView glSurfaceView;

    private ARSetupFacade arSetupFacade;

    private final HMSLogger logger;

    private View healthView;

    private final Activity activity;

    private boolean enableHealthDevice;

    public ARSceneView(ARSceneType sceneType, BinaryMessenger messenger, Activity act, int id, JSONObject sceneConfig) {
        methodChannel = new MethodChannel(messenger, Channel.AR_ENGINE_SCENE + id);
        methodChannel.setMethodCallHandler(this);
        this.activity = act;
        initView(sceneConfig);
        arSceneType = sceneType;
        logger = HMSLogger.getInstance(act);
        startSceneWithConfig(arSceneType, sceneConfig);
        arSetupFacade.setListener(this::sendResultOnUIThread);
        arSetupFacade.setFaceHealthListener(setFaceHealthServiceListener());
        arSetupFacade.setFaceHealthResultListener(setFaceHealthResultListener());
        arSetupFacade.setMessageDataListener(setMessageTextListener());
        arSetupFacade.setCameraConfigListener(setCameraConfigListener());
        arSetupFacade.setCameraIntrinsicsListener(setCameraIntrinsicsListener());
        arSetupFacade.setSceneMeshListener(setSceneMeshDrawFrameListener());
    }

    private void initView(JSONObject sceneConfig) {
        enableHealthDevice = sceneConfig.optBoolean("enableHealthDevice");
        if (enableHealthDevice) {
            healthView = LayoutInflater.from(activity.getApplicationContext())
                .inflate(getResourceId("health", "layout"), null);
            arSetupFacade = new ARSetupFacade(activity, healthView);
        } else {
            glSurfaceView = new GLSurfaceView(activity.getApplicationContext());
            arSetupFacade = new ARSetupFacade(activity, glSurfaceView);
        }
    }

    private int getResourceId(String name, String defType) {
        return activity.getApplicationContext()
            .getResources()
            .getIdentifier(name, defType, activity.getApplicationContext().getPackageName());
    }

    private static void parseBaseWorldConfig(JSONObject sceneConfig, ARPluginConfigBaseWorld baseWorldConfig) {
        try {
            String objPath = getDefaultPath(sceneConfig, "objPath");
            String texturePath = getDefaultPath(sceneConfig, TEXTURE_PATH);
            boolean drawLabel = sceneConfig.getBoolean("drawLabel");
            String imageOther = getDefaultPath(sceneConfig, "imageOther");
            String imageWall = getDefaultPath(sceneConfig, "imageWall");
            String imageFloor = getDefaultPath(sceneConfig, "imageFloor");
            String imageSeat = getDefaultPath(sceneConfig, "imageSeat");
            String imageTable = getDefaultPath(sceneConfig, "imageTable");
            String imageCeiling = getDefaultPath(sceneConfig, "imageCeiling");
            String imageBed = getDefaultPath(sceneConfig, "imageBed");
            String imageDoor = getDefaultPath(sceneConfig, "imageDoor");
            String imageWindow = getDefaultPath(sceneConfig, "imageWindow");
            String textOther = sceneConfig.getString("textOther");
            String textWall = sceneConfig.getString("textWall");
            String textFloor = sceneConfig.getString("textFloor");
            String textSeat = sceneConfig.getString("textSeat");
            String textTable = sceneConfig.getString("textTable");
            String textCeiling = sceneConfig.getString("textCeiling");
            String textBed = sceneConfig.getString("textBed");
            String textDoor = sceneConfig.getString("textDoor");
            String textWindow = sceneConfig.getString("textWindow");
            ColorRGBA colorOther = getColorRGBA(sceneConfig, "colorOther");
            ColorRGBA colorWall = getColorRGBA(sceneConfig, "colorWall");
            ColorRGBA colorFloor = getColorRGBA(sceneConfig, "colorFloor");
            ColorRGBA colorSeat = getColorRGBA(sceneConfig, "colorSeat");
            ColorRGBA colorTable = getColorRGBA(sceneConfig, "colorTable");
            ColorRGBA colorCeiling = getColorRGBA(sceneConfig, "colorCeiling");
            ColorRGBA colorBed = getColorRGBA(sceneConfig, "colorBed");
            ColorRGBA colorDoor = getColorRGBA(sceneConfig, "colorDoor");
            ColorRGBA colorWindow = getColorRGBA(sceneConfig, "colorWindow");
            int maxMapSize = sceneConfig.getInt("maxMapSize");

            baseWorldConfig.setObjPath(objPath);
            baseWorldConfig.setTexturePath(texturePath);
            baseWorldConfig.setLabelDraw(drawLabel);
            baseWorldConfig.setImageOther(imageOther);
            baseWorldConfig.setImageWall(imageWall);
            baseWorldConfig.setImageFloor(imageFloor);
            baseWorldConfig.setImageSeat(imageSeat);
            baseWorldConfig.setImageTable(imageTable);
            baseWorldConfig.setImageCeiling(imageCeiling);
            baseWorldConfig.setImageDoor(imageDoor);
            baseWorldConfig.setImageWindow(imageWindow);
            baseWorldConfig.setImageBed(imageBed);
            baseWorldConfig.setTextOther(textOther);
            baseWorldConfig.setTextWall(textWall);
            baseWorldConfig.setTextFloor(textFloor);
            baseWorldConfig.setTextSeat(textSeat);
            baseWorldConfig.setTextTable(textTable);
            baseWorldConfig.setTextCeiling(textCeiling);
            baseWorldConfig.setTextDoor(textDoor);
            baseWorldConfig.setTextWindow(textWindow);
            baseWorldConfig.setTextBed(textBed);
            baseWorldConfig.setColorOther(colorOther);
            baseWorldConfig.setColorWall(colorWall);
            baseWorldConfig.setColorFloor(colorFloor);
            baseWorldConfig.setColorSeat(colorSeat);
            baseWorldConfig.setColorTable(colorTable);
            baseWorldConfig.setColorCeiling(colorCeiling);
            baseWorldConfig.setColorDoor(colorDoor);
            baseWorldConfig.setColorWindow(colorWindow);
            baseWorldConfig.setColorBed(colorBed);
            baseWorldConfig.setMaxMapSize(maxMapSize);

            parsePointLineConfig(sceneConfig, baseWorldConfig);

        } catch (JSONException e) {
            Log.d(TAG, "Error while parsing ARWorld Scene Config. Error Message: " + e.getMessage(), e.getCause());
        }
    }

    private static void parsePointLineConfig(JSONObject sceneConfig, ARPluginConfigBasePointLine basePointLineConfig) {
        try {
            boolean drawLine = sceneConfig.getBoolean("drawLine");
            boolean drawPoint = sceneConfig.getBoolean("drawPoint");
            float lineWidth = (float) sceneConfig.getDouble("lineWidth");
            float pointSize = (float) sceneConfig.getDouble("pointSize");
            ColorRGBA lineColor = getColorRGBA(sceneConfig, "lineColor");
            ColorRGBA pointColor = getColorRGBA(sceneConfig, "pointColor");

            basePointLineConfig.setDrawLine(drawLine);
            basePointLineConfig.setDrawPoint(drawPoint);
            basePointLineConfig.setLineWidth(lineWidth);
            basePointLineConfig.setPointSize(pointSize);
            basePointLineConfig.setLineColor(lineColor);
            basePointLineConfig.setPointColor(pointColor);

            parseCommonConfig(sceneConfig, basePointLineConfig);

        } catch (JSONException e) {
            Log.d(TAG, "Error while parsing PointLine Config. Error Message: " + e.getMessage(), e.getCause());
        }
    }

    private static void parseCommonConfig(JSONObject sceneConfig, ARPluginConfigBase baseConfig) {
        try {
            if (sceneConfig.has("semantic")) {
                JSONObject semanticJson = sceneConfig.getJSONObject("semantic");
                int mode = semanticJson.getInt("mode");
                boolean showSemanticModeSupportedInfo = semanticJson.getBoolean("showSemanticModeSupportedInfo");
                baseConfig.setSemanticMode(mode);
                baseConfig.setShowSemanticSupportedInfo(showSemanticModeSupportedInfo);
            }

            int lightMode = sceneConfig.getInt("lightMode");
            int focusMode = sceneConfig.getInt("focusMode");
            int powerMode = sceneConfig.getInt("powerMode");
            int updateMode = sceneConfig.getInt("updateMode");

            baseConfig.setLightMode(lightMode);
            baseConfig.setFocusMode(intToFocusModeEnum(focusMode));
            baseConfig.setPowerMode(intToPowerModeEnum(powerMode));
            baseConfig.setUpdateMode(intToUpdateModeEnum(updateMode));

        } catch (JSONException e) {
            Log.d(TAG, "Error while parsing Common Config. Error Message: " + e.getMessage(), e.getCause());
        }
    }

    public static List<AugmentedImageDBModel> toAugmentedImageDBModelList(JSONArray paramsAI) {
        AugmentedImageDBModel[] array = new AugmentedImageDBModel[paramsAI.length()];
        for (int i = 0; i < paramsAI.length(); i++) {
            JSONObject item = paramsAI.optJSONObject(i);
            AugmentedImageDBModel augmentedImageDBModel = new AugmentedImageDBModel();
            if (item.has("imgFileFromAsset")) {
                String imgFileFromAsset = getDefaultPath(item, "imgFileFromAsset");
                augmentedImageDBModel.setImgFileFromAsset(imgFileFromAsset);
            }
            if (item.has("widthInMeters")) {
                augmentedImageDBModel.setWidthInMeters(item.optInt("widthInMeters"));
            }
            if (item.has("imgName")) {
                augmentedImageDBModel.setImgName(item.optString("imgName"));
            }
            array[i] = augmentedImageDBModel;
        }
        return Arrays.asList(array);
    }

    private void startSceneWithConfig(ARSceneType arSceneType, JSONObject sceneConfig) {
        switch (arSceneType) {
            case HAND:
                logger.startMethodExecutionTimer("StartARHandScene");
                arSetupFacade.startHand(parseARHandPluginConfig(sceneConfig));
                logger.sendSingleEvent("StartARHandScene");
                break;
            case FACE:
                boolean enableHealthDevice = sceneConfig.optBoolean("enableHealthDevice");
                logger.startMethodExecutionTimer("StartARFaceScene");
                arSetupFacade.startFace(parseARFacePluginConfig(sceneConfig));
                logger.sendSingleEvent("StartARFaceScene");
                if (enableHealthDevice) {
                    arSetupFacade.setEnableItem(ARConfigBase.ENABLE_HEALTH_DEVICE);
                }
                break;
            case BODY:
                logger.startMethodExecutionTimer("StartARBodyScene");
                arSetupFacade.startBody(parseARBodyPluginConfig(sceneConfig));
                logger.sendSingleEvent("StartARBodyScene");
                break;
            case CLOUD3D_OBJECT:
                logger.startMethodExecutionTimer("StartCloud3DObjectScene");
                String fileName = getDefaultPath(sceneConfig, FILE_NAME);
                arSetupFacade.startCloud3DObject(fileName);
                logger.sendSingleEvent("StartCloud3DObjectScene");
                break;
            case AUGMENTED_IMAGE:
                logger.startMethodExecutionTimer("StartAugmentedImageScene");
                arSetupFacade.startAugmentedImage(parseARAugmentedImagePluginConfig(sceneConfig));
                logger.sendSingleEvent("StartAugmentedImageScene");
                break;
            case WORLD_BODY:
                logger.startMethodExecutionTimer("StartWorldBodyScene");
                arSetupFacade.startWorldBody(parseARWorldBodyPluginConfig(sceneConfig));
                logger.sendSingleEvent("StartWorldBodyScene");
                break;
            case SCENE_MESH:
                logger.startMethodExecutionTimer("StartSceneMeshScene");
                arSetupFacade.startSceneMesh(parseARSceneMeshPluginConfig(sceneConfig));
                logger.sendSingleEvent("StartSceneMeshScene");
                break;
            default:
                logger.startMethodExecutionTimer("StartARWorldScene");
                arSetupFacade.startWorld(parseARWorldPluginConfig(sceneConfig));
                logger.sendSingleEvent("StartARWorldScene");
                break;
        }
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("dispose")) {
            dispose();
        }
    }

    @Override
    public View getView() {
        if (enableHealthDevice) {
            return healthView;
        } else {
            return glSurfaceView;
        }
    }

    @Override
    public void dispose() {
        arSetupFacade.stopTrackingSession();
    }

    private void sendResultOnUIThread(final List<ARTrackable> arTrackableList) {
        new Handler(Looper.getMainLooper()).post(() -> {
            List<Map<String, Object>> serializedTrackables = PluginARTrackableSerializer.serialize(arTrackableList);
            for (Map<String, Object> arTrackableMap : serializedTrackables) {
                methodChannel.invokeMethod(callbackMethodName(arSceneType), new JSONObject(arTrackableMap).toString());
            }
        });
    }

    private SceneMeshDrawFrameListener setSceneMeshDrawFrameListener() {
        return arSceneMesh -> new Handler(Looper.getMainLooper()).post(() -> {
            Map<String, Object> jsonMap = CommonSerializer.arSceneMeshToMap(arSceneMesh);
            methodChannel.invokeMethod(callbackMethodName(arSceneType), new JSONObject(jsonMap).toString());
        });
    }

    private String callbackMethodName(ARSceneType arSceneType) {
        switch (arSceneType) {
            case HAND:
                return "onDetectTrackable#Hand";
            case FACE:
                return "onDetectTrackable#Face";
            case BODY:
                return "onDetectTrackable#Body";
            case CLOUD3D_OBJECT:
                return "onDetectTrackable#Cloud3DObject";
            case AUGMENTED_IMAGE:
                return "onDetectTrackable#AugmentedImage";
            case WORLD_BODY:
                return "onDetectTrackable#WorldBody";
            case SCENE_MESH:
                return "onDetectTrackable#SceneMesh";
            default:
                return "onDetectTrackable#Plane";
        }
    }

    private ARPluginConfigHand parseARHandPluginConfig(JSONObject sceneConfig) {
        try {
            ARPluginConfigHand handSceneConfig = new ARPluginConfigHand();
            ColorRGBA boxColor = getColorRGBA(sceneConfig, "boxColor");
            boolean drawBox = sceneConfig.getBoolean("enableBoundingBox");
            float lineWidth = (float) sceneConfig.getDouble("lineWidth");
            float lineWidthSkeleton = (float) sceneConfig.getDouble("lineWidthSkeleton");
            handSceneConfig.setBoxColor(boxColor);
            handSceneConfig.setDrawBox(drawBox);
            handSceneConfig.setLineWidth(lineWidth);
            handSceneConfig.setLineWidthSkeleton(lineWidthSkeleton);
            if (sceneConfig.getInt("cameraLensFacing") == ARConfigBase.CameraLensFacing.REAR.ordinal()) {
                handSceneConfig.setCameraLensFacing(ARConfigBase.CameraLensFacing.REAR);
            }
            parsePointLineConfig(sceneConfig, handSceneConfig);
            return handSceneConfig;
        } catch (JSONException e) {
            Log.d(TAG, "Error while parsing ARHand Scene Config. Error Message: " + e.getMessage(), e.getCause());
        }
        return new ARPluginConfigHand();
    }

    private ARPluginConfigFace parseARFacePluginConfig(JSONObject sceneConfig) {
        try {
            ARPluginConfigFace faceSceneConfig = new ARPluginConfigFace();
            ColorRGBA depthColor = getColorRGBA(sceneConfig, "depthColor");
            float pointSize = (float) sceneConfig.getDouble("pointSize");
            if (sceneConfig.has(TEXTURE_PATH)) {
                String texturePath = FlutterInjector.instance()
                    .flutterLoader()
                    .getLookupKeyForAsset(sceneConfig.getString(TEXTURE_PATH));
                faceSceneConfig.setTexturePath(texturePath);
            } else {
                String texturePath = "texture.png";
                faceSceneConfig.setTexturePath(texturePath);
            }
            boolean drawFace = sceneConfig.getBoolean("drawFace");
            boolean enableHealthDevice = sceneConfig.getBoolean("enableHealthDevice");
            boolean multiFace = sceneConfig.getBoolean("multiFace");

            faceSceneConfig.setDepthColor(depthColor);
            faceSceneConfig.setPointSize(pointSize);
            faceSceneConfig.setDrawFace(drawFace);
            faceSceneConfig.setHealth(enableHealthDevice);
            faceSceneConfig.setMultiFace(multiFace);

            if (sceneConfig.getInt("cameraLensFacing") == ARConfigBase.CameraLensFacing.REAR.ordinal()) {
                faceSceneConfig.setCameraLensFacing(ARConfigBase.CameraLensFacing.REAR);
            }

            parseCommonConfig(sceneConfig, faceSceneConfig);
            return faceSceneConfig;
        } catch (JSONException e) {
            Log.d(TAG, "Error while parsing ARFace Scene Config. Error Message: " + e.getMessage(), e.getCause());
        }
        return new ARPluginConfigFace();
    }

    private ARPluginConfigBody parseARBodyPluginConfig(JSONObject sceneConfig) {
        ARPluginConfigBody bodySceneConfig = new ARPluginConfigBody();
        if (sceneConfig == null) {
            return bodySceneConfig;
        }
        parsePointLineConfig(sceneConfig, bodySceneConfig);
        return bodySceneConfig;
    }

    private ARPluginConfigWorld parseARWorldPluginConfig(JSONObject sceneConfig) {
        try {
            ARPluginConfigWorld worldSceneConfig = new ARPluginConfigWorld();
            if (sceneConfig.has("augmentedImage")) {
                JSONObject jsonObject = sceneConfig.optJSONObject("augmentedImage");
                JSONArray jsonArray = new JSONArray();
                jsonArray.put(jsonObject);
                worldSceneConfig.setAugmentedImageDBModels(toAugmentedImageDBModelList(jsonArray));
            }
            int planeFindingMode = sceneConfig.getInt("planeFindingMode");

            worldSceneConfig.setPlaneFindingMode(intToPlaneFindingModeEnum(planeFindingMode));
            parseBaseWorldConfig(sceneConfig, worldSceneConfig);
            return worldSceneConfig;
        } catch (JSONException e) {
            Log.d(TAG, "Error while parsing ARWorld Scene Config. Error Message: " + e.getMessage(), e.getCause());
        }
        return new ARPluginConfigWorld();
    }

    private ARPluginConfigAugmentedImage parseARAugmentedImagePluginConfig(JSONObject sceneConfig) {
        ARPluginConfigAugmentedImage augmentedImageSceneConfig = new ARPluginConfigAugmentedImage();
        if (sceneConfig == null) {
            return augmentedImageSceneConfig;
        }

        JSONObject jsonObject = sceneConfig.optJSONObject("augmentedImage");
        JSONArray jsonArray = new JSONArray();
        jsonArray.put(jsonObject);

        augmentedImageSceneConfig.setAugmentedImageDBModels(toAugmentedImageDBModelList(jsonArray));
        parsePointLineConfig(sceneConfig, augmentedImageSceneConfig);

        return augmentedImageSceneConfig;
    }

    private ARPluginConfigWorldBody parseARWorldBodyPluginConfig(JSONObject sceneConfig) {
        try {
            ARPluginConfigWorldBody worldBodyConfig = new ARPluginConfigWorldBody();
            if (sceneConfig.has("augmentedImage")) {
                JSONObject jsonObject = sceneConfig.optJSONObject("augmentedImage");
                JSONArray jsonArray = new JSONArray();
                jsonArray.put(jsonObject);
                worldBodyConfig.setAugmentedImageDBModels(toAugmentedImageDBModelList(jsonArray));
            }
            int planeFindingMode = sceneConfig.getInt("planeFindingMode");

            worldBodyConfig.setPlaneFindingMode(intToPlaneFindingModeEnum(planeFindingMode));
            parseBaseWorldConfig(sceneConfig, worldBodyConfig);
            return worldBodyConfig;
        } catch (JSONException e) {
            Log.d(TAG, "Error while parsing ARWorldBody Scene Config. Error Message: " + e.getMessage(), e.getCause());
        }
        return new ARPluginConfigWorldBody();
    }

    private ARPluginConfigSceneMesh parseARSceneMeshPluginConfig(JSONObject sceneConfig) {
        try {
            ARPluginConfigSceneMesh sceneMeshSceneConfig = new ARPluginConfigSceneMesh();
            String objPath = getDefaultPath(sceneConfig, "objPath");
            sceneMeshSceneConfig.setObjPath(objPath);

            if (sceneConfig.has(TEXTURE_PATH)) {
                String texturePath = FlutterInjector.instance()
                    .flutterLoader()
                    .getLookupKeyForAsset(sceneConfig.getString(TEXTURE_PATH));
                sceneMeshSceneConfig.setTexturePath(texturePath);
            } else {
                String texturePath = "texture.png";
                sceneMeshSceneConfig.setTexturePath(texturePath);
            }

            parseCommonConfig(sceneConfig, sceneMeshSceneConfig);
            return sceneMeshSceneConfig;
        } catch (JSONException e) {
            Log.d(TAG, "Error while parsing ARSceneMesh Scene Config. Error Message: " + e.getMessage(), e.getCause());
        }
        return new ARPluginConfigSceneMesh();
    }

    private FaceHealthyResult setFaceHealthResultListener() {
        return result -> new Handler(Looper.getMainLooper()).post(() ->
            methodChannel.invokeMethod("handleResult", result)
        );
    }

    private MessageTextListener setMessageTextListener() {
        return text -> new Handler(Looper.getMainLooper()).post(() -> {
            try {
                JSONObject json = new JSONObject().put("text", text);
                methodChannel.invokeMethod("handleMessageData", json.toString());
            } catch (JSONException e) {
                Log.d(TAG, e.getLocalizedMessage());
            }
        });
    }

    private FaceHealthServiceListener setFaceHealthServiceListener() {
        return new FaceHealthServiceListener() {
            @Override
            public void handleEvent(EventObject eventObject) {
                if (!(eventObject instanceof FaceHealthCheckStateEvent)) {
                    return;
                }
                final FaceHealthCheckState faceHealthCheckState
                    = ((FaceHealthCheckStateEvent) eventObject).getFaceHealthCheckState();

                activity.runOnUiThread(() ->
                    arSetupFacade.healthCheckStatusTextView.setText(faceHealthCheckState.toString()));
            }

            @Override
            public void handleProcessProgressEvent(final int progress) {
                arSetupFacade.setHealthCheckProgress(progress);
                activity.runOnUiThread(() -> setProgressTips(progress));
            }
        };
    }

    private void setProgressTips(int progress) {
        String progressTips = "processing";
        if (progress >= 100) {
            progressTips = "finish";
        }
        arSetupFacade.progressTips.setText(progressTips);
        arSetupFacade.healthProgressBar.setProgress(progress);
    }

    private CameraConfigListener setCameraConfigListener() {
        return cameraConfig -> new Handler(Looper.getMainLooper()).post(() -> {
            Map<String, Object> jsonMap = CommonSerializer.arCameraConfigToMap(cameraConfig);
            methodChannel.invokeMethod("handleCameraConfigData", new JSONObject(jsonMap).toString());
        });
    }

    private CameraIntrinsicsListener setCameraIntrinsicsListener() {
        return cameraIntrinsics -> new Handler(Looper.getMainLooper()).post(() -> {
            Map<String, Object> jsonMap = CommonSerializer.arCameraIntrinsicsToMap(cameraIntrinsics);
            methodChannel.invokeMethod("handleCameraIntrinsicsData", new JSONObject(jsonMap).toString());
        });
    }
}
