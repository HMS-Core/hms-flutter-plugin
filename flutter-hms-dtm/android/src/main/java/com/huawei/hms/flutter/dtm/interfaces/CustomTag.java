/*
 * Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.dtm.interfaces;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;

import com.huawei.hms.dtm.ICustomTag;
import com.huawei.hms.flutter.dtm.DTMPlugin;
import com.huawei.hms.flutter.dtm.logger.HMSLogger;

import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class CustomTag implements ICustomTag {
    private static final String TAG = "CustomTag";
    final MethodChannel channel = DTMPlugin.CHANNELS.get(0);
    
    @Override
    public void call(final Map<String, Object> map) {
        final Context context = DTMPlugin.getContext();
        if (context != null) {
            HMSLogger.getInstance(context).startMethodExecutionTimer(TAG);
        }
        invokeListenMethod(map);
        if (context != null) {
            HMSLogger.getInstance(context).sendSingleEvent(TAG);
        }
    }

    private void invokeListenMethod(final Map<String, Object> tags) { 
        new Handler(Looper.getMainLooper()).post(() -> channel.invokeMethod("listenToTags", tags));
    }
}
