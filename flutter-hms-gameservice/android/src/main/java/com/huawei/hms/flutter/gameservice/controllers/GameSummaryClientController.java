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
import android.util.Pair;

import com.huawei.hms.flutter.gameservice.common.Constants;
import com.huawei.hms.flutter.gameservice.common.listener.DefaultResultListener;
import com.huawei.hms.flutter.gameservice.common.utils.ValueGetter;
import com.huawei.hms.jos.games.GameSummaryClient;
import com.huawei.hms.jos.games.Games;
import com.huawei.hms.jos.games.gamesummary.GameSummary;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class GameSummaryClientController {
    private Activity activity;

    private GameSummaryClient gameSummaryClient;

    public GameSummaryClientController(Activity activity) {
        this.activity = activity;
        this.gameSummaryClient = Games.getGameSummaryClient(activity);
    }

    public void onMethodCall(final MethodCall call, final MethodChannel.Result result) {
        final Pair<String, String> methodNamePair = ValueGetter.methodNameExtractor(call);
        Constants.GamesSummaryClientMethods methodName = Constants.GamesSummaryClientMethods.getEnum(
            methodNamePair.second);
        if (methodName == Constants.GamesSummaryClientMethods.GET_LOCAL_GAME_SUMMARY) {
            getLocalGameSummary(call, result);
        } else if (methodName == Constants.GamesSummaryClientMethods.GET_GAME_SUMMARY) {
            getGameSummary(call, result);
        }
    }

    private void getLocalGameSummary(final MethodCall call, final MethodChannel.Result result) {
        DefaultResultListener<GameSummary> listener = new DefaultResultListener<>(result, activity, call.method);
        gameSummaryClient.getLocalGameSummary().addOnSuccessListener(listener).addOnFailureListener(listener);
    }

    private void getGameSummary(final MethodCall call, final MethodChannel.Result result) {
        DefaultResultListener<GameSummary> listener = new DefaultResultListener<>(result, activity, call.method);
        gameSummaryClient.getGameSummary().addOnSuccessListener(listener).addOnFailureListener(listener);
    }
}
