/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.nearbyservice.message;

import android.app.Activity;
import android.app.PendingIntent;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.nearbyservice.logger.HMSLogger;
import com.huawei.hms.flutter.nearbyservice.utils.FromMap;
import com.huawei.hms.flutter.nearbyservice.utils.HmsHelper;
import com.huawei.hms.flutter.nearbyservice.utils.ToMap;
import com.huawei.hms.flutter.nearbyservice.utils.constants.CallbackTypes;
import com.huawei.hms.flutter.nearbyservice.utils.constants.ErrorCodes;
import com.huawei.hms.nearby.Nearby;
import com.huawei.hms.nearby.message.GetOption;
import com.huawei.hms.nearby.message.Message;
import com.huawei.hms.nearby.message.MessageEngine;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import java.util.Map;

public class MessageMethodHandler implements MethodChannel.MethodCallHandler {

    private static final String TAG = "MessageMethodHandler";

    private static final String PENDING_MESSAGE_ACTION = "com.huawei.hms.flutter.nearby.PENDING_MESSAGE";

    private final MessageEngineStreamHandler messageEngineStreamHandler;

    private final HmsPendingGetCallback pendingGetCallback;

    private final MessageBroadcastReceiver broadcastReceiver;

    private final MessageEngine messageEngine;

    private final Activity activity;

    private PendingIntent pendingMsgIntent;

    public MessageMethodHandler(MethodChannel methodChannel, EventChannel eventChannel, Activity activity) {
        this.activity = activity;
        this.messageEngine = Nearby.getMessageEngine(activity);
        this.messageEngineStreamHandler = new MessageEngineStreamHandler(activity);
        eventChannel.setStreamHandler(messageEngineStreamHandler);
        HmsPendingMessageHandler pendingMessageHandler = new HmsPendingMessageHandler(methodChannel,
            activity.getApplicationContext());
        this.pendingGetCallback = new HmsPendingGetCallback(methodChannel, activity.getApplicationContext());
        this.broadcastReceiver = new MessageBroadcastReceiver(pendingMessageHandler);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer(call.method);
        switch (call.method) {
            case "put":
                put(call, result);
                break;
            case "putWithOption":
                putWithOption(call, result);
                break;
            case "registerStatusCallback":
                registerStatusCallback(call, result);
                break;
            case "get":
                get(call, result);
                break;
            case "getWithOption":
                getWithOption(call, result);
                break;
            case "getPending":
                getPending(call, result);
                break;
            case "unput":
                unput(call, result);
                break;
            case "unregisterStatusCallback":
                unregisterStatusCallback(call, result);
                break;
            case "unget":
                unget(call, result);
                break;
            case "ungetPending":
                ungetPending(call, result);
                break;
            case "dispose":
                dispose(call, result);
                break;
            default:
                result.notImplemented();
                HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent(call.method, ErrorCodes.NOT_FOUND);
                break;
        }
    }

    void put(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "put");
        Message message = HmsHelper.createMessage(ToMap.fromObject(call.argument("message")));
        if (message == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
            Log.e(TAG, "Message is null.");
            result.error(ErrorCodes.NULL_PARAM, "Message is null.", "");
        }

        messageEngine.put(message).addOnSuccessListener(aVoid -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
            Log.i(TAG, "put success");
            HmsHelper.successHandler(result);
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent(call.method, ErrorCodes.ERROR_MESSAGE);
            Log.e(TAG, "put failure | " + e.getMessage());
            HmsHelper.errorHandler(result, ErrorCodes.ERROR_MESSAGE, "put failure | " + e.getMessage(), "");
        });
    }

    void putWithOption(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "putWithOption");
        Message message = HmsHelper.createMessage(ToMap.fromObject(call.argument("message")));
        if (message == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
            Log.e(TAG, "Message is null.");
            result.error(ErrorCodes.NULL_PARAM, "Message is null.", "");
        }

        Map<String, Object> optionMap = ToMap.fromObject(call.argument("putOption"));
        if (optionMap.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
            Log.e(TAG, "PutOption is null.");
            result.error(ErrorCodes.NULL_PARAM, "PutOption is null.", "");
        }

        messageEngine.put(message, HmsHelper.createPutOption(optionMap, messageEngineStreamHandler))
            .addOnSuccessListener(aVoid -> {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
                Log.i(TAG, "putWithOption success");
                HmsHelper.successHandler(result);
            })
            .addOnFailureListener(e -> {
                HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent(call.method, ErrorCodes.ERROR_MESSAGE);
                Log.e(TAG, "putWithOption failure | " + e.getMessage());
                HmsHelper.errorHandler(result, ErrorCodes.ERROR_MESSAGE, "putWithOption failure | " + e.getMessage(),
                    "");
            });
    }

    void registerStatusCallback(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "registerStatusCallback");
        Integer id = FromMap.toInteger("statusCallback", call.argument("statusCallback"));
        if (id == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
            Log.e(TAG, "StatusCallback is null.");
            result.error(ErrorCodes.NULL_PARAM, "StatusCallback is null.", "");
            return;
        }

        messageEngine.registerStatusCallback(messageEngineStreamHandler.createStatusCallback(id))
            .addOnSuccessListener(aVoid -> {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
                Log.i(TAG, "registerStatusCallback success");
                HmsHelper.successHandler(result);
            })
            .addOnFailureListener(e -> {
                HMSLogger.getInstance(activity.getApplicationContext())
                    .sendSingleEvent(call.method, ErrorCodes.ERROR_MESSAGE);
                Log.e(TAG, "registerStatusCallback failure | " + e.getMessage());
                HmsHelper.errorHandler(result, ErrorCodes.ERROR_MESSAGE,
                    "registerStatusCallback failure | " + e.getMessage(), "");
            });
    }

    void get(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "get");
        Integer id = FromMap.toInteger("handler", call.argument("handler"));
        if (id == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
            Log.e(TAG, "MessageHandler is null.");
            result.error(ErrorCodes.NULL_PARAM, "MessageHandler is null.", "");
            return;
        }

        messageEngine.get(messageEngineStreamHandler.createMessageHandler(id)).addOnSuccessListener(aVoid -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
            Log.i(TAG, "get success");
            HmsHelper.successHandler(result);
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent(call.method, ErrorCodes.ERROR_MESSAGE);
            Log.e(TAG, "get failure | " + e.getMessage());
            HmsHelper.errorHandler(result, ErrorCodes.ERROR_MESSAGE, "get failure | " + e.getMessage(), "");
        });
    }

    void getWithOption(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "getWithOption");
        Integer id = FromMap.toInteger("handler", call.argument("handler"));
        if (id == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
            Log.e(TAG, "MessageHandler is null.");
            result.error(ErrorCodes.NULL_PARAM, "MessageHandler is null.", "");
            return;
        }

        Map<String, Object> optionMap = ToMap.fromObject(call.argument("getOption"));
        if (optionMap.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
            Log.e(TAG, "GetOption is null.");
            result.error(ErrorCodes.NULL_PARAM, "GetOption is null.", "");
        }

        messageEngine.get(messageEngineStreamHandler.createMessageHandler(id),
            HmsHelper.createGetOption(optionMap, messageEngineStreamHandler)).addOnSuccessListener(aVoid -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
            Log.i(TAG, "getWithOption success");
            HmsHelper.successHandler(result);
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent(call.method, ErrorCodes.ERROR_MESSAGE);
            Log.e(TAG, "getWithOption failure | " + e.getMessage());
            HmsHelper.errorHandler(result, ErrorCodes.ERROR_MESSAGE, "getWithOption failure | " + e.getMessage(), "");
        });
    }

    void getPending(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "getPending");
        Map<String, Object> optionMap = ToMap.fromObject(call.argument("getOption"));

        GetOption option = null;
        if (!optionMap.isEmpty()) {
            option = HmsHelper.createGetOption(optionMap, pendingGetCallback);
        }

        Intent intent = new Intent();
        intent.setPackage(activity.getPackageName());
        intent.setAction(PENDING_MESSAGE_ACTION);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            pendingMsgIntent = PendingIntent.getBroadcast(activity.getApplicationContext(), 0, intent,
                PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_MUTABLE);
        } else {
            pendingMsgIntent = PendingIntent.getBroadcast(activity.getApplicationContext(), 0, intent,
                PendingIntent.FLAG_UPDATE_CURRENT);
        }
        activity.getApplicationContext().registerReceiver(broadcastReceiver, new IntentFilter(PENDING_MESSAGE_ACTION));

        Task<Void> pendingTask;
        if (option != null) {
            pendingTask = messageEngine.get(pendingMsgIntent, option);
        } else {
            pendingTask = messageEngine.get(pendingMsgIntent);
        }

        pendingTask.addOnSuccessListener(aVoid -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
            Log.i(TAG, "getPending success");
            HmsHelper.successHandler(result);
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent(call.method, ErrorCodes.ERROR_MESSAGE);
            Log.e(TAG, "getPending failure | " + e.getMessage());
            HmsHelper.errorHandler(result, ErrorCodes.ERROR_MESSAGE, "getPending failure | " + e.getMessage(), "");
        });
    }

    void unput(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "unput");
        Message message = HmsHelper.createMessage(ToMap.fromObject(call.argument("message")));
        if (message == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
            Log.e(TAG, "Message is null.");
            result.error(ErrorCodes.NULL_PARAM, "Message is null.", "");
        }

        messageEngine.unput(message).addOnSuccessListener(aVoid -> {
            Map<String, Object> optionMap = ToMap.fromObject(call.argument("putOption"));
            Integer id = null;
            if (!optionMap.isEmpty()) {
                Log.i(TAG, "Put option found.");
                id = FromMap.toInteger("putCallback", optionMap.get("putCallback"));
            }
            if (id != null) {
                messageEngineStreamHandler.removeCallback(CallbackTypes.PUT_CALLBACK, id);
            }

            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
            Log.i(TAG, "unput success");
            HmsHelper.successHandler(result);
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent(call.method, ErrorCodes.ERROR_MESSAGE);
            Log.e(TAG, "unput | " + e.getMessage());
            HmsHelper.errorHandler(result, ErrorCodes.ERROR_MESSAGE, "unput | " + e.getMessage(), "");
        });
    }

    void unregisterStatusCallback(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "unregisterStatusCallback");
        Integer id = FromMap.toInteger("statusCallback", call.argument("statusCallback"));
        if (id == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
            Log.e(TAG, "StatusCallback is null.");
            result.error(ErrorCodes.NULL_PARAM, "StatusCallback is null.", "");
            return;
        }

        HmsStatusCallback statusCallback = HmsStatusCallback.STATUS_CBS.get(id);
        if (statusCallback == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NOT_FOUND);
            Log.e(TAG, "No status callback object found with given id.");
            result.error(ErrorCodes.NOT_FOUND, "No status callback object found with given id.", "");
            return;
        }

        messageEngine.unregisterStatusCallback(statusCallback).addOnSuccessListener(aVoid -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
            Log.i(TAG, "unregisterStatusCallback success");
            messageEngineStreamHandler.removeCallback(CallbackTypes.STATUS_CALLBACK, id);
            HmsHelper.successHandler(result);
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent(call.method, ErrorCodes.ERROR_MESSAGE);
            Log.e(TAG, "unregisterStatusCallback failure | " + e.getMessage());
            HmsHelper.errorHandler(result, ErrorCodes.ERROR_MESSAGE,
                "unregisterStatusCallback failure | " + e.getMessage(), "");
        });
    }

    void unget(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "unget");
        Integer id = FromMap.toInteger("handler", call.argument("handler"));
        if (id == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NULL_PARAM);
            Log.e(TAG, "MessageHandler is null.");
            result.error(ErrorCodes.NULL_PARAM, "MessageHandler is null.", "");
            return;
        }

        HmsMessageHandler messageHandler = HmsMessageHandler.MESSAGE_CBS.get(id);
        if (messageHandler == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method, ErrorCodes.NOT_FOUND);
            Log.e(TAG, "No message handler object found with given id.");
            result.error(ErrorCodes.NOT_FOUND, "No message handler object found with given id.", "");
            return;
        }

        messageEngine.unget(messageHandler).addOnSuccessListener(aVoid -> {
            Map<String, Object> optionMap = ToMap.fromObject(call.argument("getOption"));
            Integer id1 = null;
            if (!optionMap.isEmpty()) {
                Log.i(TAG, "Get option found.");
                id1 = FromMap.toInteger("getCallback", optionMap.get("getCallback"));
            }
            if (id1 != null) {
                messageEngineStreamHandler.removeCallback(CallbackTypes.GET_CALLBACK, id1);
            }

            messageEngineStreamHandler.removeCallback(CallbackTypes.MESSAGE_HANDLER_CALLBACK, id);
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
            Log.i(TAG, "unget success");
            HmsHelper.successHandler(result);
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent(call.method, ErrorCodes.ERROR_MESSAGE);
            Log.e(TAG, "unget failure | " + e.getMessage());
            HmsHelper.errorHandler(result, ErrorCodes.ERROR_MESSAGE, "unget failure | " + e.getMessage(), "");
        });
    }

    void ungetPending(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "ungetPending");

        messageEngine.unget(pendingMsgIntent).addOnSuccessListener(aVoid -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
            Log.i(TAG, "ungetPending success");
            activity.getApplicationContext().unregisterReceiver(broadcastReceiver);
            HmsHelper.successHandler(result);
        }).addOnFailureListener(e -> {
            HMSLogger.getInstance(activity.getApplicationContext())
                .sendSingleEvent(call.method, ErrorCodes.ERROR_MESSAGE);
            Log.e(TAG, "ungetPending failure | " + e.getMessage());
            HmsHelper.errorHandler(result, ErrorCodes.ERROR_MESSAGE, "getPending failure | " + e.getMessage(), "");
        });
    }

    void dispose(MethodCall call, MethodChannel.Result result) {
        Log.i(TAG, "dispose");
        messageEngineStreamHandler.removeAllCallbacks();
        result.success(null);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
        Log.i(TAG, "dispose success");
    }
}
