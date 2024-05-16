/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.huawei.hms.flutter.iap.utils;

public enum Errors {
    LOG_IN("ERR_CAN_NOT_LOG_IN", "Can not log in."),
    UNKNOWN_REQUEST_CODE("UNKNOWN_REQUEST_CODE", "This request code does not match with any available request codes."),
    ACTIVITY_RESULT("ACTIVITY_RESULT_ERROR", "Result is not OK"),
    IS_SANDBOX_READY("IS_SANDBOX_READY_ERROR", null),
    OBTAIN_PRODUCT_INFO("OBTAIN_PRODUCT_INFO_ERROR", null),
    PURCHASE_INTENT_EXCEPTION("PURCHASE_INTENT_EXCEPTION", null),
    CONSUME_OWNED_PURCHASE("CONSUME_OWNED_PURCHASE_ERROR", null),
    OBTAIN_OWNED_PURCHASES("OBTAIN_OWNED_PURCHASES_ERROR", null),
    START_IAP_ACTIVITY("START_IAP_ACTIVITY_ERROR", null),
    PURCHASE_INTENT_RESOLUTION("PURCHASE_INTENT_RESOLUTION_ERROR", null),
    NO_RESOLUTION("NO_RESOLUTION", "There is no resolution for error.");

    private final String errorCode;

    private final String errorMessage;

    Errors(String errorCode, String errorMessage) {
        this.errorCode = errorCode;
        this.errorMessage = errorMessage;
    }

    public String getErrorCode() {
        return errorCode;
    }

    public String getErrorMessage() {
        return errorMessage;
    }
}
