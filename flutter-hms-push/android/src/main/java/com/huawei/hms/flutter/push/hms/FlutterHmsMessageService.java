/*
Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

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

import com.huawei.hms.flutter.push.PushPlugin;
import com.huawei.hms.flutter.push.constants.PushIntent;
import com.huawei.hms.flutter.push.logger.HMSLogger;
import com.huawei.hms.flutter.push.utils.RemoteMessageUtils;
import com.huawei.hms.flutter.push.utils.Utils;
import com.huawei.hms.push.HmsMessageService;
import com.huawei.hms.push.RemoteMessage;
import com.huawei.hms.push.SendException;

import org.json.JSONObject;

/**
 * class FlutterHmsMessageService
 *
 * @since 4.0.4
 */
public class FlutterHmsMessageService extends HmsMessageService {
    private static final String TAG = "MyPushService";

    private HMSLogger hmsLogger = HMSLogger.getInstance(PushPlugin.getContext());

    @Override
    public void onNewToken(String token) {
        super.onNewToken(token);
        hmsLogger.sendPeriodicEvent("onNewToken");
        Log.d(TAG, "token received");
        Utils.sendIntent(PushIntent.TOKEN_INTENT_ACTION, PushIntent.TOKEN, token);
    }

    @Override
    public void onTokenError(Exception e) {
        super.onTokenError(e);
        hmsLogger.sendPeriodicEvent("onTokenError");
        Utils.sendIntent(PushIntent.TOKEN_INTENT_ACTION, PushIntent.TOKEN_ERROR, "Token Error: " + e.getMessage());
    }

    /**
     * Data Messages will be received on this method.
     *
     * If the app is on foreground, notifications that send with the property
     * "foreground_show": false, will also received here.
    **/
    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        super.onMessageReceived(remoteMessage);
        hmsLogger.sendPeriodicEvent("onMessageReceived");
        if (remoteMessage != null) {
            JSONObject jsonObject = new JSONObject(RemoteMessageUtils.fromMap(remoteMessage));
            Utils.sendIntent(PushIntent.DATA_MESSAGE_INTENT_ACTION, PushIntent.DATA_MESSAGE, jsonObject.toString());
        }
    }

    @Override
    public void onMessageSent(String msgID) {
        super.onMessageSent(msgID);
        hmsLogger.sendSingleEvent("onMessageSent");
        Log.d(TAG, "RemoteMessage sent successfully");
        Utils.sendIntent(PushIntent.REMOTE_MESSAGE_SENT_DELIVERED_ACTION, PushIntent.REMOTE_MESSAGE,
                "Sent Remote message with id: " + msgID);
    }

    @Override
    public void onSendError(String msgId, Exception e) {
        super.onSendError(msgId, e);
        hmsLogger.sendSingleEvent("onSendError");
        int errCode = ((SendException) e).getErrorCode();
        String errInfo = e.getMessage();
        Log.d(TAG, "RemoteMessage sent error, msgid: " + msgId + ", exception: " + e.getMessage());
        Utils.sendIntent(PushIntent.REMOTE_MESSAGE_SENT_DELIVERED_ACTION, PushIntent.REMOTE_MESSAGE_ERROR,
                "onSendError for msgId: " + msgId + ", Error Code: " + errCode + ", Error Info: " + errInfo);
    }

    @Override
    public void onMessageDelivered(String msgId, Exception e) {
        super.onMessageDelivered(msgId, e);
        hmsLogger.sendSingleEvent("onMessageDelivered");
        if (e == null) {
            Log.d(TAG, "RemoteMessage delivered successfully");
            Utils.sendIntent(PushIntent.REMOTE_MESSAGE_SENT_DELIVERED_ACTION, PushIntent.REMOTE_MESSAGE,
                    "Delivered remote message with id: " + msgId);
        } else {
            int errCode = ((SendException) e).getErrorCode();
            if (errCode == 0) {
                // 0 => RESULT_SUCCESS
                Log.d(TAG, "RemoteMessage delivered successfully");
                Utils.sendIntent(PushIntent.REMOTE_MESSAGE_SENT_DELIVERED_ACTION, PushIntent.REMOTE_MESSAGE,
                        "Delivered remote message with id: " + msgId);
            } else {
                Log.d(TAG, "RemoteMessage deliver error, msgid " + msgId + ", exception "
                        + e.getMessage() + ", code " + errCode);
                Utils.sendIntent(PushIntent.REMOTE_MESSAGE_SENT_DELIVERED_ACTION, PushIntent.REMOTE_MESSAGE,
                        "RemoteMessage deliver error, msgid " + msgId + ", exception "
                                + e.getMessage() + ", code " + errCode);
            }
        }
    }

    @Override
    public void onDeletedMessages() {
        super.onDeletedMessages();
        hmsLogger.sendPeriodicEvent("onDeletedMessages");
        Log.d(TAG, "onDeletedMessages");
    }
}
