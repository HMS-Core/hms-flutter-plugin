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

package com.huawei.hms.plugin.ar.core.util;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.res.AssetManager;
import android.util.Log;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class ApplicationUtil {
    private static final String TAG = ApplicationUtil.class.getSimpleName();

    private static final int EXPECTED_BUFFER_DATA = 1024;

    private static final int LIST_MAX_SIZE = 1024;

    private static final String DEFAULT_FILE = "default_id";

    private static final String DEFAULT_KEY = "mode_id";

    /**
     * Read the default authentication data.
     *
     * @param context context.
     * @return Return the default authentication data.
     */
    public static String readApplicationMessage(Context context) {
        String json = "";
        if (context == null) {
            return json;
        }
        SharedPreferences sharedPreferences = context.getSharedPreferences(DEFAULT_FILE, Context.MODE_PRIVATE);
        json = sharedPreferences.getString(DEFAULT_KEY, "");
        return json;
    }

    /**
     * Read json file.
     *
     * @param fileName file name.
     * @param context context.
     * @return json file content.
     */
    public static String getJson(String fileName, Context context) {
        // change json file to string
        StringBuilder stringBuilder = new StringBuilder(EXPECTED_BUFFER_DATA);
        InputStreamReader inputStreamReader = null;
        BufferedReader reader = null;
        try {
            AssetManager assetManager = context.getAssets();

            // open file and read file input stream
            inputStreamReader = new InputStreamReader(assetManager.open(fileName), "UTF-8");
            reader = new BufferedReader(inputStreamReader);
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.contains("/") || line.contains("*")) {
                    continue;
                }
                stringBuilder.append(line);
            }
        } catch (IOException e) {
            Log.w(TAG, "open json file error");
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e) {
                    Log.w(TAG, "close BufferedReader error");
                }
            }
            if (inputStreamReader != null) {
                try {
                    inputStreamReader.close();
                } catch (IOException e) {
                    Log.w(TAG, "close inputStream error");
                }
            }
        }
        return stringBuilder.toString();
    }

    /**
     * Read continents, modelName, appId, and appSecret in a specified JSON file.
     *
     * @param jsonFile Name of the JSON file that stores mode name data.
     * @return Return the modeID array, which contains continents, modelName, appId, and appSecret.
     */
    public static List<ModeInformation> json2List(String jsonFile) {
        List<ModeInformation> modeIdList = new ArrayList<>(LIST_MAX_SIZE);
        if (jsonFile == null) {
            return modeIdList;
        }
        try {
            JSONObject jsonObject = new JSONObject(jsonFile);
            JSONArray jsonArray = jsonObject.getJSONArray("data");
            if (jsonArray == null) {
                return modeIdList;
            }
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject object = jsonArray.getJSONObject(i);
                if (object == null) {
                    continue;
                }
                ModeInformation id = new ModeInformation(object.getString("modeInformation"),
                    object.getString("continents"));
                if (id.getContinents().isEmpty() || id.getModeInformation().isEmpty()) {
                    continue;
                }
                modeIdList.add(id);
            }
        } catch (JSONException e) {
            Log.e(TAG, e.getLocalizedMessage());
        }
        return modeIdList;
    }
}
