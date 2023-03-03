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

import android.content.Context;

import com.huawei.cloud.services.drive.Drive;
import com.huawei.cloud.services.drive.Drive.Comments;
import com.huawei.cloud.services.drive.Drive.Comments.Get;
import com.huawei.cloud.services.drive.Drive.Comments.List;
import com.huawei.cloud.services.drive.Drive.Replies;
import com.huawei.cloud.services.drive.DriveRequest;
import com.huawei.cloud.services.drive.model.Comment;
import com.huawei.hms.flutter.drive.common.Constants.DriveRequestType;
import com.huawei.hms.flutter.drive.common.service.DriveRequestFactory;
import com.huawei.hms.flutter.drive.common.utils.DriveUtils;

import java.io.IOException;

public class CommentsRequestFactory extends DriveRequestFactory implements ICommentRequest {

    public CommentsRequestFactory(Drive drive, Context context) {
        super(drive, context);
    }

    protected <T extends DriveRequest<?>> T buildRequest(DriveRequestType driveRequestType,
        CommentsRequestOptions requestOptions, Comment comment, Class<T> type) throws IOException {
        DriveRequest<?> request;
        switch (driveRequestType) {
            case CREATE:
                request = commentsApi().create(requestOptions.getFileId(), comment);
                break;
            case GET:
                request = commentsApi().get(requestOptions.getFileId(), requestOptions.getCommentId());
                break;
            case DELETE:
                request = commentsApi().delete(requestOptions.getFileId(), requestOptions.getCommentId());
                break;
            case LIST:
                request = commentsApi().list(requestOptions.getFileId());
                break;
            case UPDATE:
                request = commentsApi().update(requestOptions.getFileId(), requestOptions.getCommentId(), comment);
                break;
            default:
                throw new IOException("Unsupported comment request type");
        }
        if (request != null) {
            // Set the request options and cast it to the given request class.
            return type.cast(requestBuilder(request, requestOptions));
        } else {
            throw new IOException("Couldn't create the comments request");
        }
    }

    private Comments commentsApi() {
        return getDrive().comments();
    }

    protected <T extends DriveRequest<?>> T requestBuilder(T request, CommentsRequestOptions requestOptions) {
        if (DriveUtils.isNullOrEmpty(requestOptions.getFields())) {
            requestOptions.setFields("*");
        }
        // Sets the base drive request options via the base drive request factory class.
        setBasicRequestOptions(request, requestOptions);

        // Comments related options
        setCommentId(request, requestOptions.getCommentId());
        setFileId(request, requestOptions.getFileId());
        setIncludeDeleted(request, requestOptions.isIncludeDeleted());
        setPageSize(request, requestOptions.getPageSize());
        setCursor(request, requestOptions.getCursor());
        setStartEditedTime(request, requestOptions.getStartEditedTime());

        return request;
    }

    @Override
    public void setIncludeDeleted(DriveRequest<?> request, Boolean includeDeleted) {
        if (request instanceof Comments.Get) {
            ((Get) request).setIncludeDeleted(includeDeleted);
        } else if (request instanceof Comments.List) {
            ((List) request).setIncludeDeleted(includeDeleted);
        } else if (request instanceof Replies.Get) {
            ((Replies.Get) request).setIncludeDeleted(includeDeleted);
        } else if (request instanceof Replies.List) {
            ((Replies.List) request).setIncludeDeleted(includeDeleted);
        }
    }

    @Override
    public void setPageSize(DriveRequest<?> request, Integer pageSize) {
        if (pageSize != null && pageSize > 0) {
            if (request instanceof Drive.Comments.List) {
                ((Comments.List) request).setPageSize(pageSize);
            } else if (request instanceof Drive.Replies.List) {
                ((Replies.List) request).setPageSize(pageSize);
            }
        }
    }

    @Override
    public void setCursor(DriveRequest<?> request, String cursor) {
        if (DriveUtils.isNotNullAndEmpty(cursor)) {
            if (request instanceof Drive.Comments.List) {
                ((Comments.List) request).setCursor(cursor);
            } else if (request instanceof Drive.Replies.List) {
                ((Replies.List) request).setCursor(cursor);
            }
        }
    }

    @Override
    public void setStartEditedTime(DriveRequest<?> request, String startEditedTime) {
        if (!DriveUtils.isNotNullAndEmpty(startEditedTime) && request instanceof Drive.Comments.List) {
            ((Comments.List) request).setStartEditedTime(startEditedTime);
        }
    }

    @Override
    public void setCommentId(DriveRequest<?> request, String commentId) {
        if (DriveUtils.isNotNullAndEmpty(commentId)) {
            if (request instanceof Comments.Get) {
                ((Comments.Get) request).setCommentId(commentId);
            } else if (request instanceof Comments.Update) {
                ((Comments.Update) request).setCommentId(commentId);
            } else if (request instanceof Comments.Delete) {
                ((Comments.Delete) request).setCommentId(commentId);
            } else if (request instanceof Replies.Get) {
                ((Replies.Get) request).setCommentId(commentId);
            } else if (request instanceof Replies.Update) {
                ((Replies.Update) request).setCommentId(commentId);
            } else if (request instanceof Replies.Delete) {
                ((Replies.Delete) request).setCommentId(commentId);
            } else if (request instanceof Replies.Create) {
                ((Replies.Create) request).setCommentId(commentId);
            } else if (request instanceof Replies.List) {
                ((Replies.List) request).setCommentId(commentId);
            }
        }
    }

    @Override
    public void setFileId(DriveRequest<?> request, String fileID) {
        if (DriveUtils.isNotNullAndEmpty(fileID)) {
            if (request instanceof Comments.Create) {
                ((Comments.Create) request).setFileId(fileID);
            } else if (request instanceof Comments.Get) {
                ((Comments.Get) request).setFileId(fileID);
            } else if (request instanceof Comments.Delete) {
                ((Comments.Delete) request).setFileId(fileID);
            } else if (request instanceof Comments.List) {
                ((Comments.List) request).setFileId(fileID);
            } else if (request instanceof Comments.Update) {
                ((Comments.Update) request).setFileId(fileID);
            } else if (request instanceof Replies.Create) {
                ((Replies.Create) request).setFileId(fileID);
            } else if (request instanceof Replies.Get) {
                ((Replies.Get) request).setFileId(fileID);
            } else if (request instanceof Replies.Delete) {
                ((Replies.Delete) request).setFileId(fileID);
            } else if (request instanceof Replies.List) {
                ((Replies.List) request).setFileId(fileID);
            } else if (request instanceof Replies.Update) {
                ((Replies.Update) request).setFileId(fileID);
            }
        }
    }
}
