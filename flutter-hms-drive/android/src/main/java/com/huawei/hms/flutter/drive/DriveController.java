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

package com.huawei.hms.flutter.drive;

import static com.huawei.hms.flutter.drive.common.utils.DriveUtils.decapitalize;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.util.Pair;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.huawei.cloud.base.auth.DriveCredential;
import com.huawei.cloud.services.drive.Drive;
import com.huawei.hms.flutter.drive.common.Constants;
import com.huawei.hms.flutter.drive.common.Constants.ModuleNames;
import com.huawei.hms.flutter.drive.common.utils.DriveUtils;
import com.huawei.hms.flutter.drive.common.utils.HMSLogger;
import com.huawei.hms.flutter.drive.common.utils.ValueGetter;
import com.huawei.hms.flutter.drive.services.AboutController;
import com.huawei.hms.flutter.drive.services.ChannelsController;
import com.huawei.hms.flutter.drive.services.batch.BatchController;
import com.huawei.hms.flutter.drive.services.changes.ChangesController;
import com.huawei.hms.flutter.drive.services.comments.CommentsController;
import com.huawei.hms.flutter.drive.services.files.FilesController;
import com.huawei.hms.flutter.drive.services.historyversions.HistoryVersionsController;
import com.huawei.hms.flutter.drive.services.replies.RepliesController;

import java.util.Optional;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.Result;

public class DriveController {
    private static final String TAG = "DriveAuth";
    private String accessToken;
    private Drive drive;
    private DriveCredential driveCredential;
    private final Context context;
    private final MethodChannel methodChannel;
    private FilesController filesController;
    private CommentsController commentsController;
    private RepliesController repliesController;
    private AboutController aboutController;
    private ChannelsController channelsController;
    private ChangesController changesController;
    private HistoryVersionsController historyVersionsController;
    private BatchController batchController;

    public DriveController(final Context context, final MethodChannel channel) {
        this.context = context;
        methodChannel = channel;
    }

    public void onMethodCall(final @NonNull MethodCall call, final @NonNull Result result) {
        final Pair<String, String> methodNamePair = DriveUtils.methodNameExtractor(call);
        // If module is not Drive, check for drive instance presence and start the logger timer.
        if (!methodNamePair.first.equals(ModuleNames.DRIVE.getValue())) {
            if (!checkDrive(result)) {
                return;
            }
            HMSLogger.getInstance(context)
                .startMethodExecutionTimer(methodNamePair.first.concat(".") + decapitalize(methodNamePair.second));
        }

        switch (ModuleNames.getEnum(methodNamePair.first)) {
            case ABOUT:
                aboutController.onMethodCall(call, result);
                break;
            case CHANGES:
                changesController.onMethodCall(call, result);
                break;
            case DRIVE:
                driveMethodCall(call, result, methodNamePair.second);
                break;
            case FILES:
                filesController.onMethodCall(call, result);
                break;
            case CHANNELS:
                channelsController.onMethodCall(call, result);
                break;
            case REPLIES:
                repliesController.onMethodCall(call, result);
                break;
            case COMMENTS:
                commentsController.onMethodCall(call, result);
                break;
            case HISTORY_VERSIONS:
                historyVersionsController.onMethodCall(call, result);
                break;
            case BATCH:
                batchController.onMethodCall(call, result);
                break;
            case LOGGER:
                loggerMethodCall(methodNamePair.second);
                break;
            default:
                result.notImplemented();
                break;
        }

    }

    private boolean checkDrive(final Result result) {
        if (drive == null) {
            result.error(Constants.UNKNOWN_ERROR, "Drive instance can't be found, please initialize one first.", "");
            return false;
        }
        return true;
    }

    private void driveMethodCall(final @NonNull MethodCall call, final @NonNull Result result,
        final String methodName) {
        if (methodName.equals("Init")) {
            init(methodChannel, context, call, result);
        }
    }

    private void loggerMethodCall(final String methodName) {
        if (methodName.equals("Enable")) {
            HMSLogger.getInstance(context).enableLogger();
        } else if (methodName.equals("Disable")) {
            HMSLogger.getInstance(context).disableLogger();
        }
    }

    public void init(final MethodChannel channel, final Context context, final MethodCall call, final Result result) {
        final Handler handler = new Handler(Looper.getMainLooper());
        final DriveCredential.AccessMethod callback = () -> {
            handler.post(() -> flutterRefreshCallback(channel));
            return accessToken;
        };
        final String unionId = ValueGetter.getString("unionId", call);
        final Optional<Long> expiresInSeconds = ValueGetter.getOptionalLong("expiresInSeconds", call);
        accessToken = ValueGetter.getString("accessToken", call);
        final DriveCredential.Builder builder = new DriveCredential.Builder(unionId, callback);
        driveCredential = builder.build().setAccessToken(accessToken);
        expiresInSeconds.ifPresent(aLong -> driveCredential.setExpiresInSeconds(aLong));
        buildDrive(context);
        if (drive != null) {
            generateModules();
            result.success(true);
        } else {
            result.error(Constants.UNKNOWN_ERROR, "Drive initialization failed.", "");
        }
    }

    private void flutterRefreshCallback(final MethodChannel channel) {
        channel.invokeMethod("refreshToken", null, new Result() {
            @Override
            public void success(@Nullable final Object result) {
                accessToken = (String) result;
            }

            @Override
            public void error(final String errorCode, @Nullable final String errorMessage,
                @Nullable final Object errorDetails) {
                Log.e(TAG, "Error while invoking refreshToken Callback", null);
            }

            @Override
            public void notImplemented() {
                Log.e(TAG, "Refresh token callback is not implemented.", null);
            }
        });
    }

    /**
     * Build a Drive instance
     */
    private void buildDrive(final Context context) {
        if (driveCredential != null) {
            drive = new Drive.Builder(driveCredential, context).build();
        }
    }

    private void generateModules() {
        filesController = new FilesController(drive, context);
        commentsController = new CommentsController(drive, context);
        repliesController = new RepliesController(drive, context);
        aboutController = new AboutController(drive, context);
        channelsController = new ChannelsController(drive, context);
        changesController = new ChangesController(drive, context);
        historyVersionsController = new HistoryVersionsController(drive, context);
        batchController = new BatchController(drive, context, filesController, commentsController, repliesController,
            aboutController, channelsController, changesController, historyVersionsController);
    }

}
