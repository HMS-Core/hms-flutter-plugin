/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of materialgen;

/// App information.
/// To use the on-cloud material generation service, set an access token or API key for your app.
abstract class MaterialGenApplication {
  static const MethodChannel _c = MethodChannel(
    'com.huawei.hms.flutter.modeling3d/materialGenApplication/method',
  );

  /// Sets an access token for your app.
  static Future<void> setAccessToken(String accessToken) async {
    await _c.invokeMethod(
      'setAccessToken',
      <String, dynamic>{
        'accessToken': accessToken,
      },
    );
  }

  /// Sets an API key for your app.
  static Future<void> setApiKey(String apiKey) async {
    await _c.invokeMethod(
      'setApiKey',
      <String, dynamic>{
        'apiKey': apiKey,
      },
    );
  }
}
