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
import com.huawei.hms.mlsdk.document.MLDocument;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DocToMap {
    public static Map<String, Object> mlDocToMap(@NonNull MLDocument document) {
        Map<String, Object> map = new HashMap<>();
        map.put(Param.STRING_VALUE, document.getStringValue());
        map.put(Param.BLOCKS, docBlocksToMap(document.getBlocks()));
        return map;
    }

    public static ArrayList<Map<String, Object>> docBlocksToMap(@NonNull List<MLDocument.Block> blocks) {
        ArrayList<Map<String, Object>> blockList = new ArrayList<>();
        for (int i = 0; i < blocks.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLDocument.Block block = blocks.get(i);
            map.put(Param.STRING_VALUE, block.getStringValue());
            map.put(Param.LANGUAGE_LIST, Commons.textLanguagesToMap(block.getLanguageList()));
            map.put(Param.SECTIONS, docSectionsToMap(block.getSections()));
            map.put(Param.BORDER, Commons.createBorderMap(block.getBorder()));
            map.put(Param.POSSIBILITY, block.getPossibility());
            if (block.getInterval() != null) {
                map.put(Param.INTERVAL, intervalToMap(block.getInterval()));
            }
            blockList.add(map);
        }
        return blockList;
    }

    public static Map<String, Object> intervalToMap(@NonNull MLDocument.Interval interval) {
        Map<String, Object> map = new HashMap<>();
        map.put(Param.TYPE, interval.getIntervalType());
        map.put(Param.IS_TEXT_FOLLOWED, interval.isTextFollowed());
        return map;
    }

    public static ArrayList<Map<String, Object>> docSectionsToMap(@NonNull List<MLDocument.Section> sections) {
        ArrayList<Map<String, Object>> secList = new ArrayList<>();
        for (int i = 0; i < sections.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLDocument.Section section = sections.get(i);
            map.put(Param.STRING_VALUE, section.getStringValue());
            map.put(Param.BORDER, Commons.createBorderMap(section.getBorder()));
            if (section.getInterval() != null) {
                map.put(Param.INTERVAL, intervalToMap(section.getInterval()));
            }
            map.put(Param.POSSIBILITY, section.getPossibility());
            map.put(Param.LANGUAGE_LIST, Commons.textLanguagesToMap(section.getLanguageList()));
            map.put(Param.LINE_LIST, docLinesToMap(section.getLineList()));
            map.put(Param.WORD_LIST, docWordsToMap(section.getWordList()));
            secList.add(map);
        }
        return secList;
    }

    public static ArrayList<Map<String, Object>> docLinesToMap(@NonNull List<MLDocument.Line> lines) {
        ArrayList<Map<String, Object>> lineList = new ArrayList<>();
        for (int i = 0; i < lines.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLDocument.Line line = lines.get(i);
            map.put(Param.STRING_VALUE, line.getStringValue());
            map.put(Param.BORDER, Commons.createBorderMap(line.getBorder()));
            if (line.getInterval() != null) {
                map.put(Param.INTERVAL, intervalToMap(line.getInterval()));
            }
            map.put(Param.POSSIBILITY, line.getPossibility());
            map.put(Param.LANGUAGE_LIST, Commons.textLanguagesToMap(line.getLanguageList()));
            map.put(Param.WORD_LIST, docWordsToMap(line.getWordList()));
            map.put(Param.POINTS, docPointsToMap(line.getPoints()));
            lineList.add(map);
        }
        return lineList;
    }

    public static ArrayList<Map<String, Object>> docWordsToMap(@NonNull List<MLDocument.Word> words) {
        ArrayList<Map<String, Object>> wordList = new ArrayList<>();
        for (int i = 0; i < words.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLDocument.Word word = words.get(i);
            map.put(Param.STRING_VALUE, word.getStringValue());
            map.put(Param.BORDER, Commons.createBorderMap(word.getBorder()));
            if (word.getInterval() != null) {
                map.put(Param.INTERVAL, intervalToMap(word.getInterval()));
            }
            map.put(Param.POSSIBILITY, word.getPossibility());
            map.put(Param.LANGUAGE_LIST, Commons.textLanguagesToMap(word.getLanguageList()));
            map.put(Param.CHARACTER_LIST, docCharsToMap(word.getCharacterList()));
            wordList.add(map);
        }
        return wordList;
    }

    public static ArrayList<Map<String, Object>> docPointsToMap(@NonNull List<Point> points) {
        ArrayList<Map<String, Object>> pointList = new ArrayList<>();
        for (int i = 0; i < points.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            Point point = points.get(i);
            map.put("x", point.x);
            map.put("y", point.y);
            pointList.add(map);
        }
        return pointList;
    }

    public static ArrayList<Map<String, Object>> docCharsToMap(@NonNull List<MLDocument.Character> characters) {
        ArrayList<Map<String, Object>> charList = new ArrayList<>();
        for (int i = 0; i < characters.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLDocument.Character character = characters.get(i);
            map.put(Param.STRING_VALUE, character.getStringValue());
            map.put(Param.BORDER, Commons.createBorderMap(character.getBorder()));
            if (character.getInterval() != null) {
                map.put(Param.INTERVAL, intervalToMap(character.getInterval()));
            }
            map.put(Param.POSSIBILITY, character.getPossibility());
            map.put(Param.LANGUAGE_LIST, Commons.textLanguagesToMap(character.getLanguageList()));
            charList.add(map);
        }
        return charList;
    }
}
