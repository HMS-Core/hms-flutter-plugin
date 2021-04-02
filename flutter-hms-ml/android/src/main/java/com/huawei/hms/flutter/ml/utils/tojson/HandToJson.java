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

import androidx.annotation.NonNull;

import com.huawei.hms.mlsdk.handkeypoint.MLHandKeypoint;
import com.huawei.hms.mlsdk.handkeypoint.MLHandKeypoints;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HandToJson {
    public static JSONObject handJSON(@NonNull MLHandKeypoints hand) {
        Map<String, Object> map = new HashMap<>();
        map.put("score", hand.getScore());
        map.put("border", FaceToJson.createBorderJSON(hand.getRect()));
        map.put("handKeypoints", handToJSONArray(hand.getHandKeypoints()));
        return new JSONObject(map);
    }

    public static JSONArray handsToJSONArray(@NonNull List<MLHandKeypoints> list) {
        ArrayList<Map<String, Object>> hList = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLHandKeypoints hands = list.get(i);
            map.put("score", hands.getScore());
            map.put("border", FaceToJson.createBorderJSON(hands.getRect()));
            map.put("handKeypoints", handToJSONArray(hands.getHandKeypoints()));
            hList.add(map);
        }
        return new JSONArray(hList);
    }

    public static JSONArray handToJSONArray(@NonNull List<MLHandKeypoint> list) {
        ArrayList<Map<String, Object>> hList = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLHandKeypoint hand = list.get(i);
            map.put("pointX", hand.getPointX());
            map.put("pointY", hand.getPointY());
            map.put("score", hand.getScore());
            map.put("type", hand.getType());
            hList.add(map);
        }
        return new JSONArray(hList);
    }
}
