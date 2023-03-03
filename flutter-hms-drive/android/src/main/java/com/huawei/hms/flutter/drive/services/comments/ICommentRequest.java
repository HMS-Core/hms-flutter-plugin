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

import com.huawei.cloud.services.drive.DriveRequest;
import com.huawei.hms.flutter.drive.common.service.IDriveRequest;

public interface ICommentRequest extends IDriveRequest {

    /**
     * Sets whether the comments that have been deleted are included in the returned change list. A deleted change may
     * be one deleted by the user or one that the user no longer has the required permission.
     *
     * @param request        A DriveRequest to set the includeDeleted option.
     * @param includeDeleted Boolean value that indicates whether the comments that have been deleted are included in
     *                       the returned change list.
     */
    void setIncludeDeleted(DriveRequest<?> request, Boolean includeDeleted);

    /**
     * Sets a file ID for the drive comments request.
     *
     * @param request A DriveRequest to set fileID.
     * @param fileId  File ID.
     */
    void setFileId(DriveRequest<?> request, String fileId);

    /**
     * Sets a file comment ID for the drive changes request.
     *
     * @param request   A DriveRequest to set the commentID.
     * @param commentId Comment ID.
     */
    void setCommentId(DriveRequest<?> request, String commentId);

    /**
     * Sets pageSize for the drive comments request.
     *
     * @param request  A DriveRequest to set the page size.
     * @param pageSize Number of comments returned on each page. The default value is 100. The value ranges from 1 to
     *                 100. Note: It is possible that partial or empty result pages are returned before the end of the
     *                 result list has been reached.
     */
    void setPageSize(DriveRequest<?> request, Integer pageSize);

    /**
     * Sets cursor for the drive comments request.
     *
     * @param request A DriveRequest to set the cursor.
     * @param cursor  Cursor for the current page, which is obtained from nextCursor in the previous response or using
     *                the getStartCursor method. The server returns a maximum of 100 comments for each query request. If
     *                there are more than 100 comments, the cursor needs to be set to nextCursor for a new change
     *                notification. This process repeats until nextCursor in the response is empty, which indicates that
     *                all comments have been returned.
     */
    void setCursor(DriveRequest<?> request, String cursor);

    /**
     * Sets the earliest modification time of a comment for the drive comments request.
     *
     * @param request         A DriveRequest to set the startEditedTime.
     * @param startEditedTime Earliest modification time of a comment.
     */
    void setStartEditedTime(DriveRequest<?> request, String startEditedTime);
}
