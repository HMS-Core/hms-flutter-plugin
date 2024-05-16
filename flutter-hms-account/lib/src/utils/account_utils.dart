/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_account;

/// Creates a list of [Scope] from [list].
List<String> _getScopeList(
  List<Scope> list,
) {
  List<String> res = <String>[];
  for (Scope scope in list) {
    res.add(scope.getScopeUri());
  }
  return res;
}

/// Creates a map object from [params].
Map<String, dynamic> _getExtendedParamsMap(
  AccountAuthExtendedParams params,
) {
  return <String, dynamic>{
    'extendedParamType': params.getExtendedParamType(),
    'extendedScopes': _getScopeList(params.getExtendedScopes()),
  };
}
