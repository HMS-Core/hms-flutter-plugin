/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.mlimage.utils;

import android.content.Context;

import androidx.annotation.Nullable;

import com.huawei.hms.flutter.mlimage.logger.HMSLogger;
import com.huawei.hms.mlsdk.common.MLException;

import java.lang.ref.WeakReference;

import io.flutter.plugin.common.MethodChannel;

public class MLResponseHandler {
    private static volatile MLResponseHandler instance;
    private final WeakReference<Context> weakContext;

    private MethodChannel.Result mResult;
    private String tag;
    private String callName;

    private MLResponseHandler(final Context context) {
        weakContext = new WeakReference<>(context);
    }

    public static synchronized MLResponseHandler getInstance(final Context context) {
        if (instance == null) {
            synchronized (MLResponseHandler.class) {
                if (instance == null) {
                    instance = new MLResponseHandler(context.getApplicationContext());
                }
            }
        }
        return instance;
    }

    private synchronized Context getContext() {
        return weakContext.get();
    }

    public synchronized void setup(String t, String c, MethodChannel.Result r) {
        tag = t;
        callName = c;
        mResult = r;

        HMSLogger.getInstance(getContext()).startMethodExecutionTimer(callName);
    }

    public synchronized void success(@Nullable Object response) {
        HMSLogger.getInstance(getContext()).sendSingleEvent(callName);
        mResult.success(response);
    }

    public synchronized void exception(Exception e) {
        if (e instanceof MLException) {
            HMSLogger.getInstance(getContext()).sendSingleEvent(callName, e.getMessage());
            mResult.error(tag, e.getMessage(), ((MLException) e).getErrCode());
        } else {
            HMSLogger.getInstance(getContext()).sendSingleEvent(callName, e.getMessage());
            mResult.error(tag, e.getMessage(), null);
        }
    }

    public synchronized void noService() {
        HMSLogger.getInstance(getContext()).sendSingleEvent(callName, "-1");
        mResult.error(tag, "Uninitialized analyzer", null);
    }
}
