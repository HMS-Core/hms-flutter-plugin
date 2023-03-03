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

import com.huawei.hms.flutter.drive.services.comments.CommentsRequestOptions;

import java.util.Map;

public class RepliesRequestOptions extends CommentsRequestOptions {
    private String replyId;

    public String getReplyId() {
        return replyId;
    }

    public RepliesRequestOptions(String fileId, String commentId, boolean includeDeleted, Integer pageSize,
        String cursor, String startEditedTime, String form, String fields, boolean prettyPrint, String quotaID,
        Map<String, Object> parameters, String replyId) {
        super(fileId, commentId, includeDeleted, pageSize, cursor, startEditedTime, form, fields, prettyPrint, quotaID,
            parameters);
        this.replyId = replyId;
    }
}
