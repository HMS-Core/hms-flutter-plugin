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

package com.huawei.hms.plugin.ar.core.helper;

import android.content.Context;
import android.hardware.display.DisplayManager;
import android.view.Display;
import android.view.WindowManager;

import com.huawei.hiar.ARSession;

public class DisplayRotationManager implements DisplayManager.DisplayListener {
    private final Context context;

    private final Display display;

    private int width;

    private int height;

    private boolean deviceRotated = false;

    public DisplayRotationManager(Context context) {
        this.context = context;
        WindowManager systemService = context.getSystemService(WindowManager.class);
        if (systemService != null) {
            display = systemService.getDefaultDisplay();
        } else {
            display = null;
        }
    }

    public void registerDisplayListener() {
        DisplayManager systemService = context.getSystemService(DisplayManager.class);
        if (systemService != null) {
            systemService.registerDisplayListener(this, null);
        }
    }

    public void unregisterDisplayListener() {
        DisplayManager systemService = context.getSystemService(DisplayManager.class);
        if (systemService != null) {
            systemService.unregisterDisplayListener(this);
        }
    }

    public boolean isDeviceRotated() {
        return deviceRotated;
    }

    public void updateViewportRotation(int width, int height) {
        this.width = width;
        this.height = height;
        deviceRotated = true;
    }

    public void updateARSessionDisplayGeometry(ARSession arSession) {
        arSession.setDisplayGeometry(display != null ? display.getRotation() : 0, width, height);
        deviceRotated = false;
    }

    @Override
    public void onDisplayAdded(int i) {
    }

    @Override
    public void onDisplayRemoved(int i) {
    }

    @Override
    public void onDisplayChanged(int i) {
        deviceRotated = true;
    }
}
