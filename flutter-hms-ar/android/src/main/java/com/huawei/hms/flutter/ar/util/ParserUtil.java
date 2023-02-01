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

package com.huawei.hms.flutter.ar.util;

import android.util.Log;

import com.huawei.hiar.ARConfigBase;
import com.huawei.hms.plugin.ar.core.config.ColorRGBA;

import io.flutter.FlutterInjector;

import org.json.JSONException;
import org.json.JSONObject;

public final class ParserUtil {
    private static final String TAG = ParserUtil.class.getSimpleName();

    private ParserUtil() {
    }

    public static ColorRGBA getColorRGBA(JSONObject sceneConfig, String colorKey) throws JSONException {
        JSONObject colorJson = new JSONObject(sceneConfig.getString(colorKey));
        return new ColorRGBA(colorJson.getInt("red"), colorJson.getInt("green"), colorJson.getInt("blue"),
            colorJson.getInt("alpha"));
    }

    public static String getDefaultPath(JSONObject sceneConfig, String pathKey) {
        try {
            return FlutterInjector.instance().flutterLoader().getLookupKeyForAsset(sceneConfig.getString(pathKey));
        } catch (JSONException e) {
            Log.d(TAG, "Error while parsing a path from scene config. Error: " + e.getMessage(), e.getCause());
        }
        return "";
    }

    public static ARConfigBase.FocusMode intToFocusModeEnum(int val) {
        if (val == ARConfigBase.FocusMode.FIXED_FOCUS.ordinal()) {
            return ARConfigBase.FocusMode.FIXED_FOCUS;
        }
        return ARConfigBase.FocusMode.AUTO_FOCUS;
    }

    public static ARConfigBase.PowerMode intToPowerModeEnum(int val) {
        if (val == ARConfigBase.PowerMode.NORMAL.ordinal()) {
            return ARConfigBase.PowerMode.NORMAL;
        } else if (val == ARConfigBase.PowerMode.POWER_SAVING.ordinal()) {
            return ARConfigBase.PowerMode.POWER_SAVING;
        } else if (val == ARConfigBase.PowerMode.ULTRA_POWER_SAVING.ordinal()) {
            return ARConfigBase.PowerMode.ULTRA_POWER_SAVING;
        } else {
            return ARConfigBase.PowerMode.PERFORMANCE_FIRST;
        }
    }

    public static ARConfigBase.UpdateMode intToUpdateModeEnum(int val) {
        if (val == ARConfigBase.UpdateMode.BLOCKING.ordinal()) {
            return ARConfigBase.UpdateMode.BLOCKING;
        }
        return ARConfigBase.UpdateMode.LATEST_CAMERA_IMAGE;
    }

    public static ARConfigBase.PlaneFindingMode intToPlaneFindingModeEnum(int val) {
        if (val == ARConfigBase.PlaneFindingMode.DISABLED.ordinal()) {
            return ARConfigBase.PlaneFindingMode.DISABLED;
        } else if (val == ARConfigBase.PlaneFindingMode.VERTICAL_ONLY.ordinal()) {
            return ARConfigBase.PlaneFindingMode.VERTICAL_ONLY;
        } else if (val == ARConfigBase.PlaneFindingMode.HORIZONTAL_ONLY.ordinal()) {
            return ARConfigBase.PlaneFindingMode.HORIZONTAL_ONLY;
        } else {
            return ARConfigBase.PlaneFindingMode.ENABLE;
        }
    }
}
