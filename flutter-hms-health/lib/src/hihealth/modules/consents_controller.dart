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

import 'package:flutter/services.dart';
import 'package:huawei_health/huawei_health.dart';
import 'package:huawei_health/src/hihealth/data/scope_lang_item.dart';

/// Provides authorization management APIs that can be used to view and revoke
/// the granted permissions.
class ConsentsController {
  static const MethodChannel _channel =
      health_setting_controller_method_channel;

  /// Obtains the application id from the agconnect-services.json file.
  static Future<String> getAppId() async {
    return await _channel.invokeMethod('getAppId');
  }

  /// Queries the list of permissions granted to your app.
  static Future<ScopeLangItem> getScopes(String lang, String appId) async {
    Map<String, String> callMap = {"lang": lang, "appId": appId};
    final result = await _channel.invokeMethod('get', callMap);
    return ScopeLangItem.fromMap(Map<String, dynamic>.from(result));
  }

  /// Revokes all permissions granted to your app.
  static Future<void> revoke(String appId) async {
    await _channel.invokeMethod('revoke', appId);
  }

  /// Revokes certain Health Kit related permissions granted to your app.
  static Future<void> revokeWithScopes(String appId, List<Scope> scopes) async {
    Map<String, dynamic> callMap = {
      "appId": appId,
      "scopes": List<String>.from(scopes.map((e) => e.scopeStr))
    };
    await _channel.invokeMethod('revokeWithScopes', callMap);
  }
}
