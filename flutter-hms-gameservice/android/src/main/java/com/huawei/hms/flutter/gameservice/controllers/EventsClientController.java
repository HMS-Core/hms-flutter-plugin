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
import com.huawei.hms.flutter.gameservice.common.listener.DefaultListResultListener;
import com.huawei.hms.flutter.gameservice.common.utils.HMSLogger;
import com.huawei.hms.flutter.gameservice.common.utils.ValueGetter;
import com.huawei.hms.jos.games.EventsClient;
import com.huawei.hms.jos.games.Games;
import com.huawei.hms.jos.games.event.Event;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import java.util.ArrayList;

public class EventsClientController {

    private Activity activity;

    private EventsClient eventsClient;

    public EventsClientController(Activity activity) {
        this.activity = activity;
        this.eventsClient = Games.getEventsClient(activity);
    }

    public void onMethodCall(final MethodCall call, final MethodChannel.Result result) {
        final Pair<String, String> methodNamePair = ValueGetter.methodNameExtractor(call);
        switch (Constants.EventsClientMethods.getEnum(methodNamePair.second)) {
            case GROW:
                grow(call, result);
                break;
            case GET_EVENT_LIST:
                getEventList(call, result);
                break;
            case GET_EVENT_LIST_BY_IDS:
                getEventListByIds(call, result);
                break;
        }
    }

    private void grow(final MethodCall call, final MethodChannel.Result result) {
        String eventId = ValueGetter.getString("eventId", call);
        int growAmount = ValueGetter.getInt("growAmount", call);
        eventsClient.grow(eventId, growAmount);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent(call.method);
        result.success(true);
    }

    private void getEventList(final MethodCall call, final MethodChannel.Result result) {
        boolean forceReload = ValueGetter.getBoolean("forceReload", call);
        DefaultListResultListener<Event> listener = new DefaultListResultListener<>(result, Event.class,
            activity.getApplicationContext(), call.method);
        eventsClient.getEventList(forceReload).addOnSuccessListener(listener).addOnFailureListener(listener);
    }

    private void getEventListByIds(final MethodCall call, final MethodChannel.Result result) {
        boolean forceReload = ValueGetter.getBoolean("forceReload", call);
        ArrayList<String> eventIds = call.argument("eventIds");
        DefaultListResultListener<Event> listener = new DefaultListResultListener<>(result, Event.class,
            activity.getApplicationContext(), call.method);
        if (eventIds == null) {
            eventsClient.getEventListByIds(forceReload).addOnSuccessListener(listener).addOnFailureListener(listener);
        } else {
            eventsClient.getEventListByIds(forceReload, eventIds.toArray(new String[0]))
                .addOnSuccessListener(listener)
                .addOnFailureListener(listener);
        }
    }
}
