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

/// Constructs a cookie based on specified parameters.
class NetworkTool {
  static const MethodChannel _c = MethodChannel(_NETWORK_TOOL);

  /// Constructs a cookie by combining entered values.
  static Future<String> buildNetworkCookie(
    String cookieName,
    String? cookieValue,
    String? domain,
    String? path,
    bool? isHttpOnly,
    bool? isSecure,
    double? maxAge,
  ) async {
    return await _c.invokeMethod(
      'buildNetworkCookie',
      <String, dynamic>{
        'cookieName': cookieName,
        'cookieValue': cookieValue,
        'domain': domain,
        'path': path,
        'isHttpOnly': isHttpOnly,
        'isSecure': isSecure,
        'maxAge': maxAge,
      },
    );
  }

  /// Obtains a cookie URL based on the domain name and [isUseHttps].
  static Future<String> buildNetworkUrl(
    String domain,
    bool? isUseHttps,
  ) async {
    return await _c.invokeMethod(
      'buildNetworkUrl',
      <String, dynamic>{
        'domainName': domain,
        'isHttps': isUseHttps,
      },
    );
  }
}
