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

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.gameservice.common.Constants;
import com.huawei.hms.flutter.gameservice.common.Constants.HMSLoggerMethods;
import com.huawei.hms.flutter.gameservice.common.utils.HMSLogger;
import com.huawei.hms.flutter.gameservice.common.utils.ValueGetter;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class GameServiceController implements MethodChannel.MethodCallHandler {
    private AchievementClientController achievementClientController;

    private ArchiveClientController archiveClientController;

    private BuoyClientController buoyClientController;

    private EventsClientController eventsClientController;

    private GamePlayerStatisticsClientController gamePlayerStatisticsClientController;

    private GamesClientController gamesClientController;

    private GameSummaryClientController gameSummaryClientController;

    private PlayersClientController playersClientController;

    private RankingsClientController rankingsClientController;

    private Activity activity;

    public GameServiceController(Activity activity, final @NonNull MethodChannel channel) {
        this.activity = activity;
        generateModules(activity, channel);
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final MethodChannel.Result result) {
        final Pair<String, String> methodNamePair = ValueGetter.methodNameExtractor(call);
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer(call.method);
        switch (Constants.ClientNames.getEnum(methodNamePair.first)) {
            case ACHIEVEMENT:
                achievementClientController.onMethodCall(call, result);
                break;
            case ARCHIVES:
                archiveClientController.onMethodCall(call, result);
                break;
            case BUOY:
                buoyClientController.onMethodCall(call, result);
                break;
            case EVENTS:
                eventsClientController.onMethodCall(call, result);
                break;
            case GAME_PLAYER_STATS:
                gamePlayerStatisticsClientController.onMethodCall(call, result);
                break;
            case GAMES:
                gamesClientController.onMethodCall(call, result);
                break;
            case GAME_SUMMARY:
                gameSummaryClientController.onMethodCall(call, result);
                break;
            case PLAYERS:
                playersClientController.onMethodCall(call, result);
                break;
            case RANKINGS:
                rankingsClientController.onMethodCall(call, result);
                break;
            case HMS_LOGGER:
                onMethodCallHmsLogger(methodNamePair.second, result);
        }
    }

    private void onMethodCallHmsLogger(final String methodName, final MethodChannel.Result result) {
        if (HMSLoggerMethods.getEnum(methodName).equals(HMSLoggerMethods.ENABLE_LOGGER)) {
            HMSLogger.getInstance(activity.getApplicationContext()).enableLogger();
            result.success(true);
        } else if (HMSLoggerMethods.getEnum(methodName).equals(HMSLoggerMethods.DISABLE_LOGGER)) {
            HMSLogger.getInstance(activity.getApplicationContext()).disableLogger();
            result.success(true);
        } else {
            result.notImplemented();
        }
    }

    private void generateModules(Activity activity, final MethodChannel channel) {
        achievementClientController = new AchievementClientController(activity);
        archiveClientController = new ArchiveClientController(activity);
        buoyClientController = new BuoyClientController(activity);
        eventsClientController = new EventsClientController(activity);
        gamePlayerStatisticsClientController = new GamePlayerStatisticsClientController(activity);
        gamesClientController = new GamesClientController(activity);
        gameSummaryClientController = new GameSummaryClientController(activity);
        playersClientController = new PlayersClientController(activity, channel);
        rankingsClientController = new RankingsClientController(activity);
    }
}
