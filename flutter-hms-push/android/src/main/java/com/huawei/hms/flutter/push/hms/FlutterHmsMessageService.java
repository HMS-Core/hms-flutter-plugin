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

package com.huawei.hms.flutter.push.hms;

import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import com.huawei.hms.common.ResolvableApiException;
import com.huawei.hms.flutter.push.constants.Param;
import com.huawei.hms.flutter.push.constants.PushIntent;
import com.huawei.hms.flutter.push.logger.HMSLogger;
import com.huawei.hms.flutter.push.receiver.BackgroundMessageBroadcastReceiver;
import com.huawei.hms.flutter.push.utils.ApplicationUtils;
import com.huawei.hms.flutter.push.utils.MapUtils;
import com.huawei.hms.flutter.push.utils.RemoteMessageUtils;
import com.huawei.hms.flutter.push.utils.Utils;
import com.huawei.hms.push.HmsMessageService;
import com.huawei.hms.push.RemoteMessage;
import com.huawei.hms.push.SendException;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * class FlutterHmsMessageService
 *
 * @since 4.0.4
 */
public class FlutterHmsMessageService extends HmsMessageService {
    private static final String TAG = FlutterHmsMessageService.class.getSimpleName();

    @Override
    public void onNewToken(String token) {
        super.onNewToken(token);
        if (PluginContext.getContext() != null) {
            HMSLogger.getInstance(PluginContext.getContext()).sendPeriodicEvent("onNewToken");
            Log.d(TAG, "Token received");
            Utils.sendIntent(PluginContext.getContext(), PushIntent.TOKEN_INTENT_ACTION, PushIntent.TOKEN, token);
        }
    }

    /**
     * Called when the token is obtained from the Push Kit server through the getToken(String subjectId) method of
     * HmsInstanceId in the multi-sender scenario.
     * Bundle contains some extra return data, which can be obtained through key values such as HmsMessageService.SUBJECT_ID.
     *
     * @param token Token returned by the HMS Core Push SDK.
     * @param bundle Other data returned by the Push SDK except tokens.
     */
    @Override
    public void onNewToken(String token, Bundle bundle) {
        super.onNewToken(token, bundle);
        if (PluginContext.getContext() != null) {
            HMSLogger.getInstance(PluginContext.getContext()).sendPeriodicEvent("onMultiSenderNewToken");
            Log.d(TAG, "Multi-Sender Token received");
            JSONObject result = new JSONObject();
            try {
                result.put("multiSenderToken", token);
                result.put("bundle", MapUtils.bundleToMap(bundle));
                Utils.sendIntent(PluginContext.getContext(), PushIntent.MULTI_SENDER_TOKEN_INTENT_ACTION,
                    PushIntent.MULTI_SENDER_TOKEN, result.toString());
            } catch (JSONException e) {
                Utils.sendIntent(PluginContext.getContext(), PushIntent.MULTI_SENDER_TOKEN_INTENT_ACTION,
                    PushIntent.MULTI_SENDER_TOKEN_ERROR, e.getMessage());
            }
        }
    }

    @Override
    public void onTokenError(Exception e) {
        super.onTokenError(e);
        if (PluginContext.getContext() != null) {
            HMSLogger.getInstance(PluginContext.getContext()).sendPeriodicEvent("onTokenError");
            Utils.sendIntent(PluginContext.getContext(), PushIntent.TOKEN_INTENT_ACTION, PushIntent.TOKEN_ERROR,
                "Token Error: " + e.getMessage());
        }
    }

    /**
     * Called when applying for a token fails from the Push Kit server through the getToken(String subjectId) method of
     * HmsInstanceId in the multi-sender scenario.
     *
     * @param e Exception of the BaseException type, which is returned when the app fails to call the getToken method to apply for a token.
     * @param bundle Other data returned by the Push SDK except tokens.
     */
    @Override
    public void onTokenError(Exception e, Bundle bundle) {
        super.onTokenError(e, bundle);
        if (PluginContext.getContext() != null) {
            if (e instanceof ResolvableApiException) {
                HMSLogger.getInstance(PluginContext.getContext())
                    .sendSingleEvent("onTokenError", String.valueOf(((ResolvableApiException) e).getStatusCode()));
                PendingIntent resolution = ((ResolvableApiException) e).getResolution();
                if (resolution != null) {
                    try {
                        HMSLogger.getInstance(PluginContext.getContext()).sendSingleEvent("onTokenError");
                        resolution.send();
                    } catch (PendingIntent.CanceledException ex1) {
                        HMSLogger.getInstance(PluginContext.getContext())
                            .sendSingleEvent("onTokenError", ex1.getMessage());
                    }
                }
                Intent resolutionIntent = ((ResolvableApiException) e).getResolutionIntent();
                if (resolutionIntent != null) {
                    HMSLogger.getInstance(PluginContext.getContext()).sendSingleEvent("onTokenError");
                    resolutionIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    PluginContext.getContext().startActivity(resolutionIntent);
                }
            }
            HMSLogger.getInstance(PluginContext.getContext()).sendPeriodicEvent("onMultiSenderTokenError");
            Utils.sendIntent(PluginContext.getContext(), PushIntent.MULTI_SENDER_TOKEN_INTENT_ACTION,
                PushIntent.MULTI_SENDER_TOKEN_ERROR,
                "Token Error: " + e.getMessage() + "Bundle: " + MapUtils.bundleToMap(bundle).toString());
        }
    }

    /**
     * Data Messages will be received on this method.
     * <p>
     * If the app is on foreground, notifications that send with the property
     * "foreground_show": false, will also received here.
     **/
    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        super.onMessageReceived(remoteMessage);

        Context applicationContext = getApplicationContext();
        boolean isApplicationInForeground = ApplicationUtils.isApplicationInForeground(applicationContext);
        if (isApplicationInForeground) {
            HMSLogger.getInstance(PluginContext.getContext()).sendPeriodicEvent("onMessageReceived");
            if (remoteMessage != null) {
                JSONObject jsonObject = new JSONObject(RemoteMessageUtils.toMap(remoteMessage));
                Utils.sendIntent(PluginContext.getContext(), PushIntent.REMOTE_DATA_MESSAGE_INTENT_ACTION,
                    PushIntent.DATA_MESSAGE, jsonObject.toString());
            }
        } else {
            PluginContext.initialize(applicationContext);
            HMSLogger.getInstance(applicationContext).sendPeriodicEvent("onMessageReceived");
            Intent intent = new Intent(applicationContext, BackgroundMessageBroadcastReceiver.class);
            intent.setAction(BackgroundMessageBroadcastReceiver.BACKGROUND_REMOTE_MESSAGE);
            intent.putExtra(Param.MESSAGE.code(), remoteMessage);
            applicationContext.sendBroadcast(intent);
        }
    }

    @Override
    public void onMessageSent(String msgID) {
        super.onMessageSent(msgID);
        HMSLogger.getInstance(PluginContext.getContext()).sendSingleEvent("onMessageSent");
        Log.d(TAG, "RemoteMessage sent successfully");
        Utils.sendIntent(PluginContext.getContext(), PushIntent.REMOTE_MESSAGE_SENT_DELIVERED_ACTION,
            PushIntent.REMOTE_MESSAGE, "Sent Remote message with id: " + msgID);
    }

    @Override
    public void onSendError(String msgId, Exception e) {
        super.onSendError(msgId, e);
        HMSLogger.getInstance(PluginContext.getContext()).sendSingleEvent("onSendError");
        int errCode = ((SendException) e).getErrorCode();
        String errInfo = e.getMessage();
        Log.d(TAG, "RemoteMessage sent error, msgid: " + msgId + ", exception: " + e.getMessage());
        Utils.sendIntent(PluginContext.getContext(), PushIntent.REMOTE_MESSAGE_SENT_DELIVERED_ACTION,
            PushIntent.REMOTE_MESSAGE_ERROR,
            "onSendError for msgId: " + msgId + ", Error Code: " + errCode + ", Error Info: " + errInfo);
    }

    @Override
    public void onMessageDelivered(String msgId, Exception e) {
        super.onMessageDelivered(msgId, e);
        HMSLogger.getInstance(PluginContext.getContext()).sendSingleEvent("onMessageDelivered");
        if (e == null) {
            Log.d(TAG, "RemoteMessage delivered successfully");
            Utils.sendIntent(PluginContext.getContext(), PushIntent.REMOTE_MESSAGE_SENT_DELIVERED_ACTION,
                PushIntent.REMOTE_MESSAGE, "Delivered remote message with id: " + msgId);
        } else {
            int errCode = ((SendException) e).getErrorCode();
            if (errCode == 0) {
                // 0 => RESULT_SUCCESS
                Log.d(TAG, "RemoteMessage delivered successfully");
                Utils.sendIntent(PluginContext.getContext(), PushIntent.REMOTE_MESSAGE_SENT_DELIVERED_ACTION,
                    PushIntent.REMOTE_MESSAGE, "Delivered remote message with id: " + msgId);
            } else {
                Log.d(TAG, "RemoteMessage deliver error, msgid " + msgId + ", exception " + e.getMessage() + ", code "
                    + errCode);
                Utils.sendIntent(PluginContext.getContext(), PushIntent.REMOTE_MESSAGE_SENT_DELIVERED_ACTION,
                    PushIntent.REMOTE_MESSAGE,
                    "RemoteMessage deliver error, msgid " + msgId + ", exception " + e.getMessage() + ", code "
                        + errCode);
            }
        }
    }

    @Override
    public void onDeletedMessages() {
        super.onDeletedMessages();
        HMSLogger.getInstance(PluginContext.getContext()).sendPeriodicEvent("onDeletedMessages");
        Log.d(TAG, "onDeletedMessages");
    }
}
