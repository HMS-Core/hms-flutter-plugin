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

/// Provides authorization management APIs that can be used to view and revoke
/// the granted permissions.
class ConsentsController {
  static const MethodChannel _channel = _healthSettingControllerMethodChannel;

  /// Obtains the application id from the agconnect-services.json file.
  static Future<String> getAppId() async {
    final String? result = await _channel.invokeMethod<String?>(
      'getAppId',
    );
    return result!;
  }

  /// Queries the list of permissions granted to your app.
  static Future<ScopeLangItem> getScopes(
    String lang,
    String appId,
  ) async {
    final Map<dynamic, dynamic>? result =
        await _channel.invokeMethod<Map<dynamic, dynamic>?>(
      'get',
      <String, dynamic>{
        'lang': lang,
        'appId': appId,
      },
    );
    return ScopeLangItem.fromMap(result!);
  }

  /// Revokes all permissions granted to your app.
  @Deprecated('This method has been deprecated.')
  static Future<void> revoke(
    String appId,
  ) async {
    await _channel.invokeMethod<void>(
      'revoke',
      appId,
    );
  }

  /// Revokes certain Health Kit related permissions granted to your app.
  @Deprecated(
    'This method has been deprecated. You are advised to use cancelAuthorizationWithScopes(String appId, List<Scope> scopes) instead.',
  )
  static Future<void> revokeWithScopes(
    String appId,
    List<Scope> scopes,
  ) async {
    await _channel.invokeMethod<void>(
      'revokeWithScopes',
      <String, dynamic>{
        'appId': appId,
        'scopes': List<String>.from(
          scopes.map((Scope e) => e.scopeStr),
        ),
      },
    );
  }

  /// Cancels all scopes granted to your app.
  /// You can specify whether to delete user data when the scopes are canceled.
  static Future<void> cancelAuthorization(
    bool deleteData,
  ) async {
    await _channel.invokeMethod<void>(
      'cancelAuthorization',
      deleteData,
    );
  }

  /// Cancels certain Health Kit related scopes granted to your app.
  static Future<void> cancelAuthorizationWithScopes(
    String appId,
    List<Scope> scopes,
  ) async {
    await _channel.invokeMethod<void>(
      'cancelAuthorizationWithScopes',
      <String, dynamic>{
        'appId': appId,
        'scopes': List<String>.from(
          scopes.map((Scope e) => e.scopeStr),
        ),
      },
    );
  }
}
