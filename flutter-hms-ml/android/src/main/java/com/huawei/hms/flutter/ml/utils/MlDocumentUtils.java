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

import com.huawei.hms.mlsdk.document.MLDocument;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.List;

public class MlDocumentUtils {
    public static JSONObject getDocBlocks(List<MLDocument.Block> blocks) throws JSONException {
        JSONObject object = new JSONObject();
        for (MLDocument.Block block : blocks) {
            object.putOpt("stringValue", block.getStringValue());
            object.putOpt("possibility", block.getPossibility());
            object.putOpt("border", MlTextUtils.getBorders(block.getBorder()));
            object.putOpt("sections", getDocSections(block.getSections()));

            JSONObject interval = new JSONObject();
            interval.putOpt("intervalType", block.getInterval().getIntervalType());
            interval.putOpt("isTextFollowed", block.getInterval().isTextFollowed());

            object.putOpt("interval", interval);
        }
        return object;
    }

    private static JSONObject getDocSections(List<MLDocument.Section> sections) throws JSONException {
        JSONObject object = new JSONObject();
        for (MLDocument.Section section : sections) {
            object.putOpt("stringValue", section.getStringValue());
            object.putOpt("border", MlTextUtils.getBorders(section.getBorder()));
            object.putOpt("possibility", section.getPossibility());
            object.putOpt("languageList", MlTextUtils.getLanguageList(section.getLanguageList()));
            object.putOpt("lineList", getDocLineList(section.getLineList()));
            object.putOpt("wordList", getDocWordList(section.getWordList()));

            JSONObject interval = new JSONObject();
            interval.putOpt("intervalType", section.getInterval().getIntervalType());
            interval.putOpt("isTextFollowed", section.getInterval().isTextFollowed());

            object.putOpt("interval", interval);
        }
        return object;
    }

    private static JSONObject getDocLineList(List<MLDocument.Line> lines) throws JSONException {
        JSONObject object = new JSONObject();
        for (MLDocument.Line line : lines) {
            object.putOpt("stringValue", line.getStringValue());
            object.putOpt("border", MlTextUtils.getBorders(line.getBorder()));
            object.putOpt("possibility", line.getPossibility());
            object.putOpt("languageList", MlTextUtils.getLanguageList(line.getLanguageList()));
            object.putOpt("wordList", getDocWordList(line.getWordList()));
            object.putOpt("points", MlTextUtils.getVertexes(line.getPoints()));

            JSONObject interval = new JSONObject();
            interval.putOpt("intervalType", line.getInterval().getIntervalType());
            interval.putOpt("isTextFollowed", line.getInterval().isTextFollowed());

            object.putOpt("interval", interval);
        }
        return object;
    }

    private static JSONObject getDocWordList(List<MLDocument.Word> words) throws JSONException {
        JSONObject object = new JSONObject();
        for (MLDocument.Word word : words) {
            object.putOpt("stringValue", word.getStringValue());
            object.putOpt("border", MlTextUtils.getBorders(word.getBorder()));
            object.putOpt("possibility", word.getPossibility());
            object.putOpt("languageList", MlTextUtils.getLanguageList(word.getLanguageList()));
            object.putOpt("characterList", getDocCharacterList(word.getCharacterList()));

            JSONObject interval = new JSONObject();
            interval.putOpt("intervalType", word.getInterval().getIntervalType());
            interval.putOpt("isTextFollowed", word.getInterval().isTextFollowed());

            object.putOpt("interval", interval);
        }
        return object;
    }

    private static JSONObject getDocCharacterList(List<MLDocument.Character> characters) throws JSONException {
        JSONObject object = new JSONObject();
        JSONObject interval = new JSONObject();
        for (MLDocument.Character character : characters) {
            object.putOpt("stringValue", character.getStringValue());
            object.putOpt("possibility", character.getPossibility());
            object.putOpt("border", MlTextUtils.getBorders(character.getBorder()));
            object.putOpt("languageList", MlTextUtils.getLanguageList(character.getLanguageList()));

            if (character.getInterval() != null) {
                interval.putOpt("intervalType", character.getInterval().getIntervalType());
                interval.putOpt("isTextFollowed", character.getInterval().isTextFollowed());
                object.putOpt("interval", interval);
            }
        }
        return object;
    }
}