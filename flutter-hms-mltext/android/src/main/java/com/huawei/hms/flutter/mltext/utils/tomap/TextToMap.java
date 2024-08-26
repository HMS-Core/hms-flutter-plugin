/*
 * Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.huawei.hms.flutter.mltext.utils.tomap;

import android.graphics.Point;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mltext.constant.Param;
import com.huawei.hms.flutter.mltext.utils.Commons;
import com.huawei.hms.mlsdk.text.MLText;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TextToMap {
    public static Map<String, Object> createMlTextJSON(@NonNull MLText text) {
        Map<String, Object> map = new HashMap<>();
        map.put(Param.STRING_VALUE, text.getStringValue());
        map.put(Param.BLOCKS, textBlockToJSONArray(text.getBlocks()));
        return map;
    }

    public static ArrayList<Map<String, Object>> textBlockToJSONArray(@NonNull List<MLText.Block> blocks) {
        ArrayList<Map<String, Object>> blockList = new ArrayList<>();
        for (int i = 0; i < blocks.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLText.Block block = blocks.get(i);
            map.put(Param.STRING_VALUE, block.getStringValue());
            map.put(Param.TEXT_LINES, textLineToJSONArray(block.getContents()));
            map.put(Param.VERTEXES, vertexesToJSONArray(block.getVertexes()));
            map.put(Param.BORDER, Commons.createBorderMap(block.getBorder()));
            map.put(Param.LANGUAGE, block.getLanguage());
            map.put(Param.LANGUAGE_LIST, Commons.textLanguagesToMap(block.getLanguageList()));
            map.put(Param.POSSIBILITY, block.getPossibility());
            blockList.add(map);
        }
        return blockList;
    }

    public static ArrayList<Map<String, Object>> textLineToJSONArray(@NonNull List<MLText.TextLine> lines) {
        ArrayList<Map<String, Object>> lineList = new ArrayList<>();
        for (int i = 0; i < lines.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLText.TextLine line = lines.get(i);
            map.put(Param.STRING_VALUE, line.getStringValue());
            map.put(Param.ROTATION_DEGREE, line.getRotatingDegree());
            map.put(Param.IS_VERTICAL, line.isVertical());
            map.put(Param.BORDER, Commons.createBorderMap(line.getBorder()));
            map.put(Param.LANGUAGE, line.getLanguage());
            map.put(Param.LANGUAGE_LIST, Commons.textLanguagesToMap(line.getLanguageList()));
            map.put(Param.POSSIBILITY, line.getPossibility());
            map.put(Param.WORDS, textWordToJSONArray(line.getContents()));
            map.put(Param.VERTEXES, vertexesToJSONArray(line.getVertexes()));
            lineList.add(map);
        }
        return lineList;
    }

    public static ArrayList<Map<String, Object>> textWordToJSONArray(@NonNull List<MLText.Word> words) {
        ArrayList<Map<String, Object>> wordList = new ArrayList<>();
        for (int i = 0; i < words.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLText.Word word = words.get(i);
            map.put(Param.STRING_VALUE, word.getStringValue());
            map.put(Param.VERTEXES, vertexesToJSONArray(word.getVertexes()));
            map.put(Param.BORDER, Commons.createBorderMap(word.getBorder()));
            map.put(Param.LANGUAGE, word.getLanguage());
            map.put(Param.LANGUAGE_LIST, Commons.textLanguagesToMap(word.getLanguageList()));
            map.put(Param.POSSIBILITY, word.getPossibility());
            wordList.add(map);
        }
        return wordList;
    }

    public static ArrayList<Map<String, Object>> vertexesToJSONArray(@NonNull Point[] points) {
        ArrayList<Map<String, Object>> pointList = new ArrayList<>();
        for (Point p : points) {
            Map<String, Object> map = new HashMap<>();
            map.put("y", p.x);
            map.put("x", p.y);
            pointList.add(map);
        }
        return pointList;
    }
}
