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

import com.huawei.hms.common.api.CommonStatusCodes;
import com.huawei.hms.flutter.account.util.Constants;
import com.huawei.hms.support.api.client.Status;
import com.huawei.hms.support.sms.common.ReadSmsConstant;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class CommonSmsListener extends BroadcastReceiver {
    private static final String TAG = CommonSmsListener.class.getSimpleName();

    private final MethodChannel methodChannel;

    public CommonSmsListener(MethodChannel channel) {
        this.methodChannel = channel;
    }

    @Override
    public void onReceive(Context context, Intent intent) {
        Bundle bundle = intent.getExtras();
        if (bundle != null) {
            Status status = bundle.getParcelable(ReadSmsConstant.EXTRA_STATUS);
            assert status != null;
            Map<String, Object> args = new HashMap<>();
            if (status.getStatusCode() == CommonStatusCodes.SUCCESS) {
                if (bundle.containsKey(ReadSmsConstant.EXTRA_SMS_MESSAGE)) {
                    String message = bundle.getString(ReadSmsConstant.EXTRA_SMS_MESSAGE);
                    args.put("message", message);
                    methodChannel.invokeMethod("readSms", args);
                }
            } else if (status.getStatusCode() == CommonStatusCodes.TIMEOUT) {
                Log.i(TAG, "TIME OUT FOR SMS RECEIVER");
                args.put("errorCode", Constants.SMS_VERIFICATION_TIME_OUT);
                methodChannel.invokeMethod("timeOut", args);
            } else {
                Log.i(TAG, "Error while receiving sms");
            }
        }
    }
}
