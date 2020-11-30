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
import 'package:huawei_account/model/hms_account.dart';

const String AUTH_TOOL_METHOD_CHANNEL =
    "com.huawei.hms.flutter.account/auth/tool";

class HmsAuthTool {
  static const MethodChannel _channel =
      const MethodChannel(AUTH_TOOL_METHOD_CHANNEL);

  /// Clears the local cache.
  ///
  /// [accessToken] Token to be deleted.
  static Future<bool> deleteAuthInfo({@required String accessToken}) async {
    return await _channel.invokeMethod(
        "deleteAuthInfo", <String, dynamic>{'accessToken': accessToken});
  }

  /// Obtains a union id
  ///
  /// [account] HUAWEI ID for which you need to obtain the id.
  static Future<String> requestUnionId({@required HmsAccount account}) async {
    return await _channel.invokeMethod(
        "requestUnionId", <String, dynamic>{'accountName': account.name});
  }

  /// Obtains an access token
  ///
  /// [account] HUAWEI ID for which you need to obtain a token.
  ///
  /// [scopeList] HUAWEI ID authorization scope in [HmsScope].
  static Future<String> requestAccessToken(
      {@required HmsAccount account, @required List<String> scopeList}) async {
    return await _channel.invokeMethod("requestAccessToken", <String, dynamic>{
      'type': account.type,
      'name': account.name,
      'scopeList': scopeList
    });
  }
}
