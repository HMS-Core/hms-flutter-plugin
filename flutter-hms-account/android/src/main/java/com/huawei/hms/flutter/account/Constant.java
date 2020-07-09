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


package com.huawei.hms.flutter.account;

public interface Constant {
    boolean successResponse = true;
    String SIGN_IN_FAIL = "101";
    String SIGN_IN_WITH_AUTHORIZATION_CODE_FAIL = "102";
    String SILENT_SIGN_IN_FAIL = "103";
    String SIGN_OUT_FAIL = "104";
    String REVOKE_AUTHORIZATION_FAIL = "105";
    String SMS_VERIFICATION_FAIL = "106";
    String OBTAIN_HASH_CODE_FAIL = "107";
    String BUILD_NETWORK_COOKIE_FAIL = "108";
    String BUILD_NETWORK_URL_FAIL = "109";
    String ADD_AUTH_SCOPES_FAIL = "200";
    String GET_AUTH_RESULT_FAIL = "201";
    String GET_AUTH_RESULT_WITH_SCOPES_FAIL = "202";
    String CONTAIN_SCOPES_FAIL = "203";
    String DELETE_AUTH_INFO_FAIL = "204";
    String REQUEST_UNION_ID_FAIL = "205";
    String REQUEST_ACCESS_TOKEN_FAIL = "206";
    String TIME_OUT = "207";
}
