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

import com.huawei.hms.flutter.gameservice.common.Constants.GamePlayerStatisticsClientMethods;
import com.huawei.hms.flutter.gameservice.common.listener.DefaultResultListener;
import com.huawei.hms.flutter.gameservice.common.utils.ValueGetter;
import com.huawei.hms.jos.games.Games;
import com.huawei.hms.jos.games.playerstats.GamePlayerStatistics;
import com.huawei.hms.jos.games.playerstats.GamePlayerStatisticsClient;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class GamePlayerStatisticsClientController {

    private Activity activity;

    private GamePlayerStatisticsClient gamePlayerStatisticsClient;

    public GamePlayerStatisticsClientController(Activity activity) {
        this.activity = activity;
        this.gamePlayerStatisticsClient = Games.getGamePlayerStatsClient(activity);
    }

    public void onMethodCall(final MethodCall call, final MethodChannel.Result result) {
        final Pair<String, String> methodNamePair = ValueGetter.methodNameExtractor(call);
        if (GamePlayerStatisticsClientMethods.getEnum(methodNamePair.second)
            == GamePlayerStatisticsClientMethods.GET_GAME_PLAYER_STATISTICS) {
            boolean isRealTime = ValueGetter.getBoolean("isRealTime", call);
            DefaultResultListener<GamePlayerStatistics> listener = new DefaultResultListener<>(result, activity,
                call.method);
            gamePlayerStatisticsClient.getGamePlayerStatistics(isRealTime)
                .addOnSuccessListener(listener)
                .addOnFailureListener(listener);
        }
    }
}
