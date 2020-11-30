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

const String NETWORK_TOOL_METHOD_CHANNEL =
    "com.huawei.hms.flutter.account/network/tool";

class HmsNetworkTool {
  static const MethodChannel _channel =
      const MethodChannel(NETWORK_TOOL_METHOD_CHANNEL);

  /// Constructs a cookie by combining entered values.
  static Future<String> buildNetworkCookie(
      {@required String cookieName,
      @required String cookieValue,
      @required String domain,
      @required String path,
      @required bool isHttpOnly,
      @required bool isSecure,
      @required double maxAge}) async {
    return await _channel.invokeMethod("buildNetworkCookie", <String, dynamic>{
      'cookieName': cookieName,
      'cookieValue': cookieValue,
      'domain': domain,
      'path': path,
      'isHttpOnly': isHttpOnly,
      'isSecure': isSecure,
      'maxAge': maxAge
    });
  }

  /// Obtains a cookie URL based on the domain name and isUseHttps.
  static Future<String> buildNetworkUrl(
      {@required String domain, @required bool isUseHttps}) async {
    return await _channel.invokeMethod("buildNetworkUrl",
        <String, dynamic>{'domainName': domain, 'isHttps': isUseHttps});
  }
}
