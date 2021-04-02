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

import com.huawei.hms.mlsdk.document.MLDocument;
import com.huawei.hms.mlsdk.text.TextLanguage;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DocumentToJson {
    public static JSONObject createMlDocumentJSON(@NonNull MLDocument document) {
        Map<String, Object> map = new HashMap<>();
        map.put("stringValue", document.getStringValue());
        map.put("blocks", documentBlockJSONArray(document.getBlocks()));
        return new JSONObject(map);
    }

    public static JSONArray documentBlockJSONArray(@NonNull List<MLDocument.Block> blocks) {
        ArrayList<Map<String, Object>> blockList = new ArrayList<>();
        for (int i = 0; i < blocks.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLDocument.Block block = blocks.get(i);
            map.put("stringValue", block.getStringValue());
            map.put("languageList", documentLanguageJSONArray(block.getLanguageList()));
            map.put("sections", sectionToJSONArray(block.getSections()));
            map.put("border", FaceToJson.createBorderJSON(block.getBorder()));
            map.put("possibility", block.getPossibility());
            if (block.getInterval() != null) {
                map.put("interval", intervalToJSON(block.getInterval()));
            }
            blockList.add(map);
        }
        return new JSONArray(blockList);
    }

    public static JSONArray documentLanguageJSONArray(@NonNull List<TextLanguage> languages) {
        ArrayList<Map<String, Object>> langList = new ArrayList<>();
        for (int i = 0; i < languages.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            TextLanguage language = languages.get(i);
            map.put("language", language.getLanguage());
            langList.add(map);
        }
        return new JSONArray(langList);
    }

    public static JSONObject intervalToJSON(@NonNull MLDocument.Interval interval) {
        Map<String, Object> map = new HashMap<>();
        map.put("type", interval.getIntervalType());
        map.put("isTextFollowed", interval.isTextFollowed());
        return new JSONObject(map);
    }

    public static JSONArray sectionToJSONArray(@NonNull List<MLDocument.Section> sections) {
        ArrayList<Map<String, Object>> secList = new ArrayList<>();
        for (int i = 0; i < sections.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLDocument.Section section = sections.get(i);
            map.put("stringValue", section.getStringValue());
            map.put("border", FaceToJson.createBorderJSON(section.getBorder()));
            if (section.getInterval() != null) {
                map.put("interval", intervalToJSON(section.getInterval()));
            }
            map.put("possibility", section.getPossibility());
            map.put("languageList", documentLanguageJSONArray(section.getLanguageList()));
            map.put("lineList", lineListToJSONArray(section.getLineList()));
            map.put("wordList", wordListToJSONArray(section.getWordList()));
            secList.add(map);
        }
        return new JSONArray(secList);
    }

    public static JSONArray lineListToJSONArray(@NonNull List<MLDocument.Line> lines) {
        ArrayList<Map<String, Object>> lineList = new ArrayList<>();
        for (int i = 0; i < lines.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLDocument.Line line = lines.get(i);
            map.put("stringValue", line.getStringValue());
            map.put("border", FaceToJson.createBorderJSON(line.getBorder()));
            if (line.getInterval() != null) {
                map.put("interval", intervalToJSON(line.getInterval()));
            }
            map.put("possibility", line.getPossibility());
            map.put("languageList", documentLanguageJSONArray(line.getLanguageList()));
            map.put("wordList", wordListToJSONArray(line.getWordList()));
            map.put("points", pointListToJSONArray(line.getPoints()));
            lineList.add(map);
        }
        return new JSONArray(lineList);
    }

    public static JSONArray wordListToJSONArray(@NonNull List<MLDocument.Word> words) {
        ArrayList<Map<String, Object>> wordList = new ArrayList<>();
        for (int i = 0; i < words.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLDocument.Word word = words.get(i);
            map.put("stringValue", word.getStringValue());
            map.put("border", FaceToJson.createBorderJSON(word.getBorder()));
            if (word.getInterval() != null) {
                map.put("interval", intervalToJSON(word.getInterval()));
            }
            map.put("possibility", word.getPossibility());
            map.put("languageList", documentLanguageJSONArray(word.getLanguageList()));
            map.put("characterList", characterToJSONArray(word.getCharacterList()));
            wordList.add(map);
        }
        return new JSONArray(wordList);
    }

    public static JSONArray pointListToJSONArray(@NonNull List<Point> points) {
        ArrayList<Map<String, Object>> pointList = new ArrayList<>();
        for (int i = 0; i < points.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            Point point = points.get(i);
            map.put("x", point.x);
            map.put("y", point.y);
            pointList.add(map);
        }
        return new JSONArray(pointList);
    }

    public static JSONArray characterToJSONArray(@NonNull List<MLDocument.Character> characters) {
        ArrayList<Map<String, Object>> charList = new ArrayList<>();
        for (int i = 0; i < characters.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLDocument.Character character = characters.get(i);
            map.put("stringValue", character.getStringValue());
            map.put("border", FaceToJson.createBorderJSON(character.getBorder()));
            if (character.getInterval() != null) {
                map.put("interval", intervalToJSON(character.getInterval()));
            }
            map.put("possibility", character.getPossibility());
            map.put("languageList", documentLanguageJSONArray(character.getLanguageList()));
            charList.add(map);
        }
        return new JSONArray(charList);
    }
}
