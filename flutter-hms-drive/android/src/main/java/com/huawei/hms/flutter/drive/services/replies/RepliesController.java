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

package com.huawei.hms.flutter.drive.services.replies;

import static com.huawei.hms.flutter.drive.common.utils.DriveUtils.missingFileIdOrCommentId;

import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;

import com.huawei.cloud.base.json.gson.GsonFactory;
import com.huawei.cloud.services.drive.Drive;
import com.huawei.cloud.services.drive.Drive.Replies;
import com.huawei.cloud.services.drive.model.Reply;
import com.huawei.cloud.services.drive.model.ReplyList;
import com.huawei.hms.flutter.drive.common.Constants.DriveRequestType;
import com.huawei.hms.flutter.drive.common.Constants.RepliesMethods;
import com.huawei.hms.flutter.drive.common.utils.DriveUtils;

import java.io.IOException;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

public class RepliesController {
    private static final String TAG = RepliesController.class.getSimpleName();
    private static final String SERVICE_NAME = "Replies";
    private static final String REPLY_KEY = "reply";

    private final RepliesRequestFactory requestFactory;

    public RepliesController(final Drive drive, final Context context) {
        requestFactory = new RepliesRequestFactory(drive, context);
    }

    public void onMethodCall(final @NonNull MethodCall call, final @NonNull Result result) {
        final String methodName = DriveUtils.methodNameExtractor(call).second;
        switch (RepliesMethods.getEnum(methodName)) {
            case REPLIES_CREATE:
                create(call, result);
                break;
            case REPLIES_DELETE:
                delete(call, result);
                break;
            case REPLIES_GET:
                get(call, result);
                break;
            case REPLIES_LIST:
                list(call, result);
                break;
            case REPLIES_UPDATE:
                update(call, result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void create(final MethodCall call, final Result result) {
        try {
            // Mandatory fields: FileId, CommentId, Reply
            final Reply reply = toReply(call);
            final RepliesRequestOptions createOptions = toRepliesRequest(call, true);
            if (DriveUtils.missingFileIdOrCommentId(createOptions, result)) {
                return;
            }
            requestFactory.setExtraParams(reply, call);
            // Create comment create request.
            final Drive.Replies.Create createRequest = requestFactory.buildRequest(DriveRequestType.CREATE, createOptions,
                reply, Drive.Replies.Create.class);
            // Run on background and handle Flutter result.
            requestFactory.runTaskOnBackground(result, Reply.class, createRequest, SERVICE_NAME,
                SERVICE_NAME.concat(".create"));
        } catch (final IOException e) {
            DriveUtils.defaultErrorHandler(result, "Create reply error: " + e.toString());
        }
    }

    public Optional<Drive.Replies.Create> create(final Map<String, Object> args) {
        try {
            // Mandatory fields: FileId, CommentId, Reply
            final Reply reply = toReply(requestFactory.toJson(args.get(REPLY_KEY)));
            final RepliesRequestOptions createOptions = toRepliesRequest(requestFactory.toJson(args));
            if (DriveUtils.missingFileIdOrCommentId(createOptions)) {
                DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                    requestFactory.toJson(DriveUtils.newErrorMap("FileId and CommentId should be specified.")));
                return Optional.empty();
            }
            // Create comment create request.
            final Drive.Replies.Create createRequest = requestFactory.buildRequest(DriveRequestType.CREATE, createOptions,
                reply, Drive.Replies.Create.class);
            // Return the created request.
            return Optional.of(createRequest);
        } catch (final IOException e) {
            DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                requestFactory.toJson(e));
        }
        return Optional.empty();
    }

    private void delete(final MethodCall call, final Result result) {
        try {
            final RepliesRequestOptions deleteOptions = toRepliesRequest(call, false);
            // Mandatory fields: FileID, CommentID, ReplyID.
            if (missingFileCommentReplyId(deleteOptions, result)) {
                return;
            }
            // Create comment delete request.
            final Drive.Replies.Delete deleteRequest = requestFactory.buildRequest(DriveRequestType.DELETE, deleteOptions,
                null, Replies.Delete.class);
            // Run on background and handle Flutter result.
            requestFactory.runTaskOnBackground(result, Void.class, deleteRequest, SERVICE_NAME,
                SERVICE_NAME.concat(".delete"));
        } catch (final IOException e) {
            DriveUtils.defaultErrorHandler(result, "Delete reply error: " + e.getMessage());
        }
    }

    public Optional<Drive.Replies.Delete> delete(final Map<String, Object> args) {
        try {
            final RepliesRequestOptions deleteOptions = toRepliesRequest(requestFactory.toJson(args));
            // Mandatory fields: FileID, CommentID, ReplyID.
            if (missingFileCommentReplyId(deleteOptions)) {
                DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                    requestFactory.toJson(
                        DriveUtils.newErrorMap("FileId, CommentId and ReplyId should be specified.")));
                return Optional.empty();
            }
            // Create comment delete request.
            final Drive.Replies.Delete deleteRequest = requestFactory.buildRequest(DriveRequestType.DELETE, deleteOptions,
                null, Replies.Delete.class);
            return Optional.of(deleteRequest);
        } catch (final IOException e) {
            DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                requestFactory.toJson(e));
        }
        return Optional.empty();
    }

    private void get(final MethodCall call, final Result result) {
        try {
            // Mandatory fields: FileID, CommentID, ReplyID.
            final RepliesRequestOptions requestOptions = toRepliesRequest(call, false);
            if (missingFileCommentReplyId(requestOptions, result)) {
                return;
            }
            // Create get request.
            final Drive.Replies.Get repliesGetRequest = requestFactory.buildRequest(DriveRequestType.GET, requestOptions,
                null, Drive.Replies.Get.class);
            // Run on background and handle Flutter result.
            requestFactory.runTaskOnBackground(result, Reply.class, repliesGetRequest, SERVICE_NAME,
                SERVICE_NAME.concat(".get"));
        } catch (final IOException e) {
            DriveUtils.defaultErrorHandler(result, "Get reply error: " + e.getMessage());
        }
    }

    public Optional<Drive.Replies.Get> get(final Map<String, Object> args) {
        try {
            // Mandatory fields: FileID, CommentID, ReplyID.
            final RepliesRequestOptions requestOptions = toRepliesRequest(requestFactory.toJson(args));
            if (missingFileCommentReplyId(requestOptions)) {
                DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                    requestFactory.toJson(
                        DriveUtils.newErrorMap("FileId, CommentId and ReplyId should be specified.")));
                return Optional.empty();
            }
            // Create get request.
            final Drive.Replies.Get repliesGetRequest = requestFactory.buildRequest(DriveRequestType.GET, requestOptions,
                null, Drive.Replies.Get.class);
            return Optional.of(repliesGetRequest);
        } catch (final IOException e) {
            DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                requestFactory.toJson(e));
        }
        return Optional.empty();
    }

    private void list(final MethodCall call, final Result result) {
        final RepliesRequestOptions listOptions = toRepliesRequest(call, false);
        // Mandatory fields: FileID, CommentID.
        if (missingFileIdOrCommentId(listOptions, result)) {
            return;
        }
        try {
            // Create the list request
            final Drive.Replies.List listRequest = requestFactory.buildRequest(DriveRequestType.LIST, listOptions, null,
                Drive.Replies.List.class);
            // Run on background and handle Flutter result.
            requestFactory.runTaskOnBackground(result, ReplyList.class, listRequest, SERVICE_NAME,
                SERVICE_NAME.concat(".list"));
        } catch (final IOException e) {
            DriveUtils.defaultErrorHandler(result, "Replies list error: " + e.getMessage());
        }
    }

    public Optional<Drive.Replies.List> list(final Map<String, Object> args) {
        final RepliesRequestOptions listOptions = toRepliesRequest(requestFactory.toJson(args));
        // Mandatory fields: FileID, CommentID.
        if (missingFileIdOrCommentId(listOptions)) {
            DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                requestFactory.toJson(DriveUtils.newErrorMap("FileId and CommentId should be specified.")));
            return Optional.empty();
        }
        try {
            // Create the list request
            final Drive.Replies.List listRequest = requestFactory.buildRequest(DriveRequestType.LIST, listOptions, null,
                Drive.Replies.List.class);
            return Optional.of(listRequest);
        } catch (final IOException e) {
            DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                requestFactory.toJson(e));
        }
        return Optional.empty();
    }

    private void update(final MethodCall call, final Result result) {
        final Reply reply;
        try {
            // Mandatory fields: FileID, CommentID, ReplyID, Reply.
            reply = toReply(call);
            final RepliesRequestOptions updateOptions = toRepliesRequest(call, true);
            if (missingFileCommentReplyId(updateOptions, result) || reply == null) {
                return;
            }
            requestFactory.setExtraParams(reply, call);
            // Create the update request
            final Drive.Replies.Update updateRequest = requestFactory.buildRequest(DriveRequestType.UPDATE, updateOptions,
                reply, Replies.Update.class);
            // Run on background and handle Flutter result.
            requestFactory.runTaskOnBackground(result, Reply.class, updateRequest, SERVICE_NAME,
                SERVICE_NAME.concat(".update"));
        } catch (final NullPointerException | IOException e) {
            DriveUtils.defaultErrorHandler(result, "Update reply error: " + e.getMessage());
        }
    }

    public Optional<Drive.Replies.Update> update(final Map<String, Object> args) {
        final Reply reply;
        try {
            // Mandatory fields: FileID, CommentID, ReplyID, Reply.
            reply = toReply(requestFactory.toJson(args.get(REPLY_KEY)));
            final RepliesRequestOptions updateOptions = toRepliesRequest(requestFactory.toJson(args));
            if (missingFileCommentReplyId(updateOptions) || reply == null) {
                DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                    requestFactory.toJson(
                        DriveUtils.newErrorMap("FileId, CommentId, ReplyId and Reply should be specified.")));
                return Optional.empty();
            }
            // Create the update request
            final Drive.Replies.Update updateRequest = requestFactory.buildRequest(DriveRequestType.UPDATE, updateOptions,
                reply, Replies.Update.class);
            return Optional.of(updateRequest);
        } catch (final NullPointerException | IOException e) {
            DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                requestFactory.toJson(e));
        }
        return Optional.empty();
    }

    private boolean missingFileCommentReplyId(final RepliesRequestOptions requestOptions, final Result result) {
        if (!DriveUtils.isNotNullAndEmpty(requestOptions.getReplyId())) {
            Log.i(TAG, "Please specify a replyID.");
            DriveUtils.defaultErrorHandler(result, "Reply ID can't be null or empty.");
            return true;
        } else {
            return missingFileIdOrCommentId(requestOptions, result);
        }
    }

    private boolean missingFileCommentReplyId(final RepliesRequestOptions requestOptions) {
        if (!DriveUtils.isNotNullAndEmpty(requestOptions.getReplyId())) {
            Log.i(TAG, "Please specify a replyID.");
            return true;
        } else {
            return missingFileIdOrCommentId(requestOptions);
        }
    }

    private Reply toReply(final MethodCall call) throws IOException {
        final Reply reply;
        try {
            reply = GsonFactory.getDefaultInstance()
                .fromString(Objects.requireNonNull(call.argument(REPLY_KEY)), Reply.class);
        } catch (final IOException | NullPointerException e) {
            throw new IOException("Could not create the reply, please check the arguments.");
        }
        return reply;
    }

    private Reply toReply(final String args) throws IOException {
        final Reply reply;
        try {
            reply = GsonFactory.getDefaultInstance().fromString(args, Reply.class);
        } catch (final IOException | NullPointerException e) {
            throw new IOException("Could not create the reply, please check the arguments.");
        }
        return reply;
    }

    private RepliesRequestOptions toRepliesRequest(final MethodCall call, final boolean fromMap) {
        if (fromMap) {
            return requestFactory.getGson().fromJson((String) call.argument("request"), RepliesRequestOptions.class);
        }
        return requestFactory.getGson().fromJson((String) call.arguments, RepliesRequestOptions.class);
    }

    private RepliesRequestOptions toRepliesRequest(final String args) {
        return requestFactory.getGson().fromJson(args, RepliesRequestOptions.class);
    }
}
