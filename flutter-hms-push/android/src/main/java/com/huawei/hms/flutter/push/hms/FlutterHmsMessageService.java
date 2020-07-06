/*
Copyright (c) Huawei Technologies Co., Ltd. 2012-2020. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.push.hms;

import android.util.Log;

import com.huawei.hms.flutter.push.constants.PushIntent;
import com.huawei.hms.flutter.push.utils.Utils;
import com.huawei.hms.push.HmsMessageService;
import com.huawei.hms.push.RemoteMessage;

/**
 * class FlutterHmsMessageService
 *
 * @since 4.0.4
 */
public class FlutterHmsMessageService extends HmsMessageService {
    private static final String TAG = "MyPushService";

    @Override
    public void onNewToken(String token) {
        super.onNewToken(token);
        Log.d(TAG, "token received");
        Utils.sendIntent(PushIntent.TOKEN_INTENT_ACTION, PushIntent.TOKEN, token);
    }

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        super.onMessageReceived(remoteMessage);
        if (remoteMessage.getData().length() > 0) {
            Utils.sendIntent(PushIntent.DATA_MESSAGE_INTENT_ACTION, PushIntent.DATA_MESSAGE, remoteMessage.getData());
            Log.d(TAG, "Message data received");
        }
    }

    @Override
    public void onMessageSent(String s) {
        super.onMessageSent(s);
    }

    @Override
    public void onSendError(String s, Exception e) {
        super.onSendError(s, e);
    }
}
