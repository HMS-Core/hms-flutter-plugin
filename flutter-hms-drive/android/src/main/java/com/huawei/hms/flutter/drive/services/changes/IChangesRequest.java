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

import com.huawei.cloud.services.drive.DriveRequest;
import com.huawei.hms.flutter.drive.common.service.IDriveRequest;

public interface IChangesRequest extends IDriveRequest {
    /**
     * Sets cursor for the drive changes request.
     *
     * @param request A DriveRequest to set the cursor.
     * @param cursor  Cursor for the current page, which is obtained from nextCursor in the previous response or using
     *                the getStartCursor method. The server returns a maximum of 100 changes for each query request. If
     *                there are more than 100 changes, the cursor needs to be set to nextCursor for a new change
     *                notification. This process repeats until nextCursor in the response is empty, which indicates that
     *                all changes have been returned.
     */
    void setCursor(DriveRequest<?> request, String cursor);

    /**
     * Sets pageSize for the drive changes request.
     *
     * @param request  A DriveRequest to set page size.
     * @param pageSize Number of changes returned on each page. The default value is 100. The value ranges from 1 to
     *                 100. Note: It is possible that partial or empty result pages are returned before the end of the
     *                 result list has been reached.
     */
    void setPageSize(DriveRequest<?> request, Integer pageSize);

    /**
     * Sets the types of space to query for the drive changes request.
     *
     * @param request    A DriveRequest to set the containers.
     * @param containers Types of space to query. The options include drive and applicationData.
     */
    void setContainers(DriveRequest<?> request, String containers);

    /**
     * Sets whether the changes that have been deleted are included in the returned change list. A deleted change may be
     * one deleted by the user or one that the user no longer has the required permission.
     *
     * @param request        A DriveRequest to set the includeDeleted option.
     * @param includeDeleted Boolean value that indicates whether the changes that have been deleted are included in the
     *                       returned change list.
     */
    void setIncludeDeleted(DriveRequest<?> request, Boolean includeDeleted);
}
