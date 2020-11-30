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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_account/model/hms_auth_huawei_id.dart';

const String AUTH_MANAGER_METHOD_CHANNEL =
    "com.huawei.hms.flutter.account/auth/manager";

class HmsAuthManager {
  static const MethodChannel _channel =
      const MethodChannel(AUTH_MANAGER_METHOD_CHANNEL);

  /// Obtains the information about the HUAWEI ID in the latest sign-in.
  static Future<HmsAuthHuaweiId> getAuthResult() async {
    return new HmsAuthHuaweiId.fromMap(
        await _channel.invokeMethod("getAuthResult"));
  }

  /// Obtains an [HmsAuthHuaweiId] instance.
  /// [scopeList] indicates the scope values
  static Future<HmsAuthHuaweiId> getAuthResultWithScopes(
      {@required List<String> scopeList}) async {
    return new HmsAuthHuaweiId.fromMap(await _channel.invokeMethod(
        "getAuthResultWithScopes", <String, dynamic>{'scopes': scopeList}));
  }

  /// Requests the permission specified by [scopeList] from a HUAWEI ID.
  /// [requestCode] indicates the code will be used while requesting
  static Future<bool> addAuthScopes(
      {@required int requestCode, @required List<String> scopeList}) async {
    return await _channel.invokeMethod("addAuthScopes",
        <String, dynamic>{'requestCode': requestCode, 'scopes': scopeList});
  }

  /// Checks whether a specified HUAWEI ID has been assigned all permission specified by [scopeList].
  /// [authHuaweiId] indicates the signed HUAWEI ID.
  static Future<bool> containScopes(
      {@required HmsAuthHuaweiId authHuaweiId,
      @required List<String> scopeList}) async {
    return await _channel.invokeMethod("containScopes", <String, dynamic>{
      'id': authHuaweiId.toMap(),
      'scopeList': scopeList,
      'authorizedScopes': authHuaweiId.authorizedScopes
    });
  }
}
