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

package com.huawei.hms.flutter.gameservice.controllers;

import android.app.Activity;
import android.util.Log;
import android.util.Pair;

import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.gameservice.common.Constants;
import com.huawei.hms.flutter.gameservice.common.listener.DefaultResultListener;
import com.huawei.hms.flutter.gameservice.common.utils.HMSLogger;
import com.huawei.hms.flutter.gameservice.common.utils.ValueGetter;
import com.huawei.hms.jos.games.AppPlayerInfo;
import com.huawei.hms.jos.games.Games;
import com.huawei.hms.jos.games.PlayersClient;
import com.huawei.hms.jos.games.player.GameTrialProcess;
import com.huawei.hms.jos.games.player.Player;
import com.huawei.hms.jos.games.player.PlayerExtraInfo;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class PlayersClientController {
    private Activity activity;

    private PlayersClient playersClient;

    private MethodChannel channel;

    public PlayersClientController(Activity activity, MethodChannel channel) {
        this.activity = activity;
        this.playersClient = Games.getPlayersClient(activity);
        this.channel = channel;
    }

    public void onMethodCall(final MethodCall call, final MethodChannel.Result result) {
        final Pair<String, String> methodNamePair = ValueGetter.methodNameExtractor(call);
        switch (Constants.PlayersClientMethods.getEnum(methodNamePair.second)) {
            case GET_CURRENT_PLAYER:
                getCurrentPlayer(call, result);
                break;
            case GET_GAME_PLAYER:
                getGamePlayer(call, result);
                break;
            case GET_CACHE_PLAYER_ID:
                getCachePlayerId(call, result);
                break;
            case GET_PLAYER_EXTRA_INFO:
                getPlayerExtraInfo(call, result);
                break;
            case SUBMIT_PLAYER_EVENT:
                submitPlayerEvent(call, result);
                break;
            case SAVE_PLAYER_INFO:
                savePlayerInfo(call, result);
                break;
            case SET_GAME_TRIAL_PROCESS:
                setGameTrialProcess(call.method);
                break;
        }
    }

    private void getCurrentPlayer(final MethodCall call, final MethodChannel.Result result) {
        DefaultResultListener<Player> listener = new DefaultResultListener<>(result, activity, call.method);
        playersClient.getCurrentPlayer().addOnSuccessListener(listener).addOnFailureListener(listener);
    }

    private void getGamePlayer(final MethodCall call, final MethodChannel.Result result) {
        DefaultResultListener<Player> listener = new DefaultResultListener<>(result, activity, call.method);
        Task<Player> getGamePlayerTask;
        Boolean isRequirePlayerId = call.argument("isRequirePlayerId");
        // If isRequirePlayerId is present call overloaded method.
        if (isRequirePlayerId != null) {
            getGamePlayerTask = playersClient.getGamePlayer(isRequirePlayerId);
        } else {
            getGamePlayerTask = playersClient.getGamePlayer();
        }
        getGamePlayerTask.addOnSuccessListener(listener).addOnFailureListener(listener);
    }

    private void getCachePlayerId(final MethodCall call, final MethodChannel.Result result) {
        DefaultResultListener<String> listener = new DefaultResultListener<>(result, activity, call.method);
        playersClient.getCachePlayerId().addOnSuccessListener(listener).addOnFailureListener(listener);
    }

    private void getPlayerExtraInfo(final MethodCall call, final MethodChannel.Result result) {
        DefaultResultListener<PlayerExtraInfo> listener = new DefaultResultListener<>(result, activity, call.method);
        String transactionId = ValueGetter.getString("transactionId", call);
        playersClient.getPlayerExtraInfo(transactionId).addOnSuccessListener(listener).addOnFailureListener(listener);
    }

    private void submitPlayerEvent(final MethodCall call, final MethodChannel.Result result) {
        DefaultResultListener<String> listener = new DefaultResultListener<>(result, activity, call.method);
        String eventId = ValueGetter.getString("eventId", call);
        String eventType = ValueGetter.getString("eventType", call);
        String playerId = call.argument("playerId");
        Task<String> submitPlayerTask;
        // If playerId is present call overloaded method.
        if (playerId != null) {
            submitPlayerTask = playersClient.submitPlayerEvent(playerId, eventId, eventType);
        } else {
            submitPlayerTask = playersClient.submitPlayerEvent(eventId, eventType);
        }
        submitPlayerTask.addOnSuccessListener(listener).addOnFailureListener(listener);
    }

    private void savePlayerInfo(final MethodCall call, final MethodChannel.Result result) {
        DefaultResultListener<Void> listener = new DefaultResultListener<>(result, activity, call.method);
        playersClient.savePlayerInfo(callToAppPlayerInfo(call))
            .addOnSuccessListener(listener)
            .addOnFailureListener(listener);
    }

    private void setGameTrialProcess(final String methodName) {
        // Obtain player information.
        GameTrialProcess gameTrialProcess = new GameTrialProcess() {
            @Override
            public void onTrialTimeout() {
                Log.i("PlayersController", "onTrialTimeout: ");
                channel.invokeMethod("gameTrialCallback#onTrialTimeout", null);
                HMSLogger.getInstance(activity.getApplicationContext())
                    .sendPeriodicEvent(methodName + ".onTrialTimeout");
            }

            @Override
            public void onCheckRealNameResult(boolean hasRealName) {
                Log.i("PlayersController", "onCheckRealNameResult: " + hasRealName);
                channel.invokeMethod("gameTrialCallback#onCheckRealNameResult", hasRealName);
                HMSLogger.getInstance(activity.getApplicationContext())
                    .sendPeriodicEvent(methodName + ".onCheckRealNameResult");
            }
        };
        playersClient.setGameTrialProcess(gameTrialProcess);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(methodName);
    }

    private AppPlayerInfo callToAppPlayerInfo(final MethodCall call) {
        AppPlayerInfo appPlayerInfo = new AppPlayerInfo();
        appPlayerInfo.rank = call.argument("rank");
        appPlayerInfo.area = call.argument("area");
        appPlayerInfo.role = call.argument("role");
        appPlayerInfo.sociaty = call.argument("society");
        appPlayerInfo.playerId = call.argument("playerId");
        appPlayerInfo.openId = call.argument("openId");
        return appPlayerInfo;
    }
}