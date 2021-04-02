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

package com.huawei.hms.flutter.ar.view;

import android.app.Activity;
import android.opengl.GLSurfaceView;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.View;

import androidx.annotation.NonNull;

import com.huawei.hiar.ARTrackable;
import com.huawei.hms.flutter.ar.constants.ARSceneType;
import com.huawei.hms.flutter.ar.constants.Channel;
import com.huawei.hms.flutter.ar.logger.HMSLogger;
import com.huawei.hms.flutter.ar.util.ParserUtil;
import com.huawei.hms.plugin.ar.core.ARSetupFacade;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigBody;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigFace;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigHand;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigWorld;
import com.huawei.hms.plugin.ar.core.config.ColorRGBA;
import com.huawei.hms.plugin.ar.core.serializer.PluginARTrackableSerializer;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.List;
import java.util.Map;

import io.flutter.embedding.engine.loader.FlutterLoader;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.platform.PlatformView;

public class ARSceneView implements PlatformView, MethodCallHandler {
    private static final String TAG = ARSceneView.class.getSimpleName();
    private static final String TEXTURE_PATH = "texturePath";

    private ARSceneType arSceneType;
    private MethodChannel methodChannel;
    private GLSurfaceView glSurfaceView;
    private ARSetupFacade arSetupFacade;
    private HMSLogger logger;

    public ARSceneView(ARSceneType sceneType, BinaryMessenger messenger, Activity act, int id, JSONObject sceneConfig) {
        methodChannel = new MethodChannel(messenger, Channel.AR_ENGINE_SCENE + id);
        methodChannel.setMethodCallHandler(this);
        glSurfaceView = new GLSurfaceView(act.getApplicationContext());
        arSetupFacade = new ARSetupFacade(act, glSurfaceView);
        arSceneType = sceneType;
        logger = HMSLogger.getInstance(act);
        startSceneWithConfig(arSceneType, sceneConfig);
        arSetupFacade.setListener(this::sendResultOnUIThread);
    }

    private void startSceneWithConfig(ARSceneType arSceneType, JSONObject sceneConfig) {
        switch (arSceneType) {
            case HAND:
                logger.startMethodExecutionTimer("StartARHandScene");
                arSetupFacade.startHand(parseARHandPluginConfig(sceneConfig));
                logger.sendSingleEvent("StartARHandScene");
                break;
            case FACE:
                logger.startMethodExecutionTimer("StartARFaceScene");
                arSetupFacade.startFace(parseARFacePluginConfig(sceneConfig));
                logger.sendSingleEvent("StartARFaceScene");
                break;
            case BODY:
                logger.startMethodExecutionTimer("StartARBodyScene");
                arSetupFacade.startBody(parseARBodyPluginConfig(sceneConfig));
                logger.sendSingleEvent("StartARBodyScene");
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
        return glSurfaceView;
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

    private String callbackMethodName(ARSceneType arSceneType) {
        switch (arSceneType) {
            case HAND:
                return "onDetectTrackable#Hand";
            case FACE:
                return "onDetectTrackable#Face";
            case BODY:
                return "onDetectTrackable#Body";
            default:
                return "onDetectTrackable#Plane";
        }
    }

    private ARPluginConfigHand parseARHandPluginConfig(JSONObject sceneConfig) {
        try {
            ARPluginConfigHand handSceneConfig = new ARPluginConfigHand();
            ColorRGBA boxColor = ParserUtil.getColorRGBA(sceneConfig, "boxColor");
            boolean drawBox = sceneConfig.getBoolean("enableBoundingBox");
            float lineWidth = sceneConfig.getInt("lineWidth");
            handSceneConfig.setBoxColor(boxColor);
            handSceneConfig.setDrawBox(drawBox);
            handSceneConfig.setLineWidth(lineWidth);
            return handSceneConfig;
        } catch (JSONException e) {
            Log.d(TAG, "Error while parsing ARHand Scene Config. Error Message: " + e.getMessage(), e.getCause());
        }
        return new ARPluginConfigHand();
    }

    private ARPluginConfigFace parseARFacePluginConfig(JSONObject sceneConfig) {
        try {
            ARPluginConfigFace faceSceneConfig = new ARPluginConfigFace();
            ColorRGBA depthColor = ParserUtil.getColorRGBA(sceneConfig, "depthColor");
            float pointSize = (float) sceneConfig.getDouble("pointSize");
            String texturePath = sceneConfig.getString(TEXTURE_PATH).equals("null")
                ? "texture.png"
                : FlutterLoader.getInstance().getLookupKeyForAsset(sceneConfig.getString(TEXTURE_PATH));
            boolean drawFace = sceneConfig.getBoolean("drawFace");
            faceSceneConfig.setDepthColor(depthColor);
            faceSceneConfig.setPointSize(pointSize);
            faceSceneConfig.setTexturePath(texturePath);
            faceSceneConfig.setDrawFace(drawFace);
            return faceSceneConfig;
        } catch (JSONException e) {
            Log.d(TAG, "Error while parsing ARFace Scene Config. Error Message: " + e.getMessage(), e.getCause());
        }
        return new ARPluginConfigFace();
    }

    private ARPluginConfigBody parseARBodyPluginConfig(JSONObject sceneConfig) {
        try {
            ARPluginConfigBody bodySceneConfig = new ARPluginConfigBody();
            boolean drawLine = sceneConfig.getBoolean("drawLine");
            boolean drawPoint = sceneConfig.getBoolean("drawPoint");
            float lineWidth = (float) sceneConfig.getDouble("lineWidth");
            float pointSize = (float) sceneConfig.getDouble("pointSize");
            ColorRGBA lineColor = ParserUtil.getColorRGBA(sceneConfig, "lineColor");
            ColorRGBA pointColor = ParserUtil.getColorRGBA(sceneConfig, "pointColor");
            bodySceneConfig.setDrawLine(drawLine);
            bodySceneConfig.setDrawPoint(drawPoint);
            bodySceneConfig.setLineWidth(lineWidth);
            bodySceneConfig.setPointSize(pointSize);
            bodySceneConfig.setLineColor(lineColor);
            bodySceneConfig.setPointColor(pointColor);
            return bodySceneConfig;
        } catch (JSONException e) {
            Log.d(TAG, "Error while parsing ARBody Scene Config. Error Message: " + e.getMessage(), e.getCause());
        }
        return new ARPluginConfigBody();
    }

    private ARPluginConfigWorld parseARWorldPluginConfig(JSONObject sceneConfig) {
        try {
            ARPluginConfigWorld worldSceneConfig = new ARPluginConfigWorld();
            String objPath = ParserUtil.getDefaultPath(sceneConfig, "objPath");
            String texturePath = ParserUtil.getDefaultPath(sceneConfig, TEXTURE_PATH);
            boolean drawLabel = sceneConfig.getBoolean("drawLabel");
            String imageOther = ParserUtil.getDefaultPath(sceneConfig, "imageOther");
            String imageWall = ParserUtil.getDefaultPath(sceneConfig, "imageWall");
            String imageFloor = ParserUtil.getDefaultPath(sceneConfig, "imageFloor");
            String imageSeat = ParserUtil.getDefaultPath(sceneConfig, "imageSeat");
            String imageTable = ParserUtil.getDefaultPath(sceneConfig, "imageTable");
            String imageCeiling = ParserUtil.getDefaultPath(sceneConfig, "imageCeiling");
            String textOther = sceneConfig.getString("textOther");
            String textWall = sceneConfig.getString("textWall");
            String textFloor = sceneConfig.getString("textFloor");
            String textSeat = sceneConfig.getString("textSeat");
            String textTable = sceneConfig.getString("textTable");
            String textCeiling = sceneConfig.getString("textCeiling");
            ColorRGBA colorOther = ParserUtil.getColorRGBA(sceneConfig, "colorOther");
            ColorRGBA colorWall = ParserUtil.getColorRGBA(sceneConfig, "colorWall");
            ColorRGBA colorFloor = ParserUtil.getColorRGBA(sceneConfig, "colorFloor");
            ColorRGBA colorSeat = ParserUtil.getColorRGBA(sceneConfig, "colorSeat");
            ColorRGBA colorTable = ParserUtil.getColorRGBA(sceneConfig, "colorTable");
            ColorRGBA colorCeiling = ParserUtil.getColorRGBA(sceneConfig, "colorCeiling");
            worldSceneConfig.setObjPath(objPath);
            worldSceneConfig.setTexturePath(texturePath);
            worldSceneConfig.setLabelDraw(drawLabel);
            worldSceneConfig.setImageOther(imageOther);
            worldSceneConfig.setImageWall(imageWall);
            worldSceneConfig.setImageFloor(imageFloor);
            worldSceneConfig.setImageSeat(imageSeat);
            worldSceneConfig.setImageTable(imageTable);
            worldSceneConfig.setImageCeiling(imageCeiling);
            worldSceneConfig.setTextOther(textOther);
            worldSceneConfig.setTextWall(textWall);
            worldSceneConfig.setTextFloor(textFloor);
            worldSceneConfig.setTextSeat(textSeat);
            worldSceneConfig.setTextTable(textTable);
            worldSceneConfig.setTextCeiling(textCeiling);
            worldSceneConfig.setColorOther(colorOther);
            worldSceneConfig.setColorWall(colorWall);
            worldSceneConfig.setColorFloor(colorFloor);
            worldSceneConfig.setColorSeat(colorSeat);
            worldSceneConfig.setColorTable(colorTable);
            worldSceneConfig.setColorCeiling(colorCeiling);
            return worldSceneConfig;
        } catch (JSONException e) {
            Log.d(TAG, "Error while parsing ARWorld Scene Config. Error Message: " + e.getMessage(), e.getCause());
        }
        return new ARPluginConfigWorld();
    }
}
