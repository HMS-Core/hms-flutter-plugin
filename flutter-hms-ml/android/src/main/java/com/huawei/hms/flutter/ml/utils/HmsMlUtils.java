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

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Base64;

import com.huawei.hms.mlsdk.common.MLFrame;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.List;

public class HmsMlUtils {
    public static List<String> jsonArrayToList(JSONObject jsonObject) throws JSONException {
        List<String> languageList = null;
        JSONArray languageArray = jsonObject.optJSONArray("languageList");
        if (languageArray != null) {
            languageList = new ArrayList<>(languageArray.length());
            for (int i = 0; i < languageArray.length(); i++) {
                languageList.add(languageArray.getString(i));
            }
        }
        return languageList;
    }

    public static MLFrame getFrame(String encodedImage) {
        byte[] decodedString = Base64.decode(encodedImage, Base64.DEFAULT);
        Bitmap bitmap = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
        return MLFrame.fromBitmap(bitmap);
    }
}