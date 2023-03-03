/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.drive.services;

import android.content.Context;
import android.content.Intent;

import androidx.annotation.NonNull;

import com.huawei.cloud.base.json.gson.GsonFactory;
import com.huawei.cloud.services.drive.Drive;
import com.huawei.cloud.services.drive.model.Channel;
import com.huawei.hms.flutter.drive.common.service.DriveRequestFactory;
import com.huawei.hms.flutter.drive.common.service.DriveRequestOptions;
import com.huawei.hms.flutter.drive.common.utils.DriveUtils;
import com.huawei.hms.flutter.drive.common.utils.ValueGetter;

import java.io.IOException;
import java.util.Map;
import java.util.Optional;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

public class ChannelsController extends DriveRequestFactory {

    public ChannelsController(Drive drive, Context context) {
        super(drive, context);
    }

    public void onMethodCall(final @NonNull MethodCall call, final @NonNull Result result) {
        final String methodName = DriveUtils.methodNameExtractor(call).second;
        if (methodName.equals("Stop")) {
            stop(call, result);
        }
    }

    private void stop(final MethodCall call, final Result result) {
        try {
            Channel channel = GsonFactory.getDefaultInstance()
                .fromString(ValueGetter.getString("channel", call), Channel.class);
            setExtraParams(channel, call);
            DriveRequestOptions requestOptions = getGson().fromJson(ValueGetter.getString("request", call),
                DriveRequestOptions.class);
            Drive.Channels.Stop request = getDrive().channels().stop(channel);
            setBasicRequestOptions(request, requestOptions);
            runTaskOnBackground(result, Void.class, request, "Channels", "Channels.stop");
        } catch (IOException e) {
            DriveUtils.defaultErrorHandler(result, "Channel.stop failed, Error is: " + e.getMessage());
        }
    }

    public Optional<Drive.Channels.Stop> stop(final Map<String, Object> args) {
        try {
            Map<String, Object> channelMap = ValueGetter.getMap(args.get("channel"));
            Channel channel = GsonFactory.getDefaultInstance().fromString(toJson(channelMap), Channel.class);
            DriveRequestOptions requestOptions = getGson().fromJson(toJson(args), DriveRequestOptions.class);
            Drive.Channels.Stop request = getDrive().channels().stop(channel);
            setBasicRequestOptions(request, requestOptions);
            return Optional.of(request);
        } catch (IOException e) {
            DriveUtils.errorHandler(getContext(), new Intent(getContext().getPackageName() + ".BATCH_ACTION"),
                toJson(e));
        }
        return Optional.empty();
    }
}
