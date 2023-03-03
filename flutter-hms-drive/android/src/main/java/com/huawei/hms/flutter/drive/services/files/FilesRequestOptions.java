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

import com.huawei.hms.flutter.drive.common.service.DriveRequestOptions;

import java.util.Map;

public class FilesRequestOptions extends DriveRequestOptions {

    private final String fileId;
    private final String containers;
    private final boolean acknowledgeDownloadRisk;
    private final String orderBy;
    private final String queryParam;
    private final int pageSize;
    private final String cursor;
    private final String addParentFolder;
    private final String removeParentFolder;

    public String getFileId() {
        return fileId;
    }

    public String getContainers() {
        return containers;
    }

    public boolean getAcknowledgeDownloadRisk() {
        return acknowledgeDownloadRisk;
    }

    public String getOrderBy() {
        return orderBy;
    }

    public String getQueryParam() {
        return queryParam;
    }

    public int getPageSize() {
        return pageSize;
    }

    public String getCursor() {
        return cursor;
    }

    public String getAddParentFolder() {
        return addParentFolder;
    }

    public String getRemoveParentFolder() {
        return removeParentFolder;
    }

    public FilesRequestOptions(final String fileId, final String containers, final boolean acknowledgeDownloadRisk,
        final String orderBy, final String queryParam, final int pageSize, final String cursor,
        final String addParentFolder, final String removeParentFolder, final String fields, final String form,
        final Map<String, Object> parameters, final boolean prettyPrint, final String quotaId) {
        super(form, fields, prettyPrint, quotaId, parameters);
        this.fileId = fileId;
        this.containers = containers;
        this.acknowledgeDownloadRisk = acknowledgeDownloadRisk;
        this.orderBy = orderBy;
        this.queryParam = queryParam;
        this.pageSize = pageSize;
        this.cursor = cursor;
        this.addParentFolder = addParentFolder;
        this.removeParentFolder = removeParentFolder;
    }
}
