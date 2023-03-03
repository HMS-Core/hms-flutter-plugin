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

import com.huawei.hms.flutter.drive.common.service.DriveRequestOptions;

import java.util.Map;

public class ChangesRequestOptions extends DriveRequestOptions {
    private String cursor;
    private String containers;
    private int pageSize;
    private boolean includeDeleted;

    public String getCursor() {
        return cursor;
    }

    public void setCursor(String cursor) {
        this.cursor = cursor;
    }

    public String getContainers() {
        return containers;
    }

    public void setContainers(String containers) {
        this.containers = containers;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public boolean isIncludeDeleted() {
        return includeDeleted;
    }

    public void setIncludeDeleted(boolean includeDeleted) {
        this.includeDeleted = includeDeleted;
    }

    public ChangesRequestOptions(String cursor, String containers, int pageSize, boolean includeDeleted, String form,
        String fields, boolean prettyPrint, String quotaID, Map<String, Object> parameters) {
        super(form, fields, prettyPrint, quotaID, parameters);
        this.cursor = cursor;
        this.containers = containers;
        this.pageSize = pageSize;
        this.includeDeleted = includeDeleted;
    }
}
