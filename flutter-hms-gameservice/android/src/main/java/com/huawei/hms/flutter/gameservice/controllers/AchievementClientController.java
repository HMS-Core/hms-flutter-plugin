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

import com.huawei.hms.flutter.gameservice.common.Constants;
import com.huawei.hms.flutter.gameservice.common.listener.DefaultListResultListener;
import com.huawei.hms.flutter.gameservice.common.listener.DefaultResultListener;
import com.huawei.hms.flutter.gameservice.common.utils.HMSLogger;
import com.huawei.hms.flutter.gameservice.common.utils.ValueGetter;
import com.huawei.hms.jos.games.AchievementsClient;
import com.huawei.hms.jos.games.Games;
import com.huawei.hms.jos.games.achievement.Achievement;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class AchievementClientController {
    private Activity activity;

    AchievementsClient achievementsClient;

    public AchievementClientController(Activity activity) {
        this.activity = activity;
        this.achievementsClient = Games.getAchievementsClient(activity);
    }

    public void onMethodCall(final MethodCall call, final MethodChannel.Result result) {
        final Pair<String, String> methodNamePair = ValueGetter.methodNameExtractor(call);
        switch (Constants.AchievementClientMethods.getEnum(methodNamePair.second)) {
            case GET_SHOW_ACHIEVEMENT_LIST_INTENT:
                getAchievementListIntent(call, result);
                break;
            case GROW:
                grow(call, result);
                break;
            case GROW_WITH_RESULT:
                growWithResult(call, result);
                break;
            case GET_ACHIEVEMENT_LIST:
                getAchievementList(call, result);
                break;
            case VISUALIZE:
                visualize(call, result);
                break;
            case VISUALIZE_WITH_RESULT:
                visualizeWithResult(call, result);
                break;
            case MAKE_STEPS:
                makeSteps(call, result);
                break;
            case MAKE_STEPS_WITH_RESULT:
                makeStepsWithResult(call, result);
                break;
            case REACH:
                reach(call, result);
                break;
            case REACH_WITH_RESULT:
                reachWithResult(call, result);
                break;
        }
    }

    private void getAchievementListIntent(final MethodCall call, final MethodChannel.Result result) {
        DefaultResultListener<Intent> listener = new DefaultResultListener<>(result, activity, call.method);
        achievementsClient.getShowAchievementListIntent().addOnSuccessListener(listener).addOnFailureListener(listener);
    }

    private void grow(final MethodCall call, final MethodChannel.Result result) {
        String id = ValueGetter.getString("id", call);
        int numSteps = ValueGetter.getInt("numSteps", call);
        achievementsClient.grow(id, numSteps);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
        result.success(true);
    }

    private void growWithResult(final MethodCall call, final MethodChannel.Result result) {
        String id = ValueGetter.getString("id", call);
        int numSteps = ValueGetter.getInt("numSteps", call);
        DefaultResultListener<Boolean> listener = new DefaultResultListener<>(result, activity, call.method);
        achievementsClient.growWithResult(id, numSteps).addOnSuccessListener(listener).addOnFailureListener(listener);
    }

    private void getAchievementList(final MethodCall call, final MethodChannel.Result result) {
        DefaultListResultListener<Achievement> listener = new DefaultListResultListener<>(result, Achievement.class,
            activity.getApplicationContext(), call.method);
        boolean forceReload = ValueGetter.getBoolean("forceReload", call);
        achievementsClient.getAchievementList(forceReload)
            .addOnSuccessListener(listener)
            .addOnFailureListener(listener);
    }

    private void visualize(final MethodCall call, final MethodChannel.Result result) {
        String id = ValueGetter.getString("id", call);
        achievementsClient.visualize(id);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
        result.success(true);
    }

    private void visualizeWithResult(final MethodCall call, final MethodChannel.Result result) {
        String id = ValueGetter.getString("id", call);
        DefaultResultListener<Void> listener = new DefaultResultListener<>(result, activity, call.method);
        achievementsClient.visualizeWithResult(id).addOnSuccessListener(listener).addOnFailureListener(listener);
    }

    private void makeSteps(final MethodCall call, final MethodChannel.Result result) {
        String id = ValueGetter.getString("id", call);
        int numSteps = ValueGetter.getInt("numSteps", call);
        achievementsClient.makeSteps(id, numSteps);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
        result.success(true);
    }

    private void makeStepsWithResult(final MethodCall call, final MethodChannel.Result result) {
        String id = ValueGetter.getString("id", call);
        int numSteps = ValueGetter.getInt("numSteps", call);
        DefaultResultListener<Boolean> listener = new DefaultResultListener<>(result, activity, call.method);
        achievementsClient.makeStepsWithResult(id, numSteps)
            .addOnSuccessListener(listener)
            .addOnFailureListener(listener);
    }

    private void reach(final MethodCall call, final MethodChannel.Result result) {
        String id = ValueGetter.getString("id", call);
        achievementsClient.reach(id);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
        result.success(true);
    }

    private void reachWithResult(final MethodCall call, final MethodChannel.Result result) {
        String id = ValueGetter.getString("id", call);
        DefaultResultListener<Void> listener = new DefaultResultListener<>(result, activity, call.method);
        achievementsClient.reachWithResult(id).addOnSuccessListener(listener).addOnFailureListener(listener);
    }
}
