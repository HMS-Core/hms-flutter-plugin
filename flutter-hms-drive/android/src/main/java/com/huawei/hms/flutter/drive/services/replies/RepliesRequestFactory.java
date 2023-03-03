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

import static com.huawei.hms.flutter.drive.common.utils.DriveUtils.isNotNullAndEmpty;

import android.content.Context;

import com.huawei.cloud.services.drive.Drive;
import com.huawei.cloud.services.drive.Drive.Replies;
import com.huawei.cloud.services.drive.Drive.Replies.Delete;
import com.huawei.cloud.services.drive.Drive.Replies.Get;
import com.huawei.cloud.services.drive.Drive.Replies.Update;
import com.huawei.cloud.services.drive.DriveRequest;
import com.huawei.cloud.services.drive.model.Reply;
import com.huawei.hms.flutter.drive.common.Constants.DriveRequestType;
import com.huawei.hms.flutter.drive.services.comments.CommentsRequestFactory;

import java.io.IOException;

public class RepliesRequestFactory extends CommentsRequestFactory implements IReplyRequest {

    public RepliesRequestFactory(Drive drive, Context context) {
        super(drive, context);
    }

    protected <T extends DriveRequest<?>> T buildRequest(DriveRequestType driveRequestType,
        RepliesRequestOptions requestOptions, Reply reply, Class<T> type) throws IOException {
        DriveRequest<?> request;
        switch (driveRequestType) {
            case CREATE:
                request = repliesApi().create(requestOptions.getFileId(), requestOptions.getCommentId(), reply);
                break;
            case GET:
                request = repliesApi().get(requestOptions.getFileId(), requestOptions.getCommentId(),
                    requestOptions.getReplyId());
                break;
            case DELETE:
                request = repliesApi().delete(requestOptions.getFileId(), requestOptions.getCommentId(),
                    requestOptions.getReplyId());
                break;
            case LIST:
                request = repliesApi().list(requestOptions.getFileId(), requestOptions.getCommentId());
                break;
            case UPDATE:
                request = repliesApi().update(requestOptions.getFileId(), requestOptions.getCommentId(),
                    requestOptions.getReplyId(), reply);
                break;
            default:
                throw new IOException("Unsupported replies request type");
        }
        if (request != null) {
            // Set the request options and cast it to the given request class.
            return type.cast(requestBuilder(request, requestOptions));
        } else {
            throw new IOException("Couldn't create the replies request");
        }
    }

    private Replies repliesApi() {
        return getDrive().replies();
    }

    private <T extends DriveRequest<?>> T requestBuilder(T request, RepliesRequestOptions requestOptions) {
        super.requestBuilder(request, requestOptions);
        setReplyId(request, requestOptions.getReplyId());
        return request;
    }

    @Override
    public void setReplyId(DriveRequest<?> replyRequest, String replyId) {
        if (isNotNullAndEmpty(replyId)) {
            if (replyRequest instanceof Get) {
                ((Get) replyRequest).setReplyId(replyId);
            } else if (replyRequest instanceof Update) {
                ((Update) replyRequest).setReplyId(replyId);
            } else if (replyRequest instanceof Delete) {
                ((Delete) replyRequest).setReplyId(replyId);
            }
        }
    }

}
