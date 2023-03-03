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

import com.huawei.hms.flutter.drive.common.service.DriveRequestOptions;

import java.util.Map;

public class HistoryVersionsRequestOptions extends DriveRequestOptions {
    private String historyVersionId;
    private String fileId;
    private String cursor;
    private Integer pageSize;
    private Boolean acknowledgeDownloadRisk;

    public String getHistoryVersionId() {
        return historyVersionId;
    }

    public void setHistoryVersionId(String historyVersionId) {
        this.historyVersionId = historyVersionId;
    }

    public String getFileId() {
        return fileId;
    }

    public void setFileId(String fileId) {
        this.fileId = fileId;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public String getCursor() {
        return cursor;
    }

    public void setCursor(String cursor) {
        this.cursor = cursor;
    }

    public Boolean getAcknowledgeDownloadRisk() {
        return acknowledgeDownloadRisk;
    }

    public void setAcknowledgeDownloadRisk(Boolean acknowledgeDownloadRisk) {
        this.acknowledgeDownloadRisk = acknowledgeDownloadRisk;
    }

    public HistoryVersionsRequestOptions(String form, String fields, boolean prettyPrint, String quotaID,
        Map<String, Object> parameters, String historyVersionId, String fileId, String cursor, int pageSize,
        Boolean acknowledgeDownloadRisk) {
        super(form, fields, prettyPrint, quotaID, parameters);
        this.historyVersionId = historyVersionId;
        this.fileId = fileId;
        this.cursor = cursor;
        this.pageSize = pageSize;
        this.acknowledgeDownloadRisk = acknowledgeDownloadRisk;
    }
}
