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

package com.huawei.hms.flutter.account.listeners;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import com.huawei.hms.flutter.account.util.Constants;
import com.huawei.hms.support.api.client.Status;
import com.huawei.hms.support.sms.common.ReadSmsConstant;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class ReadSmsListener extends BroadcastReceiver {
    private static final String TAG = ReadSmsListener.class.getSimpleName();

    private final MethodChannel mChannel;

    public ReadSmsListener(MethodChannel channel) {
        this.mChannel = channel;
    }

    @Override
    public void onReceive(Context context, Intent intent) {
        Bundle bundle = intent.getExtras();
        if (bundle != null) {
            Status status0 = bundle.getParcelable(ReadSmsConstant.EXTRA_STATUS);
            assert status0 != null;
            Map<String, Object> args = new HashMap<>();
            if (status0.getStatusCode() == ReadSmsConstant.TIMEOUT) {
                Log.i(TAG, "TIME OUT FOR SMS RECEIVER");
                args.put("errorCode", Constants.SMS_VERIFICATION_TIME_OUT);
                mChannel.invokeMethod("timeOut", args);
            } else if (status0.getStatusCode() == ReadSmsConstant.FAIL) {
                Log.i(TAG, "FAIL FOR SMS RECEIVER");
                args.put("errorCode", Constants.SMS_VERIFICATION_FAILURE);
                mChannel.invokeMethod("failed", args);
            } else if (status0.getStatusCode() == ReadSmsConstant.SUCCESS) {
                if (bundle.containsKey(ReadSmsConstant.EXTRA_SMS_MESSAGE)) {
                    String message = bundle.getString(ReadSmsConstant.EXTRA_SMS_MESSAGE);
                    args.put("message", message);
                    mChannel.invokeMethod("readSms", args);
                }
            } else {
                Log.i(TAG, "Error while receiving sms.");
            }
        }
    }
}
