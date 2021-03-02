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
import android.content.Intent;
import android.util.Pair;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.gameservice.common.Constants;
import com.huawei.hms.flutter.gameservice.common.listener.DefaultListResultListener;
import com.huawei.hms.flutter.gameservice.common.listener.DefaultResultListener;
import com.huawei.hms.flutter.gameservice.common.utils.HMSLogger;
import com.huawei.hms.flutter.gameservice.common.utils.ValueGetter;
import com.huawei.hms.jos.games.Games;
import com.huawei.hms.jos.games.RankingsClient;
import com.huawei.hms.jos.games.ranking.Ranking;
import com.huawei.hms.jos.games.ranking.RankingScore;
import com.huawei.hms.jos.games.ranking.ScoreSubmissionInfo;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class RankingsClientController {
    private Activity activity;

    private RankingsClient rankingsClient;

    public RankingsClientController(@NonNull Activity activity) {
        this.activity = activity;
        this.rankingsClient = Games.getRankingsClient(activity);
    }

    public void onMethodCall(final MethodCall call, final MethodChannel.Result result) {
        final Pair<String, String> methodNamePair = ValueGetter.methodNameExtractor(call);
        switch (Constants.RankingsClientMethods.getEnum(methodNamePair.second)) {
            case GET_TOTAL_RANKINGS_INTENT:
                getTotalRankingsIntent(call, result);
                break;
            case GET_RANKING_INTENT:
                getRankingIntent(call, result);
                break;
            case GET_CURRENT_PLAYER_RANKING_SCORE:
                getCurrentPlayerRankingScore(call, result);
                break;
            case GET_RANKING_SUMMARY:
                getRankingSummary(call, result);
                break;
            case GET_ALL_RANKING_SUMMARIES:
                getAllRankingSummaries(call, result);
                break;
            case GET_MORE_RANKING_SCORES:
                getMoreRankingScores(call, result);
                break;
            case GET_PLAYER_CENTERED_RANKING_SCORES:
                getPlayerCenteredRankingScores(call, result);
                break;
            case GET_RANKING_TOP_SCORES:
                getRankingTopScores(call, result);
                break;
            case SUBMIT_RANKING_SCORES:
                submitRankingScores(call, result);
                break;
            case SUBMIT_SCORE_WITH_RESULT:
                submitScoreWithResult(call, result);
                break;
            case GET_RANKING_SWITCH_STATUS:
                getRankingSwitchStatus(call, result);
                break;
            case SET_RANKING_SWITCH_STATUS:
                setRankingSwitchStatus(call, result);
                break;
        }
    }

    private void getTotalRankingsIntent(final MethodCall call, final MethodChannel.Result result) {
        DefaultResultListener<Intent> listener = new DefaultResultListener<>(result, activity, call.method);
        rankingsClient.getTotalRankingsIntent().addOnSuccessListener(listener).addOnFailureListener(listener);
    }

    private void getRankingIntent(final MethodCall call, final MethodChannel.Result result) {
        DefaultResultListener<Intent> listener = new DefaultResultListener<>(result, activity, call.method);
        String rankingId = ValueGetter.getString("rankingId", call);
        Integer timeDimension = ValueGetter.getOptionalInteger("timeDimension", call);
        // If timeDimension is present call the overloaded method.
        if (timeDimension != null) {
            rankingsClient.getRankingIntent(rankingId, timeDimension)
                .addOnSuccessListener(listener)
                .addOnFailureListener(listener);
        } else {
            rankingsClient.getRankingIntent(rankingId).addOnSuccessListener(listener).addOnFailureListener(listener);
        }
    }

    private void getCurrentPlayerRankingScore(final MethodCall call, final MethodChannel.Result result) {
        String rankingId = ValueGetter.getString("rankingId", call);
        Integer timeDimension = ValueGetter.getInteger("timeDimension", call);
        DefaultResultListener<RankingScore> listener = new DefaultResultListener<>(result, activity, call.method);
        rankingsClient.getCurrentPlayerRankingScore(rankingId, timeDimension)
            .addOnSuccessListener(listener)
            .addOnFailureListener(listener);
    }

    private void getRankingSummary(final MethodCall call, final MethodChannel.Result result) {
        String rankingId = ValueGetter.getString("rankingId", call);
        boolean isRealTime = ValueGetter.getBoolean("isRealTime", call);
        DefaultResultListener<Ranking> listener = new DefaultResultListener<>(result, activity, call.method);
        rankingsClient.getRankingSummary(rankingId, isRealTime)
            .addOnSuccessListener(listener)
            .addOnFailureListener(listener);
    }

    private void getAllRankingSummaries(final MethodCall call, final MethodChannel.Result result) {
        boolean isRealTime = ValueGetter.getBoolean("isRealTime", call);
        DefaultListResultListener<Ranking> listener = new DefaultListResultListener<>(result, Ranking.class,
            activity.getApplicationContext(), call.method);
        rankingsClient.getRankingSummary(isRealTime).addOnSuccessListener(listener).addOnFailureListener(listener);
    }

    private void getMoreRankingScores(final MethodCall call, final MethodChannel.Result result) {
        DefaultResultListener<RankingsClient.RankingScores> listener = new DefaultResultListener<>(result, activity,
            call.method);
        String rankingId = ValueGetter.getString("rankingId", call);
        long offsetPlayerRank = ValueGetter.getLong("offsetPlayerRank", call);
        int maxResults = ValueGetter.getInteger("maxResults", call);
        int pageDirection = ValueGetter.getInteger("pageDirection", call);
        int timeDimension = ValueGetter.getInteger("timeDimension", call);
        rankingsClient.getMoreRankingScores(rankingId, offsetPlayerRank, maxResults, pageDirection, timeDimension)
            .addOnSuccessListener(listener)
            .addOnFailureListener(listener);
    }

    private void getPlayerCenteredRankingScores(final MethodCall call, final MethodChannel.Result result) {
        DefaultResultListener<RankingsClient.RankingScores> listener = new DefaultResultListener<>(result, activity,
            call.method);
        String rankingId = ValueGetter.getString("rankingId", call);
        int maxResults = ValueGetter.getInteger("maxResults", call);
        int timeDimension = ValueGetter.getInteger("timeDimension", call);
        // If isRealTime present calls the overloaded method.
        if (call.argument("isRealTime") != null) {
            boolean isRealTime = ValueGetter.getBoolean("isRealTime", call);
            rankingsClient.getPlayerCenteredRankingScores(rankingId, timeDimension, maxResults, isRealTime)
                .addOnSuccessListener(listener)
                .addOnFailureListener(listener);
        } else {
            long offsetPlayerRank = ValueGetter.getLong("offsetPlayerRank", call);
            int pageDirection = ValueGetter.getInteger("pageDirection", call);
            rankingsClient.getPlayerCenteredRankingScores(rankingId, timeDimension, maxResults, offsetPlayerRank,
                pageDirection).addOnSuccessListener(listener).addOnFailureListener(listener);
        }
    }

    private void getRankingTopScores(final MethodCall call, final MethodChannel.Result result) {
        DefaultResultListener<RankingsClient.RankingScores> listener = new DefaultResultListener<>(result, activity,
            call.method);
        String rankingId = ValueGetter.getString("rankingId", call);
        int maxResults = ValueGetter.getInteger("maxResults", call);
        int timeDimension = ValueGetter.getInteger("timeDimension", call);
        // If isRealTime present calls the overloaded method.
        if (call.argument("isRealTime") != null) {
            boolean isRealTime = ValueGetter.getBoolean("isRealTime", call);
            rankingsClient.getRankingTopScores(rankingId, timeDimension, maxResults, isRealTime)
                .addOnSuccessListener(listener)
                .addOnFailureListener(listener);
        } else {
            long offsetPlayerRank = ValueGetter.getLong("offsetPlayerRank", call);
            int pageDirection = ValueGetter.getInteger("pageDirection", call);
            rankingsClient.getRankingTopScores(rankingId, timeDimension, maxResults, offsetPlayerRank, pageDirection)
                .addOnSuccessListener(listener)
                .addOnFailureListener(listener);
        }
    }

    private void submitRankingScores(final MethodCall call, final MethodChannel.Result result) {
        String rankingId = ValueGetter.getString("rankingId", call);
        long score = ValueGetter.getLong("score", call);
        String scoreTips = call.argument("scoreTips");
        if (scoreTips != null) {
            rankingsClient.submitRankingScore(rankingId, score, scoreTips);
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
        } else {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
            rankingsClient.submitRankingScore(rankingId, score);
        }
        result.success(true);
    }

    private void submitScoreWithResult(final MethodCall call, final MethodChannel.Result result) {
        DefaultResultListener<ScoreSubmissionInfo> listener = new DefaultResultListener<>(result, activity,
            call.method);
        String rankingId = ValueGetter.getString("rankingId", call);
        long score = ValueGetter.getLong("score", call);
        String scoreTips = call.argument("scoreTips");
        if (scoreTips != null) {
            rankingsClient.submitScoreWithResult(rankingId, score, scoreTips)
                .addOnSuccessListener(listener)
                .addOnFailureListener(listener);
        } else {
            rankingsClient.submitScoreWithResult(rankingId, score)
                .addOnSuccessListener(listener)
                .addOnFailureListener(listener);
        }
    }

    private void getRankingSwitchStatus(final MethodCall call, final MethodChannel.Result result) {
        DefaultResultListener<Integer> listener = new DefaultResultListener<>(result, activity, call.method);
        rankingsClient.getRankingSwitchStatus().addOnSuccessListener(listener).addOnFailureListener(listener);
    }

    private void setRankingSwitchStatus(final MethodCall call, final MethodChannel.Result result) {
        DefaultResultListener<Integer> listener = new DefaultResultListener<>(result, activity, call.method);
        int status = ValueGetter.getInteger("status", call);
        rankingsClient.setRankingSwitchStatus(status).addOnSuccessListener(listener).addOnFailureListener(listener);
    }
}
