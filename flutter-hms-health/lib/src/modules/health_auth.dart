/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_health;

/// Provides [signIn] method for obtaining the Health Kit Authorization from the user.
class HealthAuth {
  static const MethodChannel _channel = _healthAccountMethodChannel;

  /// Obtains the Health Kit permissions from the user by the defined List of [Scope]s.
  static Future<AuthHuaweiId?> signIn(
    List<Scope> scopes,
  ) async {
    List<String> scopeStrList = <String>[];
    for (Scope scope in scopes) {
      scopeStrList.add(scope.scopeStr);
    }
    final String? result = await _channel.invokeMethod<String?>(
      'signIn',
      <String, dynamic>{
        'scopes': scopeStrList,
      },
    );
    if (result == null) {
      return null;
    }
    return AuthHuaweiId.fromMap(jsonDecode(result));
  }
}
