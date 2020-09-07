/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.ml.utils;

import com.huawei.hms.mlsdk.text.MLText;
import com.huawei.hms.mlsdk.text.TextLanguage;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;

import android.graphics.Point;
import android.graphics.Rect;
import android.util.Log;
import android.util.SparseArray;

public class MlTextUtils {
    private static String TAG = MlTextUtils.class.getSimpleName();

    public static JSONObject fromMLTextBlockToJson(MLText text) {
        JSONObject result = new JSONObject();
        try {
            result.putOpt("stringValue", text.getStringValue());
            result.putOpt("blocks", getBlocks(text.getBlocks()));
        } catch (JSONException e) {
            Log.e(TAG, Objects.requireNonNull(e.getMessage()));
        }
        return result;
    }

    private static JSONObject getBlocks(List<MLText.Block> blocks) {
        JSONObject object = new JSONObject();
        for (MLText.Block block : blocks) {
            try {
                object.putOpt("contents", getTextLineContents(block.getContents()));
                object.putOpt("stringValue", block.getStringValue());
                object.putOpt("possibility", block.getPossibility());
                object.putOpt("language", block.getLanguage());
                object.putOpt("border", getBorders(block.getBorder()));
                object.putOpt("vertexes", getVertexes(Arrays.asList(block.getVertexes())));
                object.putOpt("languageList", getLanguageList(block.getLanguageList()));
            } catch (JSONException e) {
                Log.e(TAG, Objects.requireNonNull(e.getMessage()));
            }
        }
        return object;
    }

    public static JSONObject getBorders(Rect rect) {
        JSONObject border = new JSONObject();
        try {
            border.putOpt("bottom", rect.bottom);
            border.putOpt("top", rect.top);
            border.putOpt("left", rect.left);
            border.putOpt("right", rect.right);
            border.putOpt("exactCenterX", rect.exactCenterX());
            border.putOpt("centerY", rect.centerY());
            border.putOpt("centerX", rect.centerX());
            border.putOpt("describeContents", rect.describeContents());
            border.putOpt("height", rect.height());
            border.putOpt("width", rect.width());
        } catch (JSONException e) {
            Log.e(TAG, "error:" + e.getMessage());
        }
        return border;
    }

    public static JSONObject getVertexes(List<Point> points) {
        JSONObject object = new JSONObject();
        for (Point point : points) {
            try {
                object.putOpt("x", point.x);
                object.putOpt("y", point.y);
                object.putOpt("describeContents", point.describeContents());
            } catch (JSONException e) {
                Log.e(TAG, "error:" + e.getMessage());
            }
        }
        return object;
    }

    public static JSONArray getLanguageList(List<TextLanguage> languages) {
        JSONArray array = new JSONArray();
        for (TextLanguage language : languages) {
            array.put(language.getLanguage());
        }
        return array;
    }

    private static JSONObject getTextLineContents(List<MLText.TextLine> textLines) {
        JSONObject object = new JSONObject();
        for (MLText.TextLine line : textLines) {
            try {
                object.putOpt("stringValue", line.getStringValue());
                object.putOpt("rotationDegree", line.getRotatingDegree());
                object.putOpt("isVertical", line.isVertical());
                object.putOpt("language", line.getLanguage());
                object.putOpt("border", getBorders(line.getBorder()));
                object.putOpt("possibility", line.getPossibility());
                object.putOpt("languageList", getLanguageList(line.getLanguageList()));
                object.putOpt("vertexes", getVertexes(Arrays.asList(line.getVertexes())));
                object.putOpt("contents", getTextWordContents(line.getContents()));
            } catch (JSONException e) {
                Log.e(TAG, Objects.requireNonNull(e.getMessage()));
            }
        }
        return object;
    }

    private static JSONObject getTextWordContents(List<MLText.Word> words) {
        JSONObject object = new JSONObject();
        for (MLText.Word word : words) {
            try {
                object.putOpt("stringValue", word.getStringValue());
                object.putOpt("border", getBorders(word.getBorder()));
                object.putOpt("language", word.getLanguage());
                object.putOpt("possibility", word.getPossibility());
                object.putOpt("languageList", getLanguageList(word.getLanguageList()));
                object.putOpt("vertexes", getVertexes(Arrays.asList(word.getVertexes())));
            } catch (JSONException e) {
                Log.e(TAG, Objects.requireNonNull(e.getMessage()));
            }
        }
        return object;
    }

    public static JSONObject fromSparseArrayMLTextBlockToJSON(SparseArray<MLText.Block> array) throws JSONException {
        List<MLText.Block> blocks = new ArrayList<>();
        JSONObject json = new JSONObject();
        for (int i = 0; i < array.size(); i++) {
            int key = array.keyAt(i);
            MLText.Block textBlock = array.get(key);
            blocks.add(textBlock);
            json.putOpt(String.valueOf(key), getBlocks(blocks));
            blocks.clear();
        }
        return json;
    }
}
