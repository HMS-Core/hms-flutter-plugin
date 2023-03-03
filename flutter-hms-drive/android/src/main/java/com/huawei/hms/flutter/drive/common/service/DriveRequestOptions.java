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

package com.huawei.hms.flutter.drive.common.service;

import java.util.Map;

public class DriveRequestOptions {

    /**
     * Response data format. The default data format is json, and only this format is supported currently.
     */
    private String form;

    /**
     * Fields to be contained in a response. An asterisk (`*`) can be used to match all related fields.
     */
    private String fields;

    /**
     * Indicates whether to return a response containing indentations and newline characters.
     */
    private boolean prettyPrint;

    /**
     * A string of less than 40 characters to identify a user. The string is used by the server to restrict the user's
     * API calls.
     */
    private String quotaId;

    /**
     * Parameters to be set for the request.
     */
    private Map<String, Object> parameters;

    public String getForm() {
        return form;
    }

    public String getFields() {
        return fields;
    }

    public void setFields(String fields) {
        this.fields = fields;
    }

    public boolean isPrettyPrint() {
        return prettyPrint;
    }

    public String getQuotaId() {
        return quotaId;
    }

    public Map<String, Object> getParameters() {
        return parameters;
    }

    public DriveRequestOptions(String form, String fields, boolean prettyPrint, String quotaID,
        Map<String, Object> parameters) {
        this.form = form;
        this.fields = fields;
        this.prettyPrint = prettyPrint;
        this.quotaId = quotaID;
        this.parameters = parameters;
    }
}
