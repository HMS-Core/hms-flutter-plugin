/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

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

class HmsAccountErrorCodes {
  static const String NULL_AUTH_SERVICE = "0001";
  static const String ILLEGAL_PARAMETER = "0002";
  static const String GET_AUTH_RESULT_WITH_SCOPES_FAILURE = "100";
  static const String ADD_AUTH_SCOPES_FAILURE = "101";
  static const String CONTAIN_SCOPES_FAILURE = "102";
  static const String SIGN_IN_FAILURE = "103";
  static const String SILENT_SIGN_IN_FAILURE = "104";
  static const String SIGN_OUT_FAILURE = "105";
  static const String REVOKE_AUTHORIZATION_FAILURE = "106";
  static const String REQUEST_UNION_ID_FAILURE = "107";
  static const String REQUEST_ACCESS_TOKEN_FAILURE = "108";
  static const String DELETE_AUTH_INFO_FAILURE = "109";
  static const String BUILD_NETWORK_COOKIE_FAILURE = "110";
  static const String BUILD_NETWORK_URL_FAILURE = "111";
  static const String SMS_VERIFICATION_FAILURE = "112";
  static const String OBTAIN_HASHCODE_VALUE_FAILURE = "113";
  static const String SMS_VERIFICATION_TIME_OUT = "114";
}
