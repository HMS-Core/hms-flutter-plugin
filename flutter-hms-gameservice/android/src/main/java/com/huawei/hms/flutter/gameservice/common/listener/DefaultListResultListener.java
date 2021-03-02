/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.gameservice.common.listener;

import android.content.Context;

import com.huawei.hmf.tasks.OnFailureListener;
import com.huawei.hmf.tasks.OnSuccessListener;
import com.huawei.hms.common.ApiException;
import com.huawei.hms.flutter.gameservice.common.Constants;
import com.huawei.hms.flutter.gameservice.common.utils.Converter;
import com.huawei.hms.flutter.gameservice.common.utils.HMSLogger;

import io.flutter.plugin.common.MethodChannel;

import java.util.List;

public class DefaultListResultListener<T> implements OnSuccessListener<List<T>>, OnFailureListener {
    private final MethodChannel.Result mResult;

    private final Class<T> type;

    private String methodName;

    private HMSLogger hmsLogger;

    public DefaultListResultListener(final MethodChannel.Result result, Class<T> type, Context context,
        String methodName) {
        mResult = result;
        this.type = type;
        this.methodName = methodName;
        hmsLogger = HMSLogger.getInstance(context);
    }

    @Override
    public void onSuccess(final List<T> o) {
        hmsLogger.sendSingleEvent(methodName);
        mResult.success(Converter.listResponseToMap(o, type));
    }

    @Override
    public void onFailure(Exception e) {
        if (e instanceof ApiException) {
            final ApiException apiException = (ApiException) e;
            final int returnCode = apiException.getStatusCode();
            hmsLogger.sendSingleEvent(methodName, Integer.toString(returnCode));
            mResult.error(Integer.toString(returnCode), apiException.getMessage(), null);
        } else {
            hmsLogger.sendSingleEvent(methodName, Constants.UNKNOWN_ERROR);
            mResult.error(Constants.UNKNOWN_ERROR, e.getMessage(), null);
        }
    }
}
