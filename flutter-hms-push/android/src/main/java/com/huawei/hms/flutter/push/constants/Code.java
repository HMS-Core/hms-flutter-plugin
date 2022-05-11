/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.push.constants;

public enum Code {

    // Success
    RESULT_SUCCESS("0"),

    // Unknown error. Contact Huawei technical support.
    RESULT_UNKNOWN("907122045"),

    // Error
    RESULT_ERROR("-1"),

    // Bundle is null, exception
    NULL_BUNDLE("333"),

    // The message contains invalid parameters.
    ERROR_INVALID_PARAMETERS("907122042"),

    // You do not have a token. Apply for a token.
    ERROR_NO_TOKEN("907122030"),

    // The current network is unavailable. Check the network connection.
    ERROR_NO_NETWORK("907122031"),

    // The token has expired. Delete the token and apply for a new one.
    ERROR_TOKEN_INVALID("907122032"),

    // If the Push service is unavailable; contact Huawei technical support.
    ERROR_SERVICE_NOT_AVAILABLE("907122046"),

    // If the Push server returns an error; contact Huawei technical support.
    ERROR_PUSH_SERVER("907122047"),

    // The number of subscribed topics exceeds 2000.
    ERROR_TOPIC_EXCEED("907122034"),

    // Failed to send the subscription topic. Contact Huawei technical support.
    ERROR_TOPIC_SEND("907122035"),

    // Push rights are not enabled. Enable the service and set push service parameters at AppGallery Connect.
    ERROR_NO_RIGHT("907122036"),

    // Failed to apply for the token. Contact Huawei technical support.
    ERROR_GET_TOKEN_ERR("907122037"),

    // No storage location is selected for the application or the storage location is invalid.
    ERROR_STORAGE_LOCATION_EMPTY("907122038"),

    // Failed to apply for a token. Cross-region token application is not allowed.
    ERROR_NOT_ALLOW_CROSS_APPLY("907122053"),

    // The message body size exceeds the maximum.
    ERROR_SIZE("907122041"),

    // The number of sent messages reaches the upper limit. The messages will be discarded.
    ERROR_TOO_MANY_MESSAGES("907122043"),

    // The message lifetime expires before the message is successfully sent to the APP server.
    ERROR_TTL_EXCEEDED("907122044"),

    //  Huawei Mobile Services (APK) can't connect  Huawei Push  Kit.
    ERROR_HMS_CLIENT_API("907122048"),

    // The current EMUI version is too early to use the capability.
    ERROR_OPERATION_NOT_SUPPORTED("907122049"),

    // The operation cannot be performed in the main thread.
    ERROR_MAIN_THREAD("907122050"),

    // The device certificate authentication fails.
    ERROR_HMS_DEVICE_AUTH_FAILED_SELF_MAPPING("907122051"),

    // Failed to bind the service.
    ERROR_BIND_SERVICE_SELF_MAPPING("907122052"),

    // The SDK is being automatically initialized. Try again later.
    ERROR_AUTO_INITIALIZING("907122054"),

    /*The input parameter is incorrect. Check whether the related configuration information is correct.
     * Example= app_id in the agconnect - services.json file;
     * Check whether the build.gradle file is configured with the certificate signature.
     */
    ERROR_ARGUMENTS_INVALID("907135000"),

    // Internal Push error. Contact Huawei technical support engineers.
    ERROR_INTERNAL_ERROR("907135001"),

    // The service does not exist. The invoked interface does not exist.
    ERROR_NAMING_INVALID("907135002"),

    // The ApiClient object is invalid.
    ERROR_CLIENT_API_INVALID("907135003"),

    // Invoking AIDL times out. Contact Huawei technical support.
    ERROR_EXECUTE_TIMEOUT("907135004"),

    // The current area does not support this service.
    ERROR_NOT_IN_SERVICE("907135005"),

    // If the AIDL connection session is invalid; contact Huawei technical support.
    ERROR_SESSION_INVALID("907135006"),

    // An error occurred when invoking an unspecified API.
    ERROR_API_NOT_SPECIFIED("1002"),

    /* Failed to invoke the gateway to query the application scope.
     * Check whether the current app has been created and enabled in AppGallery Connect.
     * If yes; contact Huawei technical support.
     */
    ERROR_GET_SCOPE_ERROR("907135700"),

    /* Scope is not configured on the AppGallery Connect.
     * Check whether the current app has been created and enabled in AppGallery Connect.
     * If yes; contact Huawei technical support.
     */
    ERROR_SCOPE_LIST_EMPTY("907135701"),

    /* The certificate fingerprint is not configured on the AppGallery Connect.
     * 1. Check whether your phone can access the Internet.
     * 2. Check whether the correct certificate fingerprint is configured in AppGallery Connect.
     *    For details; see AppGallery Connect configuration in Development Preparations.
     * 3. If the check result is correct; contact Huawei technical support.
     */
    ERROR_CERT_FINGERPRINT_EMPTY("907135702"),

    //Permission is not configured on the AppGallery Connect.
    ERROR_PERMISSION_LIST_EMPTY("907135703"),

    // The authentication information of the application does not exist.
    ERROR_AUTH_INFO_NOT_EXIST("6002"),

    // An error occurred during certificate fingerprint verification. Check whether the correct certificate
    // fingerprint is configured in AppGallery Connect. For details; see AppGallery Connect configuration
    // in Development Preparations.
    ERROR_CERT_FINGERPRINT_ERROR("6003"),

    // Interface authentication= The permission does not exist and is not applied for in AppGallery Connect.
    ERROR_PERMISSION_NOT_EXIST("6004"),

    // Interface authentication= unauthorized.
    ERROR_PERMISSION_NOT_AUTHORIZED("6005"),

    // Interface authentication= The authorization expires.
    ERROR_PERMISSION_EXPIRED("6006");


    private String code;

    Code(String code) {
        this.code = code;
    }

    public String code() {
        return code;
    }

    public static Code fromString(String text) {
        for (Code b : Code.values()) {
            if (b.code.equalsIgnoreCase(text)) {
                return b;
            }
        }
        return null;
    }

}
