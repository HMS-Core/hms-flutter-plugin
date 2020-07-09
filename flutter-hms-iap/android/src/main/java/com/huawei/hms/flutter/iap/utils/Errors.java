/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.iap.utils;

public enum Errors {
    logIn("ERR_CAN_NOT_LOG_IN", "Can not log in."),
    unkownRequestCode("UNKNOWN_REQUEST_CODE", "This request code does not match with any available request codes."),
    activityResult("ACTIVITY_RESULT_ERROR", "Result is not OK"),
    isSandbocReady("IS_SANDBOX_READY_ERROR", null),
    obtainProductInfo("OBTAIN_PRODUCT_INFO_ERROR", null),
    purchaseIntentException("PURCHASE_INTENT_EXCEPTION", null),
    consumeOwnedPurchase("CONSUME_OWNED_PURCHASE_ERROR", null),
    obtainOwnedPurchases("OBTAIN_OWNED_PURCHASES_ERROR", null),
    startIapActivity("START_IAP_ACTIVITY_ERROR", null),
    purchaseIntentResolution("PURCHASE_INTENT_RESOLUTION_ERROR", null);

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
