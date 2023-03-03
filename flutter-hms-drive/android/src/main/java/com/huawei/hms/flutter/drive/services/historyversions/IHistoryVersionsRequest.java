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

package com.huawei.hms.flutter.drive.services.historyversions;

import com.huawei.cloud.services.drive.DriveRequest;
import com.huawei.hms.flutter.drive.common.service.IDriveRequest;

public interface IHistoryVersionsRequest extends IDriveRequest {

    /**
     * Sets a file ID for the drive history versions request.
     *
     * @param request A DriveRequest to set fileID.
     * @param fileId  File ID.
     */
    void setFileId(DriveRequest<?> request, String fileId);

    /**
     * Sets the ID of a historical file version.
     *
     * @param request          A DriveRequest to set the historyVersionID.
     * @param historyVersionId ID of a historical file version.
     */
    void setHistoryVersionId(DriveRequest<?> request, String historyVersionId);

    /**
     * Sets whether a user acknowledges the download of known malware or files incurring risks.
     *
     * @param request                 A DriveRequest to set the acknowledgeDownloadRisk.
     * @param acknowledgeDownloadRisk Indicates whether a user acknowledges the download of known malware or files
     *                                incurring risks.
     */
    void setAcknowledgeDownloadRisk(DriveRequest<?> request, Boolean acknowledgeDownloadRisk);

    /**
     * Sets the maximum number of historical versions returned on each page.
     *
     * @param request  A DriveRequest to set the page size.
     * @param pageSize Maximum number of historical versions returned on each page.
     */
    void setPageSize(DriveRequest<?> request, Integer pageSize);

    /**
     * Sets the start cursor for paging during query.
     *
     * @param request A DriveRequest to set the cursor.
     * @param cursor  Start cursor for paging during query.
     */
    void setCursor(DriveRequest<?> request, String cursor);
}
