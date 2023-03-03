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

package com.huawei.hms.flutter.drive.services.changes;

import android.content.Context;

import com.huawei.cloud.base.json.gson.GsonFactory;
import com.huawei.cloud.services.drive.Drive;
import com.huawei.cloud.services.drive.model.ChangeList;
import com.huawei.cloud.services.drive.model.Channel;
import com.huawei.cloud.services.drive.model.StartCursor;
import com.huawei.hms.flutter.drive.common.Constants.ChangesMethods;
import com.huawei.hms.flutter.drive.common.Constants.ChangesRequestType;
import com.huawei.hms.flutter.drive.common.utils.DriveUtils;
import com.huawei.hms.flutter.drive.common.utils.ValueGetter;

import java.io.IOException;
import java.security.InvalidParameterException;
import java.util.Map;
import java.util.Optional;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

public class ChangesController {
    private ChangesRequestFactory changesRequestFactory;
    private static final String SERVICE_NAME = "Changes";

    public ChangesController(Drive drive, Context context) {
        this.changesRequestFactory = new ChangesRequestFactory(drive, context);
    }

    public void onMethodCall(final MethodCall call, final Result result) {
        final String methodName = DriveUtils.methodNameExtractor(call).second;
        switch (ChangesMethods.getEnum(methodName)) {
            case CHANGES_GET_START_CURSOR:
                getStartCursor(call, result);
                break;
            case CHANGES_LIST:
                list(call, result);
                break;
            case CHANGES_SUBSCRIBE:
                subscribe(call, result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void getStartCursor(final MethodCall call, final Result result) {
        try {
            ChangesRequestOptions requestOptions = toChangesRequest(call, false);
            // Create Channels.GetStartCursor request.
            Drive.Changes.GetStartCursor request = changesRequestFactory.buildRequest(
                ChangesRequestType.GET_START_CURSOR, requestOptions, null, Drive.Changes.GetStartCursor.class);
            // Run on background and handle Flutter result.
            changesRequestFactory.runTaskOnBackground(result, StartCursor.class, request, SERVICE_NAME,
                SERVICE_NAME.concat(".getStartCursor"));
        } catch (InvalidParameterException | IOException e) {
            DriveUtils.defaultErrorHandler(result, "Changes.getStartCursor failed, Error is: " + e.getMessage());
        }
    }

    public Optional<Drive.Changes.GetStartCursor> getStartCursor(final Map<String, Object> args) {
        try {
            ChangesRequestOptions requestOptions = toChangesRequest(changesRequestFactory.toJson(args));
            // Create Channels.GetStartCursor request.
            Drive.Changes.GetStartCursor request = changesRequestFactory.buildRequest(
                ChangesRequestType.GET_START_CURSOR, requestOptions, null, Drive.Changes.GetStartCursor.class);
            // Return the request
            return Optional.of(request);
        } catch (InvalidParameterException | IOException e) {
            DriveUtils.errorHandler(changesRequestFactory.getContext(), changesRequestFactory.newBatchIntent(),
                changesRequestFactory.toJson(e));
        }
        return Optional.empty();
    }

    private void list(final MethodCall call, final Result result) {
        try {
            ChangesRequestOptions requestOptions = toChangesRequest(call, false);
            if (DriveUtils.isNullOrEmpty(requestOptions.getCursor())) {
                throw new InvalidParameterException("Error, please provide cursor parameter.");
            }
            Drive.Changes.List request = changesRequestFactory.buildRequest(ChangesRequestType.LIST, requestOptions,
                null, Drive.Changes.List.class);
            changesRequestFactory.runTaskOnBackground(result, ChangeList.class, request, SERVICE_NAME,
                SERVICE_NAME.concat(".list"));
        } catch (InvalidParameterException | IOException e) {
            DriveUtils.defaultErrorHandler(result, "Changes.list failed, Error is: " + e.getMessage());
        }
    }

    public Optional<Drive.Changes.List> list(final Map<String, Object> args) {
        try {
            ChangesRequestOptions requestOptions = toChangesRequest(changesRequestFactory.toJson(args));
            if (DriveUtils.isNullOrEmpty(requestOptions.getCursor())) {
                throw new InvalidParameterException("Error, please provide cursor parameter.");
            }
            Drive.Changes.List request = changesRequestFactory.buildRequest(ChangesRequestType.LIST, requestOptions,
                null, Drive.Changes.List.class);
            return Optional.of(request);
        } catch (InvalidParameterException | IOException e) {
            DriveUtils.errorHandler(changesRequestFactory.getContext(), changesRequestFactory.newBatchIntent(),
                changesRequestFactory.toJson(e));
        }
        return Optional.empty();
    }

    private void subscribe(final MethodCall call, final Result result) {
        try {
            Channel channel = GsonFactory.getDefaultInstance().fromString(call.argument("channel"), Channel.class);
            ChangesRequestOptions requestOptions = toChangesRequest(call, true);
            if (channel == null || DriveUtils.isNullOrEmpty(requestOptions.getCursor())) {
                throw new InvalidParameterException("Error, Channel or Cursor is invalid.");
            }
            changesRequestFactory.setExtraParams(channel, call);
            Drive.Changes.Subscribe request = changesRequestFactory.buildRequest(ChangesRequestType.SUBSCRIBE,
                requestOptions, channel, Drive.Changes.Subscribe.class);
            changesRequestFactory.runTaskOnBackground(result, Channel.class, request, SERVICE_NAME,
                SERVICE_NAME.concat(".subscribe"));
        } catch (InvalidParameterException | IOException e) {
            DriveUtils.defaultErrorHandler(result, "Changes.subscribe failed, Error is: " + e.getMessage());
        }
    }

    public Optional<Drive.Changes.Subscribe> subscribe(final Map<String, Object> args) {
        try {
            Map<String, Object> channelMap = ValueGetter.getMap(args.get("channel"));
            Channel channel = GsonFactory.getDefaultInstance()
                .fromString(changesRequestFactory.toJson(channelMap), Channel.class);
            ChangesRequestOptions requestOptions = toChangesRequest(changesRequestFactory.toJson(args));
            if (channel == null || DriveUtils.isNullOrEmpty(requestOptions.getCursor())) {
                throw new InvalidParameterException("Error, Channel or Cursor is invalid.");
            }
            Drive.Changes.Subscribe request = changesRequestFactory.buildRequest(ChangesRequestType.SUBSCRIBE,
                requestOptions, channel, Drive.Changes.Subscribe.class);
            return Optional.of(request);
        } catch (InvalidParameterException | IOException e) {
            DriveUtils.errorHandler(changesRequestFactory.getContext(), changesRequestFactory.newBatchIntent(),
                changesRequestFactory.toJson(e));
        }
        return Optional.empty();
    }

    private ChangesRequestOptions toChangesRequest(final MethodCall call, boolean fromMap) {
        if (fromMap) {
            return changesRequestFactory.getGson()
                .fromJson((String) call.argument("request"), ChangesRequestOptions.class);
        }
        return changesRequestFactory.getGson().fromJson((String) call.arguments, ChangesRequestOptions.class);
    }

    private ChangesRequestOptions toChangesRequest(final String json) {
        return changesRequestFactory.getGson().fromJson(json, ChangesRequestOptions.class);
    }
}
