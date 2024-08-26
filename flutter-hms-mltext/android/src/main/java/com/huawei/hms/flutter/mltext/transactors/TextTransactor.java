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

package com.huawei.hms.flutter.mltext.transactors;

import android.app.Activity;
import android.os.Handler;
import android.os.Looper;
import android.util.SparseArray;

import com.huawei.hms.flutter.mltext.constant.Method;
import com.huawei.hms.flutter.mltext.constant.Param;
import com.huawei.hms.flutter.mltext.logger.HMSLogger;
import com.huawei.hms.flutter.mltext.utils.tomap.TextToMap;
import com.huawei.hms.mlsdk.common.MLAnalyzer;
import com.huawei.hms.mlsdk.text.MLText;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class TextTransactor implements MLAnalyzer.MLTransactor<MLText.Block> {
    private final Handler handler = new Handler(Looper.getMainLooper());
    private final Activity activity;
    private final MethodChannel channel;

    public TextTransactor(Activity activity, MethodChannel channel) {
        this.activity = activity;
        this.channel = channel;
    }

    @Override
    public void destroy() {

    }

    @Override
    public void transactResult(MLAnalyzer.Result<MLText.Block> result) {
        Map<String, Object> map = new HashMap<>();

        SparseArray<MLText.Block> sparseArray = result.getAnalyseList();
        List<MLText.Block> blocks = new ArrayList<>(sparseArray.size());

        for (int i = 0; i < sparseArray.size(); i++) {
            blocks.add(sparseArray.get(i));
        }

        map.put("result", TextToMap.textBlockToJSONArray(blocks));
        invoke(map);
    }

    private void invoke(final Map<String, Object> args) {
        HMSLogger.getInstance(activity).sendPeriodicEvent(Method.TEXT_TRANSACTION);
        handler.post(() -> channel.invokeMethod(Param.TEXT, args));
    }
}
