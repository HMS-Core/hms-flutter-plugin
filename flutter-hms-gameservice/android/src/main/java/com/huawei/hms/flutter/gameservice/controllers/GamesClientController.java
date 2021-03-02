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
import com.huawei.hms.jos.games.Games;
import com.huawei.hms.jos.games.GamesClient;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class GamesClientController {
    private Activity activity;

    GamesClient gamesClient;

    public GamesClientController(Activity activity) {
        this.activity = activity;
        this.gamesClient = Games.getGamesClient(activity);
    }

    public void onMethodCall(final MethodCall call, final MethodChannel.Result result) {
        final Pair<String, String> methodNamePair = ValueGetter.methodNameExtractor(call);
        switch (Constants.GamesClientMethods.getEnum(methodNamePair.second)) {
            case GET_APP_ID:
                getAppId(call, result);
                break;
            case SET_POPUPS_POSITION:
                setPopupsPosition(call, result);
                break;
            case CANCEL_GAME_SERVICE:
                cancelGameService(call, result);
                break;
        }
    }

    public void getAppId(final MethodCall call, final MethodChannel.Result result) {
        DefaultResultListener<String> listener = new DefaultResultListener<>(result, activity, call.method);
        gamesClient.getAppId().addOnSuccessListener(listener).addOnFailureListener(listener);
    }

    public void setPopupsPosition(final MethodCall call, final MethodChannel.Result result) {
        int position = ValueGetter.getInt("position", call);
        DefaultResultListener<Void> listener = new DefaultResultListener<>(result, activity, call.method);
        gamesClient.setPopupsPosition(position).addOnSuccessListener(listener).addOnFailureListener(listener);
    }

    public void cancelGameService(final MethodCall call, final MethodChannel.Result result) {
        DefaultResultListener<Boolean> listener = new DefaultResultListener<>(result, activity, call.method);
        gamesClient.cancelGameService().addOnSuccessListener(listener).addOnFailureListener(listener);
    }
}
