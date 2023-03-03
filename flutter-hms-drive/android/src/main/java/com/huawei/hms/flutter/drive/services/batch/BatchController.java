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

package com.huawei.hms.flutter.drive.services.batch;

import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.util.Pair;

import androidx.annotation.NonNull;

import com.google.gson.Gson;
import com.huawei.agconnect.LocalBrdMnger;
import com.huawei.cloud.base.batch.BatchRequest;
import com.huawei.cloud.base.batch.json.JsonBatchCallback;
import com.huawei.cloud.base.http.HttpHeaders;
import com.huawei.cloud.base.json.JsonError;
import com.huawei.cloud.base.json.gson.GsonFactory;
import com.huawei.cloud.client.task.Task;
import com.huawei.cloud.services.drive.Drive;
import com.huawei.cloud.services.drive.Drive.About.Get;
import com.huawei.cloud.services.drive.Drive.Channels.Stop;
import com.huawei.cloud.services.drive.model.About;
import com.huawei.cloud.services.drive.model.ChangeList;
import com.huawei.cloud.services.drive.model.Channel;
import com.huawei.cloud.services.drive.model.Comment;
import com.huawei.cloud.services.drive.model.CommentList;
import com.huawei.cloud.services.drive.model.File;
import com.huawei.cloud.services.drive.model.FileList;
import com.huawei.cloud.services.drive.model.HistoryVersion;
import com.huawei.cloud.services.drive.model.HistoryVersionList;
import com.huawei.cloud.services.drive.model.Reply;
import com.huawei.cloud.services.drive.model.ReplyList;
import com.huawei.cloud.services.drive.model.StartCursor;
import com.huawei.hms.flutter.drive.common.Constants;
import com.huawei.hms.flutter.drive.common.Constants.BatchMethods;
import com.huawei.hms.flutter.drive.common.Constants.ChangesMethods;
import com.huawei.hms.flutter.drive.common.Constants.CommentsMethods;
import com.huawei.hms.flutter.drive.common.Constants.FilesBatchMethods;
import com.huawei.hms.flutter.drive.common.Constants.HistoryVersionsMethods;
import com.huawei.hms.flutter.drive.common.Constants.ModuleNames;
import com.huawei.hms.flutter.drive.common.Constants.RepliesMethods;
import com.huawei.hms.flutter.drive.common.utils.CommonTaskManager;
import com.huawei.hms.flutter.drive.common.utils.DriveUtils;
import com.huawei.hms.flutter.drive.common.utils.HMSLogger;
import com.huawei.hms.flutter.drive.common.utils.ValueGetter;
import com.huawei.hms.flutter.drive.services.AboutController;
import com.huawei.hms.flutter.drive.services.ChannelsController;
import com.huawei.hms.flutter.drive.services.changes.ChangesController;
import com.huawei.hms.flutter.drive.services.comments.CommentsController;
import com.huawei.hms.flutter.drive.services.files.FilesController;
import com.huawei.hms.flutter.drive.services.historyversions.HistoryVersionsController;
import com.huawei.hms.flutter.drive.services.replies.RepliesController;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

public class BatchController {
    private static final String TAG = BatchController.class.getSimpleName();
    private final Context context;
    private final Gson gson;
    private final BatchRequest batch;

    private final Intent intent;

    private final FilesController filesController;
    private final CommentsController commentsController;
    private final RepliesController repliesController;
    private final AboutController aboutController;
    private final ChannelsController channelsController;
    private final ChangesController changesController;
    private final HistoryVersionsController historyVersionsController;

    public BatchController(final Drive drive, final Context context, final FilesController filesController,
        final CommentsController commentsController, final RepliesController repliesController,
        final AboutController aboutController, final ChannelsController channelsController,
        final ChangesController changesController, final HistoryVersionsController historyVersionsController) {
        this.context = context;
        gson = new Gson();
        this.filesController = filesController;
        this.commentsController = commentsController;
        this.repliesController = repliesController;
        this.aboutController = aboutController;
        this.channelsController = channelsController;
        this.changesController = changesController;
        this.historyVersionsController = historyVersionsController;
        batch = drive.batch();

        intent = new Intent(context.getPackageName() + ".BATCH_ACTION");
    }

    public void onMethodCall(final @NonNull MethodCall call, final @NonNull Result result) {
        final String methodName = DriveUtils.methodNameExtractor(call).second;
        if (BatchMethods.getEnum(methodName) == BatchMethods.BATCH_EXECUTE) {
            executeBatch(call, result);
        } else {
            result.notImplemented();
        }
    }

    private void executeBatch(final MethodCall call, final Result result) {
        try {
            HMSLogger.getInstance(context).startMethodExecutionTimer("Batch.execute");
            findModule(call, result);
            CommonTaskManager.execute(new Task() {
                @Override
                public void call() {
                    try {
                        batch.execute();
                        HMSLogger.getInstance(context).sendSingleEvent("Batch.execute");
                        DriveUtils.successHandler(result, null);
                    } catch (final IOException e) {
                        Log.e(TAG, "executeBatch: " + e.getMessage(), null);
                        HMSLogger.getInstance(context).sendSingleEvent("Batch.execute", Constants.UNKNOWN_ERROR);
                    }
                }
            });

        } catch (final IOException | NullPointerException ex) {
            Log.e(TAG, "executeBatch: " + ex.getMessage(), null);
        }

    }

    private void findModule(final MethodCall call, final Result result) throws IOException {
        final Map<String, Object> args = ValueGetter.getMap(call.arguments);
        final List<Map<String, Object>> requests = ValueGetter.toMapList("driveRequests", args);
        if (requests.isEmpty()) {
            DriveUtils.errorHandler(context, intent, "Error, batch requests are empty or null.");
            return;
        }
        for (final Map<String, Object> req : requests) {
            final String requestType = (String) req.get("requestName");
            final Pair<String, String> module = DriveUtils.methodNameExtractor(Objects.requireNonNull(requestType));
            final String reqType = module.second;
            switch (ModuleNames.getEnum(module.first)) {
                case ABOUT:
                    final Optional<Get> aboutRequest = aboutController.aboutGet(req);
                    if (aboutRequest.isPresent()) {
                        aboutRequest.get().queue(batch, new CommonJsonBatchCallback<>(About.class));
                    }
                    break;
                case CHANGES:
                    findChangesRequestType(reqType, result, req);
                    break;
                case FILES:
                    findFileRequestType(reqType, result, req);
                    break;
                case CHANNELS:
                    final Optional<Stop> stopRequest = channelsController.stop(req);
                    if (stopRequest.isPresent()) {
                        stopRequest.get()
                            .queue(batch, new CommonJsonBatchCallback<>(Void.class).setMethodName("Channels.stop"));
                    }
                    break;
                case REPLIES:
                    findRepliesRequestType(reqType, result, req);
                    break;
                case COMMENTS:
                    findCommentRequestType(reqType, result, req);
                    break;
                case HISTORY_VERSIONS:
                    findHistoryVersionsRequestType(reqType, result, req);
                    break;
                default:
                    result.notImplemented();
                    break;
            }
        }

    }

    private void findCommentRequestType(final String reqType, final Result result, final Map<String, Object> args)
        throws IOException {
        switch (CommentsMethods.getEnum(reqType)) {
            case COMMENT_CREATE:
                final Optional<Drive.Comments.Create> createRequest = commentsController.batchCommentsCreate(args);
                if (createRequest.isPresent()) {
                    createRequest.get().queue(batch, new CommonJsonBatchCallback<>(Comment.class));
                }
                break;
            case COMMENT_DELETE:
                final Optional<Drive.Comments.Delete> deleteRequest = commentsController.batchCommentsDelete(args);
                if (deleteRequest.isPresent()) {
                    deleteRequest.get()
                        .queue(batch, new CommonJsonBatchCallback<>(Void.class).setMethodName("Comments.delete"));
                }
                break;
            case COMMENT_GET:
                final Optional<Drive.Comments.Get> getRequest = commentsController.batchCommentsGet(args);
                if (getRequest.isPresent()) {
                    getRequest.get().queue(batch, new CommonJsonBatchCallback<>(Comment.class));
                }
                break;
            case COMMENT_LIST:
                final Optional<Drive.Comments.List> listRequest = commentsController.batchCommentsList(args);
                if (listRequest.isPresent()) {
                    listRequest.get().queue(batch, new CommonJsonBatchCallback<>(CommentList.class));
                }
                break;
            case COMMENTS_UPDATE:
                final Optional<Drive.Comments.Update> updateRequest = commentsController.batchCommentsUpdate(args);
                if (updateRequest.isPresent()) {
                    updateRequest.get().queue(batch, new CommonJsonBatchCallback<>(Comment.class));
                }
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void findRepliesRequestType(final String reqType, final Result result, final Map<String, Object> args)
        throws IOException {
        switch (RepliesMethods.getEnum(reqType)) {
            case REPLIES_CREATE:
                final Optional<Drive.Replies.Create> createRequest = repliesController.create(args);
                if (createRequest.isPresent()) {
                    createRequest.get().queue(batch, new CommonJsonBatchCallback<>(Reply.class));
                }
                break;
            case REPLIES_DELETE:
                final Optional<Drive.Replies.Delete> deleteRequest = repliesController.delete(args);
                if (deleteRequest.isPresent()) {
                    deleteRequest.get()
                        .queue(batch, new CommonJsonBatchCallback<>(Void.class).setMethodName("Repliest.delete"));
                }
                break;
            case REPLIES_GET:
                final Optional<Drive.Replies.Get> getRequest = repliesController.get(args);
                if (getRequest.isPresent()) {
                    getRequest.get().queue(batch, new CommonJsonBatchCallback<>(Reply.class));
                }
                break;
            case REPLIES_LIST:
                final Optional<Drive.Replies.List> listRequest = repliesController.list(args);
                if (listRequest.isPresent()) {
                    listRequest.get().queue(batch, new CommonJsonBatchCallback<>(ReplyList.class));
                }
                break;
            case REPLIES_UPDATE:
                final Optional<Drive.Replies.Update> updateRequest = repliesController.update(args);
                if (updateRequest.isPresent()) {
                    updateRequest.get().queue(batch, new CommonJsonBatchCallback<>(Reply.class));
                }
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void findChangesRequestType(final String reqType, final Result result, final Map<String, Object> args)
        throws IOException {
        switch (ChangesMethods.getEnum(reqType)) {
            case CHANGES_GET_START_CURSOR:
                final Optional<Drive.Changes.GetStartCursor> getStartCursorReq = changesController.getStartCursor(args);
                if (getStartCursorReq.isPresent()) {
                    getStartCursorReq.get().queue(batch, new CommonJsonBatchCallback<>(StartCursor.class));
                }
                break;
            case CHANGES_LIST:
                final Optional<Drive.Changes.List> listRequest = changesController.list(args);
                if (listRequest.isPresent()) {
                    listRequest.get().queue(batch, new CommonJsonBatchCallback<>(ChangeList.class));
                }
                break;
            case CHANGES_SUBSCRIBE:
                final Optional<Drive.Changes.Subscribe> subscribeRequest = changesController.subscribe(args);
                if (subscribeRequest.isPresent()) {
                    subscribeRequest.get().queue(batch, new CommonJsonBatchCallback<>(Channel.class));
                }
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void findHistoryVersionsRequestType(final String reqType, final Result result,
        final Map<String, Object> args) throws IOException {
        switch (HistoryVersionsMethods.getEnum(reqType)) {
            case HISTORY_VERSIONS_DELETE:
                final Optional<Drive.HistoryVersions.Delete> deleteRequest = historyVersionsController.delete(args);
                if (deleteRequest.isPresent()) {
                    deleteRequest.get()
                        .queue(batch,
                            new CommonJsonBatchCallback<>(Void.class).setMethodName("HistoryVersions.delete"));
                }
                break;
            case HISTORY_VERSIONS_GET:
                final Optional<Drive.HistoryVersions.Get> getRequest = historyVersionsController.get(args);
                if (getRequest.isPresent()) {
                    getRequest.get().queue(batch, new CommonJsonBatchCallback<>(HistoryVersion.class));
                }
                break;
            case HISTORY_VERSIONS_LIST:
                final Optional<Drive.HistoryVersions.List> listRequest = historyVersionsController.list(args);
                if (listRequest.isPresent()) {
                    listRequest.get().queue(batch, new CommonJsonBatchCallback<>(HistoryVersionList.class));
                }
                break;
            case HISTORY_VERSIONS_UPDATE:
                final Optional<Drive.HistoryVersions.Update> updateRequest = historyVersionsController.update(args);
                if (updateRequest.isPresent()) {
                    updateRequest.get().queue(batch, new CommonJsonBatchCallback<>(HistoryVersion.class));
                }
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void findFileRequestType(final String reqType, final Result result, final Map<String, Object> args)
        throws IOException {
        switch (FilesBatchMethods.getEnum(reqType)) {
            case FILES_GET:
                final Optional<Drive.Files.Get> getRequest = filesController.filesGet(args);
                if (getRequest.isPresent()) {
                    getRequest.get().queue(batch, new CommonJsonBatchCallback<>(File.class));
                }
                break;
            case FILES_COPY:
                final Optional<Drive.Files.Copy> copyRequest = filesController.filesCopy(args);
                if (copyRequest.isPresent()) {
                    copyRequest.get().queue(batch, new CommonJsonBatchCallback<>(File.class));
                }
                break;
            case FILES_CREATE:
                final Optional<Drive.Files.Create> createRequest = filesController.filesCreate(args);
                if (createRequest.isPresent()) {
                    createRequest.get().queue(batch, new CommonJsonBatchCallback<>(File.class));
                }
                break;
            case FILES_DELETE:
                final Optional<Drive.Files.Delete> deleteRequest = filesController.filesDelete(args);
                if (deleteRequest.isPresent()) {
                    deleteRequest.get()
                        .queue(batch, new CommonJsonBatchCallback<>(Void.class).setMethodName("Files" + ".delete"));
                }
                break;
            case FILES_EMPTY_RECYCLE:
                final Optional<Drive.Files.EmptyRecycle> emptyRecycleRequest = filesController.filesEmptyRecycle(args);
                if (emptyRecycleRequest.isPresent()) {
                    emptyRecycleRequest.get()
                        .queue(batch, new CommonJsonBatchCallback<>(Void.class).setMethodName("Files.emptyRecycle"));
                }
                break;
            case FILES_LIST:
                final Optional<Drive.Files.List> listRequest = filesController.filesList(args);
                if (listRequest.isPresent()) {
                    listRequest.get().queue(batch, new CommonJsonBatchCallback<>(FileList.class));
                }
                break;
            case FILES_UPDATE:
                final Optional<Drive.Files.Update> updateRequest = filesController.filesUpdate(args);
                if (updateRequest.isPresent()) {
                    updateRequest.get().queue(batch, new CommonJsonBatchCallback<>(File.class));
                }
                break;
            case FILES_SUBSCRIBE:
                final Optional<Drive.Files.Subscribe> subscribeRequest = filesController.filesSubscribe(args);
                if (subscribeRequest.isPresent()) {
                    subscribeRequest.get().queue(batch, new CommonJsonBatchCallback<>(Channel.class));
                }
                break;
            default:
                result.notImplemented();
        }
    }

    private class CommonJsonBatchCallback<T> extends JsonBatchCallback<T> {
        private final Class<T> type;
        private String methodName;

        CommonJsonBatchCallback(final Class<T> type) {
            this.type = type;
        }

        CommonJsonBatchCallback<T> setMethodName(final String methodName) {
            this.methodName = methodName;
            return this;
        }

        @Override
        public void onFailure(final JsonError jsonError, final HttpHeaders httpHeaders) {
            final HashMap<String, String> errorMap = new HashMap<>();
            errorMap.put("JsonError", gson.toJson(jsonError));
            errorMap.put("HttpHeaders", gson.toJson(httpHeaders));
            intent.putExtra("batchError", gson.toJson(errorMap));
            LocalBrdMnger.getInstance(context).sendBroadcast(intent);
            intent.removeExtra("batchError");
        }

        @Override
        public void onSuccess(final T resultObject, final HttpHeaders httpHeaders) {
            if (type.equals(Void.class)) {
                intent.putExtra("batchResponse",
                    methodName != null ? gson.toJson(DriveUtils.newSuccessMap(methodName)) : String.valueOf(true));
            } else {
                try {
                    intent.putExtra("batchResponse",
                        GsonFactory.getDefaultInstance().toString(type.cast(resultObject)));
                } catch (final IOException e) {
                    DriveUtils.errorHandler(context, intent, e.toString());
                }
            }
            LocalBrdMnger.getInstance(context).sendBroadcast(intent);
        }
    }
}
