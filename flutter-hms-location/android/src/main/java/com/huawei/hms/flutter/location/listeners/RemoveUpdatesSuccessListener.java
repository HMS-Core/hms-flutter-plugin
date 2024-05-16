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

package com.huawei.hms.flutter.location.listeners;

import android.content.Context;

import com.huawei.hmf.tasks.OnSuccessListener;
import com.huawei.hms.flutter.location.logger.HMSLogger;

import io.flutter.plugin.common.MethodChannel.Result;

import java.util.Map;

public class RemoveUpdatesSuccessListener<T> implements OnSuccessListener<Void> {
    private final String methodName;

    private final Context context;

    private final Result result;

    private final Integer id;

    private final Map<Integer, T> map;

    public RemoveUpdatesSuccessListener(final String methodName, final Context context, final Result result,
        final Integer id, final Map<Integer, T> map) {
        this.methodName = methodName;
        this.context = context;
        this.result = result;
        this.id = id;
        this.map = map;
    }

    @Override
    public void onSuccess(final Void avoid) {
        map.remove(id);
        HMSLogger.getInstance(context).sendSingleEvent(methodName);
        result.success(null);
    }
}
