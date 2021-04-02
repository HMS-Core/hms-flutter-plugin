/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import '../request/account_auth_extended_params.dart';
import '../common/scope.dart';

/// Creates a list of [Scope] from [list].
List<String> getScopeList(List<Scope> list) {
  List<String> res = [];
  if (list != null && list.isNotEmpty) {
    list.forEach((scope) {
      res.add(scope.getScopeUri());
    });
  }
  return res;
}

/// Creates a map object from [params].
Map<String, dynamic> getExtendedParamsMap(AccountAuthExtendedParams params) {
  Map<String, dynamic> map;

  if (params != null) {
    map = {};
    map['extendedParamType'] = params.getExtendedParamType() ?? null;
    map['extendedScopes'] = getScopeList(params.getExtendedScopes());
  }

  return map;
}

/// Checks whether [values] has a null value.
void checkParams(List<dynamic> values) {
  if (values.contains(null)) {
    throw new Exception("Required parameters must not be null!");
  }
}
