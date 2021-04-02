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

package com.huawei.hms.flutter.ml.utils.tojson;

import android.graphics.Point;

import androidx.annotation.NonNull;

import com.huawei.hms.mlsdk.text.MLText;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TextToJson {
    public static JSONObject createMlTextJSON(@NonNull MLText text) {
        Map<String, Object>  map = new HashMap<>();
        map.put("stringValue", text.getStringValue());
        map.put("blocks", textBlockToJSONArray(text.getBlocks()));
        return new JSONObject(map);
    }

    public static JSONObject blockToJSON(@NonNull MLText.Block block) {
        Map<String, Object> map = new HashMap<>();
        map.put("stringValue", block.getStringValue());
        map.put("textLines", textLineToJSONArray(block.getContents()));
        map.put("vertexes", vertexesToJSONArray(block.getVertexes()));
        map.put("border", FaceToJson.createBorderJSON(block.getBorder()));
        map.put("language", block.getLanguage());
        map.put("languageList", DocumentToJson.documentLanguageJSONArray(block.getLanguageList()));
        map.put("possibility", block.getPossibility());
        return new JSONObject(map);
    }

    public static JSONArray textBlockToJSONArray(@NonNull List<MLText.Block> blocks) {
        ArrayList<Map<String, Object>> blockList = new ArrayList<>();
        for (int i = 0; i < blocks.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLText.Block block = blocks.get(i);
            map.put("stringValue", block.getStringValue());
            map.put("textLines", textLineToJSONArray(block.getContents()));
            map.put("vertexes", vertexesToJSONArray(block.getVertexes()));
            map.put("border", FaceToJson.createBorderJSON(block.getBorder()));
            map.put("language", block.getLanguage());
            map.put("languageList", DocumentToJson.documentLanguageJSONArray(block.getLanguageList()));
            map.put("possibility", block.getPossibility());
            blockList.add(map);
        }
        return new JSONArray(blockList);
    }

    public static JSONArray textLineToJSONArray(@NonNull List<MLText.TextLine> lines) {
        ArrayList<Map<String, Object>> lineList = new ArrayList<>();
        for (int i = 0; i < lines.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLText.TextLine line = lines.get(i);
            map.put("stringValue", line.getStringValue());
            map.put("rotationDegree", line.getRotatingDegree());
            map.put("isVertical", line.isVertical());
            map.put("border", FaceToJson.createBorderJSON(line.getBorder()));
            map.put("language", line.getLanguage());
            map.put("languageList", DocumentToJson.documentLanguageJSONArray(line.getLanguageList()));
            map.put("possibility", line.getPossibility());
            map.put("words", textWordToJSONArray(line.getContents()));
            map.put("vertexes", vertexesToJSONArray(line.getVertexes()));
            lineList.add(map);
        }
        return new JSONArray(lineList);
    }

    public static JSONArray textWordToJSONArray(@NonNull List<MLText.Word> words) {
        ArrayList<Map<String, Object>> wordList = new ArrayList<>();
        for (int i = 0; i < words.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLText.Word word = words.get(i);
            map.put("stringValue", word.getStringValue());
            map.put("vertexes", vertexesToJSONArray(word.getVertexes()));
            map.put("border", FaceToJson.createBorderJSON(word.getBorder()));
            map.put("language", word.getLanguage());
            map.put("languageList", DocumentToJson.documentLanguageJSONArray(word.getLanguageList()));
            map.put("possibility", word.getPossibility());
            wordList.add(map);
        }
        return new JSONArray(wordList);
    }

    public static JSONArray vertexesToJSONArray(@NonNull Point[] points) {
        ArrayList<Map<String, Object>> pointList = new ArrayList<>();
        for (Point p : points) {
            Map<String, Object> map = new HashMap<>();
            map.put("y", p.x);
            map.put("x", p.y);
            pointList.add(map);
        }
        return new JSONArray(pointList);
    }
}
