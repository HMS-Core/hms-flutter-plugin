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

import 'hms_auth_params.dart';

class HmsAuthParamHelper {
  Map<String, dynamic> requestData = {
    'setIdToken': false,
    'setProfile': false,
    'setAccessToken': false,
    'setAuthorizationCode': false,
    'setEmail': false,
    'setId': false,
    'scopeList': [],
    'defaultParam': HmsAuthParams().defaultAuthRequestParam,
    'requestCode': 8888
  };

  /// Sets the default authorization parameter of a HUAWEI ID,
  ///
  /// [HmsAuthParams] class has value of 0 for [defaultAuthRequestParam],
  /// and value of 1 for [defaultAuthRequestParamGame].
  void setDefaultParam(int param) {
    requestData['defaultParam'] = param;
  }

  /// Requests a HUAWEI ID user to authorize an app to obtain the ID token.
  void setIdToken() {
    requestData['setIdToken'] = true;
  }

  /// Requests a HUAWEI ID user to authorize an app to obtain the account information,
  /// such as the nickname and profile picture.
  void setProfile() {
    requestData['setProfile'] = true;
  }

  /// Requests a HUAWEI ID user to authorize an app to obtain the access token.
  void setAccessToken() {
    requestData['setAccessToken'] = true;
  }

  /// Requests a HUAWEI ID user to authorize an app to obtain the authorization code.
  /// If this is used, you do not need to call [setIdToken].
  /// When your app server uses the authorization code to exchange a token with the HUAWEI ID OAuth server,
  /// the ID token will be returned in the result.
  void setAuthorizationCode() {
    requestData['setAuthorizationCode'] = true;
  }

  /// Requests a HUAWEI ID user to authorize an app to obtain the email address.
  void setEmail() {
    requestData['setEmail'] = true;
  }

  /// Requests a HUAWEI ID user to authorize an app to obtain the UnionID.
  void setId() {
    requestData['setId'] = true;
  }

  /// Adds a specified [HmsScope] to authorization configurations to request a HUAWEI ID user
  /// to authorize an app to obtain the permission specified by [HmsScope].
  void setScopeList(List<String> scopes) {
    requestData['scopeList'] = scopes;
  }

  /// Sets the request code which will be used while signing in.
  void setRequestCode(int requestCode) {
    requestData['requestCode'] = requestCode;
  }
}
