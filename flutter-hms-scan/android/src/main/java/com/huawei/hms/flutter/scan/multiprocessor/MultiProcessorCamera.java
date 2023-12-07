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

import android.graphics.ImageFormat;
import android.hardware.Camera;
import android.os.Handler;
import android.os.Message;
import android.view.SurfaceHolder;

import java.io.IOException;
import java.util.List;

class MultiProcessorCamera {
    private Camera camera = null;

    private Camera.Parameters parameters = null;

    private boolean isPreview = false;

    private FrameCallback frameCallback = new FrameCallback();

    /**
     * Open up the camera.
     *
     * @param holder SurfaceHolder
     * @throws IOException
     */
    synchronized void open(SurfaceHolder holder) throws IOException {
        camera = Camera.open();
        parameters = camera.getParameters();
        parameters.setFocusMode(Camera.Parameters.FOCUS_MODE_CONTINUOUS_PICTURE);
        parameters.setPictureFormat(ImageFormat.NV21);
        camera.setPreviewDisplay(holder);
        camera.setDisplayOrientation(90);
        camera.setParameters(parameters);
    }

    synchronized void close() {
        if (camera != null) {
            camera.release();
            camera = null;
        }
    }

    synchronized void startPreview() {
        if (camera != null && !isPreview) {
            camera.startPreview();
            isPreview = true;
        }
    }

    synchronized void stopPreview() {
        if (camera != null && isPreview) {
            camera.stopPreview();
            frameCallback.setProperties(null);
            isPreview = false;
        }
    }

    synchronized void callbackFrame(Handler handler, double zoomValue) {
        if (camera != null && isPreview) {
            frameCallback.setProperties(handler);
            double defaultZoom = 1.0d;
            if (camera.getParameters().isZoomSupported() && zoomValue != defaultZoom) {
                // Auto zoom.
                parameters.setZoom(convertZoomInt(zoomValue));
                camera.setParameters(parameters);
            }
            camera.setOneShotPreviewCallback(frameCallback);
        }
    }

    private int convertZoomInt(double zoomValue) {
        List<Integer> allZoomRatios = parameters.getZoomRatios();
        int maxZoom = allZoomRatios.get(allZoomRatios.size() - 1) / 100;
        if (zoomValue >= maxZoom) {
            return allZoomRatios.size() - 1;
        }
        for (int i = 1; i < allZoomRatios.size(); i++) {
            if (allZoomRatios.get(i) >= (zoomValue * 100) && allZoomRatios.get(i - 1) <= (zoomValue * 100)) {
                return i;
            }
        }
        return -1;
    }

    static class FrameCallback implements Camera.PreviewCallback {

        private Handler handler;

        void setProperties(Handler handler) {
            this.handler = handler;
        }

        @Override
        public void onPreviewFrame(byte[] data, Camera camera) {
            if (handler != null) {
                Message message = handler.obtainMessage(0, camera.getParameters().getPreviewSize().width,
                        camera.getParameters().getPreviewSize().height, data);
                message.sendToTarget();
                handler = null;
            }
        }
    }
}
