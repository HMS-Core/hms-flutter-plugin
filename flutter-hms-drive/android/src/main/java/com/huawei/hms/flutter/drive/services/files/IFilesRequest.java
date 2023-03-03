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

package com.huawei.hms.flutter.drive.services.files;

import com.huawei.cloud.services.drive.DriveRequest;
import com.huawei.hms.flutter.drive.common.service.IDriveRequest;

public interface IFilesRequest extends IDriveRequest {

    /**
     * Sets a file ID for the drive files request.
     *
     * @param request A DriveRequest to set fileID.
     * @param fileId  File ID.
     */
    void setFileId(DriveRequest<?> request, String fileId);

    /**
     * Sets the types of space to query for the drive files request.
     *
     * @param request    A DriveRequest to set the containers.
     * @param containers Types of space to query. The options include drive and applicationData.
     */
    void setContainers(DriveRequest<?> request, String containers);

    /**
     * Sets whether a user acknowledges the download of known malware or files incurring risks.
     *
     * @param request                 A DriveRequest to set the acknowledgeDownloadRisk.
     * @param acknowledgeDownloadRisk Indicates whether a user acknowledges the download of known malware or files
     *                                incurring risks.
     */
    void setAcknowledgeDownloadRisk(DriveRequest<?> request, Boolean acknowledgeDownloadRisk);

    /**
     * Sets orderBy for the drive files request.
     *
     * @param request A DriveRequest to set the orderBy value.
     * @param orderBy A file list can be sorted by file creation time (createdTime), folder (folder), file modification
     *                time (editedTime), file name (fileName), and file size (size, only for users whose security
     *                policies have not been updated). This parameter specifies the file list sorting mode. If this
     *                parameter is not set, a file list is sorted by file creation time by default
     */
    void setOrderBy(DriveRequest<?> request, String orderBy);

    /**
     * Sets a file query statement.
     *
     * @param request    A DriveRequest to set the queryParam.
     * @param queryParam File query statement, which can be used to query the specified file or folder based on the
     *                   specified filter criteria. A filter criterion is in the format Attribute name Operator
     *                   Attribute value. If multiple filter criteria need to be specified, use and to connect them. If
     *                   no query statement is set, all files and folders on Drive are returned by default. The
     *                   following table lists the attributes currently supported by a query statement.
     *                   <p>
     *                   To query files or folders in a parent folder, the filter criterion is always fileId in parents,
     *                   in which fileId indicates the ID of a parent folder.
     */
    void setQueryParam(DriveRequest<?> request, String queryParam);

    /**
     * Sets the page size for the drive files request.
     *
     * @param request  A DriveRequest to set the page size.
     * @param pageSize Number of files returned on each page. The value ranges from 1 to 100. If pageSize is not set or
     *                 the value of pageSize exceeds the maximum value set on the server, the maximum value set on the
     *                 server will be used by default.
     */
    void setPageSize(DriveRequest<?> request, Integer pageSize);

    /**
     * Sets cursor for the drive files request.
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
     * Sets the IDs of parent folders to be added.
     *
     * @param request         A DriveRequest to set the addParentFolder.
     * @param addParentFolder IDs of parent folders to be added, which are separated by commas (,).
     */
    void setAddParentFolder(DriveRequest<?> request, String addParentFolder);

    /**
     * Sets the IDs of parent folders to be deleted.
     *
     * @param request            A DriveRequest to set the removeParentFolder.
     * @param removeParentFolder IDs of parent folders to be deleted, which are separated by commas (,).
     */
    void setRemoveParentFolder(DriveRequest<?> request, String removeParentFolder);
}
