/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.ads_example;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.ads.utils.constants.InstallReferrer;

import org.json.JSONException;
import org.json.JSONObject;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        SharedPreferences sp = getSharedPreferences(InstallReferrer.INSTALL_REFERRER_FILE, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sp.edit();
        JSONObject jsonObject = new JSONObject();
        if (!sp.contains(InstallReferrer.INSTALL_REFERRER_FILE)) {
            try {
                jsonObject.put("channelInfo", "Sample install referrer info");
                jsonObject.put("clickTimestamp", System.currentTimeMillis() - 123456L);
                jsonObject.put("installTimestamp", System.currentTimeMillis());
                editor.putString(InstallReferrer.TEST_SERVICE_PACKAGE_NAME, jsonObject.toString());
                editor.commit();
            } catch (JSONException e) {
                Log.e("ExampleMainActivity", "saveOrDelete JSONException");

            }
        }
    }
}
