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

package com.huawei.hms.plugin.ar.core.renderer;

import android.content.Context;
import android.util.Log;

import com.huawei.hiar.ARCamera;
import com.huawei.hiar.ARFrame;
import com.huawei.hiar.ARPlane;
import com.huawei.hiar.ARSession;
import com.huawei.hiar.common.CloudServiceState;
import com.huawei.hiar.listener.CloudServiceEvent;
import com.huawei.hiar.listener.CloudServiceListener;
import com.huawei.hms.plugin.ar.core.config.ARPluginConfigBase;
import com.huawei.hms.plugin.ar.core.helper.DisplayRotationManager;
import com.huawei.hms.plugin.ar.core.helper.TextureDisplay;
import com.huawei.hms.plugin.ar.core.util.ApplicationUtil;
import com.huawei.hms.plugin.ar.core.util.ModeInformation;

import java.util.ArrayList;
import java.util.EventObject;
import java.util.List;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

public class ARCloud3DObjectRenderer extends ARBaseRenderer {
    private final static String TAG = ARCloud3DObjectRenderer.class.getSimpleName();

    private Context context;

    public ARCloud3DObjectRenderer(ARSession arSession, DisplayRotationManager displayRotationManager,
        TextureDisplay textureDisplay, ARPluginConfigBase pluginConfigBase, Context context, String fileName) {
        super(arSession, displayRotationManager, textureDisplay, pluginConfigBase);
        this.context = context;
        signWithAppIdNew(fileName);
    }

    @Override
    public void onSurfaceCreated(GL10 gl10, EGLConfig eglConfig) {
        super.onSurfaceCreated(gl10, eglConfig);
        setCloudServiceStateListener();
    }

    @Override
    public void onSurfaceChanged(GL10 gl10, int width, int height) {
        super.onSurfaceChanged(gl10, width, height);
    }

    @Override
    public void onDrawFrame(GL10 gl10) {
        super.onDrawFrame(gl10);
        ARFrame arFrame = arSession.update();
        ARCamera arCamera = arFrame.getCamera();

        textureDisplay.onDrawFrame(arFrame);
        callbackHelper.onDrawFrame(new ArrayList<>(arSession.getAllTrackables(ARPlane.class)));
        float[] viewMatrix = new float[16];
        arCamera.getViewMatrix(viewMatrix, 0);
    }

    public void setCloudServiceStateListener() {
        arSession.addServiceListener(new CloudImageServiceListener());
    }

    private void signWithAppIdNew(String fileName) {
        String authJson = ApplicationUtil.readApplicationMessage(context);
        if (authJson.isEmpty()) {
            String jsonString = ApplicationUtil.getJson(fileName, context);
            List<ModeInformation> modeList = ApplicationUtil.json2List(jsonString);
            if (modeList.size() <= 0) {
                Log.e(TAG, "sign error, get application message error");
                return;
            }
            authJson = modeList.get(0).getModeInformation();
        }
        arSession.setCloudServiceAuthInfo(authJson);
    }

    public class CloudImageServiceListener implements CloudServiceListener {
        @Override
        public void handleEvent(EventObject eventObject) {
            CloudServiceState state = null;
            if (eventObject instanceof CloudServiceEvent) {
                CloudServiceEvent cloudServiceEvent = (CloudServiceEvent) eventObject;
                state = cloudServiceEvent.getCloudServiceState();
            }
            if (state == null) {
                return;
            }
            String tipMsg = "";
            switch (state) {
                case CLOUD_SERVICE_ERROR_NETWORK_UNAVAILABLE:
                    tipMsg = "network unavailable";
                    break;
                case CLOUD_SERVICE_ERROR_CLOUD_SERVICE_UNAVAILABLE:
                    tipMsg = "cloud service unavailable";
                    break;
                case CLOUD_SERVICE_ERROR_NOT_AUTHORIZED:
                    tipMsg = "cloud service not authorized";
                    break;
                case CLOUD_SERVICE_ERROR_SERVER_VERSION_TOO_OLD:
                    tipMsg = "cloud server version too old";
                    break;
                case CLOUD_SERVICE_ERROR_TIME_EXHAUSTED:
                    tipMsg = "time exhausted";
                    break;
                case CLOUD_SERVICE_ERROR_INTERNAL:
                    tipMsg = "cloud service gallery invalid";
                    break;
                case CLOUD_OBJECT_ERROR_OBJECT_MODEL_INVALID:
                    tipMsg = "cloud object error, object invalid";
                    break;
                case CLOUD_OBJECT_ERROR_OBJECT_RECOGNIZE_FAILE:
                    tipMsg = "cloud object recognize fail";
                    break;
                default:
            }
            Log.e(TAG, tipMsg);
        }
    }
}
