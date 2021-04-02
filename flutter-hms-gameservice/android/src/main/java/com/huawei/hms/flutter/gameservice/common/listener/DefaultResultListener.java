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

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;

import androidx.annotation.NonNull;

import com.huawei.hmf.tasks.OnFailureListener;
import com.huawei.hmf.tasks.OnSuccessListener;
import com.huawei.hms.common.ApiException;
import com.huawei.hms.flutter.gameservice.common.Constants;
import com.huawei.hms.flutter.gameservice.common.utils.Converter;
import com.huawei.hms.flutter.gameservice.common.utils.HMSLogger;
import com.huawei.hms.flutter.gameservice.common.utils.ValueGetter;

import io.flutter.plugin.common.MethodChannel.Result;

import java.io.ByteArrayOutputStream;

public class DefaultResultListener<T> implements OnSuccessListener<T>, OnFailureListener {
    //Internal Flutter Result instance that will be initialized during construction.
    private Result mResult;

    // Application Context.
    private Activity activity;

    // The method name which has initiated this listener.
    private String clientName;

    private String methodName;

    private HMSLogger hmsLogger;

    public DefaultResultListener(final @NonNull Result result, @NonNull Activity activity, final String methodName) {
        this.mResult = result;
        this.activity = activity;
        this.clientName = ValueGetter.methodNameExtractor(methodName).first;
        this.methodName = methodName;
        hmsLogger = HMSLogger.getInstance(activity.getApplicationContext());
    }

    @Override
    public void onSuccess(T o) {
        hmsLogger.sendSingleEvent(methodName);
        if (o instanceof String) {
            mResult.success(o);
        } else if (o instanceof Integer) {
            mResult.success(o);
        } else if (o instanceof Intent) {
            activity.startActivityForResult((Intent) o, 13);
            mResult.success(true);
        } else if (o instanceof Void || o == null) {
            mResult.success(true);
        } else if (o instanceof Boolean) {
            mResult.success(o);
        } else if (o instanceof Bitmap) {
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            ((Bitmap) o).compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream);
            mResult.success(byteArrayOutputStream.toByteArray());
        } else {
            mResult.success(Converter.toMap(o, clientName));
        }
    }

    @Override
    public void onFailure(Exception e) {
        if (e instanceof ApiException) {
            final ApiException apiException = (ApiException) e;
            final int returnCode = apiException.getStatusCode();
            mResult.error(Integer.toString(returnCode), apiException.getMessage(), null);
            hmsLogger.sendSingleEvent(methodName, Integer.toString(returnCode));
        } else {
            mResult.error(Constants.UNKNOWN_ERROR, e.getMessage(), null);
            hmsLogger.sendSingleEvent(methodName, Constants.UNKNOWN_ERROR);
        }
    }
}
