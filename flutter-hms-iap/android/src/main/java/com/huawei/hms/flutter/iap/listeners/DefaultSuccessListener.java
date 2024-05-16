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

package com.huawei.hms.flutter.iap.listeners;

import static com.huawei.hms.flutter.iap.utils.JSONUtils.getJSONFromProductInfoResult;

import com.google.gson.Gson;

import com.huawei.hmf.tasks.OnSuccessListener;
import com.huawei.hms.flutter.iap.logger.HMSLogger;
import com.huawei.hms.iap.entity.ProductInfoResult;

import io.flutter.plugin.common.MethodChannel.Result;

public class DefaultSuccessListener<T> implements OnSuccessListener<T> {
    private final Result mResult;

    private final Gson mGson;

    private final HMSLogger hmsLogger;

    private final String methodName;

    public DefaultSuccessListener(final Result result, final Gson gson, final HMSLogger logger, final String method) {
        mResult = result;
        mGson = gson;
        hmsLogger = logger;
        methodName = method;
    }

    @Override
    public void onSuccess(final T o) {
        hmsLogger.sendSingleEvent(methodName);
        if (o instanceof ProductInfoResult) {
            mResult.success(getJSONFromProductInfoResult((ProductInfoResult) o).toString());
        } else {
            mResult.success(mGson.toJson(o));
        }
    }
}
