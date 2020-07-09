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


import 'package:huawei_account/helpers/auth_params.dart';

class AuthParamHelper {
  Map<String, dynamic> authParamHelpers = <String, dynamic>{
    'authData': {
      'setIdToken': false,
      'setProfile': false,
      'setAccessToken': false,
      'setAuthorizationCode': false,
      'setEmail': false,
      'setId': false,
      'scopeList': [],
      'defaultParam': AuthParams.defaultAuthRequestParam,
      'requestCode': 8888
    }
  };

  void setDefaultParam(int param) {
    authParamHelpers['authData']['defaultParam'] = param;
  }

  void setIdToken() {
    authParamHelpers['authData']['setIdToken'] = true;
  }

  void setProfile() {
    authParamHelpers['authData']['setProfile'] = true;
  }

  void setAccessToken() {
    authParamHelpers['authData']['setAccessToken'] = true;
  }

  void setAuthorizationCode() {
    authParamHelpers['authData']['setAuthorizationCode'] = true;
  }

  void setEmail() {
    authParamHelpers['authData']['setEmail'] = true;
  }

  void setId() {
    authParamHelpers['authData']['setId'] = true;
  }

  void addToScopeList(List<String> scopes) {
    authParamHelpers['authData']['scopeList'] = scopes;
  }

  void setRequestCode(int requestCode) {
    authParamHelpers['authData']['requestCode'] = requestCode;
  }
}
