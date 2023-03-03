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

import com.huawei.cloud.services.drive.DriveRequest;

import java.io.IOException;

public interface IDriveRequest {
    /**
     * Sets the response data format of a drive request.
     *
     * @param driveRequest A DriveRequest instance to set the form parameter.
     * @param form         Response data format. The default data format is json, and only this format is supported
     *                     currently.
     */
    void setForm(DriveRequest<?> driveRequest, String form);

    /**
     * Sets the fields to be contained in a response.
     *
     * @param driveRequest A DriveRequest instance to set fields.
     * @param fields       Fields to be contained in a response. An asterisk (*) can be used to match all related
     *                     fields.
     */
    void setFields(DriveRequest<?> driveRequest, String fields);

    /**
     * Sets whether to return a response containing indentations and newline characters.
     *
     * @param driveRequest A DriveRequest instance to set prettyPrint value.
     * @param prettyPrint  Indicates whether to return a response containing indentations and newline characters. The
     *                     value is type of Boolean.
     */
    void setPrettyPrint(DriveRequest<?> driveRequest, Boolean prettyPrint);

    /**
     * Sets a string of less than 40 characters to identify a user. The string is used by the server to restrict the
     * user's API calls.
     *
     * @param driveRequest A DriveRequest instance to set the quotaId.
     * @param quotaId      A string of less than 40 characters to identify a user. The string is used by the server to
     *                     restrict the user's API calls.
     */
    void setQuotaId(DriveRequest<?> driveRequest, String quotaId);

    /**
     * Sets the given parameter value for the given parameter name.
     *
     * @param driveRequest  A DriveRequest instance to set the given parameter and the value.
     * @param parameterName Parameter name.
     * @param value         Parameter value.
     */
    void set(DriveRequest<?> driveRequest, String parameterName, Object value);

    /**
     * Sends an HTTP request and returns the object to be converted.
     *
     * @param driveRequest A DriveRequest instance to perform the execute operation.
     * @param type         Type of the class that will be returned after the execute operation is succeeded.
     * @param <K>          The resulting class that will be returned.
     * @return K
     * @throws IOException I/O exception thrown upon an API call failure.
     */
    <K> K execute(DriveRequest<?> driveRequest, Class<K> type) throws IOException;
}
