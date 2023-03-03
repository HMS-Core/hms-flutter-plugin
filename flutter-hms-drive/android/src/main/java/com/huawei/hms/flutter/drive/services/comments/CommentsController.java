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

package com.huawei.hms.flutter.drive.services.comments;

import static com.huawei.hms.flutter.drive.common.utils.DriveUtils.missingFileIdOrCommentId;

import android.content.Context;

import androidx.annotation.NonNull;

import com.huawei.cloud.base.json.gson.GsonFactory;
import com.huawei.cloud.services.drive.Drive;
import com.huawei.cloud.services.drive.Drive.Comments;
import com.huawei.cloud.services.drive.Drive.Comments.Delete;
import com.huawei.cloud.services.drive.Drive.Comments.Update;
import com.huawei.cloud.services.drive.model.Comment;
import com.huawei.cloud.services.drive.model.CommentList;
import com.huawei.hms.flutter.drive.common.Constants.CommentsMethods;
import com.huawei.hms.flutter.drive.common.Constants.DriveRequestType;
import com.huawei.hms.flutter.drive.common.utils.DriveUtils;

import java.io.IOException;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

public class CommentsController {
    private static final String COMMENT_KEY = "comment";
    private static final String SERVICE_NAME = "Comments";

    private final CommentsRequestFactory requestFactory;

    public CommentsController(final Drive drive, final Context context) {
        requestFactory = new CommentsRequestFactory(drive, context);
    }

    // Make the comments methods private
    public void onMethodCall(final @NonNull MethodCall call, final @NonNull Result result) {
        final String methodName = DriveUtils.methodNameExtractor(call).second;
        switch (CommentsMethods.getEnum(methodName)) {
            case COMMENT_CREATE:
                commentsCreate(call, result);
                break;
            case COMMENT_DELETE:
                commentsDelete(call, result);
                break;
            case COMMENT_GET:
                commentsGet(call, result);
                break;
            case COMMENT_LIST:
                commentsList(call, result);
                break;
            case COMMENTS_UPDATE:
                commentsUpdate(call, result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void commentsCreate(final MethodCall call, final Result result) {
        try {
            final Comment comment = toComment(call);
            final CommentsRequestOptions createOptions = toCommentRequest(call, true);
            // Sets the extra parameters of the model.
            requestFactory.setExtraParams(comment, call);

            if (!DriveUtils.isNotNullAndEmpty(createOptions.getFileId())) {
                DriveUtils.defaultErrorHandler(result, "FileId can't be null or empty.");
                return;
            }
            // Create comment create request.
            final Drive.Comments.Create createRequest = requestFactory.buildRequest(DriveRequestType.CREATE,
                createOptions, comment, Drive.Comments.Create.class);
            // Run on background and handle Flutter result.
            requestFactory.runTaskOnBackground(result, Comment.class, createRequest, SERVICE_NAME,
                SERVICE_NAME.concat(".create"));
        } catch (final IOException e) {
            DriveUtils.defaultErrorHandler(result, "Create comment error: " + e.toString());
        }
    }

    public Optional<Comments.Create> batchCommentsCreate(final Map<String, Object> args) {
        try {
            final Comment comment;
            final CommentsRequestOptions createOptions;
            comment = toComment(requestFactory.toJson(args.get(COMMENT_KEY)));
            createOptions = toCommentRequest(requestFactory.toJson(args));
            if (!DriveUtils.isNotNullAndEmpty(createOptions.getFileId())) {
                DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                    requestFactory.toJson(DriveUtils.newErrorMap("FileId should be specified.")));
                return Optional.empty();
            }
            final Drive.Comments.Create createRequest = requestFactory.buildRequest(DriveRequestType.CREATE,
                createOptions, comment, Drive.Comments.Create.class);
            // Return the list request.
            return Optional.of(createRequest);
        } catch (final IOException e) {
            DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                requestFactory.toJson(e));
        }
        return Optional.empty();
    }

    private void commentsGet(final MethodCall call, final Result result) {
        try {
            final CommentsRequestOptions requestOptions = toCommentRequest(call, false);
            if (missingFileIdOrCommentId(requestOptions, result)) {
                return;
            }
            // Create get request.
            final Drive.Comments.Get commentsGetRequest = requestFactory.buildRequest(DriveRequestType.GET,
                requestOptions, null, Drive.Comments.Get.class);
            // Run on background and handle Flutter result.
            requestFactory.runTaskOnBackground(result, Comment.class, commentsGetRequest, SERVICE_NAME,
                SERVICE_NAME.concat(".get"));
        } catch (final IOException e) {
            DriveUtils.defaultErrorHandler(result, "Get comment error: " + e.getMessage());
        }
    }

    public Optional<Comments.Get> batchCommentsGet(final Map<String, Object> args) {
        try {
            final CommentsRequestOptions requestOptions = toCommentRequest(requestFactory.toJson(args));
            if (missingFileIdOrCommentId(requestOptions)) {
                DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                    requestFactory.toJson(DriveUtils.newErrorMap("FileId and CommentId should be specified.")));
                return Optional.empty();
            }
            // Create get request.
            final Drive.Comments.Get commentsGetRequest = requestFactory.buildRequest(DriveRequestType.GET,
                requestOptions, null, Drive.Comments.Get.class);
            // Return the list request.
            return Optional.of(commentsGetRequest);
        } catch (final IOException e) {
            DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                requestFactory.toJson(e));
        }
        return Optional.empty();
    }

    private void commentsDelete(final MethodCall call, final Result result) {
        try {
            final CommentsRequestOptions deleteOptions = toCommentRequest(call, false);
            if (missingFileIdOrCommentId(deleteOptions, result)) {
                return;
            }
            // Create comment delete request.
            final Drive.Comments.Delete deleteRequest = requestFactory.buildRequest(DriveRequestType.DELETE,
                deleteOptions, null, Delete.class);
            // Run on background and handle Flutter result.
            requestFactory.runTaskOnBackground(result, Void.class, deleteRequest, SERVICE_NAME,
                SERVICE_NAME.concat(".delete"));
        } catch (final IOException e) {
            DriveUtils.defaultErrorHandler(result, "Delete comment error: " + e.getMessage());
        }
    }

    public Optional<Comments.Delete> batchCommentsDelete(final Map<String, Object> args) {
        try {
            final CommentsRequestOptions deleteOptions = toCommentRequest(requestFactory.toJson(args));
            if (missingFileIdOrCommentId(deleteOptions)) {
                DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                    requestFactory.toJson(DriveUtils.newErrorMap("FileId and CommentId should be specified.")));
                return Optional.empty();
            }
            // Create comment delete request.
            final Drive.Comments.Delete deleteRequest = requestFactory.buildRequest(DriveRequestType.DELETE,
                deleteOptions, null, Delete.class);
            // Return the created request.
            return Optional.of(deleteRequest);
        } catch (final IOException e) {
            DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                requestFactory.toJson(e));
        }
        return Optional.empty();
    }

    private void commentsList(final MethodCall call, final Result result) {
        final CommentsRequestOptions listOptions = toCommentRequest(call, false);
        if (!DriveUtils.isNotNullAndEmpty(listOptions.getFileId())) {
            DriveUtils.defaultErrorHandler(result, "FileId can't be null or empty.");
            return;
        }
        try {
            // Create the list request
            final Drive.Comments.List listRequest = requestFactory.buildRequest(DriveRequestType.LIST, listOptions,
                null, Drive.Comments.List.class);
            // Run on background and handle Flutter result.
            requestFactory.runTaskOnBackground(result, CommentList.class, listRequest, SERVICE_NAME,
                SERVICE_NAME.concat(".list"));
        } catch (final IOException e) {
            DriveUtils.defaultErrorHandler(result, "Comments list error: " + e.getMessage());
        }
    }

    public Optional<Comments.List> batchCommentsList(final Map<String, Object> args) {
        final CommentsRequestOptions listOptions = toCommentRequest(requestFactory.toJson(args));
        if (!DriveUtils.isNotNullAndEmpty(listOptions.getFileId())) {
            DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                requestFactory.toJson(DriveUtils.newErrorMap("FileId should be specified.")));
            return Optional.empty();
        }
        try {
            // Create the list request
            final Drive.Comments.List listRequest = requestFactory.buildRequest(DriveRequestType.LIST, listOptions,
                null, Drive.Comments.List.class);
            // Return the list request.
            return Optional.of(listRequest);
        } catch (final IOException e) {
            DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                requestFactory.toJson(e));
        }
        return Optional.empty();
    }

    private void commentsUpdate(final MethodCall call, final Result result) {
        try {
            final Comment comment = toComment(call);
            final CommentsRequestOptions updateOptions = toCommentRequest(call, true);
            if (missingFileIdOrCommentId(updateOptions, result) || comment == null) {
                return;
            }
            requestFactory.setExtraParams(comment, call);
            // Create the update request
            final Drive.Comments.Update updateRequest = requestFactory.buildRequest(DriveRequestType.UPDATE,
                updateOptions, comment, Update.class);
            // Run on background and handle Flutter result.
            requestFactory.runTaskOnBackground(result, Comment.class, updateRequest, SERVICE_NAME,
                SERVICE_NAME.concat(".update"));
        } catch (final NullPointerException | IOException e) {
            DriveUtils.defaultErrorHandler(result, "Update comment error: " + e.getMessage());
        }
    }

    public Optional<Comments.Update> batchCommentsUpdate(final Map<String, Object> args) {
        try {
            final Comment comment = toComment(requestFactory.toJson(args.get(COMMENT_KEY)));
            final CommentsRequestOptions updateOptions = toCommentRequest(requestFactory.toJson(args));
            if (missingFileIdOrCommentId(updateOptions) || comment == null) {
                DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                    requestFactory.toJson(
                        DriveUtils.newErrorMap("FileId, CommentId and Comment should be specified.")));
                return Optional.empty();
            }
            // Create the update request
            final Drive.Comments.Update updateRequest = requestFactory.buildRequest(DriveRequestType.UPDATE,
                updateOptions, comment, Update.class);
            // Return the update request.
            return Optional.of(updateRequest);
        } catch (final NullPointerException | IOException e) {
            DriveUtils.errorHandler(requestFactory.getContext(), requestFactory.newBatchIntent(),
                requestFactory.toJson(e));
        }
        return Optional.empty();
    }

    private Comment toComment(final MethodCall call) throws IOException {
        final Comment comment;
        try {
            comment = GsonFactory.getDefaultInstance()
                .fromString(Objects.requireNonNull(call.argument(COMMENT_KEY)), Comment.class);
        } catch (final IOException | NullPointerException e) {
            throw new IOException("Could not create the comment, please check the arguments.");
        }
        return comment;
    }

    private Comment toComment(final String args) throws IOException {
        final Comment comment;
        try {
            comment = GsonFactory.getDefaultInstance().fromString(args, Comment.class);
        } catch (final IOException | NullPointerException e) {
            throw new IOException("Could not create the comment, please check the arguments.");
        }
        return comment;
    }

    private CommentsRequestOptions toCommentRequest(final MethodCall call, final boolean fromMap) {
        if (fromMap) {
            return requestFactory.getGson().fromJson((String) call.argument("request"), CommentsRequestOptions.class);
        }
        return requestFactory.getGson().fromJson((String) call.arguments, CommentsRequestOptions.class);
    }

    private CommentsRequestOptions toCommentRequest(final String args) {
        return requestFactory.getGson().fromJson(args, CommentsRequestOptions.class);
    }
}
