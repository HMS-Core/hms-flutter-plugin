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

import com.huawei.hms.flutter.drive.common.service.DriveRequestOptions;

import java.util.Map;

public class CommentsRequestOptions extends DriveRequestOptions {

    /**
     * File ID.
     */
    private String fileId;

    /**
     * Whether to return deleted comments.
     */
    private boolean includeDeleted;

    /**
     * A Comment Id.
     */
    private String commentId;

    /**
     * Pagination size for a list request.
     */
    private Integer pageSize;

    /**
     * Cursor for the current page, which is obtained from nextCursor in the previous response. The server returns a
     * maximum of 100 comments for each query request. If there are more than 100 comments, the cursor needs to be set
     * to nextCursor for a new file notification. This process repeats until nextCursor in the response is empty, which
     * indicates that all comments have been returned.
     */
    private String cursor;

    /**
     * Earliest modification time of a comment.
     */
    private String startEditedTime;

    public boolean isIncludeDeleted() {
        return includeDeleted;
    }

    public void setCursor(String cursor) {
        this.cursor = cursor;
    }

    public String getStartEditedTime() {
        return startEditedTime;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public String getFileId() {
        return fileId;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public String getCursor() {
        return cursor;
    }

    public String getCommentId() {
        return commentId;
    }

    public CommentsRequestOptions(String fileId, String commentId, boolean includeDeleted, Integer pageSize,
        String cursor, String startEditedTime, String form, String fields, boolean prettyPrint, String quotaId,
        Map<String, Object> parameters) {
        super(form, fields, prettyPrint, quotaId, parameters);
        this.fileId = fileId;
        this.commentId = commentId;
        this.includeDeleted = includeDeleted;
        this.pageSize = pageSize;
        this.cursor = cursor;
        this.startEditedTime = startEditedTime;
    }
}
