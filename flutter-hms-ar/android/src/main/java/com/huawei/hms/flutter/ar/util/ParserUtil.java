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

package com.huawei.hms.flutter.ar.util;

import android.util.Log;

import com.huawei.hms.plugin.ar.core.config.ColorRGBA;

import org.json.JSONException;
import org.json.JSONObject;

import io.flutter.embedding.engine.loader.FlutterLoader;

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
            return FlutterLoader.getInstance().getLookupKeyForAsset(sceneConfig.getString(pathKey));
        } catch (JSONException e) {
            Log.d(TAG, "Error while parsing a path from scene config. Error: " + e.getMessage(), e.getCause());
        }
        return "";
    }
}
